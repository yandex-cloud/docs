---
editable: false
sourcePath: en/_api-ref-grpc/iot/broker/v1/broker/api-ref/grpc/Broker/addPassword.md
---

# IoT Core Broker Service, gRPC: BrokerService.AddPassword

Adds password for the specified broker.

## gRPC request

**rpc AddPassword ([AddBrokerPasswordRequest](#yandex.cloud.iot.broker.v1.AddBrokerPasswordRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## AddBrokerPasswordRequest {#yandex.cloud.iot.broker.v1.AddBrokerPasswordRequest}

```json
{
  "broker_id": "string",
  "password": "string"
}
```

#|
||Field | Description ||
|| broker_id | **string**

Required field. ID of the broker to add a password for.

To get a broker ID make a [BrokerService.List](/docs/iot-core/broker/api-ref/grpc/Broker/list#List) request. ||
|| password | **string**

Passwords for the broker.

The password must contain at least three character categories among the following: upper case latin, lower case latin, numbers and special symbols. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "broker_id": "string",
    "password_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "broker_id": "string",
    "id": "string",
    "created_at": "google.protobuf.Timestamp"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[AddBrokerPasswordMetadata](#yandex.cloud.iot.broker.v1.AddBrokerPasswordMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[BrokerPassword](#yandex.cloud.iot.broker.v1.BrokerPassword)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## AddBrokerPasswordMetadata {#yandex.cloud.iot.broker.v1.AddBrokerPasswordMetadata}

#|
||Field | Description ||
|| broker_id | **string**

ID of the broker for which the password is being added. ||
|| password_id | **string**

ID of a password that is being added. ||
|#

## BrokerPassword {#yandex.cloud.iot.broker.v1.BrokerPassword}

A broker password.

#|
||Field | Description ||
|| broker_id | **string**

ID of the broker that the password belongs to. ||
|| id | **string**

ID of the password. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|#