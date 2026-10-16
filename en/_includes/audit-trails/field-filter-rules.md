You can set filtering rules in one or both sections:

* `include_rules`: Which events to log.
* `exclude_rules`: Which events to discard.

A single rule is a `conditions` section with a set of conditions. A rule is triggered if all of its conditions are met (logical _AND_). If `include_rules` or `exclude_rules` feature multiple rules, it is enough to trigger at least one of them (logical _OR_).

Each condition contains:

* `field`: Path from the event root (`$`) to a scalar value, e.g., `$.details.bucket_id`, `$.details.user.groups[0]`, or `$.details.items[2].metadata['name']`. Array indexes start from zero.
* `operator`: Comparison operator:
    * `IN`: Field value matches one of those in the `values` list.
    * `IP_IN`: IP address from the field is part of one of the subnets specified in `values` in CIDR format.
* `values`: List containing from one to 64 values. Values should be specified as strings, including for numeric and boolean fields.

A rule can contain from one to 64 conditions; each list can contain up to 64 rules.

The fields depend on event type as per the [reference](../../audit-trails/events-ref/index.md), e.g., for [ObjectCreate](../../audit-trails/audit/storage/events-ref/ObjectCreate.md). The `request_parameters` and `response` fields and their content cannot be filtered.

Key names and case in the path must match the actual [audit log](../../audit-trails/concepts/format-data-plane.md#scheme) JSON. For example, use `$.event_type` and `$.request_metadata.remote_address`, even though the reference names these fields `eventType` and `requestMetadata.remoteAddress`.

Filter structure example:

```yaml
include_rules:  # Including events; to exclude, use exclude_rules
  - conditions:  # Rule 1: condition 1 AND condition 2
      - field: "<path_to_field_1>"
        operator: IN
        values: ["<value_1>", "<value_2>"]
      - field: "<path_to_field_2>"
        operator: IP_IN
        values: ["<subnet_in_cidr>"]
  - conditions:  # OR rule 2
      - field: "<path_to_field_3>"
        operator: IN
        values: ["<value_3>"]
```
