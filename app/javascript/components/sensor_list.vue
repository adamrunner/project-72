<template>
  <div class="card-deck sensor-list">
    <sensor-card v-for="sensor in sensors"
      v-bind:key="sensor._id"
      v-bind="sensor"
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
<style>
</style>