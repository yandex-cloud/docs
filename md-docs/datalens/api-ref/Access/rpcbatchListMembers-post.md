[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [Access](index.md) > Batch list members

<div class="openapi">

# Batch list members

<!-- markdownlint-disable-file -->

Returns users and groups.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/batchListMembers
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
  "language": "en",
  "search": "example",
  "tabId": "SUBJECT_TYPE_UNSPECIFIED",
  "pageSize": 0.5,
  "pageToken": "example",
  "filter": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_filter_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Filter applied to the member list.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_language_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Language used for member data.

_Enum:_{.json-schema-reset .json-schema-value} `en`, `ru`
{.table-cell}
||
||

_pageSize_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Maximum number of members to return.
{.table-cell}
||
||

_pageToken_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Token for the next page of members.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_search_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Text used to search for members.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_tabId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Subject type used to filter members.

_Enum:_{.json-schema-reset .json-schema-value} `SUBJECT_TYPE_UNSPECIFIED`, `USER_ACCOUNT`, `GROUP`, `INVITEE`, `SERVICE_ACCOUNT`, `_system`
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
  "members": [
    {
      "sub": "example",
      "subType": "SUBJECT_TYPE_UNSPECIFIED",
      "email": "example",
      "name": "example",
      "givenName": "example",
      "familyName": "example",
      "preferredUsername": "example",
      "federation": null,
      "pictureData": "example",
      "picture": "example",
      "idpType": "example"
    }
  ],
  "nextPageToken": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_members_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [AccessExtSubjectClaims](#entity-AccessExtSubjectClaims)[]

Members matching the request.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "sub": "example",
    "subType": "SUBJECT_TYPE_UNSPECIFIED",
    "email": "example",
    "name": "example",
    "givenName": "example",
    "familyName": "example",
    "preferredUsername": "example",
    "federation": null,
    "pictureData": "example",
    "picture": "example",
    "idpType": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
||

_nextPageToken_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Token for the next page of members.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### AccessExtSubjectClaims {#entity-AccessExtSubjectClaims}

#|
|| **Name** | **Description** ||
||

_email_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subject email address.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_familyName_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subject family name.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_givenName_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subject given name.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_name_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subject display name.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_preferredUsername_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Preferred username of the subject.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_sub_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subject identifier.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_subType_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Subject type.

_Enum:_{.json-schema-reset .json-schema-value} `SUBJECT_TYPE_UNSPECIFIED`, `USER_ACCOUNT`, `GROUP`, `INVITEE`, `SERVICE_ACCOUNT`, `_system`
{.table-cell}
||
||

_federation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: unknown

Federation associated with the subject.

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
||

_idpType_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

Type of the subject identity provider.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_picture_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

URL of the subject profile picture.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_pictureData_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Encoded profile picture data.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "sub": "example",
  "subType": "SUBJECT_TYPE_UNSPECIFIED",
  "email": "example",
  "name": "example",
  "givenName": "example",
  "familyName": "example",
  "preferredUsername": "example",
  "federation": null,
  "pictureData": "example",
  "picture": "example",
  "idpType": "example"
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.