<template>
  <div>
    <CRow>
      <CCol sm="12">
        <CCard>
          <CCardHeader> <strong> Product </strong> Info </CCardHeader>
          <CCardBody>
            <CForm>
              <CInput
                description="Product Code"
                label="Code"
                horizontal
                autocomplete="code"
              />
              <CInput
                description="Product Name"
                label="Name"
                horizontal
                autocomplete="name"
              />
              <CTextarea
                label="Descirption"
                placeholder="Product description..."
                horizontal
                rows="9"
              />
              <CSelect
                label="Species"
                horizontal
                :options=options
                placeholder="Please select"
              />
            </CForm>
          </CCardBody>
          <CCardFooter>
            <CButton type="submit" size="sm" color="primary"
              ><CIcon name="cil-check-circle" /> Submit</CButton
            >
            <CButton type="reset" size="sm" color="danger" @click="create"
              ><CIcon name="cil-ban" /> Reset</CButton
            >
          </CCardFooter>
        </CCard>
      </CCol>
    </CRow>
  </div>
</template>

<script>
export default {
  name: "Product",
  data: () => {
    return {
        options: [1,2]
    }
  },
  mounted() {},
  methods: {
    create() {
      alert("hi");
    },
  },
};
</script>
