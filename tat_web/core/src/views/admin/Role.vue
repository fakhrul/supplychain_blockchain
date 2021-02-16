<template>
  <div>
    <CRow>
      <CCol sm="12">
        <CCard>
          <CCardHeader> <strong> Role </strong> Information </CCardHeader>
          <CCardBody>
            <CForm>
              <CInput label="Id" v-model="obj.id" horizontal plaintext />
              <CInput
                description="Role Code"
                label="Code"
                horizontal
                autocomplete="code"
                v-model="obj.code"
              />
              <CInput
                description="Role Name"
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
  name: "Role",
  data: () => {
    return {
      api: new TatApi(),
      obj: {
        id: "",
        code: "",
        name: "",
        description: "",
      },
    };
  },
  mounted() {
    var self = this;
    if (self.$route.params.id) {
      this.api.getRole(self.$route.params.id).then((response) => {
        self.obj = response;
      });
    }
  },
  methods: {

    onSubmit(evt) {
      evt.preventDefault();
      var self = this;
      if (self.obj.id == "") {
        this.api.createRole(self.obj).then((response) => {
          self.obj = {};
          self.$router.push({ path: "/admin/rolelist" });
        });
      } else {
        this.api.updateRole(self.obj).then((response) => {
          self.obj = {};
          self.$router.push({ path: "/admin/rolelist" });
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
