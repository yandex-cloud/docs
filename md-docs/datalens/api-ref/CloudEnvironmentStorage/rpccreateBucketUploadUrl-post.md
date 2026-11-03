[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [CloudEnvironmentStorage](index.md) > 🚧 [Experimental] Create bucket object upload URL

<div class="openapi">

# 🚧 [Experimental] Create bucket object upload URL

<!-- markdownlint-disable-file -->

Creates a temporary signed URL for uploading an object to the cloud environment storage bucket.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/createBucketUploadUrl
```

</div>

</div>

</div>

### Headers

#|
|| **Name** | **Description** ||
||

_x-dl-api-version_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

API version header.

_Const:_{.json-schema-reset .json-schema-value} `3`

_Example:_{.json-schema-reset .json-schema-example} `3`
{.table-cell}
||
|#{.json-schema-properties}

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "cloudEnvironmentId": "example",
  "path": "example",
  "size": "example",
  "contentMd5": "exampleaaaaaaaaaaaaaaaaa"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_cloudEnvironmentId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the cloud environment that owns the storage bucket.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Max length:_{.json-schema-reset .json-schema-assertion} `50`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_contentMd5_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Base64-encoded 16-byte MD5 digest of the object content.

_Min length:_{.json-schema-reset .json-schema-assertion} `24`

_Max length:_{.json-schema-reset .json-schema-assertion} `24`

_Example:_{.json-schema-reset .json-schema-example} `exampleaaaaaaaaaaaaaaaaa`
{.table-cell}
||
||

_path_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Path of the object in the storage bucket. Must not exceed 1024 UTF-8 bytes or contain control characters.

_Min length:_{.json-schema-reset .json-schema-assertion} `1`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_size_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Size of the object in bytes.

_Pattern:_{.json-schema-reset .json-schema-assertion} `^(?:0&#124;[1-9]\d*)$`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

## Responses

<div class="openapi__response__code__200">

## 200 OK

Response

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "url": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_url_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Temporary signed URL for accessing the object.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.