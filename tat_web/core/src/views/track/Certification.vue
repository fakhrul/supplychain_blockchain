<template>
  <div>
    <CRow>
      <CCol sm="12">
        <CCard>
          <CCardHeader> <strong> Certification </strong> Information </CCardHeader>
          <CCardBody>
            <CForm>
              <CInput label="Id" v-model="obj.id" horizontal plaintext />
              <CInput
                description="Certification Name"
                label="Name"
                horizontal
                autocomplete="name"
                v-model="obj.name"
              />
              <CInput
                description="Certification URL"
                label="Url"
                horizontal
                autocomplete="url"
                v-model="obj.certificateUrl"
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
  name: "Certification",
  data: () => {
    return {
      api: new TatApi(),
      obj: {
        id: "",
        name: "",
        certificateUrl: "",
        isActive: "",
        customJsonData: "",
      },
    };
  },
  mounted() {
    var self = this;
    if (self.$route.params.id) {
      this.api.getCertification(self.$route.params.id).then((response) => {
        self.obj = response.data;
      });
    }
  },
  methods: {

    onSubmit(evt) {
      evt.preventDefault();
      var self = this;
      if (self.obj.id == "") {
        this.api.createCertification(self.obj).then((response) => {
          self.$router.push({ path: "/track/certificationlist" });
        });
      } else {
        this.api.updateCertification(self.obj).then((response) => {
          self.$router.push({ path: "/track/certificationlist" });
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
