<template>
  <highcharts :options="chartOptions"></highcharts>
</template>
<script>
  // import Highcharts from 'highcharts'
  import {Chart} from 'highcharts-vue'
  export default {
    components: {
      highcharts: Chart
    },
    watch: {
      chartData: function(value) {
        this.chartOptions.series = value
      }
    },
    computed: {
    },
    props: {
      chartData: []
    },
    data: function () {
      return {
        chartOptions: {
          chart: {
            zoomType: 'x'
          },
          title: {
            text: 'Temperature Over Time'
          },
          subtitle: {
            text: document.ontouchstart === undefined ?
                  'Click and drag in the plot area to zoom in' : 'Pinch the chart to zoom in'
          },
          xAxis: {
            type: 'datetime'
          },
          series: [],
          yAxis: {
            title: {
              text: 'Temperature Over Time'
            }
          },
          legend: {
            enabled: true
          },
          plotOptions: {
          }
        }
      }
    }
  }
</script>
<style scoped>
</style>