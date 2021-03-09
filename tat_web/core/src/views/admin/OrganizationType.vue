<template>
  <div>
    <CRow>
      <CCol sm="12">
        <CCard>
          <CCardHeader> <strong> Species </strong> Information </CCardHeader>
          <CCardBody>
            <CForm>
              <CInput label="Id" v-model="obj.id" horizontal plaintext />
              <CInput
                description="Organization Type"
                label="Name"
                horizontal
                autocomplete="name"
                v-model="obj.name"
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
  name: "OrganizationType",
  data: () => {
    return {
      api: new TatApi(),
      obj: {
        id: "",
        name: "",
        custom: "",
      },
    };
  },
  mounted() {
    var self = this;
    if (self.$route.params.id) {
      this.api.getOrganizationType(self.$route.params.id).then((response) => {
        self.obj = response.data;
      });
    }
  },
  methods: {

    onSubmit(evt) {
      evt.preventDefault();
      var self = this;
      if (self.obj.id == "") {
        this.api.createOrganizationType(self.obj).then((response) => {
          self.obj = {};
          self.$router.push({ path: "/admin/organizationTypeList" });
        });
      } else {
        this.api.updateOrganizationType(self.obj).then((response) => {
          self.obj = {};
          self.$router.push({ path: "/admin/organizationTypeList" });
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
