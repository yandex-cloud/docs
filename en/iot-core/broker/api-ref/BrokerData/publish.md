---
editable: false
apiPlayground:
  - url: https://iot-data.{{ api-host }}/iot-broker/v1/brokers/{brokerId}/publish
    method: post
    path:
      type: object
      properties:
        brokerId:
          description: |-
            **string**
            Required field. ID of broker publishing message
            The maximum string length in characters is 50.
          type: string
      required:
        - brokerId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        topic:
          description: |-
            **string**
            Required field. Topic where message should be published
            The maximum string length in characters is 1024.
          type: string
        data:
          description: |-
            **string** (bytes)
            Content of the message
            The maximum string length in characters is 262144.
          type: string
          format: bytes
      required:
        - topic
      additionalProperties: false
    definitions: null
---

# IoT Core Broker Service, REST: BrokerData.Publish

Publishes message on behalf of specified broker

## HTTP request

```
POST https://iot-data.{{ api-host }}/iot-broker/v1/brokers/{brokerId}/publish
```

## Path parameters

#|
||Field | Description ||
|| brokerId | **string**

Required field. ID of broker publishing message

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.iot.broker.v1.PublishBrokerDataRequest}

```json
{
  "topic": "string",
  "data": "string"
}
```

#|
||Field | Description ||
|| topic | **string**

Required field. Topic where message should be published

The maximum string length in characters is 1024. ||
|| data | **string** (bytes)

Content of the message

The maximum string length in characters is 262144. ||
|#

## Response {#yandex.cloud.iot.broker.v1.PublishBrokerDataResponse}

**HTTP Code: 200 - OK**