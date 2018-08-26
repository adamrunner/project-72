<template>
    <button type="button" class="btn btn-primary">{{title}}</button>
</template>
<script>
  import _ from 'lodash'
  export default {
    // components: { },
    props: {
      name: String,
    },
    methods: {
      // handleClick: function(event) {
      //   debugger
      //   console.log("clicked!")
      // }
    },
    computed: {
      title: function(){
        return _.capitalize(this.name)
      }
    },
    data: function () {
      return {
      }
    }
  }
</script>
<style>
</style>