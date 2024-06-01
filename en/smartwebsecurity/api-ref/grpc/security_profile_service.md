---
editable: false
sourcePath: en/_api-ref-grpc/smartwebsecurity/api-ref/grpc/security_profile_service.md
---

# SmartWebSecurity API, gRPC: SecurityProfileService

A set of methods for managing SecurityProfile resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified SecurityProfile resource. |
| [List](#List) | Retrieves the list of SecurityProfile resources in the specified folder. |
| [Create](#Create) | Creates a security profile in the specified folder using the data specified in the request. |
| [Update](#Update) | Updates the specified security profile. |
| [Delete](#Delete) | Deletes the specified security profile. |

## Calls SecurityProfileService {#calls}

## Get {#Get}

Returns the specified SecurityProfile resource.

**rpc Get ([GetSecurityProfileRequest](#GetSecurityProfileRequest)) returns ([SecurityProfile](#SecurityProfile))**

### GetSecurityProfileRequest {#GetSecurityProfileRequest}

Field | Description
--- | ---
security_profile_id | **string**<br>Required. ID of the SecurityProfile resource to return. 


### SecurityProfile {#SecurityProfile}

Field | Description
--- | ---
id | **string**<br>ID of the security profile. 
folder_id | **string**<br>ID of the folder that the security profile belongs to. 
cloud_id | **string**<br>ID of the cloud that the security profile belongs to. 
labels | **map<string,string>**<br>Labels as `` key:value `` pairs. Maximum of 64 per resource. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
name | **string**<br>Required. Name of the security profile. The name is unique within the folder. 1-50 characters long. The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `.
description | **string**<br>Optional description of the security profile. The maximum string length in characters is 512.
default_action | enum **DefaultAction**<br>Required. Action to perform if none of rules matched. <ul><li>`ALLOW`: Pass request to service.</li><li>`DENY`: Deny request.</li></ul>
security_rules[] | **[SecurityRule](#SecurityRule)**<br>List of security rules. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
captcha_id | **string**<br>Captcha ID to use with this security profile. Set empty to use default. 


### SecurityRule {#SecurityRule}

Field | Description
--- | ---
name | **string**<br>Required. Name of the rule. The name is unique within the folder. 1-50 characters long. The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `.
priority | **int64**<br>Determines the priority for checking the incoming traffic. Enter an integer within the range of 1 and 999999. The rule priority must be unique within the entire security profile. A lower numeric value means a higher priority. The default_action has the lowest priority. Acceptable values are 1 to 999999, inclusive.
dry_run | **bool**<br>This mode allows you to test your security profile or a single rule. For example, you can have the number of alarms for a specific rule displayed. Note: if this option is true, no real action affecting your traffic regarding this rule will be taken. 
rule_specifier | **oneof:** `rule_condition` or `smart_protection`<br>
&nbsp;&nbsp;rule_condition | **[RuleCondition](#RuleCondition)**<br>Rule actions, see [Rule actions](/docs/smartwebsecurity/concepts/rules#rule-action). 
&nbsp;&nbsp;smart_protection | **[SmartProtection](#SmartProtection)**<br>Smart Protection rule, see [Smart Protection rules](/docs/smartwebsecurity/concepts/rules#smart-protection-rules). 
description | **string**<br>Optional description of the rule. 0-512 characters long. The maximum string length in characters is 512.


### RuleCondition {#RuleCondition}

Field | Description
--- | ---
action | enum **Action**<br>Action to perform if this rule matched. <ul><li>`ALLOW`: Pass request to service.</li><li>`DENY`: Deny request.</li></ul>
condition | **[Condition](#Condition)**<br>The condition for matching the rule. 


### SmartProtection {#SmartProtection}

Field | Description
--- | ---
mode | enum **Mode**<br>Mode of protection. <ul><li>`FULL`: Full protection means that the traffic will be checked based on ML models and behavioral analysis, with suspicious requests being sent to SmartCaptcha.</li><li>`API`: API protection means checking the traffic based on ML models and behavioral analysis without sending suspicious requests to SmartCaptcha. The suspicious requests will be blocked.</li></ul>
condition | **[Condition](#Condition)**<br>The condition for matching the rule. 


### Condition {#Condition}

Field | Description
--- | ---
authority | **[AuthorityMatcher](#AuthorityMatcher)**<br>Match authority (Host header). 
http_method | **[HttpMethodMatcher](#HttpMethodMatcher)**<br>Match HTTP method. 
request_uri | **[RequestUriMatcher](#RequestUriMatcher)**<br>Match Request URI. 
headers[] | **[HeaderMatcher](#HeaderMatcher)**<br>Match HTTP headers. The maximum number of elements is 20.
source_ip | **[IpMatcher](#IpMatcher)**<br>Match IP. 


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
http_methods[] | **[StringMatcher](#StringMatcher)**<br>List of HTTP methods. OR semantics implied. The maximum number of elements is 20.


### AuthorityMatcher {#AuthorityMatcher}

Field | Description
--- | ---
authorities[] | **[StringMatcher](#StringMatcher)**<br>List of authorities. OR semantics implied. The maximum number of elements is 20.


### RequestUriMatcher {#RequestUriMatcher}

Field | Description
--- | ---
path | **[StringMatcher](#StringMatcher)**<br>Path of the URI [RFC3986](https://datatracker.ietf.org/doc/html/rfc3986#section-3.3). 
queries[] | **[QueryMatcher](#QueryMatcher)**<br>List of query matchers. AND semantics implied. The maximum number of elements is 20.


### QueryMatcher {#QueryMatcher}

Field | Description
--- | ---
key | **string**<br>Required. Key of the query parameter. The string length in characters must be 1-255.
value | **[StringMatcher](#StringMatcher)**<br>Required. Value of the query parameter. 


### HeaderMatcher {#HeaderMatcher}

Field | Description
--- | ---
name | **string**<br>Required. Name of header (case insensitive). The string length in characters must be 1-255.
value | **[StringMatcher](#StringMatcher)**<br>Required. Value of the header. 


### IpMatcher {#IpMatcher}

Field | Description
--- | ---
ip_ranges_match | **[IpRangesMatcher](#IpRangesMatcher)**<br> 
ip_ranges_not_match | **[IpRangesMatcher](#IpRangesMatcher)**<br> 
geo_ip_match | **[GeoIpMatcher](#GeoIpMatcher)**<br> 
geo_ip_not_match | **[GeoIpMatcher](#GeoIpMatcher)**<br> 


### IpRangesMatcher {#IpRangesMatcher}

Field | Description
--- | ---
ip_ranges[] | **string**<br>List of IP ranges. OR semantics implied. The maximum number of elements is 10000.


### GeoIpMatcher {#GeoIpMatcher}

Field | Description
--- | ---
locations[] | **string**<br>ISO 3166-1 alpha 2. OR semantics implied. The minimum number of elements is 1. The string length in characters for each value must be equal to 2.


## List {#List}

Retrieves the list of SecurityProfile resources in the specified folder.

**rpc List ([ListSecurityProfilesRequest](#ListSecurityProfilesRequest)) returns ([ListSecurityProfilesResponse](#ListSecurityProfilesResponse))**

### ListSecurityProfilesRequest {#ListSecurityProfilesRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder that the security profile belongs to. Currently page_size, page_token, filter and order_by are not supported and List method will return all security profiles in the folder. 


### ListSecurityProfilesResponse {#ListSecurityProfilesResponse}

Field | Description
--- | ---
security_profiles[] | **[SecurityProfile](#SecurityProfile1)**<br>List of SecurityProfile resources. Currently next_page_token is not supported and List method will return all security profiles in the folder. 


### SecurityProfile {#SecurityProfile1}

Field | Description
--- | ---
id | **string**<br>ID of the security profile. 
folder_id | **string**<br>ID of the folder that the security profile belongs to. 
cloud_id | **string**<br>ID of the cloud that the security profile belongs to. 
labels | **map<string,string>**<br>Labels as `` key:value `` pairs. Maximum of 64 per resource. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
name | **string**<br>Required. Name of the security profile. The name is unique within the folder. 1-50 characters long. The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `.
description | **string**<br>Optional description of the security profile. The maximum string length in characters is 512.
default_action | enum **DefaultAction**<br>Required. Action to perform if none of rules matched. <ul><li>`ALLOW`: Pass request to service.</li><li>`DENY`: Deny request.</li></ul>
security_rules[] | **[SecurityRule](#SecurityRule1)**<br>List of security rules. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
captcha_id | **string**<br>Captcha ID to use with this security profile. Set empty to use default. 


### SecurityRule {#SecurityRule1}

Field | Description
--- | ---
name | **string**<br>Required. Name of the rule. The name is unique within the folder. 1-50 characters long. The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `.
priority | **int64**<br>Determines the priority for checking the incoming traffic. Enter an integer within the range of 1 and 999999. The rule priority must be unique within the entire security profile. A lower numeric value means a higher priority. The default_action has the lowest priority. Acceptable values are 1 to 999999, inclusive.
dry_run | **bool**<br>This mode allows you to test your security profile or a single rule. For example, you can have the number of alarms for a specific rule displayed. Note: if this option is true, no real action affecting your traffic regarding this rule will be taken. 
rule_specifier | **oneof:** `rule_condition` or `smart_protection`<br>
&nbsp;&nbsp;rule_condition | **[RuleCondition](#RuleCondition1)**<br>Rule actions, see [Rule actions](/docs/smartwebsecurity/concepts/rules#rule-action). 
&nbsp;&nbsp;smart_protection | **[SmartProtection](#SmartProtection1)**<br>Smart Protection rule, see [Smart Protection rules](/docs/smartwebsecurity/concepts/rules#smart-protection-rules). 
description | **string**<br>Optional description of the rule. 0-512 characters long. The maximum string length in characters is 512.


### RuleCondition {#RuleCondition1}

Field | Description
--- | ---
action | enum **Action**<br>Action to perform if this rule matched. <ul><li>`ALLOW`: Pass request to service.</li><li>`DENY`: Deny request.</li></ul>
condition | **[Condition](#Condition1)**<br>The condition for matching the rule. 


### SmartProtection {#SmartProtection1}

Field | Description
--- | ---
mode | enum **Mode**<br>Mode of protection. <ul><li>`FULL`: Full protection means that the traffic will be checked based on ML models and behavioral analysis, with suspicious requests being sent to SmartCaptcha.</li><li>`API`: API protection means checking the traffic based on ML models and behavioral analysis without sending suspicious requests to SmartCaptcha. The suspicious requests will be blocked.</li></ul>
condition | **[Condition](#Condition1)**<br>The condition for matching the rule. 


### Condition {#Condition1}

Field | Description
--- | ---
authority | **[AuthorityMatcher](#AuthorityMatcher1)**<br>Match authority (Host header). 
http_method | **[HttpMethodMatcher](#HttpMethodMatcher1)**<br>Match HTTP method. 
request_uri | **[RequestUriMatcher](#RequestUriMatcher1)**<br>Match Request URI. 
headers[] | **[HeaderMatcher](#HeaderMatcher1)**<br>Match HTTP headers. The maximum number of elements is 20.
source_ip | **[IpMatcher](#IpMatcher1)**<br>Match IP. 


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
http_methods[] | **[StringMatcher](#StringMatcher1)**<br>List of HTTP methods. OR semantics implied. The maximum number of elements is 20.


### AuthorityMatcher {#AuthorityMatcher1}

Field | Description
--- | ---
authorities[] | **[StringMatcher](#StringMatcher1)**<br>List of authorities. OR semantics implied. The maximum number of elements is 20.


### RequestUriMatcher {#RequestUriMatcher1}

Field | Description
--- | ---
path | **[StringMatcher](#StringMatcher1)**<br>Path of the URI [RFC3986](https://datatracker.ietf.org/doc/html/rfc3986#section-3.3). 
queries[] | **[QueryMatcher](#QueryMatcher1)**<br>List of query matchers. AND semantics implied. The maximum number of elements is 20.


### QueryMatcher {#QueryMatcher1}

Field | Description
--- | ---
key | **string**<br>Required. Key of the query parameter. The string length in characters must be 1-255.
value | **[StringMatcher](#StringMatcher1)**<br>Required. Value of the query parameter. 


### HeaderMatcher {#HeaderMatcher1}

Field | Description
--- | ---
name | **string**<br>Required. Name of header (case insensitive). The string length in characters must be 1-255.
value | **[StringMatcher](#StringMatcher1)**<br>Required. Value of the header. 


### IpMatcher {#IpMatcher1}

Field | Description
--- | ---
ip_ranges_match | **[IpRangesMatcher](#IpRangesMatcher1)**<br> 
ip_ranges_not_match | **[IpRangesMatcher](#IpRangesMatcher1)**<br> 
geo_ip_match | **[GeoIpMatcher](#GeoIpMatcher1)**<br> 
geo_ip_not_match | **[GeoIpMatcher](#GeoIpMatcher1)**<br> 


### IpRangesMatcher {#IpRangesMatcher1}

Field | Description
--- | ---
ip_ranges[] | **string**<br>List of IP ranges. OR semantics implied. The maximum number of elements is 10000.


### GeoIpMatcher {#GeoIpMatcher1}

Field | Description
--- | ---
locations[] | **string**<br>ISO 3166-1 alpha 2. OR semantics implied. The minimum number of elements is 1. The string length in characters for each value must be equal to 2.


## Create {#Create}

Creates a security profile in the specified folder using the data specified in the request.

**rpc Create ([CreateSecurityProfileRequest](#CreateSecurityProfileRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateSecurityProfileMetadata](#CreateSecurityProfileMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SecurityProfile](#SecurityProfile2)<br>

### CreateSecurityProfileRequest {#CreateSecurityProfileRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a security profile in. 
labels | **map<string,string>**<br>Labels as `` key:value `` pairs. Maximum of 64 per resource. 
name | **string**<br>Name of the security profile. The name is unique within the folder. 1-50 characters long. 
description | **string**<br>Optional description of the security profile. 
default_action | **[SecurityProfile.DefaultAction](#SecurityProfile2)**<br>Action to perform if none of rules matched. 
security_rules[] | **[SecurityRule](#SecurityRule2)**<br>List of security rules. 
captcha_id | **string**<br>Captcha ID to use with this security profile. Set empty to use default. 


### SecurityRule {#SecurityRule2}

Field | Description
--- | ---
name | **string**<br>Required. Name of the rule. The name is unique within the folder. 1-50 characters long. The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `.
priority | **int64**<br>Determines the priority for checking the incoming traffic. Enter an integer within the range of 1 and 999999. The rule priority must be unique within the entire security profile. A lower numeric value means a higher priority. The default_action has the lowest priority. Acceptable values are 1 to 999999, inclusive.
dry_run | **bool**<br>This mode allows you to test your security profile or a single rule. For example, you can have the number of alarms for a specific rule displayed. Note: if this option is true, no real action affecting your traffic regarding this rule will be taken. 
rule_specifier | **oneof:** `rule_condition` or `smart_protection`<br>
&nbsp;&nbsp;rule_condition | **[RuleCondition](#RuleCondition2)**<br>Rule actions, see [Rule actions](/docs/smartwebsecurity/concepts/rules#rule-action). 
&nbsp;&nbsp;smart_protection | **[SmartProtection](#SmartProtection2)**<br>Smart Protection rule, see [Smart Protection rules](/docs/smartwebsecurity/concepts/rules#smart-protection-rules). 
description | **string**<br>Optional description of the rule. 0-512 characters long. The maximum string length in characters is 512.


### RuleCondition {#RuleCondition2}

Field | Description
--- | ---
action | enum **Action**<br>Action to perform if this rule matched. <ul><li>`ALLOW`: Pass request to service.</li><li>`DENY`: Deny request.</li></ul>
condition | **[Condition](#Condition2)**<br>The condition for matching the rule. 


### SmartProtection {#SmartProtection2}

Field | Description
--- | ---
mode | enum **Mode**<br>Mode of protection. <ul><li>`FULL`: Full protection means that the traffic will be checked based on ML models and behavioral analysis, with suspicious requests being sent to SmartCaptcha.</li><li>`API`: API protection means checking the traffic based on ML models and behavioral analysis without sending suspicious requests to SmartCaptcha. The suspicious requests will be blocked.</li></ul>
condition | **[Condition](#Condition2)**<br>The condition for matching the rule. 


### Condition {#Condition2}

Field | Description
--- | ---
authority | **[AuthorityMatcher](#AuthorityMatcher2)**<br>Match authority (Host header). 
http_method | **[HttpMethodMatcher](#HttpMethodMatcher2)**<br>Match HTTP method. 
request_uri | **[RequestUriMatcher](#RequestUriMatcher2)**<br>Match Request URI. 
headers[] | **[HeaderMatcher](#HeaderMatcher2)**<br>Match HTTP headers. The maximum number of elements is 20.
source_ip | **[IpMatcher](#IpMatcher2)**<br>Match IP. 


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
http_methods[] | **[StringMatcher](#StringMatcher2)**<br>List of HTTP methods. OR semantics implied. The maximum number of elements is 20.


### AuthorityMatcher {#AuthorityMatcher2}

Field | Description
--- | ---
authorities[] | **[StringMatcher](#StringMatcher2)**<br>List of authorities. OR semantics implied. The maximum number of elements is 20.


### RequestUriMatcher {#RequestUriMatcher2}

Field | Description
--- | ---
path | **[StringMatcher](#StringMatcher2)**<br>Path of the URI [RFC3986](https://datatracker.ietf.org/doc/html/rfc3986#section-3.3). 
queries[] | **[QueryMatcher](#QueryMatcher2)**<br>List of query matchers. AND semantics implied. The maximum number of elements is 20.


### QueryMatcher {#QueryMatcher2}

Field | Description
--- | ---
key | **string**<br>Required. Key of the query parameter. The string length in characters must be 1-255.
value | **[StringMatcher](#StringMatcher2)**<br>Required. Value of the query parameter. 


### HeaderMatcher {#HeaderMatcher2}

Field | Description
--- | ---
name | **string**<br>Required. Name of header (case insensitive). The string length in characters must be 1-255.
value | **[StringMatcher](#StringMatcher2)**<br>Required. Value of the header. 


### IpMatcher {#IpMatcher2}

Field | Description
--- | ---
ip_ranges_match | **[IpRangesMatcher](#IpRangesMatcher2)**<br> 
ip_ranges_not_match | **[IpRangesMatcher](#IpRangesMatcher2)**<br> 
geo_ip_match | **[GeoIpMatcher](#GeoIpMatcher2)**<br> 
geo_ip_not_match | **[GeoIpMatcher](#GeoIpMatcher2)**<br> 


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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateSecurityProfileMetadata](#CreateSecurityProfileMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SecurityProfile](#SecurityProfile2)>**<br>if operation finished successfully. 


### CreateSecurityProfileMetadata {#CreateSecurityProfileMetadata}

Field | Description
--- | ---
security_profile_id | **string**<br>ID of the security profile that is being created. 


### SecurityProfile {#SecurityProfile2}

Field | Description
--- | ---
id | **string**<br>ID of the security profile. 
folder_id | **string**<br>ID of the folder that the security profile belongs to. 
cloud_id | **string**<br>ID of the cloud that the security profile belongs to. 
labels | **map<string,string>**<br>Labels as `` key:value `` pairs. Maximum of 64 per resource. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
name | **string**<br>Required. Name of the security profile. The name is unique within the folder. 1-50 characters long. The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `.
description | **string**<br>Optional description of the security profile. The maximum string length in characters is 512.
default_action | enum **DefaultAction**<br>Required. Action to perform if none of rules matched. <ul><li>`ALLOW`: Pass request to service.</li><li>`DENY`: Deny request.</li></ul>
security_rules[] | **[SecurityRule](#SecurityRule3)**<br>List of security rules. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
captcha_id | **string**<br>Captcha ID to use with this security profile. Set empty to use default. 


## Update {#Update}

Updates the specified security profile.

**rpc Update ([UpdateSecurityProfileRequest](#UpdateSecurityProfileRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateSecurityProfileMetadata](#UpdateSecurityProfileMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SecurityProfile](#SecurityProfile3)<br>

### UpdateSecurityProfileRequest {#UpdateSecurityProfileRequest}

Field | Description
--- | ---
security_profile_id | **string**<br>Required. ID of the security profile to update. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the SecurityProfile resource are going to be updated. 
labels | **map<string,string>**<br>Labels as `` key:value `` pairs. Maximum of 64 per resource. 
name | **string**<br>Name of the security profile. The name is unique within the folder. 1-50 characters long. 
description | **string**<br>Optional description of the security profile. 
default_action | **[SecurityProfile.DefaultAction](#SecurityProfile3)**<br>Action to perform if none of rules matched. 
security_rules[] | **[SecurityRule](#SecurityRule3)**<br>List of security rules. 
captcha_id | **string**<br>Captcha ID to use with this security profile. Set empty to use default. 


### SecurityRule {#SecurityRule3}

Field | Description
--- | ---
name | **string**<br>Required. Name of the rule. The name is unique within the folder. 1-50 characters long. The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `.
priority | **int64**<br>Determines the priority for checking the incoming traffic. Enter an integer within the range of 1 and 999999. The rule priority must be unique within the entire security profile. A lower numeric value means a higher priority. The default_action has the lowest priority. Acceptable values are 1 to 999999, inclusive.
dry_run | **bool**<br>This mode allows you to test your security profile or a single rule. For example, you can have the number of alarms for a specific rule displayed. Note: if this option is true, no real action affecting your traffic regarding this rule will be taken. 
rule_specifier | **oneof:** `rule_condition` or `smart_protection`<br>
&nbsp;&nbsp;rule_condition | **[RuleCondition](#RuleCondition3)**<br>Rule actions, see [Rule actions](/docs/smartwebsecurity/concepts/rules#rule-action). 
&nbsp;&nbsp;smart_protection | **[SmartProtection](#SmartProtection3)**<br>Smart Protection rule, see [Smart Protection rules](/docs/smartwebsecurity/concepts/rules#smart-protection-rules). 
description | **string**<br>Optional description of the rule. 0-512 characters long. The maximum string length in characters is 512.


### RuleCondition {#RuleCondition3}

Field | Description
--- | ---
action | enum **Action**<br>Action to perform if this rule matched. <ul><li>`ALLOW`: Pass request to service.</li><li>`DENY`: Deny request.</li></ul>
condition | **[Condition](#Condition3)**<br>The condition for matching the rule. 


### SmartProtection {#SmartProtection3}

Field | Description
--- | ---
mode | enum **Mode**<br>Mode of protection. <ul><li>`FULL`: Full protection means that the traffic will be checked based on ML models and behavioral analysis, with suspicious requests being sent to SmartCaptcha.</li><li>`API`: API protection means checking the traffic based on ML models and behavioral analysis without sending suspicious requests to SmartCaptcha. The suspicious requests will be blocked.</li></ul>
condition | **[Condition](#Condition3)**<br>The condition for matching the rule. 


### Condition {#Condition3}

Field | Description
--- | ---
authority | **[AuthorityMatcher](#AuthorityMatcher3)**<br>Match authority (Host header). 
http_method | **[HttpMethodMatcher](#HttpMethodMatcher3)**<br>Match HTTP method. 
request_uri | **[RequestUriMatcher](#RequestUriMatcher3)**<br>Match Request URI. 
headers[] | **[HeaderMatcher](#HeaderMatcher3)**<br>Match HTTP headers. The maximum number of elements is 20.
source_ip | **[IpMatcher](#IpMatcher3)**<br>Match IP. 


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
http_methods[] | **[StringMatcher](#StringMatcher3)**<br>List of HTTP methods. OR semantics implied. The maximum number of elements is 20.


### AuthorityMatcher {#AuthorityMatcher3}

Field | Description
--- | ---
authorities[] | **[StringMatcher](#StringMatcher3)**<br>List of authorities. OR semantics implied. The maximum number of elements is 20.


### RequestUriMatcher {#RequestUriMatcher3}

Field | Description
--- | ---
path | **[StringMatcher](#StringMatcher3)**<br>Path of the URI [RFC3986](https://datatracker.ietf.org/doc/html/rfc3986#section-3.3). 
queries[] | **[QueryMatcher](#QueryMatcher3)**<br>List of query matchers. AND semantics implied. The maximum number of elements is 20.


### QueryMatcher {#QueryMatcher3}

Field | Description
--- | ---
key | **string**<br>Required. Key of the query parameter. The string length in characters must be 1-255.
value | **[StringMatcher](#StringMatcher3)**<br>Required. Value of the query parameter. 


### HeaderMatcher {#HeaderMatcher3}

Field | Description
--- | ---
name | **string**<br>Required. Name of header (case insensitive). The string length in characters must be 1-255.
value | **[StringMatcher](#StringMatcher3)**<br>Required. Value of the header. 


### IpMatcher {#IpMatcher3}

Field | Description
--- | ---
ip_ranges_match | **[IpRangesMatcher](#IpRangesMatcher3)**<br> 
ip_ranges_not_match | **[IpRangesMatcher](#IpRangesMatcher3)**<br> 
geo_ip_match | **[GeoIpMatcher](#GeoIpMatcher3)**<br> 
geo_ip_not_match | **[GeoIpMatcher](#GeoIpMatcher3)**<br> 


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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateSecurityProfileMetadata](#UpdateSecurityProfileMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SecurityProfile](#SecurityProfile3)>**<br>if operation finished successfully. 


### UpdateSecurityProfileMetadata {#UpdateSecurityProfileMetadata}

Field | Description
--- | ---
security_profile_id | **string**<br>ID of the SecurityProfile resource that is being updated. 


### SecurityProfile {#SecurityProfile3}

Field | Description
--- | ---
id | **string**<br>ID of the security profile. 
folder_id | **string**<br>ID of the folder that the security profile belongs to. 
cloud_id | **string**<br>ID of the cloud that the security profile belongs to. 
labels | **map<string,string>**<br>Labels as `` key:value `` pairs. Maximum of 64 per resource. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
name | **string**<br>Required. Name of the security profile. The name is unique within the folder. 1-50 characters long. The string length in characters must be 1-50. Value must match the regular expression ` [a-zA-Z0-9][a-zA-Z0-9-_.]* `.
description | **string**<br>Optional description of the security profile. The maximum string length in characters is 512.
default_action | enum **DefaultAction**<br>Required. Action to perform if none of rules matched. <ul><li>`ALLOW`: Pass request to service.</li><li>`DENY`: Deny request.</li></ul>
security_rules[] | **[SecurityRule](#SecurityRule4)**<br>List of security rules. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
captcha_id | **string**<br>Captcha ID to use with this security profile. Set empty to use default. 


## Delete {#Delete}

Deletes the specified security profile.

**rpc Delete ([DeleteSecurityProfileRequest](#DeleteSecurityProfileRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteSecurityProfileMetadata](#DeleteSecurityProfileMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteSecurityProfileRequest {#DeleteSecurityProfileRequest}

Field | Description
--- | ---
security_profile_id | **string**<br>Required. ID of the security profile to delete. 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteSecurityProfileMetadata](#DeleteSecurityProfileMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteSecurityProfileMetadata {#DeleteSecurityProfileMetadata}

Field | Description
--- | ---
security_profile_id | **string**<br>ID of the SecurityProfile resource that is being deleted. 


