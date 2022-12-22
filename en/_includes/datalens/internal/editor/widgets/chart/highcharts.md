## Highcharts {#highcharts}

### General information {#common-highcharts}

As a result of executing the Highcharts tab, data required for chart configuration using
[Highcharts](http://api.highcharts.com/highcharts) tools should be exported.

### Example {#example-highcharts}

```js
module.exports = {
    chart: {
        // changes the chart background
        backgroundColor: '#ffeba0'
    },
    title: {
        text: 'Title'
    },
    subtitle: {
        text: 'Subtitle'
    },
    yAxis: {
        title: {
            text: 'Text for the Y-axis',
            // makes the text red and bold
            style: {
                color: '#ff0000',
                fontWeight: 'bold'
            }
        }
    },
    plotOptions: {
        // for all chart types
        series: {
            // connect nulls
            connectNulls: true
        }
    }
};
```
