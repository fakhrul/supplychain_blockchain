<template>
  <div>
    <CRow>
      <CCol sm="12">
        <CCard>
          <CCardHeader> <strong> Track </strong> Update </CCardHeader>
          <CCardBody>
            <CForm>
              <CInput label="Id" v-model="obj.id" horizontal plaintext />
              <CInput
                description="Updater"
                label="Code"
                horizontal
                autocomplete="code"
                v-model="obj.code"
              />
              <CInput
                description="Product Code"
                label="Code"
                horizontal
                autocomplete="code"
                v-model="obj.code"
              />
              <CSelect
                label="Activity"
                horizontal
                v-model="obj.activity_code"
                :value.sync="obj.activity_code"
                :options="activityList"
                placeholder="Please select"
              />
              <CSelect
                label="Location"
                horizontal
                v-model="obj.location_code"
                :value.sync="obj.location_code"
                :options="locationList"
                placeholder="Please select"
              />
             <CTextarea
                label="Information"
                placeholder="Information..."
                horizontal
                rows="9"
                v-model="obj.info"
              />
             <CTextarea
                label="Remarks"
                placeholder="Product description..."
                horizontal
                rows="9"
                v-model="obj.remarks"
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
  name: "TrackUpdate",
  data: () => {
    return {
      activityList: [],
      locationList: [],
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
    self.refreshActivity();
    self.refreshLocation();
    if (self.$route.params.id) {
      this.api.getProduct(self.$route.params.id).then((response) => {
        self.obj = response;
      });
    }
  },
  methods: {
    refreshActivity() {
      var self = this;
      self.api.getActivityList().then((response) => {
        for (var i in response.data) {
          self.activityList.push({
            value: response.data[i].code,
            label: response.data[i].name,
          });
        }

      });
    },
    refreshLocation() {
      var self = this;
      self.api.getLocationList().then((response) => {
        for (var i in response.data) {
          self.locationList.push({
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
