<template>
  <CRow>
    <CCol sm="12">
      <CCard>
        <CCardHeader> <strong> Track History </strong> List </CCardHeader>
        <CCardBody>
          <h4>Name: {{ product.name }}</h4>
          <p class="text-muted">ID: {{ product.id }}</p>
          <div>
            <img :src="getImgUrl()" />
          </div>
          <p>
            <a :href="product.qrUrl" target="_blank">{{ product.qrUrl }}</a>
          </p>
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
                      {{ item.code }}
                    </h4>
                    <p class="text-muted">Name: {{ item.name }}</p>
                    <p class="text-muted">Category: {{ item.categoryName }}</p>
                    <!-- <CButton
                      size="sm"
                      color="info"
                      class=""
                      @click="onView(item)"
                    >
                      View
                    </CButton> -->
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
          <CButton
            type="submit"
            size="sm"
            color="primary"
            @click="addNew(product.id)"
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
  { key: "createdDateInText", _style: "min-width:50px" },
  { key: "organization_name", _style: "min-width:50px" },
  { key: "area_name", _style: "min-width:50px" },
  { key: "activity_name", _style: "min-width:50px" },
  { key: "gps", _style: "min-width:50px" },
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
      product: {},
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
    getImgUrl() {
      var self = this;
      var url = "http://127.0.0.1:5005/api/eth/generateQr/" + self.product.id;
      return url;
    },
    toggleDetails(item, index) {
      this.$set(this.items[index], "_toggled", !item._toggled);
      this.collapseDuration = 300;
      this.$nextTick(() => {
        this.collapseDuration = 0;
      });
    },
    refreshTable() {
      var self = this;
      if (self.$route.params.id) {
        this.api.getProduct(self.$route.params.id).then((response) => {
          self.product = response.data;
          this.api.getProductTrail(self.$route.params.id).then((response) => {
            self.items = response.data.trailInfoList;
          });
        });
      }
      // var self = this;
      // self.api.getTrailList().then((response) => {
      //   self.items = response.data;
      //   console.log(self.items)
      // });
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
      var self = this;
      self.$router.push({
        path: `/track/trackupdate/${self.product.id}`,
      });
    },
  },
};
</script>
