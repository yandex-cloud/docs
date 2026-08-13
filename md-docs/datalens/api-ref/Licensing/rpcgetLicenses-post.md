[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [Licensing](index.md) > Get licenses

<div class="openapi">

# Get licenses

<!-- markdownlint-disable-file -->

Returns tenant licenses with optional filters by user IDs and license status, sorting, and pagination.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getLicenses
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

_Const:_{.json-schema-reset .json-schema-value} `2`

_Example:_{.json-schema-reset .json-schema-example} `2`
{.table-cell}
||
|#{.json-schema-properties}

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "userIds": [
    "example"
  ],
  "status": "active",
  "sortBy": "createdAt",
  "order": "asc",
  "limit": 1,
  "pageToken": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_limit_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Maximum number of licenses to return.

_Min value:_{.json-schema-reset .json-schema-assertion} `1`

_Max value:_{.json-schema-reset .json-schema-assertion} `200`
{.table-cell}
||
||

_order_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

License sort order.

_Enum:_{.json-schema-reset .json-schema-value} `asc`, `desc`
{.table-cell}
||
||

_pageToken_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Token for the next page of licenses.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_sortBy_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

License field to sort by.

_Enum:_{.json-schema-reset .json-schema-value} `createdAt`, `updatedAt`
{.table-cell}
||
||

_status_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

License status to filter by.

_Enum:_{.json-schema-reset .json-schema-value} `active`, `expired`, `expiring`
{.table-cell}
||
||

_userIds_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string[]

IDs of users whose licenses should be returned.

_Min items:_{.json-schema-reset .json-schema-assertion} `0`

_Max items:_{.json-schema-reset .json-schema-assertion} `1000`

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  "example"
]
```

{% endcut %}
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
  "licenses": [
    {
      "licenseId": "example",
      "meta": {},
      "tenantId": "example",
      "userId": "example",
      "licenseType": "creator",
      "isActive": true,
      "expiresAt": "example",
      "createdBy": "example",
      "createdAt": "example",
      "updatedBy": "example",
      "updatedAt": "example",
      "lastLoginAt": "example"
    }
  ],
  "nextPageToken": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_licenses_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [LicenseWithLastLogin](#entity-LicenseWithLastLogin)[]

Licenses matching the request.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "licenseId": "example",
    "meta": {},
    "tenantId": "example",
    "userId": "example",
    "licenseType": "creator",
    "isActive": true,
    "expiresAt": "example",
    "createdBy": "example",
    "createdAt": "example",
    "updatedBy": "example",
    "updatedAt": "example",
    "lastLoginAt": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_nextPageToken_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Token for the next page of licenses.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### LicenseWithLastLogin {#entity-LicenseWithLastLogin}

#|
|| **Name** | **Description** ||
||

_createdAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Date and time when the license was created.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_createdBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the user who created the license.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_expiresAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Date and time when the license expires.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_isActive_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Whether the license is active.
{.table-cell}
||
||

_lastLoginAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

Date and time when the licensed user last logged in.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_licenseId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Unique identifier of the license.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_licenseType_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Type of the license.

_Const:_{.json-schema-reset .json-schema-value} `creator`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_meta_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Additional license metadata.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_tenantId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the tenant that owns the license.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updatedAt_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Date and time when the license was last updated.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_updatedBy_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the user who last updated the license.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_userId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the user assigned the license.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "licenseId": "example",
  "meta": {},
  "tenantId": "example",
  "userId": "example",
  "licenseType": "creator",
  "isActive": true,
  "expiresAt": "example",
  "createdBy": "example",
  "createdAt": "example",
  "updatedBy": "example",
  "updatedAt": "example",
  "lastLoginAt": "example"
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.