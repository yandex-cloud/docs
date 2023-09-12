# Values in Total fields of tabular DataLens charts mismatch those in Yandex Metrica

## Issue description {#issue-description}

DataLens uses a connection to Yandex Metrica data.
My tabular chart in DataLens and data from Yandex Metrica show different values in Total fields.

## Solution {#issue-resolution}

Such a behavior results from Yandex Metrica mechanics. When you request data over the API, Yandex Metrica returns an approximate result.
Accuracy of the provided data is also affected by [sampling](https://yandex.ru/dev/metrika/doc/api2/api_v1/sampling.html) on the Yandex Metrica side.

To make sure that additive metrics show correct total values, change the accuracy in the connection settings to 100%.

A direct connection to Yandex Metrica has several limitations. We recommend exporting raw data from Yandex Metrica to an intermediate database. For example, to export and/or replicate data from Yandex Metrica, you can use the [ClickHouse database](../../../managed-clickhouse/quickstart.md).

Once you export the data to an intermediate database, you can [set up a connection to it](../../../datalens/operations/connection/create-clickhouse.md) from DataLens.

## If the issue persists {#if-issue-still-persists}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).
In the request, specify the following information:
1. Link to the problem object from the browser address bar.
2. Full text of the error message with the Request ID content.
3. [HAR file](../../../support/create-har.md) with the recorded results of browser interaction with DataLens servers.