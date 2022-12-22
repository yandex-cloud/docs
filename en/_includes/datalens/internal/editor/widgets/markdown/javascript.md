## JavaScript {#javascript}

### General information {#common}

As a result of executing the JavaScript tab, data required for Markdown rendering should be exported.

### Available methods {#available-methods}

* **`ChartEditor.getParams()`**: Returns an object with normalized parameters.

* **`ChartEditor.getLoadedData()`**: Returns an object with data requested in the URLs tab.

* **`ChartEditor.getSharedData()`**: Returns an object with data shared by all tabs from the Shared tab .


### Example {#example}

```js
// generating text

const inline = 'To embed a code inside clauses, put the code in apostrophes'
                + '`<html class="ie no-js">`.';

const text = `
# Header h1
## Header h2
### Header h3
#### Header h4

${inline}
`;

// exporting data for rendering
module.exports = {
    markdown: text
};
```
