## Config {#config}

### General information {#common}

As a result of executing the Config tab, data responsible for additional display configuration should be exported.

### Example {#example}

```js
module.exports = {
    // formatting displayed values (defaults to null)
    format: {
        // number of decimal places (defaults to 0)
        precision: 1,
        // multuply by 100 and add the percent sign (defaults to true)
        percent: true
    },
    // overriding information displayed in a tooltip (defaults to null)
    // * point is an object indicating data on the point being hovered over
    manageTooltipConfig: (point) => {
        // returns the overriden info
        return {
            // values in the tooltip
            tooltipValues: [
                {
                    // title (defaults to null)
                    title: 'ratio',
                    // value (defaults to 0)
                    value: point.value
                },
                {
                    title: 'dividend',
                    value: point.dividend
                },
                {
                    title: 'divisor',
                    value: point.divider
                }
            ]
        };
    }
};
```
