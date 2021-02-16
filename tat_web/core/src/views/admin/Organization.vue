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
                description="Organization Code"
                label="Code"
                horizontal
                autocomplete="code"
                v-model="obj.code"
              />
              <CInput
                description="Organization Name"
                label="Name"
                horizontal
                autocomplete="name"
                v-model="obj.name"
              />
              <CTextarea
                label="Address"
                placeholder="Organization Address..."
                horizontal
                rows="5"
                v-model="obj.address"
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
  name: "Organization",
  data: () => {
    return {
      api: new TatApi(),
      obj: {
        id: "",
        code: "",
        name: "",
        address: "",
      },
    };
  },
  mounted() {
    var self = this;
    if (self.$route.params.id) {
      this.api.getOrganization(self.$route.params.id).then((response) => {
        self.obj = response;
      });
    }
  },
  methods: {

    onSubmit(evt) {
      evt.preventDefault();
      var self = this;
      if (self.obj.id == "") {
        this.api.createOrganization(self.obj).then((response) => {
          self.obj = {};
          self.$router.push({ path: "/admin/organizationlist" });
        });
      } else {
        this.api.updateOrganization(self.obj).then((response) => {
          self.obj = {};
          self.$router.push({ path: "/admin/organizationlist" });
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
