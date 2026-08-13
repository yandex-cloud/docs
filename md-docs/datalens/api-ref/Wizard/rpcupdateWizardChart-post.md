[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [Wizard](index.md) > 🚧 [Experimental] Update wizard chart

<div class="openapi">

# 🚧 [Experimental] Update wizard chart

<!-- markdownlint-disable-file -->

Updates the specified wizard chart.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/updateWizardChart
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
  "entryId": "example",
  "template": "datalens",
  "annotation": {
    "description": "example"
  },
  "mode": "save",
  "data": {}
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_data_{.json-schema-reset .json-schema-property .json-schema-required}
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

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_entryId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_mode_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: [EntryUpdateMode](#entity-EntryUpdateMode)

Entry update mode.

_Enum:_{.json-schema-reset .json-schema-value} `save`, `publish`
{.table-cell}
||
||

_template_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

_Const:_{.json-schema-reset .json-schema-value} `datalens`

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_annotation_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [EntryAnnotationArg](#entity-EntryAnnotationArg)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "description": "example"
}
```

{% endcut %}
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

</div>

<div class="openapi-entity">

### EntryAnnotationArg {#entity-EntryAnnotationArg}

#|
|| **Name** | **Description** ||
||

_description_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Description of the entry.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "description": "example"
}
```

{% endcut %}

</div>

<div class="openapi-entity">

### EntryUpdateMode {#entity-EntryUpdateMode}

Entry update mode.

**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `save`, `publish`

</div>

## Responses

<div class="openapi__response__code__200">

## 200 OK

Response

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_[additional]_{.json-schema-reset .json-schema-additional-property}
{.table-cell}|
**Type**: unknown

_Example:_{.json-schema-reset .json-schema-example} `null`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.