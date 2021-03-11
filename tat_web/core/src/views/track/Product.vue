<template>
  <div>
    <CRow>
      <CCol sm="12">
        <CCard>
          <CCardHeader> <strong> Product </strong> Info </CCardHeader>
          <CCardBody>
            <CForm>
              <CInput label="Id" v-model="obj.id" horizontal plaintext />
              <CSelect
                label="Category"
                horizontal
                v-model="obj.category.id"
                :value.sync="obj.category.id"
                :options="categoryList"
                placeholder="Please select"
              />
              <CInput
                description="Product Name"
                label="Name"
                horizontal
                autocomplete="name"
                v-model="obj.name"
              />
              <CTextarea
                label="Description"
                placeholder="Product Description"
                horizontal
                rows="5"
                v-model="obj.description"
              />
              <CRow form class="form-group">
                <CCol tag="label" sm="3" class="col-form-label">
                  Certification
                </CCol>
                <CCol sm="9">
                  <CInputCheckbox
                    v-for="item in certificationList"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value"
                    :checked="item.checked"
                    @click="onCertificationClick(item.value, $event)"
                  />
                </CCol>
              </CRow>

              <!-- <CSelect
                label="Species"
                horizontal
                v-model="obj.species_code"
                :value.sync="obj.species_code"
                :options="options"
                placeholder="Please select"
              /> -->
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
      certificationList: [],
      categoryList: [],
      api: new TatApi(),
      obj: {
        id: "",
        category: {
          id: "",
        },
        certificationList: [],
        description: "",
        name: "",
        customJsonData: ""
      },
    };
  },
  mounted() {
    var self = this;
    self.refreshCategory();
    if (self.$route.params.id) {
      this.api.getProduct(self.$route.params.id).then((response) => {
        self.obj = response.data;
        self.api.getCertificationList().then((response) => {
          for (var i in response.data) {
            var isAvailable = self.containsObject(
              response.data[i].id,
              self.obj.certificationList
            );
            self.certificationList.push({
              value: response.data[i].id,
              label: response.data[i].name,
              checked: isAvailable,
            });
          }
        });
      });
    }else{
      self.api.getCertificationList().then((response) => {
        for (var i in response.data) {
          self.certificationList.push({
            value: response.data[i].id,
            label: response.data[i].name,
            checked: false,
          });
        }
      });
    }
  },
  methods: {
    // refreshSpecies() {
    //   var self = this;
    //   self.api.getSpeciesList().then((response) => {
    //     for (var i in response.data) {
    //       self.options.push({
    //         value: response.data[i].code,
    //         label: response.data[i].name,
    //       });
    //     }
    //   });
    // },
    refreshCategory() {
      var self = this;
      self.api.getCategoryList().then((response) => {
        for (var i in response.data) {
          self.categoryList.push({
            value: response.data[i].id,
            label: response.data[i].name,
          });
        }
      });
    },
  onCertificationClick(value, event) {
      var self = this;
      if (event.target.checked) {
        if (!self.containsObject(value, self.obj.certificationList)) {
          self.obj.certificationList.push({
            id: value,
          });
        }
      } else {
        self.removeObject(value, self.obj.certificationList);
      }
    },
    removeObject(obj, list) {
      var removeIndex = list
        .map(function(item) {
          return item.id;
        })
        .indexOf(obj);
      list.splice(removeIndex, 1);
    },
    containsObject(obj, list) {
      var i;
      for (i = 0; i < list.length; i++) {
        if (list[i].id === obj) {
          return true;
        }
      }

      return false;
    },
    onSubmit(evt) {
      evt.preventDefault();
      var self = this;
      if (self.obj.id == "") {
        this.api.createProduct(self.obj).then((response) => {
          self.$router.push({ path: "/track/productlist" });
        });
      } else {
        this.api.updateProduct(self.obj).then((response) => {
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
