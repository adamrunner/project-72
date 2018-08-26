<template>
  <div v-bind:class="alertClasses" role="alert">
    {{message}}
  </div>
</template>
<script>
  export default {
    props: {
      alertType: {
        type: String,
        required: true,
        default: 'primary'
      },
      message: {
        type: String,
        required: true
      }
    },
    computed: {
      alertClasses: function(){
        return `alert alert-${this.alertType}`
      }
    },
    data: function() {
      return {}
    }
  }
</script>
<style>
</style>