# Variables in an instance template

With {{ ig-name }}, you can create a group of VM instances of the same type from a [template](instance-template.md). To use different specifications for such instances, use the substitution feature for the system and user-defined variables in the template. For example, you can use variables and [tags](./policies/allocation-policy.md#tags) to [create an instance group with fixed IP addresses](../../operations/instance-groups/create-with-fixed-ip.md).

A _system variable_ is a value calculated by {{ ig-name }} when a VM is created; it is then inserted into the template for further use.

A _user-defined variable_ is a value taken from a list by {{ ig-name }}. The list is created by the user in advance and its variables are described in `key:value` format.

## Fields supporting variables {#support-fields}

The VM template is described in a YAML file using the `instance_template` key. You can put system and user-defined variables instead of values in the following template fields:

* `instance_template.fqdn`: Host FQDN.
* `instance_template.hostname`: Host name.
* `instance_template.metadata`: VM metadata. Variables can only be used in the `metadata` field key values.
* `instance_template.name`: VM name.
* `instance_template.labels`: [VM](../../../resource-manager/concepts/labels.md) labels. Variables can only be used in the `labels` field key values.
* `instance_template.boot_disk_spec.disk_id`: Boot disk ID.
* `instance_template.boot_disk_spec.disk_spec.description`: Boot disk description.
* `instance_template.boot_disk_spec.disk_spec.image_id`: Boot disk image ID.
* `instance_template.boot_disk_spec.disk_spec.snapshot_id`: Boot disk snapshot ID.
* `instance_template.boot_disk_spec.disk_spec.type_id`: Boot disk type.
* `instance_template.network_interface_specs.primary_v4_address_spec.one_to_one_nat_spec.address`: Configuration of the external IPv4 address.
* `instance_template.network_interface_specs.primary_v6_address_spec.one_to_one_nat_spec.address`: Configuration of the external IPv6 address.
* `instance_template.placement_policy.placement_group_id`: [Placement group](../placement-groups.md) ID.
* `instance_template.secondary_disk_specs.disk_id`: Secondary disk ID.
* `instance_template.secondary_disk_specs.disk_spec.description`: Secondary disk description.
* `instance_template.secondary_disk_specs.disk_spec.image_id`: Secondary disk image ID.
* `instance_template.secondary_disk_specs.disk_spec.snapshot_id`: Secondary disk snapshot ID.
* `instance_template.secondary_disk_specs.disk_spec.type_id`: Secondary disk type.

## Stages of variable substitution {#substitution-rules}

In {{ ig-name }}, system and user-defined variables get replaced with values in two stages:

1. [Replacing system variables with calculated values](#first-stage).
1. [Replacing user-defined variables with values from the list](#second-stage).

Value conversion may also occur in multiple stages. In this case, the value obtained in the first stage is a variable for the second stage.

You can see an [example](#example) of substitution stages below.

### Value substitution: Stage 1 {#first-stage}

{{ ig-name }} will only replace the fixed list of system variables with the calculated values:

System variable | Description | Possible values
--- | --- | ---
`{instance_group.id}` | Instance group ID | String value, e.g., `cl1cd2vd4ohr********`. For more info, see [Getting information about an instance group](../../operations/instance-groups/get-info.md).
`{instance_group.labels.label_key}` | Value of an instance group's [label](../../../resource-manager/concepts/labels.md) with `label_key` for key. | String value, e.g., `label_value`. For more info, see [Getting information about an instance group](../../operations/instance-groups/get-info.md).
`{instance.index}` | Unique instance number in the group. | Values: 1 to N, where N is the number of instances in the group.  
`{instance.index_in_zone}` | Instance number in the availability zone. It is unique for a specific instance group within a zone. | Values: 1 to N, where N is the number of instances in a single availability zone.
`{instance.labels.another_label_key}` | Value of a particular instance's label with `another_label_key` for key. | String value, e.g., `another_label_value`. For more info, see [Getting information about a VM](../../operations/vm-info/get-info.md).
`{instance.short_id}` | Instance ID that is unique within the group. | String value consisting of four alphabetic characters, e.g., `ilum`.
`{instance.tag}` | Tag of an instance in the group within the availability zone. | Value, specified in the `allocation_policy.zones.instance_tags_pool` field. For more information, see the [Allocation policy](policies/allocation-policy.md).
`{instance.zone_id}` | Availability zone ID. | Value, specified in the `allocation_policy.zones.zone_id` field. For more information, see the [Allocation policy](policies/allocation-policy.md).

>For example, when creating an instance group, {{ ig-name }} will assign an ID to the group and substitute it instead of `{instance_group.id}` for each instance.

### Value substitution: Stage 2 {#second-stage}

To enable {{ ig-name }} to substitute values at this stage, provide a list of user-defined variables in `key:value` format in advance.

At this stage, {{ ig-name }} will do the following:

1. Compare variables with the keys from the user-provided list.
1. Replace the variables with the values specified in the keys.

## Conversion of variables {#converting-rules}

System and user-defined variables are specified as values for template fields in curly brackets `{}`. {{ ig-name }} converts them according to the rules below.

Template field value | Field value</br>after conversion | Conversion description
--- | --- | ---
`{specified_key}` | `value`  | The value will be inserted from the list prepared in advance.
`{unknown_key}` | `{unknown_key}` | If the specified key is not supported by the substitution feature, {{ ig-name }} will not replace it.
`not_var{{specified_key}}` | `{specified_key}` | At Stage 1, the internal level of brackets will be removed.
`not_var{{unknown_key}}` | `not_var{{unknown_key}}` | Keys that are not supported by the substitution feature will not change.

## Example of running substitution stages {#example}

1. Let's assume the instance template specifies the following:

   * List of user-defined variables in `key:value` format in the `variables` section.
   * System and user-defined variables in [allowed](#support-fields) fields:
     * The `{short_zone_var_{instance.zone_id}}` user-defined variable and the `{instance.index}` system variable are specified in the `instance_template.name` field.
     * The system `{instance.index}` variable is specified in the `instance_template.hostname` field.

   ```yaml
   ...
   variables:
     - key: short_zone_var_{{ region-id }}-a
       value: rc1a
     - key: short_zone_var_{{ region-id }}-b
       value: rc1b
     - key: short_zone_var_{{ region-id }}-d
       value: rc1d
   instance_template:
     name: production-{short_zone_var_{instance.zone_id}}-{instance.index}
     hostname: production-{instance.index}
     platform_id: standard-v3
   ...
   ```

1. At Stage 1, {{ ig-name }} will replace the [system variables](#first-stage) with the calculated values:

   ```yaml
   ...
   variables:
     - key: short_zone_var_{{ region-id }}-a
       value: rc1a
     - key: short_zone_var_{{ region-id }}-b
       value: rc1b
     - key: short_zone_var_{{ region-id }}-d
       value: rc1d
   instance_template:
     name: production-{short_zone_var_{{ region-id }}-a}-1
     hostname: production-1
     platform_id: standard-v3
   ...
   ```

   Where:

   * In the `instance_template.name` field:
     * The `{short_zone_var_{instance.zone_id}}` variable will be converted to `{short_zone_var_{{ region-id }}-a}`.
     * The `{instance.index}` system variable will be converted to `1`.
   * In the `instance_template.hostname` field, the `{instance.index}` system variable will be converted to `1`.

1. At Stage 2, {{ ig-name }} will convert the resulting variables to the values listed in the `variables` section:

   ```yaml
   ...
   variables:
     - key: short_zone_var_{{ region-id }}-a
       value: rc1a
     - key: short_zone_var_{{ region-id }}-b
       value: rc1b
     - key: short_zone_var_{{ region-id }}-d
       value: rc1d
   instance_template:
     name: production-rc1a-1
     hostname: production-1
     platform_id: standard-v3
   ...
   ```

   In the `instance_template.name` field, the `{short_zone_var_{{ region-id }}-a}` variable will be converted to `rc1a`.

### See also {#see-also}

* [{#T}](specification.md)
* [{#T}](instance-template.md)
* [{#T}](../../operations/instance-groups/create-with-fixed-ip.md)