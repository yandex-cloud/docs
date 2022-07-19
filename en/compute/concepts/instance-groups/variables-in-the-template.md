# Variables in an instance template

{% if product == "cloud-il" %}

{% include [one-az-disclaimer](../../../_includes/overview/one-az-disclaimer.md) %}

{% endif %}

{{ ig-name }} lets you create a group of instances of the same type from a [template](instance-template.md). To use different characteristics for such instances, use the substitution mechanism for the system and user-defined variables in the template.

A _system variable_ is a value that {{ ig-name }} calculates during instance creation and inserts it into the template for further use.

A _user-defined variable_ is a value that {{ ig-name }} takes from a list. The list is made by the user in advance and its variables are described in `key:value` format.

## Fields that support variables {#support-fields}

The instance template is described in a YAML file using the `instance_template` key. You can specify the system and user-defined variables instead of the values of the following template fields:

* `instance_template.fqdn`: Host FQDN.
* `instance_template.hostname`: Hostname.
* `instance_template.metadata`: Instance metadata. Variables can only be used in the `metadata` field key values.
* `instance_template.name`: Instance name.
* `instance_template.labels`: Instance labels. Variables can only be used in the `labels` field key values.
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

{{ ig-name }} replaces system and user-defined variables with values in two stages:

1. [Replacing system variables with calculated values](#first-stage).
1. [Replacing user-defined variables with values from the list](#second-stage).

Conversion can occur in multiple stages. In this case, the value obtained in the first stage is a variable for the second stage.

An [example](#example) of substitution stages is given below.

### First stage of value substitution {#first-stage}

{{ ig-name }} only replaces the fixed list of system variables with calculated values:

| System variable | Description |
| --- | --- |
| `{instance_group.id}` | Instance group ID. |
| `{instance_group.labels.label_key}` | Value of the label with the `label_key` key. |
| `{instance.index}` | The unique instance number in the group.</br>Possible values: 1 to N, where N is the number of instances in the group. |
| `{instance.index_in_zone}` | Instance number in the zone. It's unique for a specific group of</br>instances within a zone. |
| `{instance.short_id}` | Instance ID that is unique within the group. Consists of four letters. |
| `{instance.zone_id}` | Zone ID. |

> For example, when creating an instance group, {{ ig-name }} assigns an ID to the group and substitutes the `{instance_group.id}` of each instance with it.

### Second stage of value substitution {#second-stage}

To make sure that {{ ig-name }} substitutes values at this stage, make a list of user-defined variables in `key:value` format in advance.

At this stage, {{ ig-name }}:

1. Compares variables with the keys from the custom list.
1. Sets them to the values specified in the keys.

## Conversion of variables {#converting-rules}

System and user-defined variables are specified as values for template fields in curly brackets `{}`. {{ ig-name }} converts them according to the rules below.

| Template field value | Field value</br>after conversion | Conversion description |
| --- | --- | --- |
| `{specified_key}` | `value` | The value is inserted from the list created in advance. |
| `{unknown_key}` | `{unknown_key}` | If the specified key is not supported by the substitution mechanism, {{ ig-name }} won't replace it. |
| `not_var{{specified_key}}` | `{specified_key}` | At the first stage, the internal level of brackets is removed. |
| `not_var{{unknown_key}}` | `not_var{{unknown_key}}` | A key that is not supported by the substitution mechanism won't change. |

## Example of running the substitution stages {#example}

1. The instance template specifies:

   * The list of user-defined variables in `key:value` format in the `variables` section.
   * The system and user-defined variables in the [supported](#support-fields) fields:
      * The `instance_template.name` field specifies the `{short_zone_var_{instance.zone_id}}` user-defined variable and the `{instance.index}` system variable.
      * The `instance_template.hostname` field specifies the `{instance.index}` system variable.

   ```yaml
   ...
   variables:
     - key: short_zone_var_{{ region-id }}-a
       value: rc1a
     - key: short_zone_var_{{ region-id }}-b
       value: rc1b
     - key: short_zone_var_{{ region-id }}-c
       value: rc1c
   instance_template:
     name: production-{short_zone_var_{instance.zone_id}}-{instance.index}
     hostname: production-{instance.index}
     platform_id: standard-v3
   ...
   ```

1. During the first stage, {{ ig-name }} replaces the [system variables](#first-stage) with the calculated values.

   ```yaml
   ...
   variables:
     - key: short_zone_var_{{ region-id }}-a
       value: rc1a
     - key: short_zone_var_{{ region-id }}-b
       value: rc1b
     - key: short_zone_var_{{ region-id }}-c
       value: rc1c
   instance_template:
     name: production-{short_zone_var_{{ region-id }}-a}-1
     hostname: production-1
     platform_id: standard-v3
   ...
   ```

   Where:
   
   * In the `instance_template.name` field:
      * The `{short_zone_var_{instance.zone_id}}` variable is converted to the `{short_zone_var_{{ region-id }}-a}` variable.
      * The `{instance.index}` system variable is converted to index `1`.
   * In the `instance_template.hostname` field, the `{instance.index}` system variable is converted to index `1`.

1. At the second stage, {{ ig-name }} converts the resulting variables to the values from the list in the `variables` section:

   ```yaml
   ...
   variables:
     - key: short_zone_var_{{ region-id }}-a
       value: rc1a
     - key: short_zone_var_{{ region-id }}-b
       value: rc1b
     - key: short_zone_var_{{ region-id }}-c
       value: rc1c
   instance_template:
     name: production-rc1a-1
     hostname: production-1
     platform_id: standard-v3
   ...
   ```

    In the `instance_template.name` field: the `{short_zone_var_{{ region-id }}-a}` variable is converted to the value `rc1a`.
