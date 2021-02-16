<template>
  <div>
    <CRow>
      <CCol sm="12">
        <CCard>
          <CCardHeader> <strong> Profile </strong> Update </CCardHeader>
          <CCardBody>
            <CForm>
              <CInput label="Id" v-model="obj.id" horizontal plaintext />
              <!-- <CInput
                description="Profile Code"
                label="Code"
                horizontal
                autocomplete="code"
                v-model="obj.code"
              /> -->
              <CInput
                description="Profile Name"
                label="Name"
                horizontal
                autocomplete="name"
                v-model="obj.name"
              />
              <CInput
                description="Profile Email"
                label="Email"
                horizontal
                autocomplete="email"
                v-model="obj.email"
              />
              <CInput
                description="Profile Password"
                label="Password"
                horizontal
                autocomplete="password"
                v-model="obj.password"
              />
              <CSelect
                label="Organization"
                horizontal
                v-model="obj.organization_code"
                :value.sync="obj.organization_code"
                :options="organizationList"
                placeholder="Please select"
              />
              <CSelect
                label="Role"
                horizontal
                v-model="obj.role_code"
                :value.sync="obj.role_code"
                :options="roleList"
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
  name: "Profile",
  data: () => {
    return {
      organizationList: [],
      roleList: [],
      api: new TatApi(),
      obj: {
        id: "",
        code: "",
        name: "",
        email: "",
        password: "",
        organization_code: "",
        role_code: "",
      },
    };
  },
  mounted() {
    var self = this;
    self.refreshOrganization();
    self.refreshRole();
    if (self.$route.params.id) {
      this.api.getProfile(self.$route.params.id).then((response) => {
        self.obj = response;
      });
    }
  },
  methods: {
    refreshOrganization() {
      var self = this;
      self.api.getOrganizationList().then((response) => {
        for (var i in response.data) {
          self.organizationList.push({
            value: response.data[i].code,
            label: response.data[i].name,
          });
        }
      });
    },
    refreshRole() {
      var self = this;
      self.api.getRoleList().then((response) => {
        for (var i in response.data) {
          self.roleList.push({
            value: response.data[i].code,
            label: response.data[i].name,
          });
        }
      });
    },

    onSubmit(evt) {
      evt.preventDefault();
      var self = this;
      if (self.obj.code == "") self.obj.code = self.obj.email;
      if (self.obj.id == "") {
        this.api.createProfile(self.obj).then((response) => {
          self.obj = {};
          self.$router.push({ path: "/admin/profilelist" });
        });
      } else {
        this.api.updateProfile(self.obj).then((response) => {
          self.obj = {};
          self.$router.push({ path: "/admin/profilelist" });
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
