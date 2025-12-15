---
editable: false
apiPlayground:
  - url: https://iam.{{ api-host }}/iam/aws-compatibility/v1/ephemeralAccessKeys
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        subjectId:
          description: |-
            **string**
            The subject identifier for whom the ephemeral access key will be created.
            If not specified, it defaults to the subject that made the request.
            The maximum string length in characters is 50.
          type: string
        sessionName:
          description: |-
            **string**
            Required field. Use the session name to uniquely identify a session when the same SA is impersonated by different principals or for different reasons
            Pattern: [\w+=,.@-]*
            The string length in characters must be 1-64.
          type: string
        policy:
          description: |-
            **string**
            AWS-compatible policy in JSON format that you want to use as an inline session policy.
            The maximum string length in characters is 2048.
          type: string
        duration:
          description: |-
            **string** (duration)
            Duration, which specifies the duration of the ephemeral access key,
            but duration won't be longer than the lifetime of the authentication token that made the request
          type: string
          format: duration
      required:
        - sessionName
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/iam/v1/awscompatibility/api-ref/TemporaryAccessKey/createEphemeral.md
---

# Access Key, REST: TemporaryAccessKey.CreateEphemeral

Creates an ephemeral access key for the specified subject.

## HTTP request

```
POST https://iam.{{ api-host }}/iam/aws-compatibility/v1/ephemeralAccessKeys
```

## Body parameters {#yandex.cloud.iam.v1.awscompatibility.CreateEphemeralAccessKeyRequest}

```json
{
  "subjectId": "string",
  "sessionName": "string",
  "policy": "string",
  "duration": "string"
}
```

#|
||Field | Description ||
|| subjectId | **string**

The subject identifier for whom the ephemeral access key will be created.
If not specified, it defaults to the subject that made the request.

The maximum string length in characters is 50. ||
|| sessionName | **string**

Required field. Use the session name to uniquely identify a session when the same SA is impersonated by different principals or for different reasons
Pattern: [\w+=,.@-]*

The string length in characters must be 1-64. ||
|| policy | **string**

AWS-compatible policy in JSON format that you want to use as an inline session policy.

The maximum string length in characters is 2048. ||
|| duration | **string** (duration)

Duration, which specifies the duration of the ephemeral access key,
but duration won't be longer than the lifetime of the authentication token that made the request ||
|#

## Response {#yandex.cloud.iam.v1.awscompatibility.CreateEphemeralAccessKeyResponse}

**HTTP Code: 200 - OK**

```json
{
  "accessKeyId": "string",
  "secret": "string",
  "sessionToken": "string",
  "expiresAt": "string"
}
```

#|
||Field | Description ||
|| accessKeyId | **string**

ID of the access key.
The key is AWS compatible. ||
|| secret | **string**

Secret access key.
The key is AWS compatible. ||
|| sessionToken | **string**

Session token.
The token is AWS compatible. Should be attached to any call made by provided credentials. ||
|| expiresAt | **string** (date-time)

Expiration time.
The date on which the current credentials expire.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#