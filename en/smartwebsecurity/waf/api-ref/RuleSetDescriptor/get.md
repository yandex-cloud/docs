---
editable: false
sourcePath: en/_api-ref/smartwebsecurity/v1/waf/api-ref/RuleSetDescriptor/get.md
---

# SmartWebSecurity WAF API, REST: RuleSetDescriptor.Get

Returns the specified RuleSetDescriptor resource.

## HTTP request

```
GET https://smartwebsecurity.{{ api-host }}/smartwebsecurity/v1/wafRuleSetDescriptors/{name}/{version}
```

## Path parameters

#|
||Field | Description ||
|| name | **string**

Required field. Name of the RuleSetDescriptor resource to return. ||
|| version | **string**

Required field. Version of the RuleSetDescriptor resource to return. ||
|#

## Response {#yandex.cloud.smartwebsecurity.v1.waf.RuleSetDescriptor}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "version": "string",
  "id": "string",
  "rules": [
    {
      "id": "string",
      "anomalyScore": "string",
      "paranoiaLevel": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| name | **string**

Required field. Name of the rule set ||
|| version | **string**

Required field. Version of the rule set ||
|| id | **string**

Required field. ID of the rule set ||
|| rules[] | **[RuleDescription](#yandex.cloud.smartwebsecurity.v1.waf.RuleSetDescriptor.RuleDescription)**

List of rules ||
|#

## RuleDescription {#yandex.cloud.smartwebsecurity.v1.waf.RuleSetDescriptor.RuleDescription}

#|
||Field | Description ||
|| id | **string**

ID of the rule ||
|| anomalyScore | **string** (int64)

Numeric anomaly value, i.e., a potential attack indicator.
The higher this value, the more likely it is that the request that satisfies the rule is an attack.
See [documentation](/docs/smartwebsecurity/concepts/waf#anomaly). ||
|| paranoiaLevel | **string** (int64)

Paranoia level classifies rules according to their aggression.
The higher the paranoia level, the better your protection, but also the higher the probability of WAF false positives.
See [documentation](/docs/smartwebsecurity/concepts/waf#paranoia). ||
|#