# How to set up SQL query filtering



## Case description {#case-description}

You need to set up SQL query filtering.

## Solution {#case-resolution}

Currently, you can only filter queries by the `hostname` and `error_severity` fields.

You can also work with logs by exporting them from the service API and importing them to {{ cloud-logging-name }}, where you can [filter and view the logs](../../../logging/concepts/filter.md). 

You can also export queries using a script and perform filtering with console utilities.