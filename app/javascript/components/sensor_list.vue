<template>
  <table class="table table-bordered table-striped">
    <thead> 
      <th>Description</th>
      <th>Hostname</th>
      <th>Temp</th>
      <th>Humidity</th>
      <th>Heat Index</th>
      <th>Voltage</th>
      <th>Battery</th>
      <th>Entries</th>
      <th>Friendly Time Stamp</th>
      <th>Timestamp</th>
    </thead>
    <tbody>
      <sensor-row v-for="sensor in sensors"
        v-bind:key="sensor._id"
        v-bind="sensor"
        ></sensor-row>      
    </tbody>
  </table>
</template>
<script>
  import SensorRow from './sensor_row.vue'
  export default {
    components: { SensorRow },
    props: {
      sensors: Object
    },
    data: function () {
      return {
      }
    }
  }
</script>
<style>
</style>