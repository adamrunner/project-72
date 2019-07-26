<template>
  <tr :id="_id">
    <td>{{description}}</td>
    <td>{{hostname}}</td>
    <td><base-field v-bind="current_temp" /> </td>
    <td><base-field v-bind="current_humidity" /></td>
    <td><base-field v-bind="current_heat_index" /></td>
    <td><base-field v-bind="current_voltage" /></td>
    <td><base-field v-bind="current_battery" /></td>
    <td>{{entries_count}}</td>
    <td>{{friendlyTimeStamp}}</td>
    <td>{{timestamp}}</td>
  </tr>
</template>

<script>
  import BaseField from './base_field'
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
      created_at: '',
      battery_present: '',
    },
    components: {
      BaseField
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