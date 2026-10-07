[Документация Yandex Cloud](../../../../../../index.md) > [Yandex SIEM](../../../../../index.md) > Справочник API > gRPC (англ.) > [Yandex Cloud SIEM Instances API](../index.md) > [SIEMInstance](index.md) > List

# Yandex Cloud SIEM Instances API, gRPC: SIEMInstanceService.List

Retrieves a list of SIEM Instances in Yandex Cloud.
This method is intended for SOC employees, it is necessary to obtain all client SIEM Instances to which there is access.

This returns the result for those SIEM Instances for which the caller has permission `siem.instances.get`.

## gRPC request

**rpc List ([ListInstancesRequest](#yandex.cloud.siem.v1.instances.ListInstancesRequest)) returns ([ListInstancesResponse](#yandex.cloud.siem.v1.instances.ListInstancesResponse))**

## ListInstancesRequest {#yandex.cloud.siem.v1.instances.ListInstancesRequest}

```json
{
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| page_size | **int64**

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`, the service returns a `next_page_token` that can be used
to get the next page of results in subsequent List requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100.

Acceptable values are 0 to 1000, inclusive. ||
|| page_token | **string**

Page token. Set `page_token` to the `next_page_token` returned by a previous List request to
get the next page of results.

The maximum string length in characters is 2000. ||
|#

## ListInstancesResponse {#yandex.cloud.siem.v1.instances.ListInstancesResponse}

```json
{
  "siem_instances": [
    {
      "id": "string",
      "organization_id": "string",
      "name": "string",
      "description": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| siem_instances[] | **[SIEMInstance](#yandex.cloud.siem.v1.instances.SIEMInstance)**

Requested list of SIEM Instances ||
|| next_page_token | **string**

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
|| organization_id | **string**

ID of the Organization that the SIEM instance belongs to. ||
|| name | **string**

Required. Name of the SIEM Instance.
The name is unique within the Organization. Organization can have one SIEM Instance. 1-64 characters long. ||
|| description | **string**

The description of the SIEM Instance. 0-256 characters long. ||
|#