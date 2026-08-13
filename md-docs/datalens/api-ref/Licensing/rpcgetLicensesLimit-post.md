[Документация Yandex Cloud](../../../index.md) > [Yandex DataLens](../../index.md) > DataLens Public API > [DataLens API (англ.)](../index.md) > [Licensing](index.md) > Get licenses limit

<div class="openapi">

# Get licenses limit

<!-- markdownlint-disable-file -->

Returns current and upcoming license limits for the tenant, including active license counts per limit.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getLicensesLimit
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

## Responses

<div class="openapi__response__code__200">

## 200 OK

Response

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "current": {
    "type": "regular",
    "value": 0.5,
    "startedAt": "example",
    "activeLicensesCount": 0.5
  },
  "next": {
    "type": "regular",
    "value": 0.5,
    "startedAt": "example",
    "activeLicensesCount": 0.5
  }
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_current_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: object &#124; null

Current license limit.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "type": "regular",
  "value": 0.5,
  "startedAt": "example",
  "activeLicensesCount": 0.5
}
```

{% endcut %}
{.table-cell}
||
||

_next_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: object &#124; null

Upcoming license limit.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "type": "regular",
  "value": 0.5,
  "startedAt": "example",
  "activeLicensesCount": 0.5
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.