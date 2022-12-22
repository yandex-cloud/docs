## Highmaps {#highmaps}

### General information {#common}

As a result of executing the Highmaps tab, data required for setting up a map with [Highmaps](http://api.highcharts.com/highmaps) tools should be exported.

### Example {#example}

```js
module.exports = {
    title: {
        text: 'Title'
    },
    subtitle: {
        text: 'Subtitle'
    },
    plotOptions: {
        map: {
            dataLabels: {
                // show values on points
                enabled: true
            }
        }
    }
};
```
