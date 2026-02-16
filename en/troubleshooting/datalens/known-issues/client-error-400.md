# Fixing the `Bad Request for url MetrikaHttpApiException direct_client_logins` error



## Issue description {#issue-description}

When connecting through the {{ metrika }} API, the `direct_client_logins` parameter is not specified in the URL.

## Solution {#issue-resolution}

To create a request, you need to provide the `direct_client_logins` parameter. For more details, see [here](https://yandex.ru/dev/metrika/doc/api2/api_v1/direct-clicks.html?lang=ru).

Currently, {{ datalens-short-name }} cannot deliver this parameter and the like; therefore, you cannot build a chart this way, but you can [export data to {{ CH }}](../../../datalens/qa/index.md#uploading-data-logs-api).

