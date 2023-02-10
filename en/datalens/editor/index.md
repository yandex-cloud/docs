# Quick start in the ChartEditor

{% if audience == "internal" %}

## Access to the ChartEditor {#access}

{% include [access](../../_includes/datalens/internal/editor/access.md) %}

{% endif %}

## New chart

### With a template {#with-template}

1. Create new chart in [ChartEditor](https://charts.yandex-team.ru/editor).
   Choose the template that best suits your needs.

2. Click "preview" to see the result of the script.

### Without templates or API requests {#without-template}

1. Create new chart in [ChartEditor](https://charts.yandex-team.ru/editor). Specify the 
   `without template` option. For simple chart rendering, just fill in the `JavaScript` tab.

2. Editing the `JavaScript` tab
```(js)
const preparedData = {
    graphs: [
        {
            data: [
                76400445,
                86400445,
                96672938
            ],
        },
    ],
    categories_ms: [
        1417392000000,
        1417478400000,
        1417564800000,
    ]
};

module.exports = preparedData;

```

As a result, a single line with three points is shown.

---

By editing the parameters and code in the tabs, you'll change the chart. Don't forget to save
 and publish it. For more information about the architecture, tabs, and how they work, see [Architecture](architecture.md).

## Debugging {#debug}

To debug your code, enable the Javascript console in your browser and click

`Preview` to have all debugging information displayed in the console.

To display additional information in a particular place in the code, write:

```js
console.log(value);
```

If there are errors in the code, you'll see:

```js
Config:8
    subtitle: `Scale: ${scale}`,
    ^^^^^^^^

SyntaxError: Unexpected identifier
```

You can clearly see from this response that the error occurred on the `Config` tab, in line 8.
