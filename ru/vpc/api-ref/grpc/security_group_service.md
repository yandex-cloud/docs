---
editable: false
sourcePath: en/_api-ref-grpc/vpc/api-ref/grpc/security_group_service.md
---

# Virtual Private Cloud API, gRPC: SecurityGroupService

A set of methods for managing SecurityGroup resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified SecurityGroup resource. |
| [List](#List) | Retrieves the list of SecurityGroup resources in the specified folder. |
| [Create](#Create) | Creates a security group in the specified folder and network. |
| [Update](#Update) | Updates the specified security group. |
| [UpdateRules](#UpdateRules) | Updates the rules of the specified security group. |
| [UpdateRule](#UpdateRule) | Updates the specified rule. |
| [Delete](#Delete) | Deletes the specified security group. |
| [Move](#Move) | Moves security groups to another folder. |
| [ListOperations](#ListOperations) | Lists operations for the specified security groups. |

## Calls SecurityGroupService {#calls}

## Get {#Get}

Returns the specified SecurityGroup resource. <br>To get the list of all available SecurityGroup resources, make a [List](#List) request.

**rpc Get ([GetSecurityGroupRequest](#GetSecurityGroupRequest)) returns ([SecurityGroup](#SecurityGroup))**

### GetSecurityGroupRequest {#GetSecurityGroupRequest}

Field | Description
--- | ---
security_group_id | **string**<br>Required. ID of the Security Group resource to return. To get the security group ID, use a [SecurityGroup.List](#SecurityGroup) request. 


### SecurityGroup {#SecurityGroup}

Field | Description
--- | ---
id | **string**<br>ID of the security group. 
folder_id | **string**<br>ID of the folder that the security group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the security group. 1-63 characters long. 
description | **string**<br>Description of the security group. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
network_id | **string**<br>ID of the network that the security group belongs to. 
status | enum **Status**<br>Security group status. <ul><li>`CREATING`: Security group is being created.</li><li>`ACTIVE`: Security is active and it's rules are applied to the network interfaces.</li><li>`UPDATING`: Security group is updating. Updating is a long operation because we must update all instances in SG.</li><li>`DELETING`: Instance is being deleted.</li></ul>
rules[] | **[SecurityGroupRule](#SecurityGroupRule)**<br>List of the security group rules. 
default_for_network | **bool**<br>Flag that indicates that the security group is the default for the network. 


### SecurityGroupRule {#SecurityGroupRule}

Field | Description
--- | ---
id | **string**<br>ID of the rule. 
description | **string**<br>Description of the rule. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
direction | enum **Direction**<br>Required. The direction of network traffic allowed by this rule. <ul><li>`INGRESS`: Allows ingress traffic.</li><li>`EGRESS`: Allows egress traffic.</li></ul>
ports | **[PortRange](#PortRange)**<br>The range of ports that allow traffic to pass through. Null value means any. 
protocol_name | **string**<br>Protocol name. Null value means any protocol. Values from [IANA](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). 
protocol_number | **int64**<br>Protocol number from [IANA protocol numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). 
target | **oneof:** `cidr_blocks`, `security_group_id` or `predefined_target`<br>
&nbsp;&nbsp;cidr_blocks | **[CidrBlocks](#CidrBlocks)**<br>CIDR blocks to allow to recieve or send traffic. 
&nbsp;&nbsp;security_group_id | **string**<br>ID of the security group to add rule to. 
&nbsp;&nbsp;predefined_target | **string**<br>Predefined target. See [security groups rules](/docs/vpc/concepts/security-groups#security-groups-rules) for more information. 


### PortRange {#PortRange}

Field | Description
--- | ---
from_port | **int64**<br>The lowest port in the range. Acceptable values are 0 to 65535, inclusive.
to_port | **int64**<br>The highest port in the range. Acceptable values are 0 to 65535, inclusive.


### CidrBlocks {#CidrBlocks}

Field | Description
--- | ---
v4_cidr_blocks[] | **string**<br>IPv4 CIDR blocks to allow traffic to. 
v6_cidr_blocks[] | **string**<br>IPv6 CIDR blocks to allow traffic to. 


## List {#List}

Retrieves the list of SecurityGroup resources in the specified folder.

**rpc List ([ListSecurityGroupsRequest](#ListSecurityGroupsRequest)) returns ([ListSecurityGroupsResponse](#ListSecurityGroupsResponse))**

### ListSecurityGroupsRequest {#ListSecurityGroupsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list security groups in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListSecurityGroupsResponse.next_page_token](#ListSecurityGroupsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. 
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListSecurityGroupsResponse.next_page_token](#ListSecurityGroupsResponse) returned by a previous list request. 
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently you can use filtering only on the [SecurityGroup.name](#SecurityGroup1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.</li></ol> 


### ListSecurityGroupsResponse {#ListSecurityGroupsResponse}

Field | Description
--- | ---
security_groups[] | **[SecurityGroup](#SecurityGroup1)**<br>List of SecurityGroup resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListNetworksRequest.page_size](#ListNetworksRequest), use the `next_page_token` as the value for the [ListNetworksRequest.page_token](#ListNetworksRequest) query parameter in the next list request. Subsequent list requests will have their own `next_page_token` to continue paging through the results. 


### SecurityGroup {#SecurityGroup1}

Field | Description
--- | ---
id | **string**<br>ID of the security group. 
folder_id | **string**<br>ID of the folder that the security group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the security group. 1-63 characters long. 
description | **string**<br>Description of the security group. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
network_id | **string**<br>ID of the network that the security group belongs to. 
status | enum **Status**<br>Security group status. <ul><li>`CREATING`: Security group is being created.</li><li>`ACTIVE`: Security is active and it's rules are applied to the network interfaces.</li><li>`UPDATING`: Security group is updating. Updating is a long operation because we must update all instances in SG.</li><li>`DELETING`: Instance is being deleted.</li></ul>
rules[] | **[SecurityGroupRule](#SecurityGroupRule1)**<br>List of the security group rules. 
default_for_network | **bool**<br>Flag that indicates that the security group is the default for the network. 


### SecurityGroupRule {#SecurityGroupRule1}

Field | Description
--- | ---
id | **string**<br>ID of the rule. 
description | **string**<br>Description of the rule. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
direction | enum **Direction**<br>Required. The direction of network traffic allowed by this rule. <ul><li>`INGRESS`: Allows ingress traffic.</li><li>`EGRESS`: Allows egress traffic.</li></ul>
ports | **[PortRange](#PortRange1)**<br>The range of ports that allow traffic to pass through. Null value means any. 
protocol_name | **string**<br>Protocol name. Null value means any protocol. Values from [IANA](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). 
protocol_number | **int64**<br>Protocol number from [IANA protocol numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). 
target | **oneof:** `cidr_blocks`, `security_group_id` or `predefined_target`<br>
&nbsp;&nbsp;cidr_blocks | **[CidrBlocks](#CidrBlocks1)**<br>CIDR blocks to allow to recieve or send traffic. 
&nbsp;&nbsp;security_group_id | **string**<br>ID of the security group to add rule to. 
&nbsp;&nbsp;predefined_target | **string**<br>Predefined target. See [security groups rules](/docs/vpc/concepts/security-groups#security-groups-rules) for more information. 


### PortRange {#PortRange1}

Field | Description
--- | ---
from_port | **int64**<br>The lowest port in the range. Acceptable values are 0 to 65535, inclusive.
to_port | **int64**<br>The highest port in the range. Acceptable values are 0 to 65535, inclusive.


### CidrBlocks {#CidrBlocks1}

Field | Description
--- | ---
v4_cidr_blocks[] | **string**<br>IPv4 CIDR blocks to allow traffic to. 
v6_cidr_blocks[] | **string**<br>IPv6 CIDR blocks to allow traffic to. 


## Create {#Create}

Creates a security group in the specified folder and network.

**rpc Create ([CreateSecurityGroupRequest](#CreateSecurityGroupRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateSecurityGroupMetadata](#CreateSecurityGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SecurityGroup](#SecurityGroup2)<br>

### CreateSecurityGroupRequest {#CreateSecurityGroupRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder for this request to create a security group in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
name | **string**<br>Name of the security group. The name must be unique within the folder. Value must match the regular expression ` \|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])? `.
description | **string**<br>Description of the security group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
network_id | **string**<br>Required. ID of the Network to create security group for. 
rule_specs[] | **[SecurityGroupRuleSpec](#SecurityGroupRuleSpec)**<br>Security rules specifications. 


### SecurityGroupRuleSpec {#SecurityGroupRuleSpec}

Field | Description
--- | ---
description | **string**<br>Description of the security rule. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Rule labels as `` key:value `` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
direction | **[SecurityGroupRule.Direction](#SecurityGroupRule2)**<br>Required. The direction of network traffic allowed by this rule. 
ports | **[PortRange](#PortRange2)**<br>The range of ports that allow traffic to pass through. Null value means any port. 
protocol | **oneof:** `protocol_name` or `protocol_number`<br>Values from [IANA protocol numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). Null value means any protocol.
&nbsp;&nbsp;protocol_name | **string**<br>Protocol name. 
&nbsp;&nbsp;protocol_number | **int64**<br>Protocol number from [IANA protocol numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). 
target | **oneof:** `cidr_blocks`, `security_group_id` or `predefined_target`<br>
&nbsp;&nbsp;cidr_blocks | **[CidrBlocks](#CidrBlocks2)**<br>CIDR blocks to allow to recieve or send traffic. 
&nbsp;&nbsp;security_group_id | **string**<br>ID of the security group to add rule to. 
&nbsp;&nbsp;predefined_target | **string**<br>Predefined target. See [security groups rules](/docs/vpc/concepts/security-groups#security-groups-rules) for more information. 


### PortRange {#PortRange2}

Field | Description
--- | ---
from_port | **int64**<br>The lowest port in the range. Acceptable values are 0 to 65535, inclusive.
to_port | **int64**<br>The highest port in the range. Acceptable values are 0 to 65535, inclusive.


### CidrBlocks {#CidrBlocks2}

Field | Description
--- | ---
v4_cidr_blocks[] | **string**<br>IPv4 CIDR blocks to allow traffic to. 
v6_cidr_blocks[] | **string**<br>IPv6 CIDR blocks to allow traffic to. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateSecurityGroupMetadata](#CreateSecurityGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SecurityGroup](#SecurityGroup2)>**<br>if operation finished successfully. 


### CreateSecurityGroupMetadata {#CreateSecurityGroupMetadata}

Field | Description
--- | ---
security_group_id | **string**<br>ID of the security group that is being created. 


### SecurityGroup {#SecurityGroup2}

Field | Description
--- | ---
id | **string**<br>ID of the security group. 
folder_id | **string**<br>ID of the folder that the security group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the security group. 1-63 characters long. 
description | **string**<br>Description of the security group. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
network_id | **string**<br>ID of the network that the security group belongs to. 
status | enum **Status**<br>Security group status. <ul><li>`CREATING`: Security group is being created.</li><li>`ACTIVE`: Security is active and it's rules are applied to the network interfaces.</li><li>`UPDATING`: Security group is updating. Updating is a long operation because we must update all instances in SG.</li><li>`DELETING`: Instance is being deleted.</li></ul>
rules[] | **[SecurityGroupRule](#SecurityGroupRule2)**<br>List of the security group rules. 
default_for_network | **bool**<br>Flag that indicates that the security group is the default for the network. 


### SecurityGroupRule {#SecurityGroupRule2}

Field | Description
--- | ---
id | **string**<br>ID of the rule. 
description | **string**<br>Description of the rule. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
direction | enum **Direction**<br>Required. The direction of network traffic allowed by this rule. <ul><li>`INGRESS`: Allows ingress traffic.</li><li>`EGRESS`: Allows egress traffic.</li></ul>
ports | **[PortRange](#PortRange3)**<br>The range of ports that allow traffic to pass through. Null value means any. 
protocol_name | **string**<br>Protocol name. Null value means any protocol. Values from [IANA](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). 
protocol_number | **int64**<br>Protocol number from [IANA protocol numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). 
target | **oneof:** `cidr_blocks`, `security_group_id` or `predefined_target`<br>
&nbsp;&nbsp;cidr_blocks | **[CidrBlocks](#CidrBlocks3)**<br>CIDR blocks to allow to recieve or send traffic. 
&nbsp;&nbsp;security_group_id | **string**<br>ID of the security group to add rule to. 
&nbsp;&nbsp;predefined_target | **string**<br>Predefined target. See [security groups rules](/docs/vpc/concepts/security-groups#security-groups-rules) for more information. 


## Update {#Update}

Updates the specified security group. Method starts an asynchronous operation that can be cancelled while it is in progress.

**rpc Update ([UpdateSecurityGroupRequest](#UpdateSecurityGroupRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateSecurityGroupMetadata](#UpdateSecurityGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SecurityGroup](#SecurityGroup3)<br>

### UpdateSecurityGroupRequest {#UpdateSecurityGroupRequest}

Field | Description
--- | ---
security_group_id | **string**<br>Required. ID of the security group to update. <br>To get the security group ID make a [SecurityGroupService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the Address should be updated. 
name | **string**<br>New name for the security group. The name must be unique within the folder. Value must match the regular expression ` \|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])? `.
description | **string**<br>New description of the security group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Security group labels as `key:value` pairs. <br>Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label: <ol><li>Get the current set of labels with a [SecurityGroupService.Get](#Get) request. </li><li>Add or remove a label in this set. </li><li>Send the new set in this field.</li></ol> No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
rule_specs[] | **[SecurityGroupRuleSpec](#SecurityGroupRuleSpec)**<br>Updated rule list. All existing rules will be replaced with given list. 


### SecurityGroupRuleSpec {#SecurityGroupRuleSpec1}

Field | Description
--- | ---
description | **string**<br>Description of the security rule. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Rule labels as `` key:value `` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
direction | **[SecurityGroupRule.Direction](#SecurityGroupRule3)**<br>Required. The direction of network traffic allowed by this rule. 
ports | **[PortRange](#PortRange3)**<br>The range of ports that allow traffic to pass through. Null value means any port. 
protocol | **oneof:** `protocol_name` or `protocol_number`<br>Values from [IANA protocol numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). Null value means any protocol.
&nbsp;&nbsp;protocol_name | **string**<br>Protocol name. 
&nbsp;&nbsp;protocol_number | **int64**<br>Protocol number from [IANA protocol numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). 
target | **oneof:** `cidr_blocks`, `security_group_id` or `predefined_target`<br>
&nbsp;&nbsp;cidr_blocks | **[CidrBlocks](#CidrBlocks3)**<br>CIDR blocks to allow to recieve or send traffic. 
&nbsp;&nbsp;security_group_id | **string**<br>ID of the security group to add rule to. 
&nbsp;&nbsp;predefined_target | **string**<br>Predefined target. See [security groups rules](/docs/vpc/concepts/security-groups#security-groups-rules) for more information. 


### PortRange {#PortRange3}

Field | Description
--- | ---
from_port | **int64**<br>The lowest port in the range. Acceptable values are 0 to 65535, inclusive.
to_port | **int64**<br>The highest port in the range. Acceptable values are 0 to 65535, inclusive.


### CidrBlocks {#CidrBlocks3}

Field | Description
--- | ---
v4_cidr_blocks[] | **string**<br>IPv4 CIDR blocks to allow traffic to. 
v6_cidr_blocks[] | **string**<br>IPv6 CIDR blocks to allow traffic to. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateSecurityGroupMetadata](#UpdateSecurityGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SecurityGroup](#SecurityGroup3)>**<br>if operation finished successfully. 


### UpdateSecurityGroupMetadata {#UpdateSecurityGroupMetadata}

Field | Description
--- | ---
security_group_id | **string**<br>ID of the SecurityGroup that is being updated. 
added_rule_ids[] | **string**<br>List of added security rules IDs. 


### SecurityGroup {#SecurityGroup3}

Field | Description
--- | ---
id | **string**<br>ID of the security group. 
folder_id | **string**<br>ID of the folder that the security group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the security group. 1-63 characters long. 
description | **string**<br>Description of the security group. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
network_id | **string**<br>ID of the network that the security group belongs to. 
status | enum **Status**<br>Security group status. <ul><li>`CREATING`: Security group is being created.</li><li>`ACTIVE`: Security is active and it's rules are applied to the network interfaces.</li><li>`UPDATING`: Security group is updating. Updating is a long operation because we must update all instances in SG.</li><li>`DELETING`: Instance is being deleted.</li></ul>
rules[] | **[SecurityGroupRule](#SecurityGroupRule3)**<br>List of the security group rules. 
default_for_network | **bool**<br>Flag that indicates that the security group is the default for the network. 


### SecurityGroupRule {#SecurityGroupRule3}

Field | Description
--- | ---
id | **string**<br>ID of the rule. 
description | **string**<br>Description of the rule. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
direction | enum **Direction**<br>Required. The direction of network traffic allowed by this rule. <ul><li>`INGRESS`: Allows ingress traffic.</li><li>`EGRESS`: Allows egress traffic.</li></ul>
ports | **[PortRange](#PortRange4)**<br>The range of ports that allow traffic to pass through. Null value means any. 
protocol_name | **string**<br>Protocol name. Null value means any protocol. Values from [IANA](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). 
protocol_number | **int64**<br>Protocol number from [IANA protocol numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). 
target | **oneof:** `cidr_blocks`, `security_group_id` or `predefined_target`<br>
&nbsp;&nbsp;cidr_blocks | **[CidrBlocks](#CidrBlocks4)**<br>CIDR blocks to allow to recieve or send traffic. 
&nbsp;&nbsp;security_group_id | **string**<br>ID of the security group to add rule to. 
&nbsp;&nbsp;predefined_target | **string**<br>Predefined target. See [security groups rules](/docs/vpc/concepts/security-groups#security-groups-rules) for more information. 


## UpdateRules {#UpdateRules}

Updates the rules of the specified security group.

**rpc UpdateRules ([UpdateSecurityGroupRulesRequest](#UpdateSecurityGroupRulesRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateSecurityGroupMetadata](#UpdateSecurityGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SecurityGroup](#SecurityGroup4)<br>

### UpdateSecurityGroupRulesRequest {#UpdateSecurityGroupRulesRequest}

Field | Description
--- | ---
security_group_id | **string**<br>Required. ID of the SecurityGroup that is being updated with new rules. 
deletion_rule_ids[] | **string**<br>List of rules IDs to delete. 
addition_rule_specs[] | **[SecurityGroupRuleSpec](#SecurityGroupRuleSpec)**<br>Security rules specifications. 


### SecurityGroupRuleSpec {#SecurityGroupRuleSpec2}

Field | Description
--- | ---
description | **string**<br>Description of the security rule. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Rule labels as `` key:value `` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
direction | **[SecurityGroupRule.Direction](#SecurityGroupRule4)**<br>Required. The direction of network traffic allowed by this rule. 
ports | **[PortRange](#PortRange4)**<br>The range of ports that allow traffic to pass through. Null value means any port. 
protocol | **oneof:** `protocol_name` or `protocol_number`<br>Values from [IANA protocol numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). Null value means any protocol.
&nbsp;&nbsp;protocol_name | **string**<br>Protocol name. 
&nbsp;&nbsp;protocol_number | **int64**<br>Protocol number from [IANA protocol numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). 
target | **oneof:** `cidr_blocks`, `security_group_id` or `predefined_target`<br>
&nbsp;&nbsp;cidr_blocks | **[CidrBlocks](#CidrBlocks4)**<br>CIDR blocks to allow to recieve or send traffic. 
&nbsp;&nbsp;security_group_id | **string**<br>ID of the security group to add rule to. 
&nbsp;&nbsp;predefined_target | **string**<br>Predefined target. See [security groups rules](/docs/vpc/concepts/security-groups#security-groups-rules) for more information. 


### PortRange {#PortRange4}

Field | Description
--- | ---
from_port | **int64**<br>The lowest port in the range. Acceptable values are 0 to 65535, inclusive.
to_port | **int64**<br>The highest port in the range. Acceptable values are 0 to 65535, inclusive.


### CidrBlocks {#CidrBlocks4}

Field | Description
--- | ---
v4_cidr_blocks[] | **string**<br>IPv4 CIDR blocks to allow traffic to. 
v6_cidr_blocks[] | **string**<br>IPv6 CIDR blocks to allow traffic to. 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateSecurityGroupMetadata](#UpdateSecurityGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SecurityGroup](#SecurityGroup4)>**<br>if operation finished successfully. 


### UpdateSecurityGroupMetadata {#UpdateSecurityGroupMetadata1}

Field | Description
--- | ---
security_group_id | **string**<br>ID of the SecurityGroup that is being updated. 
added_rule_ids[] | **string**<br>List of added security rules IDs. 


### SecurityGroup {#SecurityGroup4}

Field | Description
--- | ---
id | **string**<br>ID of the security group. 
folder_id | **string**<br>ID of the folder that the security group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the security group. 1-63 characters long. 
description | **string**<br>Description of the security group. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
network_id | **string**<br>ID of the network that the security group belongs to. 
status | enum **Status**<br>Security group status. <ul><li>`CREATING`: Security group is being created.</li><li>`ACTIVE`: Security is active and it's rules are applied to the network interfaces.</li><li>`UPDATING`: Security group is updating. Updating is a long operation because we must update all instances in SG.</li><li>`DELETING`: Instance is being deleted.</li></ul>
rules[] | **[SecurityGroupRule](#SecurityGroupRule4)**<br>List of the security group rules. 
default_for_network | **bool**<br>Flag that indicates that the security group is the default for the network. 


### SecurityGroupRule {#SecurityGroupRule4}

Field | Description
--- | ---
id | **string**<br>ID of the rule. 
description | **string**<br>Description of the rule. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
direction | enum **Direction**<br>Required. The direction of network traffic allowed by this rule. <ul><li>`INGRESS`: Allows ingress traffic.</li><li>`EGRESS`: Allows egress traffic.</li></ul>
ports | **[PortRange](#PortRange5)**<br>The range of ports that allow traffic to pass through. Null value means any. 
protocol_name | **string**<br>Protocol name. Null value means any protocol. Values from [IANA](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). 
protocol_number | **int64**<br>Protocol number from [IANA protocol numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). 
target | **oneof:** `cidr_blocks`, `security_group_id` or `predefined_target`<br>
&nbsp;&nbsp;cidr_blocks | **[CidrBlocks](#CidrBlocks5)**<br>CIDR blocks to allow to recieve or send traffic. 
&nbsp;&nbsp;security_group_id | **string**<br>ID of the security group to add rule to. 
&nbsp;&nbsp;predefined_target | **string**<br>Predefined target. See [security groups rules](/docs/vpc/concepts/security-groups#security-groups-rules) for more information. 


## UpdateRule {#UpdateRule}

Updates the specified rule.

**rpc UpdateRule ([UpdateSecurityGroupRuleRequest](#UpdateSecurityGroupRuleRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateSecurityGroupRuleMetadata](#UpdateSecurityGroupRuleMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SecurityGroupRule](#SecurityGroupRule5)<br>

### UpdateSecurityGroupRuleRequest {#UpdateSecurityGroupRuleRequest}

Field | Description
--- | ---
security_group_id | **string**<br>Required. ID of the SecurityGroup to update rule in. 
rule_id | **string**<br>Required. ID of the rule to update. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the Address should be updated. 
description | **string**<br>New description of the rule. 
labels | **map<string,string>**<br>Rule labels as `key:value` pairs. <br>Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label: <ol><li>Get the current set of labels with a [AddressService.Get](./address_service#Get) request. </li><li>Add or remove a label in this set. </li><li>Send the new set in this field.</li></ol> 


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateSecurityGroupRuleMetadata](#UpdateSecurityGroupRuleMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SecurityGroupRule](#SecurityGroupRule5)>**<br>if operation finished successfully. 


### UpdateSecurityGroupRuleMetadata {#UpdateSecurityGroupRuleMetadata}

Field | Description
--- | ---
security_group_id | **string**<br>ID of the SecurityGroup that is being updated with new rules. 
rule_id | **string**<br>ID of the rule that is being updated. 


### SecurityGroupRule {#SecurityGroupRule5}

Field | Description
--- | ---
id | **string**<br>ID of the rule. 
description | **string**<br>Description of the rule. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
direction | enum **Direction**<br>Required. The direction of network traffic allowed by this rule. <ul><li>`INGRESS`: Allows ingress traffic.</li><li>`EGRESS`: Allows egress traffic.</li></ul>
ports | **[PortRange](#PortRange5)**<br>The range of ports that allow traffic to pass through. Null value means any. 
protocol_name | **string**<br>Protocol name. Null value means any protocol. Values from [IANA](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). 
protocol_number | **int64**<br>Protocol number from [IANA protocol numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). 
target | **oneof:** `cidr_blocks`, `security_group_id` or `predefined_target`<br>
&nbsp;&nbsp;cidr_blocks | **[CidrBlocks](#CidrBlocks5)**<br>CIDR blocks to allow to recieve or send traffic. 
&nbsp;&nbsp;security_group_id | **string**<br>ID of the security group to add rule to. 
&nbsp;&nbsp;predefined_target | **string**<br>Predefined target. See [security groups rules](/docs/vpc/concepts/security-groups#security-groups-rules) for more information. 


### PortRange {#PortRange5}

Field | Description
--- | ---
from_port | **int64**<br>The lowest port in the range. Acceptable values are 0 to 65535, inclusive.
to_port | **int64**<br>The highest port in the range. Acceptable values are 0 to 65535, inclusive.


### CidrBlocks {#CidrBlocks5}

Field | Description
--- | ---
v4_cidr_blocks[] | **string**<br>IPv4 CIDR blocks to allow traffic to. 
v6_cidr_blocks[] | **string**<br>IPv6 CIDR blocks to allow traffic to. 


## Delete {#Delete}

Deletes the specified security group.

**rpc Delete ([DeleteSecurityGroupRequest](#DeleteSecurityGroupRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteSecurityGroupMetadata](#DeleteSecurityGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteSecurityGroupRequest {#DeleteSecurityGroupRequest}

Field | Description
--- | ---
security_group_id | **string**<br>Required. ID of the security group to delete. <br>To get a address ID make a [SecurityGroup.List](#SecurityGroup5) request. 


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteSecurityGroupMetadata](#DeleteSecurityGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteSecurityGroupMetadata {#DeleteSecurityGroupMetadata}

Field | Description
--- | ---
security_group_id | **string**<br>ID of the SecurityGroup that is being deleted. 


## Move {#Move}

Moves security groups to another folder.

**rpc Move ([MoveSecurityGroupRequest](#MoveSecurityGroupRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[MoveSecurityGroupMetadata](#MoveSecurityGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SecurityGroup](#SecurityGroup5)<br>

### MoveSecurityGroupRequest {#MoveSecurityGroupRequest}

Field | Description
--- | ---
security_group_id | **string**<br>Required. ID of the security group to move. 
destination_folder_id | **string**<br>Required. ID of the folder to move security group to. 


### Operation {#Operation5}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[MoveSecurityGroupMetadata](#MoveSecurityGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SecurityGroup](#SecurityGroup5)>**<br>if operation finished successfully. 


### MoveSecurityGroupMetadata {#MoveSecurityGroupMetadata}

Field | Description
--- | ---
security_group_id | **string**<br>ID of the security group that is being moved. 


### SecurityGroup {#SecurityGroup5}

Field | Description
--- | ---
id | **string**<br>ID of the security group. 
folder_id | **string**<br>ID of the folder that the security group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the security group. 1-63 characters long. 
description | **string**<br>Description of the security group. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
network_id | **string**<br>ID of the network that the security group belongs to. 
status | enum **Status**<br>Security group status. <ul><li>`CREATING`: Security group is being created.</li><li>`ACTIVE`: Security is active and it's rules are applied to the network interfaces.</li><li>`UPDATING`: Security group is updating. Updating is a long operation because we must update all instances in SG.</li><li>`DELETING`: Instance is being deleted.</li></ul>
rules[] | **[SecurityGroupRule](#SecurityGroupRule6)**<br>List of the security group rules. 
default_for_network | **bool**<br>Flag that indicates that the security group is the default for the network. 


### SecurityGroupRule {#SecurityGroupRule6}

Field | Description
--- | ---
id | **string**<br>ID of the rule. 
description | **string**<br>Description of the rule. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
direction | enum **Direction**<br>Required. The direction of network traffic allowed by this rule. <ul><li>`INGRESS`: Allows ingress traffic.</li><li>`EGRESS`: Allows egress traffic.</li></ul>
ports | **[PortRange](#PortRange6)**<br>The range of ports that allow traffic to pass through. Null value means any. 
protocol_name | **string**<br>Protocol name. Null value means any protocol. Values from [IANA](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). 
protocol_number | **int64**<br>Protocol number from [IANA protocol numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). 
target | **oneof:** `cidr_blocks`, `security_group_id` or `predefined_target`<br>
&nbsp;&nbsp;cidr_blocks | **[CidrBlocks](#CidrBlocks6)**<br>CIDR blocks to allow to recieve or send traffic. 
&nbsp;&nbsp;security_group_id | **string**<br>ID of the security group to add rule to. 
&nbsp;&nbsp;predefined_target | **string**<br>Predefined target. See [security groups rules](/docs/vpc/concepts/security-groups#security-groups-rules) for more information. 


### PortRange {#PortRange6}

Field | Description
--- | ---
from_port | **int64**<br>The lowest port in the range. Acceptable values are 0 to 65535, inclusive.
to_port | **int64**<br>The highest port in the range. Acceptable values are 0 to 65535, inclusive.


### CidrBlocks {#CidrBlocks6}

Field | Description
--- | ---
v4_cidr_blocks[] | **string**<br>IPv4 CIDR blocks to allow traffic to. 
v6_cidr_blocks[] | **string**<br>IPv6 CIDR blocks to allow traffic to. 


## ListOperations {#ListOperations}

Lists operations for the specified security groups.

**rpc ListOperations ([ListSecurityGroupOperationsRequest](#ListSecurityGroupOperationsRequest)) returns ([ListSecurityGroupOperationsResponse](#ListSecurityGroupOperationsResponse))**

### ListSecurityGroupOperationsRequest {#ListSecurityGroupOperationsRequest}

Field | Description
--- | ---
security_group_id | **string**<br>Required. ID of the address to list operations for. <br>To get a address ID make a [SecurityGroup.List](#SecurityGroup6) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListSecurityGroupOperationsResponse.next_page_token](#ListSecurityGroupOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. 
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListSecurityGroupOperationsResponse.next_page_token](#ListSecurityGroupOperationsResponse) returned by a previous list request. 


### ListSecurityGroupOperationsResponse {#ListSecurityGroupOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation6)**<br>List of operations for the specified security group. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListSecurityGroupOperationsRequest.page_size](#ListSecurityGroupOperationsRequest), use `next_page_token` as the value for the [ListSecurityGroupOperationsRequest.page_token](#ListSecurityGroupOperationsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation6}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty). If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any. 


