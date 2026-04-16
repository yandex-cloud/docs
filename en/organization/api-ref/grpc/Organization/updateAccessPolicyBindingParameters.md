---
editable: false
---

# Identity Hub API, gRPC: OrganizationService.UpdateAccessPolicyBindingParameters

Updates the access policy binding parameters for the organization.

## gRPC request

**rpc UpdateAccessPolicyBindingParameters ([access.UpdateAccessPolicyBindingParametersRequest](#yandex.cloud.access.UpdateAccessPolicyBindingParametersRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## access.UpdateAccessPolicyBindingParametersRequest {#yandex.cloud.access.UpdateAccessPolicyBindingParametersRequest}

```json
{
  "resource_id": "string",
  "access_policy_binding": {
    "access_policy_template_id": "string",
    "parameters": "map<string, string>"
  }
}
```

#|
||Field | Description ||
|| resource_id | **string**

Required field. ID of the resource for which access policy bindings are being updated.

The maximum string length in characters is 50. ||
|| access_policy_binding | **[AccessPolicyBinding](#yandex.cloud.access.AccessPolicyBinding)**

Required field. Identity for which access policy binding is being updated. ||
|#

## AccessPolicyBinding {#yandex.cloud.access.AccessPolicyBinding}

#|
||Field | Description ||
|| access_policy_template_id | **string**

Required field. ID of the access policy template being applied.

The maximum string length in characters is 50. ||
|| parameters | **object** (map<**string**, **string**>)

A list of access policy binding parameter KEY=VALUE pairs.

The maximum string length in characters for each value is 1024. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. No more than 64 per resource. ||
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
    "resource_id": "string",
    "access_policy_binding": {
      "access_policy_template_id": "string",
      "parameters": "map<string, string>"
    }
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "UpdateAccessPolicyBindingParametersResponse"
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
|| metadata | **[UpdateAccessPolicyBindingParametersMetadata](#yandex.cloud.access.UpdateAccessPolicyBindingParametersMetadata)**

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
|| response | **[UpdateAccessPolicyBindingParametersResponse](#yandex.cloud.access.UpdateAccessPolicyBindingParametersResponse)**

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

## UpdateAccessPolicyBindingParametersMetadata {#yandex.cloud.access.UpdateAccessPolicyBindingParametersMetadata}

#|
||Field | Description ||
|| resource_id | **string**

ID of the resource for which access policy bindings are being updated. ||
|| access_policy_binding | **[AccessPolicyBinding](#yandex.cloud.access.AccessPolicyBinding2)**

Identity for which access policy binding is being updated. ||
|#

## AccessPolicyBinding {#yandex.cloud.access.AccessPolicyBinding2}

#|
||Field | Description ||
|| access_policy_template_id | **string**

Required field. ID of the access policy template being applied.

The maximum string length in characters is 50. ||
|| parameters | **object** (map<**string**, **string**>)

A list of access policy binding parameter KEY=VALUE pairs.

The maximum string length in characters for each value is 1024. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. No more than 64 per resource. ||
|#

## UpdateAccessPolicyBindingParametersResponse {#yandex.cloud.access.UpdateAccessPolicyBindingParametersResponse}

#|
||Field | Description ||
|| Empty | > ||
|#