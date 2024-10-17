---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Channel/list.md
---

# Video API, gRPC: ChannelService.List {#List}

List channels for organization.

## gRPC request

**rpc List ([ListChannelsRequest](#yandex.cloud.video.v1.ListChannelsRequest)) returns ([ListChannelsResponse](#yandex.cloud.video.v1.ListChannelsResponse))**

## ListChannelsRequest {#yandex.cloud.video.v1.ListChannelsRequest}

```json
{
  "organizationId": "string",
  "pageSize": "int64",
  "pageToken": "string",
  "orderBy": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| organizationId | **string**

ID of the organization. ||
|| pageSize | **int64**

The maximum number of the results per page to return. Default value: 100. ||
|| pageToken | **string**

Page token for getting the next page of the result. ||
|| orderBy | **string**

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
      "organizationId": "string",
      "title": "string",
      "description": "string",
      "createdAt": "google.protobuf.Timestamp",
      "updatedAt": "google.protobuf.Timestamp",
      "labels": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| channels[] | **[Channel](#yandex.cloud.video.v1.Channel)**

List of channels for specific organization. ||
|| nextPageToken | **string**

Token for getting the next page. ||
|#

## Channel {#yandex.cloud.video.v1.Channel}

Root entity for content separation.

#|
||Field | Description ||
|| id | **string**

ID of the channel. ||
|| organizationId | **string**

ID of the organization where channel should be created. ||
|| title | **string**

Channel title. ||
|| description | **string**

Channel description. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when channel was created. ||
|| updatedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of last channel update. ||
|| labels | **string**

Custom labels as `` key:value `` pairs. Maximum 64 per resource. ||
|#