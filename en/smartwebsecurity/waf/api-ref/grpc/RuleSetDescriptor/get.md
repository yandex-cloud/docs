---
editable: false
sourcePath: en/_api-ref-grpc/smartwebsecurity/v1/waf/api-ref/grpc/RuleSetDescriptor/get.md
---

# SmartWebSecurity WAF API, gRPC: RuleSetDescriptorService.Get

Returns the specified RuleSetDescriptor resource.

## gRPC request

**rpc Get ([GetRuleSetDescriptorRequest](#yandex.cloud.smartwebsecurity.v1.waf.GetRuleSetDescriptorRequest)) returns ([RuleSetDescriptor](#yandex.cloud.smartwebsecurity.v1.waf.RuleSetDescriptor))**

## GetRuleSetDescriptorRequest {#yandex.cloud.smartwebsecurity.v1.waf.GetRuleSetDescriptorRequest}

```json
{
  "name": "string",
  "version": "string"
}
```

#|
||Field | Description ||
|| name | **string**

Required field. Name of the RuleSetDescriptor resource to return. ||
|| version | **string**

Required field. Version of the RuleSetDescriptor resource to return. ||
|#

## RuleSetDescriptor {#yandex.cloud.smartwebsecurity.v1.waf.RuleSetDescriptor}

```json
{
  "name": "string",
  "version": "string",
  "id": "string",
  "rules": [
    {
      "id": "string",
      "anomaly_score": "int64",
      "paranoia_level": "int64"
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
|| anomaly_score | **int64**

Numeric anomaly value, i.e., a potential attack indicator.
The higher this value, the more likely it is that the request that satisfies the rule is an attack.
See [documentation](/docs/smartwebsecurity/concepts/waf#anomaly). ||
|| paranoia_level | **int64**

Paranoia level classifies rules according to their aggression.
The higher the paranoia level, the better your protection, but also the higher the probability of WAF false positives.
See [documentation](/docs/smartwebsecurity/concepts/waf#paranoia). ||
|#