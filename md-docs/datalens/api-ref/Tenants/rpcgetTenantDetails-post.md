[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [Tenants](index.md) > Get tenant details

<div class="openapi">

# Get tenant details

<!-- markdownlint-disable-file -->

Returns the current tenant state and public settings.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getTenantDetails
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

## Responses

<div class="openapi__response__code__200">

## 200 OK

Response

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "tenantId": "example",
  "orgId": "example",
  "settings": {
    "dataExportProhibited": true,
    "prohibitionPublication": true,
    "workbookFileExportProhibited": true,
    "defaultColorPaletteId": "example",
    "aiAssistantProhibited": true,
    "externalAIProvidersEnabled": true,
    "aiChatHistoryProhibited": true,
    "sharingProhibited": true,
    "newObjectCreatorRole": "admin",
    "defaultSidebarMode": "simplified",
    "autoAssignLicenses": true,
    "autoBuyLicenses": true,
    "autoBuyLicensesLimit": 0.5
  },
  "dlpEnabled": true,
  "foldersEnabled": true
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_dlpEnabled_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Whether DataLens Platform mode is enabled for the tenant.
{.table-cell}
||
||

_foldersEnabled_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: boolean

Whether legacy folder navigation is enabled for the tenant.
{.table-cell}
||
||

_orgId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string &#124; null

ID of the organization. Null when the tenant has no organization.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_settings_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_aiAssistantProhibited_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether the Neuroanalyst is prohibited for the tenant.
{.table-cell}
||
||

_aiChatHistoryProhibited_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether storing Neuroanalyst chat history is prohibited for the tenant.
{.table-cell}
||
||

_autoAssignLicenses_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether seats are assigned automatically.
{.table-cell}
||
||

_autoBuyLicenses_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether additional seats are purchased automatically.
{.table-cell}
||
||

_autoBuyLicensesLimit_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number &#124; null

Maximum number of seats that can be purchased automatically.
{.table-cell}
||
||

_dataExportProhibited_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether exporting data is prohibited for the tenant.
{.table-cell}
||
||

_defaultColorPaletteId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

ID of the default color palette.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_defaultSidebarMode_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Default sidebar display mode.

_Enum:_{.json-schema-reset .json-schema-value} `simplified`, `full`
{.table-cell}
||
||

_externalAIProvidersEnabled_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether Neuroanalyst may use models hosted outside Yandex Cloud.
{.table-cell}
||
||

_newObjectCreatorRole_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Default role assigned to the creator of a new object.

_Enum:_{.json-schema-reset .json-schema-value} `admin`, `editor`, `none`
{.table-cell}
||
||

_prohibitionPublication_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether entries publication is prohibited for the tenant.
{.table-cell}
||
||

_sharingProhibited_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether creating temporary public links is prohibited for the tenant.
{.table-cell}
||
||

_workbookFileExportProhibited_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether workbooks export is prohibited for the tenant.
{.table-cell}
||
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Public tenant settings. Additional public settings may be returned.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "dataExportProhibited": true,
  "prohibitionPublication": true,
  "workbookFileExportProhibited": true,
  "defaultColorPaletteId": "example",
  "aiAssistantProhibited": true,
  "externalAIProvidersEnabled": true,
  "aiChatHistoryProhibited": true,
  "sharingProhibited": true,
  "newObjectCreatorRole": "admin",
  "defaultSidebarMode": "simplified",
  "autoAssignLicenses": true,
  "autoBuyLicenses": true,
  "autoBuyLicensesLimit": 0.5
}
```

{% endcut %}
{.table-cell}
||
||

_tenantId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the current DataLens tenant.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.