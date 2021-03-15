<template>
  <div>
    <CRow>
      <CCol sm="12">
        <CCard>
          <CCardHeader> <strong> Track </strong> Update </CCardHeader>
          <CCardBody>
            <CForm>
              <CInput label="Id" v-model="obj.id" horizontal plaintext />
              <CSelect
                label="Organization"
                horizontal
                v-model="obj.organization.id"
                :value.sync="obj.organization.id"
                :options="organizationList"
                placeholder="Please select"
                @change="organizationChange($event)"
              />
              <CSelect
                label="Updater"
                horizontal
                v-model="obj.profile.id"
                :value.sync="obj.profile.id"
                :options="profileList"
                placeholder="Please select"
                @change="profileChange($event)"
              />
              <CSelect
                label="Area"
                horizontal
                v-model="obj.area.id"
                :value.sync="obj.area.id"
                :options="areaList"
                placeholder="Please select"
                @change="areaChange($event)"
              />
              <CSelect
                label="Activity"
                horizontal
                v-model="obj.activity.id"
                :value.sync="obj.activity.id"
                :options="activityList"
                placeholder="Please select"
                @change="activityChange($event)"
              />
              <CInput
                description="Product"
                label="Product Id"
                horizontal
                autocomplete=""
                v-model="obj.product.id"
              />
              <CInput
                description="GPS"
                label="GPS"
                horizontal
                autocomplete="asd"
                v-model="obj.gps"
              />
              <p></p>
              <CTextarea
                label="Remarks"
                placeholder="Remarks"
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
      location: null,
      gettingLocation: false,
      organizationList: [],
      profileList: [],
      activityList: [],
      areaList: [],
      api: new TatApi(),
      obj: {
        id: "",
        organization: {
          id: "",
        },
        profile: {
          id: "",
        },
        product: {
          id: "",
        },
        area: {
          id: "",
        },
        activity: {
          id: "",
        },
        name: "",
        customJsonData: "",
        gps: "",
        remarks: "",
      },
    };
  },
  mounted() {
    var self = this;
    self.refreshOrganization();
    if (self.$route.params.id) {
      this.api.getProduct(self.$route.params.id).then((response) => {
        self.obj.product = response.data;
        self.refreshGeoLocation();
      });
    }
  },
  methods: {
    refreshGeoLocation() {
      var self = this;
      if (!("geolocation" in navigator)) {
        alert("Geolocation is not available.");
        return;
      }

      self.gettingLocation = true;
      navigator.geolocation.getCurrentPosition(
        (pos) => {
          self.gettingLocation = false;
          self.location = pos;
          self.obj.gps = self.location.coords.latitude + "," +  self.location.coords.longitude;
          console.log(pos.coords)
        },
        (err) => {
          self.gettingLocation = false;
          alert(err.message);
        }
      );
    },
    activityChange(event) {},
    areaChange(event) {},
    profileChange(event) {},
    organizationChange(event) {
      var self = this;
      self.profileList = [];
      self.areaList = [];
      var organizationId = event.target.value;
      self.api.getOrganization(organizationId).then((response) => {
        self.obj.organization = response.data;
        self.api
          .getProfileByOrganization(self.obj.organization.id)
          .then((response) => {
            for (var i in response.data) {
              self.profileList.push({
                value: response.data[i].id,
                label: response.data[i].name,
              });
            }
          });

        self.api
          .getAreaByOrganization(self.obj.organization.id)
          .then((response) => {
            for (var i in response.data) {
              self.areaList.push({
                value: response.data[i].id,
                label: response.data[i].name,
              });
            }
          });

        console.log(self.obj.organization);
        self.api
          .getActivityByOrganization(self.obj.organization.id)
          .then((response) => {
            for (var i in response.data) {
              self.activityList.push({
                value: response.data[i].id,
                label: response.data[i].name,
              });
            }
          });
      });
    },
    refreshOrganization() {
      var self = this;
      self.api.getOrganizationList().then((response) => {
        for (var i in response.data) {
          self.organizationList.push({
            value: response.data[i].id,
            label: response.data[i].name,
          });
        }
      });
    },

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
      // alert(self.obj.product.id)
      this.api.createTrail(self.obj).then((response) => {
        self.$router.push({
          // path: "/track/history",
          path: `/track/history/${self.obj.product.id}`,
        });
      });
      // } else {
      //   this.api.updateTrail(self.obj).then((response) => {
      //     self.$router.push({
      //       //  path: "/track/history"
      //         path: `/track/history/${self.product.id}`,
      //        });
      //   });
      // }
    },
    onReset(evt) {
      evt.preventDefault();
      this.obj = {};
    },
  },
};
</script>
