# Resolving the "Validation error Request failed with status code 500" error when saving a dashboard


## Issue description {#issue-description}

* When saving the dashboard, you see this error:

```text
Validation error
"Error: Request failed with status code 500
at t.exports (https://yastatic.net/s3/cloud/datalens/static/freeze/js/vendors.1108fcc0.js:2:6017)
at t.exports (https://yastatic.net/s3/cloud/datalens/static/freeze/js/vendors.1108fcc0.js:2:8466)
at XMLHttpRequest.y (https://yastatic.net/s3/cloud/datalens/static/freeze/js/vendors.1108fcc0.js:2:1286)"
```

## Solution {#issue-resolution}

For the dashboard name, you can only use the following characters: uppercase and lowercase letters (Latin or Cyrillic), digits, hyphen, dot, and space.

Try changing the name of the dashboard if it contains characters not from the approved list.

## If the issue persists {#if-issue-still-persists}

If the above recommendations did not help solve the issue, [create a request for technical support](https://console.cloud.yandex.ru/support?section=contact).
In the request, specify the following information:

1. Link to the problematic dashboard
2. [HAR-file](https://cloud.yandex.ru/docs/support/create-har) built when attempting to add a joined table to the dataset.
