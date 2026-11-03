<div class="openapi">

# 🚧 [Experimental] Get dashboard screenshot

<!-- markdownlint-disable-file -->

Renders the specified dashboard and returns the screenshot data.

## Request

<div class="openapi__requests">

<div class="openapi__request__wrapper" style="--method: var(--dc-openapi-methods-post);margin-bottom: 12px">

<div class="openapi__request">

POST {.openapi__method}
```text translate=no
https://api.datalens.tech/rpc/getDashScreenshot
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
  "type": "png",
  "base64": true,
  "s3": true,
  "width": 0.1,
  "height": 0.1,
  "fullPage": true,
  "queryParams": {},
  "dashId": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_dashId_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

ID of the dashboard to capture.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
||

_base64_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether to return the file as a base64 string.
{.table-cell}
||
||

_fullPage_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether to capture the full page.
{.table-cell}
||
||

_height_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Viewport height in pixels.

_Max value:_{.json-schema-reset .json-schema-assertion} `6000`

_Exclusive min:_{.json-schema-reset .json-schema-assertion} `0`
{.table-cell}
||
||

_queryParams_{.json-schema-reset .json-schema-property}
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

Additional query parameters of the captured page, for example chart or dashboard parameters.

{% cut "**Example**" %}{.json-schema-example}

```json translate=no
{}
```

{% endcut %}
{.table-cell}
||
||

_s3_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: boolean

Whether to upload the file to S3. Defaults to true unless base64 is enabled.
{.table-cell}
||
||

_type_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: string

Output file format. Defaults to png.

_Enum:_{.json-schema-reset .json-schema-value} `png`, `jpeg`, `jpg`
{.table-cell}
||
||

_width_{.json-schema-reset .json-schema-property}
{.table-cell}|
**Type**: number

Viewport width in pixels.

_Max value:_{.json-schema-reset .json-schema-assertion} `6000`

_Exclusive min:_{.json-schema-reset .json-schema-assertion} `0`
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
  "data": "example"
}
```

{% endcut %}

#|
|| **Name** | **Description** ||
||

_data_{.json-schema-reset .json-schema-property .json-schema-required}
{.table-cell}|
**Type**: string

URL of the uploaded file or its base64 representation.

_Example:_{.json-schema-reset .json-schema-example} `example`
{.table-cell}
||
|#{.json-schema-properties}

</div>

</div>

</div>

[*Deprecated]: No longer supported, please use an alternative and newer version.