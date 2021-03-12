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
              <CInput
                description="Profile Phone"
                label="Phone"
                horizontal
                autocomplete="phone"
                v-model="obj.phone"
              />
              <CSelect
                label="Organization"
                horizontal
                v-model="obj.organization.id"
                :value.sync="obj.organization.id"
                :options="organizationList"
                placeholder="Please select"
              />
              <!-- <CSelect
                label="Role"
                horizontal
                v-model="obj.role_code"
                :value.sync="obj.role_code"
                :options="roleList"
                placeholder="Please select"
              /> -->
              <CRow form class="form-group">
                <CCol tag="label" sm="3" class="col-form-label">
                  Organization Type
                </CCol>
                <CCol sm="9">
                  <CInputCheckbox
                    v-for="item in roleList"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value"
                    :checked="item.checked"
                    @click="onRoleClick(item.value, $event)"
                  />
                </CCol>
              </CRow>
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
        name: "",
        email: "",
        password: "",
        phone: "",
        organization: {
          id: "",
        },
        roleList: [],
        isActive: "",
        customJsonData: "",
      },
    };
  },
  mounted() {
    var self = this;
    self.refreshOrganization();
    // self.refreshRole();
    if (self.$route.params.id) {
      this.api.getProfile(self.$route.params.id).then((response) => {
        self.obj = response.data;
        self.api.getRoleList().then((response) => {
          for (var i in response.data) {
            var isAvailable = self.containsObject(
              response.data[i].id,
              self.obj.roleList
            );
            self.roleList.push({
              value: response.data[i].id,
              label: response.data[i].name,
              checked: isAvailable,
            });
          }
        });
      });
    } else {
      self.api.getRoleList().then((response) => {
        for (var i in response.data) {
          self.roleList.push({
            value: response.data[i].id,
            label: response.data[i].name,
            checked: false,
          });
        }
      });
    }
  },
  methods: {
    onOrganizationClick(event) {
      console.log(event);
    },
    onRoleClick(value, event) {
      var self = this;
      if (event.target.checked) {
        if (!self.containsObject(value, self.obj.roleList)) {
          self.obj.roleList.push({
            id: value,
          });
        }
      } else {
        self.removeObject(value, self.obj.roleList);
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
    refreshRole() {
      var self = this;
      self.api.getRoleList().then((response) => {
        for (var i in response.data) {
          self.roleList.push({
            value: response.data[i].id,
            label: response.data[i].name,
          });
        }
      });
    },

    onSubmit(evt) {
      evt.preventDefault();
      var self = this;
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
