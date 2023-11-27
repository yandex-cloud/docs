# How to set up SQL query filtering



## Scenario description {#case-description}

You need to set up SQL query filtering.

## Solution {#case-resolution}

Currently, there is filtering only by the `hostname` and `error_severity` fields.

One way to work with logs would be to export them from the API service and import them, for instance, to the `Cloud Logging` service, where you can [filter and view the logs](../../../logging/concepts/filter).

You can also export queries using a script and perform filtering with console utilities.

