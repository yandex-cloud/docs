---
editable: false
sourcePath: en/_api-ref-grpc/cdn/v1/api-ref/grpc/Shielding/listAvailableLocations.md
---

# Cloud CDN API, gRPC: ShieldingService.ListAvailableLocations

Lists available geographical locations.

## gRPC request

**rpc ListAvailableLocations ([ListShieldingLocationsRequest](#yandex.cloud.cdn.v1.ListShieldingLocationsRequest)) returns ([ListShieldingLocationsResponse](#yandex.cloud.cdn.v1.ListShieldingLocationsResponse))**

## ListShieldingLocationsRequest {#yandex.cloud.cdn.v1.ListShieldingLocationsRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

Request to list available geographical locations for shielding.

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder for which to request a list of locations where shielding can be activated. ||
|| page_size | **int64**

Maximum number of results per page. ||
|| page_token | **string**

Page token. To get the next page of results,
set `page_token` to the [ListShieldingLocationsResponse.next_page_token](#yandex.cloud.cdn.v1.ListShieldingLocationsResponse)
returned by a previous list response. ||
|#

## ListShieldingLocationsResponse {#yandex.cloud.cdn.v1.ListShieldingLocationsResponse}

```json
{
  "shielding_locations": [
    {
      "location_id": "int64",
      "data_center": "string",
      "country": "string",
      "city": "string"
    }
  ],
  "next_page_token": "string"
}
```

Response for the list of available shielding locations.

#|
||Field | Description ||
|| shielding_locations[] | **[ShieldingDetails](#yandex.cloud.cdn.v1.ShieldingDetails)**

List of available shielding locations, each representing a potential geographical location for the shielding server. ||
|| next_page_token | **string**

Token for getting the next page of results. ||
|#

## ShieldingDetails {#yandex.cloud.cdn.v1.ShieldingDetails}

Message representing the details of a shielding server.

#|
||Field | Description ||
|| location_id | **int64**

Unique identifier for the geographical location of the shielding server. ||
|| data_center | **string**

Name of the data center where the shielding server is located. ||
|| country | **string**

Country where the shielding server's data center is located, useful for understanding geographical distribution. ||
|| city | **string**

City where the shielding server's data center is situated, providing a more precise location than just the country. ||
|#