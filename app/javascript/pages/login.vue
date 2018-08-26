<template>
  <div class="text-center">
    <alert v-bind:message="loginResponse" v-bind:alert-type="alertType" v-if="loginResponse"></alert>
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
  import axios from 'axios'
  export default {
    components: {
      'email-input': emailInput,
      'password-input': passwordInput,
      'button-input': buttonInput,
      'alert': alert,
    },
    methods:{
      submitLogin: function(event) {
        axios.post('http://localhost:3000/auth', {
          email:    this.email,
          password: this.password
        }).then(response => {
          this.loginResponseCode = response.status
          this.loginResponse = "Logged in successfully!"
          this.emit('login-success', response.data.token)
        }).catch(e => {
          if(e.response.status == 401){
            this.loginResponseCode = e.response.status
            this.loginResponse = "Invalid Email/Password combination, try again!"
          }
        })
      }
    },
    watch:{
    },
    computed:{
      alertType: function() {
        var type;
        switch(this.loginResponseCode){
          case 401:
            type = "danger"
          break;

          case 200:
            type = "success"
          break;
        }
      return type;
      }
    },
    props: {
      email: String,
      password: String,
      loginResponse: String,
      loginResponseCode: Number,
    },
    data: function() {
      return {
      }
    }
  }
</script>
<style>
</style>