<template>
  <div class="dashboard">
    <sensor-list v-bind:sensors="sensors"></sensor-list>
    <chart v-bind:chart-data="temperatureChart" title="Temperature Over Time" x_title="Sensors" y_title="ºF"></chart>
    <chart v-bind:chart-data="batteryChart" title="Battery % Over Time" x_title="Sensors" y_title="Batt %"></chart>
  </div>
</template>
<script>
  import HighchartsVue from 'highcharts-vue'
  import SensorList from '../components/sensor_list'
  import Chart      from '../components/chart'
  export default {
    components: {
      'chart': Chart,
      'sensor-list': SensorList
    },
    watch:{
    },
    computed:{

    },
    props: {
    },
    data: function() {
      return {
        sensors: {},
        temperatureChart: [],
        batteryChart: []
      }
    }
  }
</script>
<style>
</style>