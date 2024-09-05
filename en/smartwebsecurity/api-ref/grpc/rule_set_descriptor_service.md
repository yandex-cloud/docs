---
editable: false
sourcePath: en/_api-ref-grpc/smartwebsecurity/api-ref/grpc/rule_set_descriptor_service.md
---

# SmartWebSecurity API, gRPC: RuleSetDescriptorService

A set of methods for managing RuleSetDescriptor resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified RuleSetDescriptor resource. |

## Calls RuleSetDescriptorService {#calls}

## Get {#Get}

Returns the specified RuleSetDescriptor resource.

**rpc Get ([GetRuleSetDescriptorRequest](#GetRuleSetDescriptorRequest)) returns ([RuleSetDescriptor](./#RuleSetDescriptor))**

### GetRuleSetDescriptorRequest {#GetRuleSetDescriptorRequest}

Field | Description
--- | ---
name | **string**<br>Required. Name of the RuleSetDescriptor resource to return. 
version | **string**<br>Required. Version of the RuleSetDescriptor resource to return. 


### RuleSetDescriptor {#RuleSetDescriptor}

Field | Description
--- | ---
name | **string**<br>Required. Name of the rule set 
version | **string**<br>Required. Version of the rule set 
id | **string**<br>Required. ID of the rule set 
rules[] | **[RuleDescription](#RuleDescription)**<br>List of rules 


### RuleDescription {#RuleDescription}

Field | Description
--- | ---
id | **string**<br>ID of the rule 
anomaly_score | **int64**<br>Numeric anomaly value, i.e., a potential attack indicator. The higher this value, the more likely it is that the request that satisfies the rule is an attack. See [documentation](/docs/smartwebsecurity/concepts/waf#anomaly). 
paranoia_level | **int64**<br>Paranoia level classifies rules according to their aggression. The higher the paranoia level, the better your protection, but also the higher the probability of WAF false positives. See [documentation](/docs/smartwebsecurity/concepts/waf#paranoia). 


