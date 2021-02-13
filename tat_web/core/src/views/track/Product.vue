<template>
  <div>
    <CRow>
      <CCol sm="12">
        <CCard>
          <CCardHeader> <strong> Product </strong> Info </CCardHeader>
          <CCardBody>
            <CForm>
              <CInput label="Id" v-model="obj.id" horizontal plaintext />

              <CInput
                description="Product Code"
                label="Code"
                horizontal
                autocomplete="code"
                v-model="obj.code"
              />
              <CInput
                description="Product Name"
                label="Name"
                horizontal
                autocomplete="name"
                v-model="obj.name"
              />
              <CSelect
                label="Species"
                horizontal
                v-model="obj.species_code"
                :value.sync="obj.species_code"
                :options="options"
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
  name: "Product",
  data: () => {
    return {
      options: [],
      api: new TatApi(),
      obj: {
        id: "",
        code:"",
        name:"",
        species_code:""
      },
    };
  },
  mounted() {
    var self = this;
    self.refreshSpecies();
    if (self.$route.params.id) {
      this.api.getProduct(self.$route.params.id).then((response) => {
        self.obj = response;
      });
    }
  },
  methods: {
    refreshSpecies() {
      var self = this;
      self.api.getSpeciesList().then((response) => {
        for (var i in response.data) {
          self.options.push({
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
        this.api.createProduct(self.obj).then((response) => {
          self.obj = {};
          self.$router.push({ path: "/track/productlist" });
        });
      } else {
        this.api.updateProduct(self.obj).then((response) => {
          self.obj = {};
          self.$router.push({ path: "/track/productlist" });
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
