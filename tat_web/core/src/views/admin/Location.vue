<template>
  <div>
    <CRow>
      <CCol sm="12">
        <CCard>
          <CCardHeader> <strong> Location </strong> Info </CCardHeader>
          <CCardBody>
            <CForm>
              <CInput label="Id" v-model="obj.id" horizontal plaintext />

              <CInput
                description="Location Code"
                label="Code"
                horizontal
                autocomplete="code"
                v-model="obj.code"
              />
              <CInput
                description="Location Name"
                label="Name"
                horizontal
                autocomplete="name"
                v-model="obj.name"
              />
              <CSelect
                label="Organization"
                horizontal
                v-model="obj.organization_code"
                :value.sync="obj.organization_code"
                :options="organizationList"
                placeholder="Please select"
              />
              <CSelect
                label="Type"
                horizontal
                v-model="obj.type"
                :value.sync="obj.type"
                :options="typeList"
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
  name: "Location",
  data: () => {
    return {
      typeList: ['Ceramic Tank', 'On Transit', 'End User'],
      organizationList: [],
      api: new TatApi(),
      obj: {
        id: "",
        code:"",
        name:"",
        type:"",
        organization_code:""
      },
    };
  },
  mounted() {
    var self = this;
    self.refreshOrganization();
    if (self.$route.params.id) {
      this.api.getLocation(self.$route.params.id).then((response) => {
        self.obj = response;
      });
    }
  },
  methods: {
    refreshOrganization() {
      var self = this;
      self.api.getOrganizationList().then((response) => {
        for (var i in response.data) {
          self.organizationList.push({
            value: response.data[i].code,
            label: response.data[i].name,
          });
        }

      });
    },

    onSubmit(evt) {
      evt.preventDefault();
      var self = this;
      if (self.obj.id == "") {
        this.api.createLocation(self.obj).then((response) => {
          self.obj = {};
          self.$router.push({ path: "/admin/Locationlist" });
        });
      } else {
        this.api.updateLocation(self.obj).then((response) => {
          self.obj = {};
          self.$router.push({ path: "/admin/Locationlist" });
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
