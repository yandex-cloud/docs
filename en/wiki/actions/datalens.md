# {{ datalens-full-name }} charts

[{{ datalens-full-name }}](https://datalens.yandex-team.ru/) is a service for visualization and {% if lang == "ru" and audience != "internal" %}[analytics](../../glossary/data-analytics){% else %}analytics{% endif %} that enables you to build advanced charts and dashboards based on data from multiple sources.

Read more about the service features in the [{{ datalens-full-name }} documentation](../../datalens/overview.md).

To add a chart to a Wiki page, copy the embed code from the dashboard:
1. Click ![image](../../_assets/options.svg) in the upper-right corner of the chart.
1. Select **Get a link and code** in the drop-down list.
1. Go to the **Wiki** tab.
1. Configure the chart parameters.
1. Copy the code.

Use the obtained `iframe` to embed in the page:

```
{{iframe frameborder="0" width="350px" height="420px" src="https://charts.yandex-team.ru/preview/editor/fwnyltulelsq9?_embedded=1"}}
```
For more information about `iframe` parameters, see [{#T}](iframe.md).