[Документация Yandex Cloud](../../../index.md) > [Yandex DataSphere](../../index.md) > [Справочник API](../overview.md) > [REST (англ.)](../index.md) > [Community](index.md) > GetRestrictionsMeta

# DataSphere API v2, REST: Community.GetRestrictionsMeta

Get meta information about available restrictions.

## HTTP request

```
GET https://datasphere.api.cloud.yandex.net/datasphere/v2/communities/restrictionsMeta
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

- `BOOLEAN`
- `LONG`
- `STRING` ||
|#