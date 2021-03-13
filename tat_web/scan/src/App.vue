<template>
  <router-view></router-view>
</template>

<script>
export default {
  name: "App",
 
  mounted() {
    // if(!auth.check())
    // {
    //   this.$router.push({ path: '/pages/login' })
    // }
  },
};
</script>


