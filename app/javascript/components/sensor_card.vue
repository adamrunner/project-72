<template>
  <div class="card sensor-card" v-bind:id="_id">

    <a href="javascript:void(0)" class='close-card'>
      <span class="fa fa-times"></span>
    </a>

    <h4 class="card-header">{{description}}</h4>
    <ul class="temperature-info">
      <template v-if='current_battery'>
      <li class="heading">Battery Low</li>
      <li class="temperature-value"><span class="temp_value">{{current_battery_low}}</span></li>
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
      <p class="card-text">{{hostname}}</p>
    </div>
    <div class="card-footer">
      <p class="text-muted time_ago">Updated {{timestamp}}</p>
      <p class="text-muted time_ago">{{friendlyTimeStamp}}</p>
      <p class="text-muted time_ago">Entries: {{entries_count}}</p>
    </div>
  </div>

</template>

<script>
  import moment from 'moment'
  export default {
    computed: {
      timestamp: function() {
        return moment(this.current_updated_at).toString()
      }
    },
    watch: {
      current_updated_at: function(value) {
        this.friendlyTimeStamp = moment(value).calendar()
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
        friendlyTimeStamp: moment(this.current_updated_at).calendar()
      }
    }
  }
</script>

<style>
</style>