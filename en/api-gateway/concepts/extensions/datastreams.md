---
title: x-yc-apigateway-integration:cloud_datastreams extension
description: In this article, you will learn about the x-yc-apigateway-integration:cloud_datastreams extension use cases, supported parameters, and specification.
---

# x-yc-apigateway-integration:cloud_datastreams extension

 The `x-yc-apigateway-integration:cloud_datastreams` extension enables you to access {{ yds-full-name }} to run operations on [streams](../../../data-streams/concepts/glossary.md#stream-concepts). Currently, the only supported operation is [PutRecord](../../../data-streams/kinesisapi/methods/putrecord.md). 

{% include [add-extentions-console](../../../_includes/api-gateway/add-extentions-console.md) %}

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

Parameter | Type | Description
----|----|----
`action` | `string` | Operation in progress. Possible values: `PutRecord`.
`stream_name` | `string` | {{ yds-name }} stream name.
`partition_key` | `string` | This is an optional parameter. [Shard key](../../../data-streams/concepts/glossary#partition-key). If it is not specified, the writing operation will be performed to a random segment. The parameters are subsituted into `partition_key`.
`payload_format_type` | `string` | This is an optional parameter. It determines what is to be written. If the value is `body`, only the request body will be written to the stream. If the value is `request`, the whole [request](./cloud-functions.md#request_v1) in JSON format will be written to the stream. The default value is `body`.
`service_account_id` | `string` | Service account ID. It is used for authorization when performing {{ yds-name }} stream operations. If you omit the parameter, the `service_account_id` [top-level parameter](./index.md#top-level) value will be used.

## Extension specification {#spec}

Specification example:

```yaml
  /pets-stream/{petId}:
    post:
      x-yc-apigateway-integration:
        type: cloud_datastreams
        action: PutRecord
        stream_name: /{{ region-id }}/b1v1emj927uv********/ett01h3uz7qm********/pets-stream
        partition_key: '{petId}'
        service_account_id: ajeqvh23fi2********
      parameters:
      - description: petId
        explode: false
        in: path
        name: petId
        required: true
        schema:
          type: string
        style: simple
```
