<div class="openapi">

# 🚧 [Experimental] Get QL chart

<!-- markdownlint-disable-file -->

Returns the specified QL chart.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getQLChart
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
||

_x-dl-audit-mode_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `true`

_Example:_{.json-schema-reset .json-schema-example} ``
{.table-cell}
||
|#{.json-schema-properties}

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "chartId": "example",
  "workbookId": "example",
  "revId": "example",
  "includePermissions": true,
  "includeLinks": true,
  "includeFavorite": true,
  "branch": "saved"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_chartId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the QL chart to return. You can find it in the chart settings in DataLens interface.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_branch_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [EntryBranch](#entity-EntryBranch)

Entry branch: saved or published.

_Enum:_{.json-schema-reset .json-schema-value} `saved`, `published`
{.table-cell}
||
||

_includeFavorite_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Include favorite status in the response.
{.table-cell}
||
||

_includeLinks_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Include information on configured links in the response.
{.table-cell}
||
||

_includePermissions_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Include information on configured permissions in the response.
{.table-cell}
||
||

_revId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Version ID for the QL chart.<br/> If the field is empty, you will get the current version of the QL chart.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workbookId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string &#124; null

ID of the workbook the QL chart belongs to. If navigation across folders is enabled and the QL chart belongs to a folder, the value must be `null`.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### EntryBranch {#entity-EntryBranch}

Entry branch: saved or published.

**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `saved`, `published`

</div>

## Responses

<div class="openapi__response__code__200">

## 200 OK

Response

<div class="openapi-entity">

### Body

{% cut "application/json" %}

`null`

{% endcut %}

**Type**: unknown

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.