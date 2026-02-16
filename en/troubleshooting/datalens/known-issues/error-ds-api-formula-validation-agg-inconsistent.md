# Fixing the `ERR.DS_API.FORMULA.VALIDATION.AGG.INCONSISTENT` error


## Issue description {#issue-description}

When switching the chart display mode from **{{ ui-key.yacloud_monitoring.wizard.axes.linear }}** to **{{ ui-key.datalens.editor.templates.view.label_metric }}**, you see this error message:

```json

{
"cggk06m72id82_result": {
"code": "ERR.DS_API.FORMULA.VALIDATION.AGG.INCONSISTENT",
"status": 400,
"sourceType": "bi_datasets",
"message": "Inconsistent aggregation among operands",
"details": {}
}
}
"Error: Request failed with status code 427
at t.exports (https://yastatic.net/s3/cloud/datalens/static/freeze/js/vendors.0dfa929f.js:2:6017)
at t.exports (https://yastatic.net/s3/cloud/datalens/static/freeze/js/vendors.0dfa929f.js:2:8466)
at XMLHttpRequest.y (https://yastatic.net/s3/cloud/datalens/static/freeze/js/vendors.0dfa929f.js:2:1286)"

```

## Solution {#issue-resolution}

You can only use grouping by `AGO` in charts where the `X` axis shows a date and the `Y` axis, a dimension. Since there is no `X` axis in the indicator field, you cannot use `AGO`.