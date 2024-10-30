---
editable: false
sourcePath: en/_api-ref/datasphere/v2/api-ref/Community/getRestrictionsMeta.md
---

# DataSphere API v2, REST: Community.GetRestrictionsMeta {#GetRestrictionsMeta}

Get meta information about available restrictions.

## HTTP request

```
GET https://datasphere.{{ api-host }}/datasphere/v2/communities/restrictionsMeta
```

## Response {#yandex.cloud.datasphere.v2.GetRestrictionsMetaResponse}

**HTTP Code: 200 - OK**

```json
{
  "restrictionsMeta": [
    {
      "name": "string",
      "valueType": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| restrictionsMeta[] | **[RestrictionMeta](#yandex.cloud.datasphere.v2.RestrictionMeta)**

List of restrictions. ||
|#

## RestrictionMeta {#yandex.cloud.datasphere.v2.RestrictionMeta}

#|
||Field | Description ||
|| name | **string**

Name of restriction. ||
|| valueType | **enum** (RestrictionValueType)

Value type of restriction.

- `RESTRICTION_VALUE_TYPE_UNSPECIFIED`
- `BOOLEAN`
- `LONG`
- `STRING` ||
|#