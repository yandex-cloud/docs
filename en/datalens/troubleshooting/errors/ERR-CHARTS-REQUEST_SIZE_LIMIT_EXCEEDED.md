# Request size limit exceeded

`ERR.CHARTS.REQUEST_SIZE_LIMIT_EXCEEDED`

Data amount limit exceeded.

This error occurs when the amount of incoming data to be shown on a chart is too large.
Each visualization type in {{ datalens-short-name }} has its own {% if product == "yandex-cloud" %}[limit](../../concepts/limits.md){% else %}limit{% endif %} for the number of rows.

To correct the error, reduce the amount of data requested, for example:

* Use filters.
* For **Table** visualizations, go to the {% if product == "yandex-cloud" %}[chart settings](../../concepts/chart/settings#common-settings){% else %}chart settings{% endif %} and enable **Pagination**.
* For **Table** or **Summary table** visualizations, reduce the number of dimensions in the **Columns** or **Rows** section.

