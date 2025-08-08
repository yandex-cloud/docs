---
editable: false
apiPlayground:
  - url: https://registry.{{ api-host }}/cloud-registry/v1/artifacts/{artifactId}
    method: get
    path:
      type: object
      properties:
        artifactId:
          description: |-
            **string**
            Required field. ID of the artifact resource to return.
          type: string
      required:
        - artifactId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/cloudregistry/v1/api-ref/Artifact/get.md
---

# Yandex Cloud Registry API, REST: Artifact.Get

Returns the specified artifact resource.

To get the list of available artifact resources, make [RegistryService.ListArtifacts](/docs/cloud-registry/api-ref/Registry/listArtifacts#ListArtifacts) method call.

## HTTP request

```
GET https://registry.{{ api-host }}/cloud-registry/v1/artifacts/{artifactId}
```

## Path parameters

#|
||Field | Description ||
|| artifactId | **string**

Required field. ID of the artifact resource to return. ||
|#

## Response {#yandex.cloud.cloudregistry.v1.Artifact}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "path": "string",
  "name": "string",
  "kind": "string",
  "status": "string",
  "createdAt": "string",
  "modifiedAt": "string"
}
```

A Artifact resource.

#|
||Field | Description ||
|| id | **string**

Output only. ID of the artifact. ||
|| path | **string**

Path where the artifact is located. ||
|| name | **string**

Name of the artifact. ||
|| kind | **enum** (Kind)

Kind of the artifact.

- `KIND_UNSPECIFIED`
- `FOLDER`: Artifact kind is folder.
- `PACKAGE`: Artifact kind is package.
- `ARTIFACT`: Artifact kind is artifact. ||
|| status | **enum** (Status)

Output only. Status of the artifact.

- `STATUS_UNSPECIFIED`
- `CREATING`: Artifact status is being created.
- `ACTIVE`: Artifact status is ready to use.
- `DELETING`: Artifact status is being deleted. ||
|| createdAt | **string** (date-time)

Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| modifiedAt | **string** (date-time)

Output only. Modification timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#