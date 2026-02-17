---
editable: false
---

# Access Key, gRPC: TemporaryAccessKeyService.CreateEphemeral

Creates an ephemeral access key for the specified subject.

## gRPC request

**rpc CreateEphemeral ([CreateEphemeralAccessKeyRequest](#yandex.cloud.iam.v1.awscompatibility.CreateEphemeralAccessKeyRequest)) returns ([CreateEphemeralAccessKeyResponse](#yandex.cloud.iam.v1.awscompatibility.CreateEphemeralAccessKeyResponse))**

## CreateEphemeralAccessKeyRequest {#yandex.cloud.iam.v1.awscompatibility.CreateEphemeralAccessKeyRequest}

```json
{
  "subject_id": "string",
  "session_name": "string",
  "policy": "string",
  "duration": "google.protobuf.Duration"
}
```

#|
||Field | Description ||
|| subject_id | **string**

The subject identifier for whom the ephemeral access key will be created.
If not specified, it defaults to the subject that made the request.

The maximum string length in characters is 50. ||
|| session_name | **string**

Required field. Use the session name to uniquely identify a session when the same SA is impersonated by different principals or for different reasons
Pattern: [\w+=,.@-]*

The string length in characters must be 1-64. ||
|| policy | **string**

AWS-compatible policy in JSON format that you want to use as an inline session policy.

The maximum string length in characters is 2048. ||
|| duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Duration, which specifies the duration of the ephemeral access key,
but duration won't be longer than the lifetime of the authentication token that made the request ||
|#

## CreateEphemeralAccessKeyResponse {#yandex.cloud.iam.v1.awscompatibility.CreateEphemeralAccessKeyResponse}

```json
{
  "access_key_id": "string",
  "secret": "string",
  "session_token": "string",
  "expires_at": "google.protobuf.Timestamp"
}
```

#|
||Field | Description ||
|| access_key_id | **string**

ID of the access key.
The key is AWS compatible. ||
|| secret | **string**

Secret access key.
The key is AWS compatible. ||
|| session_token | **string**

Session token.
The token is AWS compatible. Should be attached to any call made by provided credentials. ||
|| expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Expiration time.
The date on which the current credentials expire. ||
|#