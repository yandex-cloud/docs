# Fixing the `Validation error Request failed with status code 500` error when saving a dashboard



## Issue description {#issue-description}

When saving the dashboard, you see this error:

```text
Validation error
"Error: Request failed with status code 500
at t.exports (https://yastatic.net/s3/cloud/datalens/static/freeze/js/vendors.1108fcc0.js:2:6017)
at t.exports (https://yastatic.net/s3/cloud/datalens/static/freeze/js/vendors.1108fcc0.js:2:8466)
at XMLHttpRequest.y (https://yastatic.net/s3/cloud/datalens/static/freeze/js/vendors.1108fcc0.js:2:1286)"
```

## Solution {#issue-resolution}

For the dashboard name, you can only use these characters: 

* Uppercase or lowercase Latin or Cyrillic letters.
* Digits.
* Hyphen, period, and space.

Try changing the name of the dashboard if it contains any invalid characters.

## If the issue persists {#if-issue-still-persists}

If the above recommendations did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Link to the dashboard in question.
1. [HAR-file](../../../support/create-har.md) built when attempting to add a joined table to the dataset.
