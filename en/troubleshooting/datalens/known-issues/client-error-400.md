# Resolving the "Bad Request for url MetrikaHttpApiException direct_client_logins" error


## Issue description {#issue-description}

When you are connecting to the Yandex Metrica API, the `direct_client_logins` parameter is not specified in the connection URL

## Solution {#issue-resolution}

Make sure to add the `direct_client_logins` parameter to your request. For more details, see [here](https://yandex.ru/dev/metrika/doc/api2/api_v1/direct-clicks.html?lang=ru).

Currently, DataLens cannot deliver this parameter and the like, therefore, you cannot build a chart in this way, but you can [export data to ClickHouse](https://cloud.yandex.ru/docs/datalens/qa/#uploading-data-logs-api).

