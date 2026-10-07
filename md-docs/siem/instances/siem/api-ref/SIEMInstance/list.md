[Документация Yandex Cloud](../../../../../index.md) > [Yandex SIEM](../../../../index.md) > Справочник API > REST (англ.) > [Yandex Cloud SIEM Instances API](../index.md) > [SIEMInstance](index.md) > List

# Yandex Cloud SIEM Instances API, REST: SIEMInstance.List

Retrieves a list of SIEM Instances in Yandex Cloud.
This method is intended for SOC employees, it is necessary to obtain all client SIEM Instances to which there is access.

This returns the result for those SIEM Instances for which the caller has permission `siem.instances.get`.

## HTTP request

```
GET https://siem.api.cloud.yandex.net/siem/v1/instances
```

## Query parameters {#yandex.cloud.siem.v1.instances.ListInstancesRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`, the service returns a `next_page_token` that can be used
to get the next page of results in subsequent List requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100.

Acceptable values are 0 to 1000, inclusive. ||
|| pageToken | **string**

Page token. Set `page_token` to the `next_page_token` returned by a previous List request to
get the next page of results.

The maximum string length in characters is 2000. ||
|#

## Response {#yandex.cloud.siem.v1.instances.ListInstancesResponse}

**HTTP Code: 200 - OK**

```json
{
  "siemInstances": [
    {
      "id": "string",
      "organizationId": "string",
      "name": "string",
      "description": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| siemInstances[] | **[SIEMInstance](#yandex.cloud.siem.v1.instances.SIEMInstance)**

Requested list of SIEM Instances ||
|| nextPageToken | **string**

This token allows you to get the next page of results for List requests if the number of
results is larger than `page_size` specified in the request. To get the next page, specify
the value of `next_page_token` as a value for the `page_token` parameter in the next List
request. Subsequent List requests will have their own `next_page_token` to continue paging
through the results. ||
|#

## SIEMInstance {#yandex.cloud.siem.v1.instances.SIEMInstance}

SIEM Instance is instance of Yandex Cloud SIEM

#|
||Field | Description ||
|| id | **string**

Required. Unique ID of the SIEM Instance. ||
|| organizationId | **string**

ID of the Organization that the SIEM instance belongs to. ||
|| name | **string**

Required. Name of the SIEM Instance.
The name is unique within the Organization. Organization can have one SIEM Instance. 1-64 characters long. ||
|| description | **string**

The description of the SIEM Instance. 0-256 characters long. ||
|#