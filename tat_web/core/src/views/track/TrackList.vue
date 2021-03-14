<template>
  <CRow>
    <CCol sm="12">
      <CCard>
        <CCardHeader> <strong> Track History </strong> List </CCardHeader>
        <CCardBody>
          <CDataTable
            :items="items"
            :fields="fields"
            column-filter
            table-filter
            items-per-page-select
            :items-per-page="10"
            hover
            sorter
            pagination
          >
            <!-- <template #status="{item}">
              <td>
                <CBadge :color="getBadge(item.status)">
                  {{ item.status }}
                </CBadge>
              </td>
            </template>
            -->
            <template #show_details="{item, index}">
              <td class="py-2">
                <CButton
                  color="primary"
                  variant="outline"
                  square
                  size="sm"
                  @click="toggleDetails(item, index)"
                >
                  {{ Boolean(item._toggled) ? "Hide" : "Show" }}
                </CButton>
              </td>
            </template>
            <template #details="{item}">
              <CCollapse
                :show="Boolean(item._toggled)"
                :duration="collapseDuration"
              >
                <CCardBody>
                  <CMedia :aside-image-props="{ height: 102 }">
                    <h4>
                      {{ item.name }}
                    </h4>
                    <p class="text-muted">Id : {{ item.id }}</p>
                    <p class="text-muted">Category: {{ item.categoryName }}</p>
                    <p>
                    Qr Img :
                    <div>
                      <img :src="getImgUrl(item.id)" />
                    </div>
                    </p>
                    <p>
                    Qr Link :
                    <a :href="getImgUrl(item.id)" target="_blank">{{getImgUrl(item.id)}} }}</a>
                    </p>
                    <p>
                    Qr Info :
                    <a :href="item.qrUrl" target="_blank">{{ item.qrUrl }}</a>
                    </p>
                    <CButton
                      size="sm"
                      color="info"
                      class=""
                      @click="onView(item)"
                    >
                      View
                    </CButton>
                    <!-- <CButton
                      size="sm"
                      color="danger"
                      class="ml-1"
                      @click="showDeleteConfirmation(item)"
                    >
                      Delete
                    </CButton> -->
                  </CMedia>
                </CCardBody>
              </CCollapse>
            </template>
          </CDataTable>
        </CCardBody>
        <CCardFooter>
          <CButton type="submit" size="sm" color="primary" @click="addNew"
            ><CIcon name="cil-check-circle" /> Add New</CButton
          >
        </CCardFooter>
      </CCard>
      <CModal
        title="Confirm Delete"
        color="warning"
        :show.sync="warningModal"
        @update:show="onDeleteConfirmation"
      >
        Are you sure you want to delete this {{ itemToDelete.code }} ?
      </CModal>
    </CCol>
  </CRow>
</template>

<script>
import TatApi from "../../lib/tatapi";

const items = [];

const fields = [
  { key: "name", _style: "min-width:50px" },
  { key: "categoryName", _style: "min-width:50px" },
  { key: "isActive", _style: "min-width:50px" },
  { key: "id", _style: "min-width:50px" },
  {
    key: "show_details",
    label: "",
    _style: "width:1%",
    sorter: false,
    filter: false,
  },
];

export default {
  name: "TrackList",
  data() {
    return {
      items: items.map((item, id) => {
        return { ...item, id };
      }),
      fields,
      details: [],
      collapseDuration: 0,
      api: new TatApi(),
      warningModal: false,
      itemToDelete: {},
    };
  },
  mounted() {
    var self = this;
    self.refreshTable();
  },
  methods: {
    toggleDetails(item, index) {
      this.$set(this.items[index], "_toggled", !item._toggled);
      this.collapseDuration = 300;
      this.$nextTick(() => {
        this.collapseDuration = 0;
      });
    },
    refreshTable() {
      var self = this;
      self.api.getTrailList().then((response) => {
        self.items = response.data;
      });
    },
    getImgUrl(id) {
      return "http://127.0.0.1:5005/api/eth/generateQr/" + id;
    },
    onView(item) {
      var self = this;
      self.$router.push({
        path: `/track/history/${item.id}`,
      });
    },
    onDeleteConfirmation(status, evt, accept) {
      var self = this;
      if (accept) {
        this.api.deleteTrack(self.itemToDelete.id).then((response) => {
          self.refreshTable();
        });
      }
      self.itemToDelete = {};
    },
    showDeleteConfirmation(item) {
      var self = this;
      self.itemToDelete = item;
      self.warningModal = true;
    },
    addNew() {
      this.$router.push({ path: "/track/trackupdate" });
    },
  },
};
</script>
