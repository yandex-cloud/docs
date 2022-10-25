# Received too many result data rows

`ERR.DS_API.ROW_COUNT_LIMIT`

Allowed number of rows exceeded.

{{ datalens-short-name }} restricts the amount of data that can be displayed in the chart. Each visualization type has its own {% if product == "yandex-cloud" %}[limit](../../concepts/limits.md){% else %}limit{% endif %} for the number of rows.

To fix the error, use filters to reduce the amount of queried data.

