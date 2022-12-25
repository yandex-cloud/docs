## JavaScript {#javascript}

### General information {#common}

As a result of executing the JavaScript tab, data required for rendering Wiki text should be exported.

### Available methods {#available-methods}

* **`ChartEditor.getParams()`**: Returns an object with normalized parameters.

* **`ChartEditor.getLoadedData()`**: Returns an object with data requested in the URLs tab.

* **`ChartEditor.updateConfig(config)`**: Extends the definition of the [Config](config.md) tab output with the `config` argument.

### Example {#example}

```js
// writing Wiki text

const text1 = 'Bold text';
const text2 = 'Monospaced text';
// using a template string
const wiki1 =
`**${text1}**
//Italic text//
__Underlined text__
##${text2}##`;

const text3 = 'Question';
const text4 = 'Note';
// using concatenation of strings with line breaks (\n)
const wiki2 = '\n--Strikethrough text--'
    + '\n??' + text3 + '??\n'
    + '!!' + text4 + '!!\n'
    + '!!(blue)Blue text!!';

// exporting data for rendering
module.exports = {
    content: wiki1 + wiki2
};
```
