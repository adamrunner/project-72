import VueRouter from 'vue-router';
import * as Vue from 'vue/dist/vue.common.js';
import Dashboard from '../pages/dashboard.vue'
import Login from '../pages/login.vue'

Vue.use(VueRouter);

const router = new VueRouter({
  mode: 'history',
  routes: [{
      path: "/",
      redirect: {
        name: "Login"
      }
    },
    {
      path: '/login',
      name: 'Login',
      component: Login
    },
    {
      path: '/dashboard',
      name: 'Dashboard',
      component: Dashboard,
      data: window.data
    }
  ]
})
export default router;