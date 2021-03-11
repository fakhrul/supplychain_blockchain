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
                description="Organization Name"
                label="Name"
                horizontal
                autocomplete="name"
                v-model="obj.name"
              />
              <CRow form class="form-group">
                <CCol tag="label" sm="3" class="col-form-label">
                  Organization Type
                </CCol>
                <CCol sm="9">
                  <CInputCheckbox
                    v-for="item in organizationTypes"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value"
                    :checked="item.checked"
                    @click="onOrganizationTypeClick(item.value, $event)"
                  />
                </CCol>
              </CRow>
              <CTextarea
                label="Address"
                placeholder="Organization Address..."
                horizontal
                rows="5"
                v-model="obj.organizationAddress"
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
      organizationTypes: [],
      // organizationTypes: [
      //   {
      //     label: "a",
      //     value: "A",
      //     checked: false,
      //   },
      //   {
      //     label: "b",
      //     value: "B",
      //     checked: true,
      //   },
      // ],
      obj: {
        id: "",
        name: "",
        organizationTypeIdList: [],
        organizationAddress: "",
        isActive: false,
        customJsonData: "",
      },
    };
  },
  created() {},
  mounted() {
    var self = this;
    if (self.$route.params.id) {
      self.api.getOrganization(self.$route.params.id).then((response) => {
        self.obj = response.data;
        self.api.getOrganizationTypeList().then((response) => {
          for (var i in response.data) {
            var isAvailable = self.containsObject(
              response.data[i].id,
              self.obj.organizationTypeIdList
            );
            self.organizationTypes.push({
              value: response.data[i].id,
              label: response.data[i].name,
              checked: isAvailable,
            });
          }
        });
      });
    } else {
      self.api.getOrganizationTypeList().then((response) => {
        for (var i in response.data) {
          self.organizationTypes.push({
            value: response.data[i].id,
            label: response.data[i].name,
            checked: false,
          });
        }
      });
    }
  },
  methods: {
    onOrganizationTypeClick(value, event) {
      var self = this;
      if (event.target.checked) {
        if (!self.containsObject(value, self.obj.organizationTypeIdList)) {
          self.obj.organizationTypeIdList.push({
            id: value,
          });
        }
      } else {
        self.removeObject(value, self.obj.organizationTypeIdList);
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
      var self = this;
      console.log(self.organizationTypes);
      // this.obj = {};
    },
    organizaitonTypeClick() {
      alert("a");
    },
  },
};
</script>
