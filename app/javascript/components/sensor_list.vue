
<template>
  <div class="card-deck">
    <sensor-card v-for="sensor in sensors"
      v-bind:key="sensor._id"
      v-bind:_id="sensor._id"
      v-bind:hostname="sensor.hostname"
      v-bind:updated_at="sensor.updated_at"
      v-bind:description="sensor.description"
      v-bind:entries_count="sensor.entries_count"
      v-bind:current_updated_at="sensor.current_updated_at"
      v-bind:battery_threshold="sensor.battery_threshold"
      v-bind:current_battery_low="sensor.current_battery_low"
      v-bind:current_battery="sensor.current_battery"
      v-bind:current_voltage="sensor.current_voltage"
      v-bind:current_temp="sensor.current_temp"
      v-bind:current_humidity="sensor.current_humidity"
      v-bind:current_heat_index="sensor.current_heat_index"
      ></sensor-card>
  </div>
</template>
<script>
  import SensorCard from './sensor_card.vue'
  export default {
    components: { SensorCard },
    props: {
      sensors: {}
    },
    data: function () {
      return {
      }
    }
  }
</script>
<style scoped>
</style>