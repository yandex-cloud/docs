---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Channel/list.md
---

# Video API, gRPC: ChannelService.List

List channels for organization.

## gRPC request

**rpc List ([ListChannelsRequest](#yandex.cloud.video.v1.ListChannelsRequest)) returns ([ListChannelsResponse](#yandex.cloud.video.v1.ListChannelsResponse))**

## ListChannelsRequest {#yandex.cloud.video.v1.ListChannelsRequest}

```json
{
  "organization_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "order_by": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| organization_id | **string**

Required field. ID of the organization. ||
|| page_size | **int64**

The maximum number of the results per page to return. Default value: 100. ||
|| page_token | **string**

Page token for getting the next page of the result. ||
|| order_by | **string**

By which column the listing should be ordered and in which direction,
format is "createdAt desc". "id asc" if omitted.
Possible fields: ["id", "createdAt", "updatedAt"]
Both snake_case and camelCase are supported for fields. ||
|| filter | **string**

Filter expression that filters resources listed in the response.
Expressions are composed of terms connected by logic operators.
Value in quotes: `'` or `"`
Example: "key1='value' AND key2='value'"
Supported operators: ["AND"].
Supported fields: ["title"]
Both snake_case and camelCase are supported for fields. ||
|#

## ListChannelsResponse {#yandex.cloud.video.v1.ListChannelsResponse}

```json
{
  "channels": [
    {
      "id": "string",
      "organization_id": "string",
      "title": "string",
      "description": "string",
      "created_at": "google.protobuf.Timestamp",
      "updated_at": "google.protobuf.Timestamp",
      "labels": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| channels[] | **[Channel](#yandex.cloud.video.v1.Channel)**

List of channels for specific organization. ||
|| next_page_token | **string**

Token for getting the next page. ||
|#

## Channel {#yandex.cloud.video.v1.Channel}

Root entity for content separation.

#|
||Field | Description ||
|| id | **string**

ID of the channel. ||
|| organization_id | **string**

ID of the organization where channel should be created. ||
|| title | **string**

Channel title. ||
|| description | **string**

Channel description. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when channel was created. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of last channel update. ||
|| labels | **string**

Custom labels as `` key:value `` pairs. Maximum 64 per resource. ||
|#