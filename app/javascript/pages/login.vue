<template>
<div class="text-center">
  <alert v-bind:message="loginMessage" v-bind:alert-type="alertType" v-if="loginResponse"></alert>
  <form class="form-signin">
    <h1 class="h3 mb-3 font-weight-normal">Please sign in</h1>
    <email-input name="email" v-model="email" placeholder="user@example.com" :show-label="false"></email-input>
    <password-input name="password" v-model="password" placeholder="password" :show-label="false"></password-input>
    <button-input name="login" v-on:click.native="submitLogin"></button-input>
  </form>
</div>
</template>
<script>
import emailInput from '../components/forms/email-input.vue'
import passwordInput from '../components/forms/password-input.vue'
import buttonInput from '../components/forms/button-input.vue'
import alert from '../components/alert.vue'
import userService from '../services/user'
export default {
  components: {
    'email-input': emailInput,
    'password-input': passwordInput,
    'button-input': buttonInput,
    'alert': alert,
  },
  methods: {
    submitLogin: function(event) {
      var that = this
      userService.login(this.email, this.password).then(function(data){
        that.loginResponse = data;
      })
    }
  },
  watch: {},
  computed: {
    loginMessage: function() {
      if (this.loginResponse.token) {
        return "Login successful."
      } else {
        return "Invalid username or password provided."
      }
    },
    alertType: function() {
      if (this.loginResponse.token) {
        return "success"
      } else {
        return "danger"
      }
    }
  },
  props: {
    email: String,
    password: String,
    loginResponse: Object,
    loginResponseCode: Number,
  },
  data: function() {
    return {}
  }
}
</script>
<style>
</style>