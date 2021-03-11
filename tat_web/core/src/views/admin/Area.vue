<template>
  <div>
    <CRow>
      <CCol sm="12">
        <CCard>
          <CCardHeader> <strong> Area </strong> Information </CCardHeader>
          <CCardBody>
            <CForm>
              <CInput label="Id" v-model="obj.id" horizontal plaintext />
              <CInput
                description="Area Name"
                label="Name"
                horizontal
                autocomplete="name"
                v-model="obj.name"
              />
              <CSelect
                label="Organization"
                horizontal
                v-model="obj.organization.id"
                :value.sync="obj.organization.id"
                :options="organizationList"
                placeholder="Please select"
              />
            </CForm>
          </CCardBody>
          <CCardFooter>
            <CButton type="submit" size="sm" color="primary" @click="onSubmit"
              ><CIcon name="cil-check-circle" /> Submit</CButton
            >
            <CButton type="reset" size="sm" color="danger" @click="onReset"
              ><CIcon name="cil-ban" /> Reset</CButton
            >
          </CCardFooter>
        </CCard>
      </CCol>
    </CRow>
  </div>
</template>

<script>
import TatApi from "../../lib/tatapi";

export default {
  name: "Area",
  data: () => {
    return {
      organizationList: [],
      api: new TatApi(),
      obj: {
        id: "",
        name: "",
        organization: {
          id: "",
        },
        isActive: "",
        customJsonData: ""
      },
    };
  },
  mounted() {
    var self = this;
    self.refreshOrganization();
    if (self.$route.params.id) {
      this.api.getArea(self.$route.params.id).then((response) => {
        self.obj = response.data;
      });
    }
  },
  methods: {
    refreshOrganization() {
      var self = this;
      self.api.getOrganizationList().then((response) => {
        for (var i in response.data) {
          self.organizationList.push({
            value: response.data[i].id,
            label: response.data[i].name,
          });
        }
      });
    },

    onSubmit(evt) {
      evt.preventDefault();
      var self = this;
      if (self.obj.id == "") {
        this.api.createArea(self.obj).then((response) => {
          // self.obj = {};
          self.$router.push({ path: "/admin/arealist" });
        });
      } else {
        this.api.updateArea(self.obj).then((response) => {
          // self.obj = {};
          self.$router.push({ path: "/admin/arealist" });
        });
      }
    },
    onReset(evt) {
      evt.preventDefault();
      this.obj = {};
    },
  },
};
</script>
