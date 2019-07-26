<template>
  <span>
    {{value}}{{unit}}
  </span>
</template>
<script>
  export default {
    props: {
      value: '',
      unit: ''
    },
    data: function () { 
      return {
        
      }
    }
  }
</script>
<style scoped>
</style>