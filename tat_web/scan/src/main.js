import Vue from 'vue'
import App from './App.vue'
import '../node_modules/timeline-vuejs/dist/timeline-vuejs.css'
import Router from 'vue-router'
import Api from './lib/api'
import axios from 'axios'
// const NotFound = { template: '<p>Page not found</p>' }
// const Home = { template: '<p>home page</p>' }
// const About = { template: '<p>about page</p>' }
// const NotFound = () => import('./components/NotFound')
const Home = () => import('./components/Home')
const Scan = () => import('./components/Scan')

window.api = new Api();

Vue.config.productionTip = false

Vue.use(Router)

const router = new Router({
  mode: 'history',
  routes: configRoutes()
})

function configRoutes() {
  return [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/:id',
    name: 'Scan',
    component: Scan
  },
]}

new Vue({
  el: '#app',
  router,
  template: '<App/>',
  components: {
    App
  },
})

// new Vue({ el: '#app', router, render: h => h(App) })

