# Resolving the `ERR.DS_API.REQUEST_TIMEOUT` error


## Issue description {#issue-description}

Building the chart ends with the `ERR.DS_API.REQUEST_TIMEOUT` error after a long waiting time.

## Solution {#issue-resolution}

You cannot increase the data waiting time threshold on the {{ datalens-name }} side. We recommend decomposing the most resource-consuming tasks or pre-filtering data to reduce its amount.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Link to the problematic object in {{ datalens-name }}, i.e., chart or dashboard.
1. `Request ID` of the problematic query; you can find it on the error page.