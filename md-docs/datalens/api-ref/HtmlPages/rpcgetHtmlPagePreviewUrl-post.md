[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [HtmlPages](index.md) > Get HTML page preview URL

<div class="openapi">

# Get HTML page preview URL

<!-- markdownlint-disable-file -->

Returns a temporary URL for previewing the specified HTML page.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getHtmlPagePreviewUrl
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
  "entryId": "example",
  "branch": "saved",
  "revId": "example",
  "lang": "ru",
  "theme": "light"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_entryId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the HTML page to preview.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_branch_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

HTML page branch to preview. Defaults to published.

_Enum:_{.json-schema-reset .json-schema-value} `saved`, `published`
{.table-cell}
||
||

_lang_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Language of the HTML page preview.

_Enum:_{.json-schema-reset .json-schema-value} `ru`, `en`
{.table-cell}
||
||

_revId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

ID of the HTML page revision to preview.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_theme_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Theme of the HTML page preview.

_Enum:_{.json-schema-reset .json-schema-value} `light`, `dark`, `light-hc`, `dark-hc`, `system`
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

Temporary URL for previewing the HTML page.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.