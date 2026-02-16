# `Total` values in {{ datalens-name }} table charts mismatch the respective data from Yandex Metrica


## Issue description {#issue-description}

When connecting to {{ metrika }}, your table chart in {{ datalens-name }} and data from {{ metrika }} show different values in `Total` fields.

## Solution {#issue-resolution}

Such a behavior results from {{ metrika }} mechanics. When you request data over the API, {{ metrika }} returns an approximate result. 

Accuracy of the provided data is also affected by [sampling](https://yandex.ru/dev/metrika/en/) on the {{ metrika }} side. To make sure that additive metrics show correct total values, change the accuracy in the connection settings to 100%.

A direct connection has certain limitations. We recommend exporting raw data from {{ metrika }} to an intermediate database; e.g., to export or replicate data, you can use a [{{ CH }} database](../../../managed-clickhouse/quickstart.md). Once you export the data to an intermediate database, you can [set up a connection to it](../../../datalens/operations/connection/create-clickhouse.md) from {{ datalens-name }}.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Link to the problematic object from your browser address bar.
1. Full text of the error message with the `Request ID`.
1. [HAR file](../../../support/create-har.md) with the recorded results of browser communication with {{ datalens-name }} servers.