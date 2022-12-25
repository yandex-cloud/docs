## Config {#config}

### General information {#common}

As a result of executing the Config tab, data responsible for additional configuration should be exported.

### Example {#example}

**Config** tab
```js
module.exports = {
    // table title, a short entry
    // title: 'Table title',
    // table title with styles
    title: {
        // title text
        text: 'Table title',
        // Title CSS styles
        style: {
            'text-align': 'center',
            'font-size': '20px'
        }
    },
    // ID of the table head column to sort data by
    sort: 'date',
    // sorting order: 'acs' - Ascending, 'desc' - Descending
    order: 'asc'
};
```
