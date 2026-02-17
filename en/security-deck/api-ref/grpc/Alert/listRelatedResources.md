---
editable: false
---

# Security Deck Alerts API, gRPC: AlertService.ListRelatedResources

List alert related resources.

## gRPC request

**rpc ListRelatedResources ([ListAlertRelatedResourcesRequest](#yandex.cloud.securitydeck.alerts.v1.ListAlertRelatedResourcesRequest)) returns ([ListAlertRelatedResourcesResponse](#yandex.cloud.securitydeck.alerts.v1.ListAlertRelatedResourcesResponse))**

## ListAlertRelatedResourcesRequest {#yandex.cloud.securitydeck.alerts.v1.ListAlertRelatedResourcesRequest}

```json
{
  "alert_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| alert_id | **string**

Required field. Alert ID.

The maximum string length in characters is 50. ||
|| page_size | **int64**

Number of results per page.

The maximum value is 1000. ||
|| page_token | **string**

Token for the results page.

The maximum string length in characters is 200. ||
|#

## ListAlertRelatedResourcesResponse {#yandex.cloud.securitydeck.alerts.v1.ListAlertRelatedResourcesResponse}

```json
{
  "related_resources": [
    {
      // Includes only one of the fields `cloud_resource`
      "cloud_resource": {
        "id": "string",
        "type": "string",
        "parent": "RelatedCloudResource"
      }
      // end of the list of possible fields
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| related_resources[] | **[RelatedResource](#yandex.cloud.securitydeck.alerts.v1.RelatedResource)**

List of related resources. ||
|| next_page_token | **string**

Token for getting the next page of the list. ||
|#

## RelatedResource {#yandex.cloud.securitydeck.alerts.v1.RelatedResource}

A resource related to some entity (e.g. to alert).

#|
||Field | Description ||
|| cloud_resource | **[RelatedCloudResource](#yandex.cloud.securitydeck.alerts.v1.RelatedCloudResource)**

A Yandex Cloud resource.

Includes only one of the fields `cloud_resource`. ||
|#

## RelatedCloudResource {#yandex.cloud.securitydeck.alerts.v1.RelatedCloudResource}

A Yandex Cloud resource related to some entity

#|
||Field | Description ||
|| id | **string**

Resource ID. ||
|| type | **string**

Resource type (e.g. "iam.serviceAccount", "compute.instance"). ||
|| parent | **[RelatedCloudResource](#yandex.cloud.securitydeck.alerts.v1.RelatedCloudResource)**

Parent for this resource.
E.g. "resource-manager.folder" if resource is in a folder.
Optional. May be absent if was not specified by alert provider. ||
|#