[Документация Yandex Cloud](../../../index.md) > [Партнерская программа B2B Tech](../../index.md) > Партнерский портал > [API](../../api/index.md) > [Описание методов (англ.)](../index.md) > [Yandex 360](index.md) > Get list of tariffs and add-ons of organization 360

<div class="openapi">

# Get list of tariffs and add-ons of organization 360

<!-- markdownlint-disable-file -->

Get a list of connected tariffs (workseats) and add-ons of organization 360.

POST /workseats/v2/:subaccountId/:organization360Id/list

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
/workseats/v2/{subaccountId}/{organization360Id}/list
```

</div>

</div>

</div>

### Path parameters

#|
|| **Name** | **Description** ||
||

_organization360Id_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Organization 360 ID

_Example:_{.json-schema-reset .json-schema-example} ``
{.table-cell}
||
||

_subaccountId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

Client subaccount ID

_Example:_{.json-schema-reset .json-schema-example} ``
{.table-cell}
||
|#{.json-schema-properties}

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
{
  "filter": "status=equal \"init\"",
  "page": "1",
  "pageSize": 25,
  "sorting": {
    "id": "status",
    "order": "desc"
  }
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_filter_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Filter string. Available fields: status, addonsStatus (equal, any), type, fromDate, toDate, toCreatedAt, fromCreatedAt, createdBy, disabledBy (equal)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_page_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Page number

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_pageSize_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Number of records per page
{.table-cell}
||
||

_sorting_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Field to sort by: status, type, createdAt, disabledAt, createdBy, disabledBy

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_order_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: [SortingOrder](#entity-SortingOrder)

Sort order: asc (ascending) or desc (descending)

_Enum:_{.json-schema-reset .json-schema-value} `asc`, `desc`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Sorting parameters. Available fields: status, type, createdAt, disabledAt, createdBy, disabledBy

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "id": "example",
  "order": "asc"
}
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

</div>

<div class="openapi-entity">

### SortingOrder {#entity-SortingOrder}

Sort order: asc (ascending) or desc (descending)

**Type**: string

_Enum:_{.json-schema-reset .json-schema-value} `asc`, `desc`

</div>

## Responses

<div class="openapi__response__code__200">

## 200 OK

Successful response

<div class="openapi-entity">

### Body

{% cut "application/json" %}

```json translate=no
[
  {
    "workseatSetId": "7d1c46ea-9556-4fb0-8dde-a2178a8479c3",
    "createdAt": 1790243883,
    "type": "postpaid",
    "status": "init",
    "startDate": 1821780427,
    "productsType": "common",
    "productsData": {
      "amount": 2,
      "usedAmount": 0,
      "productId": "b2b_le_cloud_licenses_corp_light",
      "productTitle": "Корпоративный Лайт"
    },
    "createdBy": "bfbcv502pjhsioj0mfis",
    "addons": [
      {
        "createdAt": 1790243930,
        "type": "postpaid",
        "status": "init",
        "startDate": 1821780427,
        "productsType": "common",
        "productsData": {
          "amount": 2,
          "usedAmount": 0,
          "productId": "b2b_cloud_licenses_disk_1tb_addon",
          "productTitle": "Место на диске",
          "features": [
            {
              "description": "Дополнительное место",
              "group": "disk",
              "value": "+1 ТБ",
              "enabled": true,
              "code": "mpfs_disk_space_for_b2b_mail_360",
              "tags": []
            }
          ]
        },
        "createdBy": "bfbcv502pjhsioj0mfis",
        "workseatsPackets": [
          {
            "productId": "32710bae-851a-477f-b8e4-ac1e805969c4",
            "amount": 2,
            "isMetricsEnabled": true,
            "createdAt": 1790243930,
            "createdBy": "bfbcv502pjhsioj0mfis"
          }
        ],
        "id": "97af46b0-29c7-4d42-a700-da768cac17a3",
        "endDate": null,
        "disabledAt": null
      },
      {
        "createdAt": 1790243908,
        "type": "postpaid",
        "status": "disabled",
        "startDate": 1821780427,
        "disabledAt": 1790243930,
        "productsType": "common",
        "productsData": {
          "amount": 1,
          "usedAmount": 0,
          "productId": "b2b_cloud_licenses_disk_1tb_addon",
          "productTitle": "Место на диске",
          "features": [
            {
              "description": "Дополнительное место",
              "group": "disk",
              "value": "+1 ТБ",
              "enabled": true,
              "code": "mpfs_disk_space_for_b2b_mail_360",
              "tags": []
            }
          ]
        },
        "createdBy": "bfbcv502pjhsioj0mfis",
        "disabledBy": "bfbcv502pjhsioj0mfis",
        "disabledReason": "replaced",
        "workseatsPackets": [
          {
            "productId": "32710bae-851a-477f-b8e4-ac1e805969c4",
            "amount": 1,
            "isMetricsEnabled": true,
            "createdAt": 1790243908,
            "createdBy": "bfbcv502pjhsioj0mfis"
          }
        ],
        "id": "888da7cf-1ed3-44f2-a03c-495fa6402fca",
        "endDate": null
      }
    ],
    "workseatsPackets": [
      {
        "productId": "66343683-033d-403c-b81b-523337568c51",
        "amount": 2,
        "isMetricsEnabled": true,
        "createdAt": 1790243883,
        "createdBy": "bfbcv502pjhsioj0mfis"
      }
    ],
    "endDate": null,
    "disabledAt": null
  }
]
```

{% endcut %}

**Type**: [WorkseatListItem](#entity-WorkseatListItem)[]

</div>

<div class="openapi-entity">

### WorkseatListItem {#entity-WorkseatListItem}

Connected tariff (workseat) item with add-ons

#|
|| **Name** | **Description** ||
||

_addons_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_createdAt_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer

Add-on creation date and time (Unix time, seconds)
{.table-cell}
||
||

_createdBy_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Who created (IAM user ID or null for Yandex 360)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_disabledAt_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer

Add-on disable date and time (Unix time, seconds)
{.table-cell}
||
||

_disabledBy_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Who disabled (IAM user ID or null for Yandex 360)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_disabledReason_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Disable reason: EXPIRED, MANUAL, REPLACED

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_endDate_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer

Add-on end date and time (Unix time, seconds)
{.table-cell}
||
||

_id_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Add-on ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_productsData_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_amount_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Available add-on quantity
{.table-cell}
||
||

_productId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Add-on product ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_productTitle_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Add-on name

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_usedAmount_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Used add-on quantity
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Per-product data for the add-on (quantities, dates)

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "amount": 0.5,
  "usedAmount": 0.5,
  "productId": "example",
  "productTitle": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_productsType_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Type: common or educational

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_startDate_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer

Add-on start date and time (Unix time, seconds)
{.table-cell}
||
||

_status_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Add-on status: init, enabled, disabled

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Payment type: postpaid or prepaid

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workseatsPackets_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_amount_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Available users in the packet
{.table-cell}
||
||

_createdAt_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer

Creation/change date and time (Unix time, seconds)
{.table-cell}
||
||

_createdBy_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Who created (IAM user ID or null for Yandex 360)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_isMetricsEnabled_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether the packet is paid: true — paid, false — free
{.table-cell}
||
||

_productId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Changed packet product ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

History of available user quantity changes for the add-on

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "productId": "example",
    "amount": 0.5,
    "isMetricsEnabled": true,
    "createdAt": 0,
    "createdBy": "example"
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

List of add-ons for the tariff

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "id": "example",
    "type": "example",
    "status": "example",
    "createdAt": 0,
    "startDate": 0,
    "endDate": 0,
    "disabledAt": 0,
    "productsType": "example",
    "productsData": {
      "amount": 0.5,
      "usedAmount": 0.5,
      "productId": "example",
      "productTitle": "example"
    },
    "createdBy": "example",
    "disabledBy": "example",
    "disabledReason": "example",
    "workseatsPackets": [
      {
        "productId": "example",
        "amount": 0.5,
        "isMetricsEnabled": true,
        "createdAt": 0,
        "createdBy": "example"
      }
    ]
  }
]
```

{% endcut %}
{.table-cell}
||
||

_createdAt_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer

Creation date and time (Unix time, seconds)
{.table-cell}
||
||

_createdBy_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Who created (IAM user ID or null for Yandex 360)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_disabledAt_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer

Tariff disable date and time (Unix time, seconds)
{.table-cell}
||
||

_disabledBy_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Who disabled (IAM user ID or null for Yandex 360)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_disableReason_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Disable reason: EXPIRED, MANUAL, REPLACED

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_endDate_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer

Tariff end date and time (Unix time, seconds)
{.table-cell}
||
||

_productsData_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object" %}

#|
||

_amount_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Available users by tariff
{.table-cell}
||
||

_productId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Product/tariff ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_productTitle_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Product/tariff name

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_usedAmount_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Used users by tariff
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

Product data

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "amount": 0.5,
  "usedAmount": 0.5,
  "productId": "example",
  "productTitle": "example"
}
```

{% endcut %}
{.table-cell}
||
||

_productsType_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Type: common or educational

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_startDate_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer

Tariff start date and time (Unix time, seconds)
{.table-cell}
||
||

_status_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Tariff status: init (planned), enabled (current), disabled (past)

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Payment type: postpaid or prepaid

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workseatSetId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Tariff ID in organization

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_workseatsPackets_{.json-schema-reset .json-schema-property}
{.table-cell}|
{% cut "**Type**: object[]" %}

#|
||

_amount_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Available users in the packet
{.table-cell}
||
||

_createdAt_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: integer

Creation/change date and time (Unix time, seconds)
{.table-cell}
||
||

_isMetricsEnabled_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether the packet is paid: true — paid, false — free
{.table-cell}
||
||

_productId_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Changed packet product ID

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

{% endcut %}

History of available user quantity changes for the tariff

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
[
  {
    "productId": "example",
    "amount": 0.5,
    "isMetricsEnabled": true,
    "createdAt": 0
  }
]
```

{% endcut %}
{.table-cell}
||
|#{.json-schema-properties}

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{
  "workseatSetId": "example",
  "createdAt": 0,
  "type": "example",
  "status": "example",
  "startDate": 0,
  "endDate": 0,
  "createdBy": "example",
  "disabledBy": "example",
  "productsType": "example",
  "productsData": {
    "amount": 0.5,
    "usedAmount": 0.5,
    "productId": "example",
    "productTitle": "example"
  },
  "addons": [
    {
      "id": "example",
      "type": "example",
      "status": "example",
      "createdAt": 0,
      "startDate": 0,
      "endDate": 0,
      "disabledAt": 0,
      "productsType": "example",
      "productsData": {
        "amount": 0.5,
        "usedAmount": 0.5,
        "productId": "example",
        "productTitle": "example"
      },
      "createdBy": "example",
      "disabledBy": "example",
      "disabledReason": "example",
      "workseatsPackets": [
        {
          "productId": "example",
          "amount": 0.5,
          "isMetricsEnabled": true,
          "createdAt": 0,
          "createdBy": "example"
        }
      ]
    }
  ],
  "disableReason": "example",
  "disabledAt": 0,
  "workseatsPackets": [
    {
      "productId": "example",
      "amount": 0.5,
      "isMetricsEnabled": true,
      "createdAt": 0
    }
  ]
}
```

{% endcut %}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.