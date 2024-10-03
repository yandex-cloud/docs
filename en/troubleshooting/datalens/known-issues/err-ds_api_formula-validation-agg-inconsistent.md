# Resolving the ERR.DS_API.FORMULA.VALIDATION.AGG.INCONSISTENT error


## Issue description {#issue-description}

When switching the display mode of the chart from Line type to Indicator type, you see this error message:

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

AGO grouping can only be used in charts where the X-axis represents dates and the Y-axis represents a dimension.
Since there is no X-axis in the indicator field, you cannot use AGO.
