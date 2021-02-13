<template>
  <div>
    <CRow>
      <CCol sm="12">
        <CCard>
          <CCardHeader> <strong> Species </strong> Information </CCardHeader>
          <CCardBody>
            <CForm>
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
            <CButton type="submit" size="sm" color="primary" @click="create"
              ><CIcon name="cil-check-circle" /> Submit</CButton
            >
            <CButton type="reset" size="sm" color="danger"
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
        code: "",
        name: "",
        description: "",
      },
    };
  },
  methods: {

    create() {
      var self = this;
      this.api.createSpecies(self.obj).then((response) => {
        self.obj = {};
        self.$router.push({ path: "/admin/specieslist" });
        // self.$router.push("/specieslist");
      });
    },
  },
};
</script>
