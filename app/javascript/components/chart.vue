<template>
  <highcharts :options="chartOptions"></highcharts>
</template>
<script>
  import {Chart} from 'highcharts-vue'
  export default {
    components: {
      highcharts: Chart
    },
    computed: {
    },
    props: {
      chartData: Array,
      title:  String,
      x_title:String,
      y_title:String,
      legend: String
    },
    data: function () {
      return {
        chartOptions: {
          chart: {
            zoomType: 'x'
          },
          title: {
            text: this.title
          },
          subtitle: {
            text: document.ontouchstart === undefined ?
                  'Click and drag in the plot area to zoom in' : 'Pinch the chart to zoom in'
          },
          xAxis: {
            title: this.x_title,
            type: 'datetime'
          },
          series: this.chartData,
          yAxis: {
            title: {
              text: this.y_title
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
<style>
</style>