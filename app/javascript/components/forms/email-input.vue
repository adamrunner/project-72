<template>
  <div>
    <label v-if="showLabel">{{title}}</label>
    <input type='email' class="form-control"
      v-bind:value="value"
      v-on:input="$emit('input', $event.target.value)"
      v-bind:name="name"
      v-bind:placeholder="placeholder" >
  </div>
</template>
<script>
  import _ from 'lodash'
  export default {
    // components: { },
    props: {
      value: String,
      name: String,
      placeholder: String,
      showLabel: {
        type: Boolean,
        default: true
      }
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