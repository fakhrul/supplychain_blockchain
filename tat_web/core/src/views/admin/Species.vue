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
                description="Species Code"
                label="Code"
                horizontal
                autocomplete="code"
                v-model="obj.code"
              />
              <CInput
                description="Species Name"
                label="Name"
                horizontal
                autocomplete="name"
                v-model="obj.name"
              />
              <CTextarea
                label="Descirption"
                placeholder="Product description..."
                horizontal
                rows="9"
                v-model="obj.description"
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
  name: "Species",
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
      this.api.getSpecies(self.$route.params.id).then((response) => {
        self.obj = response;
      });
    }
  },
  methods: {
    // create() {
    //   var self = this;
    //   this.api.createSpecies(self.obj).then((response) => {
    //     self.obj = {};
    //     self.$router.push({ path: "/admin/specieslist" });
    //     // self.$router.push("/specieslist");
    //   });
    // },
    onSubmit(evt) {
      evt.preventDefault();
      var self = this;
      if (self.obj.id == "") {
        this.api.createSpecies(self.obj).then((response) => {
          self.obj = {};
          self.$router.push({ path: "/admin/specieslist" });
        });
      } else {
        this.api.updateSpecies(self.obj).then((response) => {
          self.obj = {};
          self.$router.push({ path: "/admin/specieslist" });
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
