<template>
</template>
<script>
  import SensorList from './sensor_list'
  import Chart      from './chart'
  export default {
    components: {
      Chart,
      SensorList
    },
    watch:{
      initialState: function(data) {
        // TODO: set up data for different components
      }
    },
    computed:{

    },
    props: {

    },
    data: function() {
      return {

      }
    }
  }
</script>
<style>
</style>