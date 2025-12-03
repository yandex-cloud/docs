---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/audit-trails/cli-ref-beta/trail/update.md
---

# yc beta audit-trails trail update

Updates the specified trail.

#### Command Usage

Syntax: 

`yc beta audit-trails trail update <TRAIL-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--description`|<b>`string`</b><br/>New description of the trail.|
|`--destination`|<b>`shorthand/json`</b><br/>New destination configuration for the trail<br/><br/>Example:<br/>--destination destination={cloud-logging={destination={log-group-id=value}}}<br/><br/>Shorthand Syntax:<br/>{destination={cloud-logging={destination={log-group-id=str}} \| data-stream={codec=RAW\|GZIP\|ZSTD, database-id=str, stream-name=str} \| eventrouter={eventrouter-connector-id=str} \| object-storage={bucket-id=str, object-prefix=str}}}<br/>Fields:<br/>destination  oneof<cloud-logging\|data-stream\|eventrouter\|object-storage>  — Oneof destination field<br/>object-storage  struct  — Configuration for event delivery to Object Storage<br/><br/>Uploaded objects will have prefix <trail_id>/ by default<br/>bucket-id      string  — Name of the destination bucket<br/>object-prefix  string  — Prefix for exported objects. Optional<br/>If specified, uploaded objects will have prefix <object_prefix>/<trail_id>/<br/>cloud-logging   struct  — Configuration for event delivery to Cloud Logging<br/>destination  oneof\<log-group-id\>  — Oneof destination field<br/>log-group-id  string  — ID of the Cloud Logging destination group<br/>data-stream     struct  — Configuration for event delivery to YDS<br/>codec        enum<GZIP\|RAW\|ZSTD>  — Codec for compressing events<br/>database-id  string               — ID of the database hosting the destination YDS<br/>stream-name  string               — Name of the destination YDS<br/>eventrouter     struct  — Configuration for event delivery to EventRouter<br/>eventrouter-connector-id  string  — ID of the EventRouter Connector<br/>|
|`--filter`|<b>`shorthand/json`</b><br/>Updated filtering configuration of the trail<br/>deprecated: use filtering_policy instead<br/><br/>Example:|
|`--filter`|<b>`event-filter={filters=[{categories=[{plane=CONTROL_PLANE,`</b><br/>type=WRITE}], path-filter={root={element={any-filter={resource={id=value, type=value}}}}}, service=value}]}, path-filter={root={element={any-filter={resource={id=value, type=value}}}}}<br/><br/>Shorthand Syntax:<br/>{event-filter={filters=[{categories=[{plane=CONTROL_PLANE\|DATA_PLANE, type=WRITE\|READ},...], path-filter={root={element={any-filter={resource={id=str, type=str}} \| some-filter={filters=[\<PathFilterElement\>,...], resource={id=str, type=str}}}}}, service=str},...]}, path-filter={root={element={any-filter={resource={id=str, type=str}} \| some-filter={filters=[\<PathFilterElement\>,...], resource={id=str, type=str}}}}}}<br/>Fields:<br/>event-filter  struct  required  — Configuration of additional events gathering from specific services<br/>filters  []struct  — List of filters for services<br/>categories   []struct            — List of the event categories gathered for a specified service<br/>plane  enum<CONTROL_PLANE\|DATA_PLANE>  required  — Plane of the gathered category<br/>type   enum<READ\|WRITE>                required  — Type of the gathered category<br/>path-filter  struct    required  — Resource path filter for a specified service<br/>root  struct  required  — Root element of the resource path filter for the trail<br/>Resource described in that filter node must contain the trail itself<br/>element  oneof<any-filter\|some-filter>  — Oneof element field<br/>any-filter   struct  — Filter element with ANY type. If used, configures the trail to gather any events from the resource<br/>resource  struct  required  — Resource definition<br/>id    string  required  — ID of the resource<br/>type  string  required  — Type of the resource<br/>some-filter  struct  — Filter element with SOME type. If used, configures the trail to gather some of the events from the resource<br/>filters   []struct            — Filters for the resources contained in the parent resource<br/>… []struct (recursive)<br/>resource  struct    required  — Definition of the resource that contains nested resources<br/>id    string  required  — ID of the resource<br/>type  string  required  — Type of the resource<br/>service      string    required  — Service ID of the gathered events<br/>path-filter   struct            — Configuration of default events gathering for the trail<br/>If not specified, default events won't be gathered for the trail<br/>root  struct  required  — Root element of the resource path filter for the trail<br/>Resource described in that filter node must contain the trail itself<br/>element  oneof<any-filter\|some-filter>  — Oneof element field<br/>any-filter   struct  — Filter element with ANY type. If used, configures the trail to gather any events from the resource<br/>resource  struct  required  — Resource definition<br/>id    string  required  — ID of the resource<br/>type  string  required  — Type of the resource<br/>some-filter  struct  — Filter element with SOME type. If used, configures the trail to gather some of the events from the resource<br/>filters   []struct            — Filters for the resources contained in the parent resource<br/>… []struct (recursive)<br/>resource  struct    required  — Definition of the resource that contains nested resources<br/>id    string  required  — ID of the resource<br/>type  string  required  — Type of the resource<br/>|
|`--filtering-policy`|<b>`shorthand/json`</b><br/>Updated event filtering policy<br/><br/>Example:|
|`--filtering-policy`|<b>`data-events-filters=[{additional-rules={excluded-events={event-types=value}},`</b><br/>resource-scopes=[{id=value, type=value}], service=value, service-specific-rules={dns-filter={include-nonrecursive-queries=true}}}], management-events-filter={resource-scopes=[{id=value, type=value}]}<br/><br/>Shorthand Syntax:<br/>{data-events-filters=[{additional-rules={excluded-events={event-types=str,...} \| included-events={event-types=str,...}}, resource-scopes=[{id=str, type=str},...], service=str, service-specific-rules={dns-filter={include-nonrecursive-queries=bool}}},...], management-events-filter={resource-scopes=[{id=str, type=str},...]}}<br/>Fields:<br/>data-events-filters       []struct  — List of filters describing gathering data events<br/>resource-scopes         []struct                                          — A list of resources which will be monitored by the trail<br/>id    string  required  — ID of the resource<br/>type  string  required  — Type of the resource<br/>service                 string                                  required  — Name of the service whose events will be delivered<br/>additional-rules        oneof<excluded-events\|included-events>            — Oneof additional-rules field<br/>included-events  struct  — Explicitly included events of specified service<br/>New events of the service won't be delivered by default<br/>event-types  []string  —<br/>excluded-events  struct  — Explicitly excluded events of specified service<br/>New events of the service will be delivered by default<br/>event-types  []string  —<br/>service-specific-rules  oneof\<dns-filter\>                                 — Oneof service-specific-rules field<br/>dns-filter  struct  — Filter is allowed only if service = dns<br/>include-nonrecursive-queries  bool  — Not only recursive queries will be delivered<br/>management-events-filter  struct    — Singular filter describing gathering management events<br/>resource-scopes  []struct  — A list of resources which will be monitored by the trail<br/>id    string  required  — ID of the resource<br/>type  string  required  — Type of the resource<br/>|
|`--labels`|<b>`stringToString`</b><br/>New custom labels for the secret as 'key:value' pairs. Maximum 64 per key.|
|`--name`|<b>`string`</b><br/>New name of the trail.|
|`--service-account-id`|<b>`string`</b><br/>New service account ID of the trail|
|`--trail-id`|<b>`string`</b><br/>ID of the trail to update.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
