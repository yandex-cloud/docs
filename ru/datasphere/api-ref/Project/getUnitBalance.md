---
editable: false
sourcePath: en/_api-ref/datasphere/v2/api-ref/Project/getUnitBalance.md
---

# DataSphere API v2, REST: Project.GetUnitBalance

Returns the unit balance of the specified project.

## HTTP request

```
GET https://datasphere.{{ api-host }}/datasphere/v2/projects/{projectId}:unitBalance
```

## Path parameters

#|
||Field | Description ||
|| projectId | **string**

Required field. ID of the project to return the unit balance for. ||
|#

## Response {#yandex.cloud.datasphere.v2.GetUnitBalanceResponse}

**HTTP Code: 200 - OK**

```json
{
  "unitBalance": "string"
}
```

#|
||Field | Description ||
|| unitBalance | **string** (int64)

The number of units available to the project. ||
|#