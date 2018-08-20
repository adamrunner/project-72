<template>
  <highcharts :options="chartOptions"></highcharts>
</template>
<script>
  import {Chart} from 'highcharts-vue'
  export default {
    components: {
      highcharts: Chart
    },
    watch: {
      chartData: function(value) {
        this.chartOptions.series = value
      },
      title: function(value){
        this.chartOptions.title.text = value
      },
      x_title: function(value){
        this.chartOptions.xAxis.title = value
      },
      y_title: function(value){
        this.chartOptions.yAxis.title = value
      },
      legend: function(value){
        this.chartOptions.legend.enabled = value
      }
    },
    computed: {
    },
    props: {
      chartData: [],
      title: '',
      x_title:'',
      y_title:'',
      legend:''
    },
    data: function () {
      return {
        chartOptions: {
          chart: {
            zoomType: 'x'
          },
          title: {
            text: ''
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
              text:''
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