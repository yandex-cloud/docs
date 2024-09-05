---
editable: false
sourcePath: en/_api-ref-grpc/smartwebsecurity/api-ref/grpc/waf_profile_service.md
---

# SmartWebSecurity API, gRPC: WafProfileService

A set of methods for managing WafProfile resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified WafProfile resource. |
| [List](#List) | Retrieves the list of WafProfile resources in the specified folder. |
| [Create](#Create) | Creates a WAF profile in the specified folder using the data specified in the request. |
| [Update](#Update) | Updates the specified WAF profile. |
| [Delete](#Delete) | Deletes the specified WAF profile. |

## Calls WafProfileService {#calls}

## Get {#Get}

Returns the specified WafProfile resource.

**rpc Get ([GetWafProfileRequest](#GetWafProfileRequest)) returns ([WafProfile](#WafProfile))**

### GetWafProfileRequest {#GetWafProfileRequest}

Field | Description
--- | ---
waf_profile_id | **string**<br>Required. ID of the WafProfile resource to return. 


### WafProfile {#WafProfile}

Field | Description
--- | ---
id | **string**<br>Required. ID of the WAF profile. 
folder_id | **string**<br>Required. ID of the folder that the WAF profile belongs to. 
cloud_id | **string**<br>Required. ID of the cloud that the WAF profile belongs to. 
name | **string**<br>Required. Name of the WAF profile. The name is unique within the folder. 1-50 characters long. The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `.
description | **string**<br>Optional description of the WAF profile. The maximum string length in characters is 512.
labels | **map<string,string>**<br>Labels as `` key:value `` pairs. Maximum of 64 per resource. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
rules[] | **[WafProfileRule](#WafProfileRule)**<br>Settings for each rule in rule set. 
exclusion_rules[] | **[WafProfileExclusionRule](#WafProfileExclusionRule)**<br>List of exclusion rules. See [Rules](/docs/smartwebsecurity/concepts/waf#exclusion-rules). 
rule_set | **oneof:** `core_rule_set`<br>
&nbsp;&nbsp;core_rule_set | **[CoreRuleSet](#CoreRuleSet)**<br>Core rule set settings. See [Basic rule set](/docs/smartwebsecurity/concepts/waf#rules-set) for details. 
analyze_request_body | **[AnalyzeRequestBody](#AnalyzeRequestBody)**<br>Parameters for request body analyzer. 


### CoreRuleSet {#CoreRuleSet}

Field | Description
--- | ---
inbound_anomaly_score | **int64**<br>Anomaly score. Enter an integer within the range of 2 and 10000. The higher this value, the more likely it is that the request that satisfies the rule is an attack. See [Rules](/docs/smartwebsecurity/concepts/waf#anomaly) for more details. Acceptable values are 2 to 10000, inclusive.
paranoia_level | **int64**<br>Paranoia level. Enter an integer within the range of 1 and 4. Paranoia level classifies rules according to their aggression. The higher the paranoia level, the better your protection, but also the higher the probability of WAF false positives. See [Rules](/docs/smartwebsecurity/concepts/waf#paranoia) for more details. NOTE: this option has no effect on enabling or disabling rules. it is used only as recommendation for user to enable all rules with paranoia_level <= this value. Value must be equal to 1,2,3,4.
rule_set | **[RuleSet](#RuleSet)**<br>Required. Rule set. 


### AnalyzeRequestBody {#AnalyzeRequestBody}

Field | Description
--- | ---
is_enabled | **bool**<br>Possible to turn analyzer on and turn if off. 
size_limit | **int64**<br>Maximum size of body to pass to analyzer. In kilobytes. Value must be equal to 0,8,16,32,64,128,256,512.
size_limit_action | enum **Action**<br>Action to perform if maximum size of body exceeded. <ul><li>`IGNORE`: Ignore request.</li><li>`DENY`: Deny request.</li></ul>


### WafProfileRule {#WafProfileRule}

Field | Description
--- | ---
rule_id | **string**<br>Required. Rule ID. 
is_enabled | **bool**<br>Determines is it rule enabled or not. 
is_blocking | **bool**<br>Determines is it rule blocking or not. 


### WafProfileExclusionRule {#WafProfileExclusionRule}

Field | Description
--- | ---
name | **string**<br>Required. Name of exclusion rule. 
description | **string**<br>Optional description of the rule. 0-512 characters long. The maximum string length in characters is 512.
condition | **Condition**<br>The condition for matching traffic. 
exclude_rules | **[ExcludeRules](#ExcludeRules)**<br>Required. Exclude rules. 
log_excluded | **bool**<br>Records the fact that an exception rule is triggered. 


### ExcludeRules {#ExcludeRules}

Field | Description
--- | ---
exclude_all | **bool**<br>Set this option true to exclude all rules. 
rule_ids[] | **string**<br>List of rules to exclude. 


### Condition {#Condition}

Field | Description
--- | ---
authority | **AuthorityMatcher**<br>Match authority (Host header). 
http_method | **HttpMethodMatcher**<br>Match HTTP method. 
request_uri | **RequestUriMatcher**<br>Match Request URI. 
headers[] | **HeaderMatcher**<br>Match HTTP headers. The maximum number of elements is 20.
source_ip | **IpMatcher**<br>Match IP. 


### StringMatcher {#StringMatcher}

Field | Description
--- | ---
match | **oneof:** `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match` or `pire_regex_not_match`<br>
&nbsp;&nbsp;exact_match | **string**<br> The string length in characters must be 0-255.
&nbsp;&nbsp;exact_not_match | **string**<br> The string length in characters must be 0-255.
&nbsp;&nbsp;prefix_match | **string**<br> The string length in characters must be 0-255.
&nbsp;&nbsp;prefix_not_match | **string**<br> The string length in characters must be 0-255.
&nbsp;&nbsp;pire_regex_match | **string**<br> The string length in characters must be 0-255.
&nbsp;&nbsp;pire_regex_not_match | **string**<br> The string length in characters must be 0-255.


### HttpMethodMatcher {#HttpMethodMatcher}

Field | Description
--- | ---
http_methods[] | **StringMatcher**<br>List of HTTP methods. OR semantics implied. The maximum number of elements is 20.


### AuthorityMatcher {#AuthorityMatcher}

Field | Description
--- | ---
authorities[] | **StringMatcher**<br>List of authorities. OR semantics implied. The maximum number of elements is 20.


### RequestUriMatcher {#RequestUriMatcher}

Field | Description
--- | ---
path | **StringMatcher**<br>Path of the URI [RFC3986](https://datatracker.ietf.org/doc/html/rfc3986#section-3.3). 
queries[] | **QueryMatcher**<br>List of query matchers. AND semantics implied. The maximum number of elements is 20.


### QueryMatcher {#QueryMatcher}

Field | Description
--- | ---
key | **string**<br>Required. Key of the query parameter. The string length in characters must be 1-255.
value | **StringMatcher**<br>Required. Value of the query parameter. 


### HeaderMatcher {#HeaderMatcher}

Field | Description
--- | ---
name | **string**<br>Required. Name of header (case insensitive). The string length in characters must be 1-255.
value | **StringMatcher**<br>Required. Value of the header. 


### IpMatcher {#IpMatcher}

Field | Description
--- | ---
ip_ranges_match | **IpRangesMatcher**<br> 
ip_ranges_not_match | **IpRangesMatcher**<br> 
geo_ip_match | **GeoIpMatcher**<br> 
geo_ip_not_match | **GeoIpMatcher**<br> 


### IpRangesMatcher {#IpRangesMatcher}

Field | Description
--- | ---
ip_ranges[] | **string**<br>List of IP ranges. OR semantics implied. The maximum number of elements is 10000.


### GeoIpMatcher {#GeoIpMatcher}

Field | Description
--- | ---
locations[] | **string**<br>ISO 3166-1 alpha 2. OR semantics implied. The minimum number of elements is 1. The string length in characters for each value must be equal to 2.


### RuleSet {#RuleSet}

Field | Description
--- | ---
name | **string**<br>Required. Name of rule set. 
version | **string**<br>Required. Version of rule set. 


## List {#List}

Retrieves the list of WafProfile resources in the specified folder.

**rpc List ([ListWafProfilesRequest](#ListWafProfilesRequest)) returns ([ListWafProfilesResponse](#ListWafProfilesResponse))**

### ListWafProfilesRequest {#ListWafProfilesRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder that the WAF profile belongs to. Currently page_size, page_token, filter and order_by are not supported and List method will return all WAF profiles in the folder. 


### ListWafProfilesResponse {#ListWafProfilesResponse}

Field | Description
--- | ---
waf_profiles[] | **[WafProfile](#WafProfile1)**<br>List of WafProfile resources. Currently next_page_token is not supported and List method will return all WAF profiles in the folder. 


### WafProfile {#WafProfile1}

Field | Description
--- | ---
id | **string**<br>Required. ID of the WAF profile. 
folder_id | **string**<br>Required. ID of the folder that the WAF profile belongs to. 
cloud_id | **string**<br>Required. ID of the cloud that the WAF profile belongs to. 
name | **string**<br>Required. Name of the WAF profile. The name is unique within the folder. 1-50 characters long. The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `.
description | **string**<br>Optional description of the WAF profile. The maximum string length in characters is 512.
labels | **map<string,string>**<br>Labels as `` key:value `` pairs. Maximum of 64 per resource. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
rules[] | **[WafProfileRule](#WafProfileRule1)**<br>Settings for each rule in rule set. 
exclusion_rules[] | **[WafProfileExclusionRule](#WafProfileExclusionRule1)**<br>List of exclusion rules. See [Rules](/docs/smartwebsecurity/concepts/waf#exclusion-rules). 
rule_set | **oneof:** `core_rule_set`<br>
&nbsp;&nbsp;core_rule_set | **[CoreRuleSet](#CoreRuleSet1)**<br>Core rule set settings. See [Basic rule set](/docs/smartwebsecurity/concepts/waf#rules-set) for details. 
analyze_request_body | **[AnalyzeRequestBody](#AnalyzeRequestBody1)**<br>Parameters for request body analyzer. 


### CoreRuleSet {#CoreRuleSet1}

Field | Description
--- | ---
inbound_anomaly_score | **int64**<br>Anomaly score. Enter an integer within the range of 2 and 10000. The higher this value, the more likely it is that the request that satisfies the rule is an attack. See [Rules](/docs/smartwebsecurity/concepts/waf#anomaly) for more details. Acceptable values are 2 to 10000, inclusive.
paranoia_level | **int64**<br>Paranoia level. Enter an integer within the range of 1 and 4. Paranoia level classifies rules according to their aggression. The higher the paranoia level, the better your protection, but also the higher the probability of WAF false positives. See [Rules](/docs/smartwebsecurity/concepts/waf#paranoia) for more details. NOTE: this option has no effect on enabling or disabling rules. it is used only as recommendation for user to enable all rules with paranoia_level <= this value. Value must be equal to 1,2,3,4.
rule_set | **[RuleSet](#RuleSet1)**<br>Required. Rule set. 


### AnalyzeRequestBody {#AnalyzeRequestBody1}

Field | Description
--- | ---
is_enabled | **bool**<br>Possible to turn analyzer on and turn if off. 
size_limit | **int64**<br>Maximum size of body to pass to analyzer. In kilobytes. Value must be equal to 0,8,16,32,64,128,256,512.
size_limit_action | enum **Action**<br>Action to perform if maximum size of body exceeded. <ul><li>`IGNORE`: Ignore request.</li><li>`DENY`: Deny request.</li></ul>


### WafProfileRule {#WafProfileRule1}

Field | Description
--- | ---
rule_id | **string**<br>Required. Rule ID. 
is_enabled | **bool**<br>Determines is it rule enabled or not. 
is_blocking | **bool**<br>Determines is it rule blocking or not. 


### WafProfileExclusionRule {#WafProfileExclusionRule1}

Field | Description
--- | ---
name | **string**<br>Required. Name of exclusion rule. 
description | **string**<br>Optional description of the rule. 0-512 characters long. The maximum string length in characters is 512.
condition | **Condition**<br>The condition for matching traffic. 
exclude_rules | **[ExcludeRules](#ExcludeRules1)**<br>Required. Exclude rules. 
log_excluded | **bool**<br>Records the fact that an exception rule is triggered. 


### ExcludeRules {#ExcludeRules1}

Field | Description
--- | ---
exclude_all | **bool**<br>Set this option true to exclude all rules. 
rule_ids[] | **string**<br>List of rules to exclude. 


### Condition {#Condition1}

Field | Description
--- | ---
authority | **AuthorityMatcher**<br>Match authority (Host header). 
http_method | **HttpMethodMatcher**<br>Match HTTP method. 
request_uri | **RequestUriMatcher**<br>Match Request URI. 
headers[] | **HeaderMatcher**<br>Match HTTP headers. The maximum number of elements is 20.
source_ip | **IpMatcher**<br>Match IP. 


### StringMatcher {#StringMatcher1}

Field | Description
--- | ---
match | **oneof:** `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match` or `pire_regex_not_match`<br>
&nbsp;&nbsp;exact_match | **string**<br> The string length in characters must be 0-255.
&nbsp;&nbsp;exact_not_match | **string**<br> The string length in characters must be 0-255.
&nbsp;&nbsp;prefix_match | **string**<br> The string length in characters must be 0-255.
&nbsp;&nbsp;prefix_not_match | **string**<br> The string length in characters must be 0-255.
&nbsp;&nbsp;pire_regex_match | **string**<br> The string length in characters must be 0-255.
&nbsp;&nbsp;pire_regex_not_match | **string**<br> The string length in characters must be 0-255.


### HttpMethodMatcher {#HttpMethodMatcher1}

Field | Description
--- | ---
http_methods[] | **StringMatcher**<br>List of HTTP methods. OR semantics implied. The maximum number of elements is 20.


### AuthorityMatcher {#AuthorityMatcher1}

Field | Description
--- | ---
authorities[] | **StringMatcher**<br>List of authorities. OR semantics implied. The maximum number of elements is 20.


### RequestUriMatcher {#RequestUriMatcher1}

Field | Description
--- | ---
path | **StringMatcher**<br>Path of the URI [RFC3986](https://datatracker.ietf.org/doc/html/rfc3986#section-3.3). 
queries[] | **QueryMatcher**<br>List of query matchers. AND semantics implied. The maximum number of elements is 20.


### QueryMatcher {#QueryMatcher1}

Field | Description
--- | ---
key | **string**<br>Required. Key of the query parameter. The string length in characters must be 1-255.
value | **StringMatcher**<br>Required. Value of the query parameter. 


### HeaderMatcher {#HeaderMatcher1}

Field | Description
--- | ---
name | **string**<br>Required. Name of header (case insensitive). The string length in characters must be 1-255.
value | **StringMatcher**<br>Required. Value of the header. 


### IpMatcher {#IpMatcher1}

Field | Description
--- | ---
ip_ranges_match | **IpRangesMatcher**<br> 
ip_ranges_not_match | **IpRangesMatcher**<br> 
geo_ip_match | **GeoIpMatcher**<br> 
geo_ip_not_match | **GeoIpMatcher**<br> 


### IpRangesMatcher {#IpRangesMatcher1}

Field | Description
--- | ---
ip_ranges[] | **string**<br>List of IP ranges. OR semantics implied. The maximum number of elements is 10000.


### GeoIpMatcher {#GeoIpMatcher1}

Field | Description
--- | ---
locations[] | **string**<br>ISO 3166-1 alpha 2. OR semantics implied. The minimum number of elements is 1. The string length in characters for each value must be equal to 2.


### RuleSet {#RuleSet1}

Field | Description
--- | ---
name | **string**<br>Required. Name of rule set. 
version | **string**<br>Required. Version of rule set. 


## Create {#Create}

Creates a WAF profile in the specified folder using the data specified in the request.

**rpc Create ([CreateWafProfileRequest](#CreateWafProfileRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateWafProfileMetadata](#CreateWafProfileMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[WafProfile](#WafProfile2)<br>

### CreateWafProfileRequest {#CreateWafProfileRequest}

Field | Description
--- | ---
folder_id | **string**<br>ID of the folder to create a WAF profile in. 
name | **string**<br>Name of the WAF profile. The name is unique within the folder. 1-50 characters long. 
description | **string**<br>Optional description of the WAF profile. 
labels | **map<string,string>**<br>Labels as `` key:value `` pairs. Maximum of 64 per resource. 
rules[] | **[WafProfileRule](#WafProfileRule2)**<br>Settings for each rule in rule set. 
exclusion_rules[] | **[WafProfileExclusionRule](#WafProfileExclusionRule2)**<br>List of exclusion rules. See [Rules](/docs/smartwebsecurity/concepts/waf#exclusion-rules). 
rule_set | **oneof:** `core_rule_set`<br>
&nbsp;&nbsp;core_rule_set | **[WafProfile.CoreRuleSet](#WafProfile2)**<br>Core rule set settings. See [Basic rule set](/docs/smartwebsecurity/concepts/waf#rules-set) for details. 
analyze_request_body | **[WafProfile.AnalyzeRequestBody](#WafProfile2)**<br>Parameters for request body analyzer. 


### WafProfileRule {#WafProfileRule2}

Field | Description
--- | ---
rule_id | **string**<br>Required. Rule ID. 
is_enabled | **bool**<br>Determines is it rule enabled or not. 
is_blocking | **bool**<br>Determines is it rule blocking or not. 


### WafProfileExclusionRule {#WafProfileExclusionRule2}

Field | Description
--- | ---
name | **string**<br>Required. Name of exclusion rule. 
description | **string**<br>Optional description of the rule. 0-512 characters long. The maximum string length in characters is 512.
condition | **Condition**<br>The condition for matching traffic. 
exclude_rules | **[ExcludeRules](#ExcludeRules2)**<br>Required. Exclude rules. 
log_excluded | **bool**<br>Records the fact that an exception rule is triggered. 


### ExcludeRules {#ExcludeRules2}

Field | Description
--- | ---
exclude_all | **bool**<br>Set this option true to exclude all rules. 
rule_ids[] | **string**<br>List of rules to exclude. 


### Condition {#Condition2}

Field | Description
--- | ---
authority | **AuthorityMatcher**<br>Match authority (Host header). 
http_method | **HttpMethodMatcher**<br>Match HTTP method. 
request_uri | **RequestUriMatcher**<br>Match Request URI. 
headers[] | **HeaderMatcher**<br>Match HTTP headers. The maximum number of elements is 20.
source_ip | **IpMatcher**<br>Match IP. 


### StringMatcher {#StringMatcher2}

Field | Description
--- | ---
match | **oneof:** `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match` or `pire_regex_not_match`<br>
&nbsp;&nbsp;exact_match | **string**<br> The string length in characters must be 0-255.
&nbsp;&nbsp;exact_not_match | **string**<br> The string length in characters must be 0-255.
&nbsp;&nbsp;prefix_match | **string**<br> The string length in characters must be 0-255.
&nbsp;&nbsp;prefix_not_match | **string**<br> The string length in characters must be 0-255.
&nbsp;&nbsp;pire_regex_match | **string**<br> The string length in characters must be 0-255.
&nbsp;&nbsp;pire_regex_not_match | **string**<br> The string length in characters must be 0-255.


### HttpMethodMatcher {#HttpMethodMatcher2}

Field | Description
--- | ---
http_methods[] | **StringMatcher**<br>List of HTTP methods. OR semantics implied. The maximum number of elements is 20.


### AuthorityMatcher {#AuthorityMatcher2}

Field | Description
--- | ---
authorities[] | **StringMatcher**<br>List of authorities. OR semantics implied. The maximum number of elements is 20.


### RequestUriMatcher {#RequestUriMatcher2}

Field | Description
--- | ---
path | **StringMatcher**<br>Path of the URI [RFC3986](https://datatracker.ietf.org/doc/html/rfc3986#section-3.3). 
queries[] | **QueryMatcher**<br>List of query matchers. AND semantics implied. The maximum number of elements is 20.


### QueryMatcher {#QueryMatcher2}

Field | Description
--- | ---
key | **string**<br>Required. Key of the query parameter. The string length in characters must be 1-255.
value | **StringMatcher**<br>Required. Value of the query parameter. 


### HeaderMatcher {#HeaderMatcher2}

Field | Description
--- | ---
name | **string**<br>Required. Name of header (case insensitive). The string length in characters must be 1-255.
value | **StringMatcher**<br>Required. Value of the header. 


### IpMatcher {#IpMatcher2}

Field | Description
--- | ---
ip_ranges_match | **IpRangesMatcher**<br> 
ip_ranges_not_match | **IpRangesMatcher**<br> 
geo_ip_match | **GeoIpMatcher**<br> 
geo_ip_not_match | **GeoIpMatcher**<br> 


### IpRangesMatcher {#IpRangesMatcher2}

Field | Description
--- | ---
ip_ranges[] | **string**<br>List of IP ranges. OR semantics implied. The maximum number of elements is 10000.


### GeoIpMatcher {#GeoIpMatcher2}

Field | Description
--- | ---
locations[] | **string**<br>ISO 3166-1 alpha 2. OR semantics implied. The minimum number of elements is 1. The string length in characters for each value must be equal to 2.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateWafProfileMetadata](#CreateWafProfileMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[WafProfile](#WafProfile2)>**<br>if operation finished successfully. 


### CreateWafProfileMetadata {#CreateWafProfileMetadata}

Field | Description
--- | ---
waf_profile_id | **string**<br>ID of the WAF profile that is being created. 


### WafProfile {#WafProfile2}

Field | Description
--- | ---
id | **string**<br>Required. ID of the WAF profile. 
folder_id | **string**<br>Required. ID of the folder that the WAF profile belongs to. 
cloud_id | **string**<br>Required. ID of the cloud that the WAF profile belongs to. 
name | **string**<br>Required. Name of the WAF profile. The name is unique within the folder. 1-50 characters long. The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `.
description | **string**<br>Optional description of the WAF profile. The maximum string length in characters is 512.
labels | **map<string,string>**<br>Labels as `` key:value `` pairs. Maximum of 64 per resource. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
rules[] | **[WafProfileRule](#WafProfileRule3)**<br>Settings for each rule in rule set. 
exclusion_rules[] | **[WafProfileExclusionRule](#WafProfileExclusionRule3)**<br>List of exclusion rules. See [Rules](/docs/smartwebsecurity/concepts/waf#exclusion-rules). 
rule_set | **oneof:** `core_rule_set`<br>
&nbsp;&nbsp;core_rule_set | **[CoreRuleSet](#CoreRuleSet2)**<br>Core rule set settings. See [Basic rule set](/docs/smartwebsecurity/concepts/waf#rules-set) for details. 
analyze_request_body | **[AnalyzeRequestBody](#AnalyzeRequestBody2)**<br>Parameters for request body analyzer. 


### CoreRuleSet {#CoreRuleSet2}

Field | Description
--- | ---
inbound_anomaly_score | **int64**<br>Anomaly score. Enter an integer within the range of 2 and 10000. The higher this value, the more likely it is that the request that satisfies the rule is an attack. See [Rules](/docs/smartwebsecurity/concepts/waf#anomaly) for more details. Acceptable values are 2 to 10000, inclusive.
paranoia_level | **int64**<br>Paranoia level. Enter an integer within the range of 1 and 4. Paranoia level classifies rules according to their aggression. The higher the paranoia level, the better your protection, but also the higher the probability of WAF false positives. See [Rules](/docs/smartwebsecurity/concepts/waf#paranoia) for more details. NOTE: this option has no effect on enabling or disabling rules. it is used only as recommendation for user to enable all rules with paranoia_level <= this value. Value must be equal to 1,2,3,4.
rule_set | **[RuleSet](#RuleSet2)**<br>Required. Rule set. 


### AnalyzeRequestBody {#AnalyzeRequestBody2}

Field | Description
--- | ---
is_enabled | **bool**<br>Possible to turn analyzer on and turn if off. 
size_limit | **int64**<br>Maximum size of body to pass to analyzer. In kilobytes. Value must be equal to 0,8,16,32,64,128,256,512.
size_limit_action | enum **Action**<br>Action to perform if maximum size of body exceeded. <ul><li>`IGNORE`: Ignore request.</li><li>`DENY`: Deny request.</li></ul>


### RuleSet {#RuleSet2}

Field | Description
--- | ---
name | **string**<br>Required. Name of rule set. 
version | **string**<br>Required. Version of rule set. 


## Update {#Update}

Updates the specified WAF profile.

**rpc Update ([UpdateWafProfileRequest](#UpdateWafProfileRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateWafProfileMetadata](#UpdateWafProfileMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[WafProfile](#WafProfile3)<br>

### UpdateWafProfileRequest {#UpdateWafProfileRequest}

Field | Description
--- | ---
waf_profile_id | **string**<br>Required. ID of the WAF profile to update. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the WafProfile resource are going to be updated. 
name | **string**<br>Name of the WAF profile. The name is unique within the folder. 1-50 characters long. 
description | **string**<br>Optional description of the WAF profile. 
labels | **map<string,string>**<br>Labels as `` key:value `` pairs. Maximum of 64 per resource. 
rules[] | **[WafProfileRule](#WafProfileRule3)**<br>Settings for each rule in rule set. 
exclusion_rules[] | **[WafProfileExclusionRule](#WafProfileExclusionRule3)**<br>List of exclusion rules. See [Rules](/docs/smartwebsecurity/concepts/waf#exclusion-rules). 
rule_set | **oneof:** `core_rule_set`<br>
&nbsp;&nbsp;core_rule_set | **[WafProfile.CoreRuleSet](#WafProfile3)**<br>Core rule set settings. See [Basic rule set](/docs/smartwebsecurity/concepts/waf#rules-set) for details. 
analyze_request_body | **[WafProfile.AnalyzeRequestBody](#WafProfile3)**<br>Parameters for request body analyzer. 


### WafProfileRule {#WafProfileRule3}

Field | Description
--- | ---
rule_id | **string**<br>Required. Rule ID. 
is_enabled | **bool**<br>Determines is it rule enabled or not. 
is_blocking | **bool**<br>Determines is it rule blocking or not. 


### WafProfileExclusionRule {#WafProfileExclusionRule3}

Field | Description
--- | ---
name | **string**<br>Required. Name of exclusion rule. 
description | **string**<br>Optional description of the rule. 0-512 characters long. The maximum string length in characters is 512.
condition | **Condition**<br>The condition for matching traffic. 
exclude_rules | **[ExcludeRules](#ExcludeRules3)**<br>Required. Exclude rules. 
log_excluded | **bool**<br>Records the fact that an exception rule is triggered. 


### ExcludeRules {#ExcludeRules3}

Field | Description
--- | ---
exclude_all | **bool**<br>Set this option true to exclude all rules. 
rule_ids[] | **string**<br>List of rules to exclude. 


### Condition {#Condition3}

Field | Description
--- | ---
authority | **AuthorityMatcher**<br>Match authority (Host header). 
http_method | **HttpMethodMatcher**<br>Match HTTP method. 
request_uri | **RequestUriMatcher**<br>Match Request URI. 
headers[] | **HeaderMatcher**<br>Match HTTP headers. The maximum number of elements is 20.
source_ip | **IpMatcher**<br>Match IP. 


### StringMatcher {#StringMatcher3}

Field | Description
--- | ---
match | **oneof:** `exact_match`, `exact_not_match`, `prefix_match`, `prefix_not_match`, `pire_regex_match` or `pire_regex_not_match`<br>
&nbsp;&nbsp;exact_match | **string**<br> The string length in characters must be 0-255.
&nbsp;&nbsp;exact_not_match | **string**<br> The string length in characters must be 0-255.
&nbsp;&nbsp;prefix_match | **string**<br> The string length in characters must be 0-255.
&nbsp;&nbsp;prefix_not_match | **string**<br> The string length in characters must be 0-255.
&nbsp;&nbsp;pire_regex_match | **string**<br> The string length in characters must be 0-255.
&nbsp;&nbsp;pire_regex_not_match | **string**<br> The string length in characters must be 0-255.


### HttpMethodMatcher {#HttpMethodMatcher3}

Field | Description
--- | ---
http_methods[] | **StringMatcher**<br>List of HTTP methods. OR semantics implied. The maximum number of elements is 20.


### AuthorityMatcher {#AuthorityMatcher3}

Field | Description
--- | ---
authorities[] | **StringMatcher**<br>List of authorities. OR semantics implied. The maximum number of elements is 20.


### RequestUriMatcher {#RequestUriMatcher3}

Field | Description
--- | ---
path | **StringMatcher**<br>Path of the URI [RFC3986](https://datatracker.ietf.org/doc/html/rfc3986#section-3.3). 
queries[] | **QueryMatcher**<br>List of query matchers. AND semantics implied. The maximum number of elements is 20.


### QueryMatcher {#QueryMatcher3}

Field | Description
--- | ---
key | **string**<br>Required. Key of the query parameter. The string length in characters must be 1-255.
value | **StringMatcher**<br>Required. Value of the query parameter. 


### HeaderMatcher {#HeaderMatcher3}

Field | Description
--- | ---
name | **string**<br>Required. Name of header (case insensitive). The string length in characters must be 1-255.
value | **StringMatcher**<br>Required. Value of the header. 


### IpMatcher {#IpMatcher3}

Field | Description
--- | ---
ip_ranges_match | **IpRangesMatcher**<br> 
ip_ranges_not_match | **IpRangesMatcher**<br> 
geo_ip_match | **GeoIpMatcher**<br> 
geo_ip_not_match | **GeoIpMatcher**<br> 


### IpRangesMatcher {#IpRangesMatcher3}

Field | Description
--- | ---
ip_ranges[] | **string**<br>List of IP ranges. OR semantics implied. The maximum number of elements is 10000.


### GeoIpMatcher {#GeoIpMatcher3}

Field | Description
--- | ---
locations[] | **string**<br>ISO 3166-1 alpha 2. OR semantics implied. The minimum number of elements is 1. The string length in characters for each value must be equal to 2.


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateWafProfileMetadata](#UpdateWafProfileMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[WafProfile](#WafProfile3)>**<br>if operation finished successfully. 


### UpdateWafProfileMetadata {#UpdateWafProfileMetadata}

Field | Description
--- | ---
waf_profile_id | **string**<br>ID of the WafProfile resource that is being updated. 


### WafProfile {#WafProfile3}

Field | Description
--- | ---
id | **string**<br>Required. ID of the WAF profile. 
folder_id | **string**<br>Required. ID of the folder that the WAF profile belongs to. 
cloud_id | **string**<br>Required. ID of the cloud that the WAF profile belongs to. 
name | **string**<br>Required. Name of the WAF profile. The name is unique within the folder. 1-50 characters long. The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `.
description | **string**<br>Optional description of the WAF profile. The maximum string length in characters is 512.
labels | **map<string,string>**<br>Labels as `` key:value `` pairs. Maximum of 64 per resource. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
rules[] | **[WafProfileRule](#WafProfileRule4)**<br>Settings for each rule in rule set. 
exclusion_rules[] | **[WafProfileExclusionRule](#WafProfileExclusionRule4)**<br>List of exclusion rules. See [Rules](/docs/smartwebsecurity/concepts/waf#exclusion-rules). 
rule_set | **oneof:** `core_rule_set`<br>
&nbsp;&nbsp;core_rule_set | **[CoreRuleSet](#CoreRuleSet3)**<br>Core rule set settings. See [Basic rule set](/docs/smartwebsecurity/concepts/waf#rules-set) for details. 
analyze_request_body | **[AnalyzeRequestBody](#AnalyzeRequestBody3)**<br>Parameters for request body analyzer. 


### CoreRuleSet {#CoreRuleSet3}

Field | Description
--- | ---
inbound_anomaly_score | **int64**<br>Anomaly score. Enter an integer within the range of 2 and 10000. The higher this value, the more likely it is that the request that satisfies the rule is an attack. See [Rules](/docs/smartwebsecurity/concepts/waf#anomaly) for more details. Acceptable values are 2 to 10000, inclusive.
paranoia_level | **int64**<br>Paranoia level. Enter an integer within the range of 1 and 4. Paranoia level classifies rules according to their aggression. The higher the paranoia level, the better your protection, but also the higher the probability of WAF false positives. See [Rules](/docs/smartwebsecurity/concepts/waf#paranoia) for more details. NOTE: this option has no effect on enabling or disabling rules. it is used only as recommendation for user to enable all rules with paranoia_level <= this value. Value must be equal to 1,2,3,4.
rule_set | **[RuleSet](#RuleSet3)**<br>Required. Rule set. 


### AnalyzeRequestBody {#AnalyzeRequestBody3}

Field | Description
--- | ---
is_enabled | **bool**<br>Possible to turn analyzer on and turn if off. 
size_limit | **int64**<br>Maximum size of body to pass to analyzer. In kilobytes. Value must be equal to 0,8,16,32,64,128,256,512.
size_limit_action | enum **Action**<br>Action to perform if maximum size of body exceeded. <ul><li>`IGNORE`: Ignore request.</li><li>`DENY`: Deny request.</li></ul>


### RuleSet {#RuleSet3}

Field | Description
--- | ---
name | **string**<br>Required. Name of rule set. 
version | **string**<br>Required. Version of rule set. 


## Delete {#Delete}

Deletes the specified WAF profile.

**rpc Delete ([DeleteWafProfileRequest](#DeleteWafProfileRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteWafProfileMetadata](#DeleteWafProfileMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteWafProfileRequest {#DeleteWafProfileRequest}

Field | Description
--- | ---
waf_profile_id | **string**<br>Required. ID of the WAF profile to delete. 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteWafProfileMetadata](#DeleteWafProfileMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteWafProfileMetadata {#DeleteWafProfileMetadata}

Field | Description
--- | ---
waf_profile_id | **string**<br>ID of the WafProfile resource that is being deleted. 


