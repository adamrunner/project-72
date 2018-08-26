/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb
import moment from 'moment'
window.moment = moment
import Vue from 'vue'
import HighchartsVue from 'highcharts-vue'
import Dashboard from '../components/dashboard.vue'
import Login from '../pages/login.vue'

document.addEventListener('DOMContentLoaded', () => {
  if (window.user){
    var dashboardElement   = document.body.appendChild(document.createElement('app'))
    Dashboard.data         = window.data
    window.dashboard       = new Vue(Dashboard)
    dashboard.$mount(dashboardElement)
  }else{
    var loginElement = document.body.appendChild(document.createElement('app'))
    window.login       = new Vue(Login)
    login.$mount(loginElement)
  }
})