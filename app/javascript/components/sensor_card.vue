<template>
  <div class="card sensor-card" v-bind:id="_id">

    <a href="javascript:void(0)" class='close-card'>
      <span class="fa fa-times"></span>
    </a>

    <h4 class="card-header">{{hostname}}</h4>
    <ul class="temperature-info">
      <li class="heading">Battery Low</li>
      <li class="temperature-value"><span class="temp_value">{{current_battery_low}}</span></li>
      <template v-if='current_battery'>
        <li class="heading">Battery</li>
        <li class="temperature-value"><span class="temp_value">{{current_battery.value}}{{current_battery.unit}}</span></li>
      </template>
      <template v-if='current_voltage'>
        <li class="heading">Voltage</li>
        <li class="temperature-value"><span class="temp_value">{{current_voltage.value}}{{current_voltage.unit}}</span></li>
      </template>
      <template v-if='current_temp'>
        <li class="heading">Temp</li>
        <li class="temperature-value"><span class="temp_value">{{current_temp.value}}{{current_temp.unit}}</span></li>
      </template>
      <template v-if='current_humidity'>
        <li class="heading">Humidity</li>
        <li class="temperature-value"><span class="temp_value">{{current_humidity.value}}{{current_humidity.unit}}</span></li>
      </template>
      <template v-if='current_heat_index'>
        <li class="heading">Feels Like</li>
        <li class="temperature-value"><span class="temp_value">{{current_heat_index.value}}{{current_heat_index.unit}}</span></li>
      </template>
    </ul>
    <div class="card-block">
      <p class="card-text">{{description}}</p>
    </div>
    <div class="card-footer">
      <p class="text-muted time_ago">Updated {{fromNow}}</p>
      <p class="text-muted time_ago">Entries: {{entries_count}}</p>
    </div>
  </div>

</template>

<script>
  import moment from 'moment'
  export default {
    computed: {
      fromNow: function() {
        return moment(this.updated_at).fromNow()
      }
    },
    watch: {
      current_updated_at: function() {
        this.fromNow = moment(this.updated_at).fromNow()
      }
    },
    props: {
      _id: '',
      hostname: '',
      updated_at: '',
      description: '',
      entries_count: '',
      current_updated_at: '',
      battery_threshold: '',
      current_battery_low: '',
      current_battery: '',
      current_voltage: '',
      current_temp: '',
      current_humidity: '',
      current_heat_index: '',
    },
    data: function () {
      return {
      }
    }
  }
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>