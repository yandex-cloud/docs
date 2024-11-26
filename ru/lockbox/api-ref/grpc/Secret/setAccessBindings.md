---
editable: false
sourcePath: en/_api-ref-grpc/lockbox/v1/api-ref/grpc/Secret/setAccessBindings.md
---

# Lockbox API, gRPC: SecretService.SetAccessBindings

Sets access bindings for the secret.

## gRPC request

**rpc SetAccessBindings ([access.SetAccessBindingsRequest](#yandex.cloud.access.SetAccessBindingsRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## access.SetAccessBindingsRequest {#yandex.cloud.access.SetAccessBindingsRequest}

```json
{
  "resource_id": "string",
  "access_bindings": [
    {
      "role_id": "string",
      "subject": {
        "id": "string",
        "type": "string"
      }
    }
  ]
}
```

#|
||Field | Description ||
|| resource_id | **string**

Required field. ID of the resource for which access bindings are being set.

To get the resource ID, use a corresponding List request. ||
|| access_bindings[] | **[AccessBinding](#yandex.cloud.access.AccessBinding)**

Access bindings to be set. For more information, see [Access Bindings](/docs/iam/concepts/access-control/#access-bindings). ||
|#

## AccessBinding {#yandex.cloud.access.AccessBinding}

#|
||Field | Description ||
|| role_id | **string**

Required field. ID of the [yandex.cloud.iam.v1.Role](/docs/iam/api-ref/grpc/Role/get#yandex.cloud.iam.v1.Role) that is assigned to the `subject`. ||
|| subject | **[Subject](#yandex.cloud.access.Subject)**

Required field. Identity for which access binding is being created.
It can represent an account with a unique ID or several accounts with a system identifier. ||
|#

## Subject {#yandex.cloud.access.Subject}

#|
||Field | Description ||
|| id | **string**

Required field. ID of the subject.

It can contain one of the following values:
* `allAuthenticatedUsers`: A special public group that represents anyone
who is authenticated. It can be used only if the `type` is `system`.
* `allUsers`: A special public group that represents anyone. No authentication is required.
For example, you don't need to specify the IAM token in an API query.
It can be used only if the `type` is `system`.
* `group:organization:<id>:users`: A special system group that represents all members of organization
with given <id>. It can be used only if the `type` is `system`.
* `group:federation:<id>:users`: A special system group that represents all users of federation
with given <id>. It can be used only if the `type` is `system`.
* `<cloud generated id>`: An identifier that represents a user account.
It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`. ||
|| type | **string**

Required field. Type of the subject.

It can contain one of the following values:
* `userAccount`: An account on Yandex or Yandex Connect, added to Yandex Cloud.
* `serviceAccount`: A service account. This type represents the [yandex.cloud.iam.v1.ServiceAccount](/docs/iam/api-ref/grpc/ServiceAccount/get#yandex.cloud.iam.v1.ServiceAccount) resource.
* `federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory.
* `system`: System group. This type represents several accounts with a common system identifier.

For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). ||
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
    "resource_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Empty"
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
|| metadata | **[SetAccessBindingsMetadata](#yandex.cloud.access.SetAccessBindingsMetadata)**

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
|| response | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**

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

## SetAccessBindingsMetadata {#yandex.cloud.access.SetAccessBindingsMetadata}

#|
||Field | Description ||
|| resource_id | **string**

ID of the resource for which access bindings are being set. ||
|#