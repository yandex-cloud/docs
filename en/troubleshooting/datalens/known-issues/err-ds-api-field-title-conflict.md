# Fixing the `ERR.DS_API.FIELD.TITLE.CONFLICT` error in {{ datalens-name }}


## Issue description {#issue-description}

When validating a dataset, you get this error:

```
Failed to validate dataset.
```

## Diagnostics and issue reproduction {#issue-diagnostics-and-reproduction}

If this error occurs, the **Additional information** section shows the `Field title conflicts with another field` and `ERR.DS_API.FIELD.TITLE.CONFLICT` messages.

## Solution {#issue-resolution}

This issue occurs due to field name conflicts. The name of the field you add must not coincide with any existing field in the dataset. Check that you set a unique name for this field in your dataset.

A field with this name might have been added to the chart first, and then to the dataset used for the chart. In this case, rename the field added to the chart.

![image](../../../_assets/troubleshooting/datalens/duplicate-chart-fields-example.png)

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Link to the object in question from the browser address bar.
1. Full text of the error message with the `Request ID`.
1. [HAR file](../../../support/create-har.md) with the recorded results of browser interaction with {{ datalens-name }} servers.