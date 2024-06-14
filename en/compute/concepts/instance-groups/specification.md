---
title: "YAML specification of an instance group in {{ compute-full-name }}"
description: "This tutorial describes an instance group specification in YAML format."
---

# Specification of an instance group in YAML format

You can create or edit an instance group based on the specification in [YAML](https://en.wikipedia.org/wiki/YAML) format. The specification describes:

* Basic attributes and settings of the group: name, description, [labels](../../../resource-manager/concepts/labels.md), [service account](../../../iam/concepts/users/service-accounts.md), and deletion protection.
* [VM instance template](instance-template.md) and [variables](variables-in-the-template.md) used in it.
* Policies for VM instance [allocation](policies/allocation-policy.md), [deployment](policies/deploy-policy.md), [scaling](policies/scale-policy.md), and [recovery](policies/healing-policy.md).
* Settings for balancing the traffic between VM instances using [{{ network-load-balancer-full-name }}](../../../network-load-balancer/) or [{{ alb-full-name }}](../../../application-load-balancer/).

{% note info %}

You can also create an instance group using [Terraform](https://terraform.io) based on the description similar to a YAML specification. For more information, see [Getting started with Terraform](../../../tutorials/infrastructure-management/terraform-quickstart.md), [Create an instance group](../../operations/instance-groups/create-fixed-group.md), and the [`yandex_compute_instance_group` resource guide]({{ tf-provider-resources-link }}/compute_instance_group).

{% endnote %}


## Example {#example}

You can use the specification below to create an automatically scalable instance group, as in the [tutorial on how to process messages from the {{ message-queue-full-name }} queue](../../tutorials/autoscale-monitoring.md):

```yaml
folder_id: b1gken0eihqn********
name: queue-autoscale-ig
instance_template:
  platform_id: standard-v3
  resources_spec:
    memory: 2g
    cores: 2
    core_fraction: 100
  boot_disk_spec:
    mode: READ_WRITE
    disk_spec:
      type_id: network-hdd
      size: 5g
      image_id: fd8m5bal0bi9********
  network_interface_specs:
    - network_id: enpocgefm44f********
      subnet_ids:
        - e2ljvdp4j276********
      primary_v4_address_spec: {
        one_to_one_nat_spec: {
          ip_version: IPV4
        }
      }
      security_group_ids:
        - enps0ar5s3ti********
  filesystem_specs:
    - mode: READ_WRITE
      device_name: sample-fs
      filesystem_id: epdccsrlalon********
  service_account_id: aje1ki4ae68u********
  network_settings:
    type: STANDARD
  scheduling_policy: {}
  placement_policy:
    placement_group_id: rmppvhrgm77g********
scale_policy:
  auto_scale:
    min_zone_size: 0
    max_size: 5
    measurement_duration: 60s
    warmup_duration: 0s
    stabilization_duration: 300s
    initial_size: 1
    auto_scale_type: REGIONAL
    custom_rules:
      - rule_type: WORKLOAD
        metric_type: GAUGE
        metric_name: queue.messages.stored_count
        labels:
          queue: queue-autoscale-queue
        target: 5
        service: message-queue
deploy_policy:
  max_unavailable: 1
  startup_duration: 0s
  strategy: OPPORTUNISTIC
  minimal_action: RESTART
auto_healing_policy:
  auto_healing_action: RESTART
allocation_policy:
  zones:
    - zone_id: {{ region-id }}-a
service_account_id: ajefnb8427bh********
```


## Fields {#fields}

The list, structure, and descriptions of specification fields are provided:

* In the specification of the [CreateInstanceGroupRequest](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/compute/v1/instancegroup/instance_group_service.proto#L219) structure and other [structures used in it](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/compute/v1/instancegroup/instance_group.proto), in the API repository on GitHub ([Protobuf](https://en.wikipedia.org/wiki/Protocol_Buffers) format).
* In the description of the [create](../../api-ref/InstanceGroup/create) REST API method of the `InstanceGroup` resource ([JSON](https://en.wikipedia.org/wiki/JSON) format).
* In the description of the [InstanceGroupService/Create](../../api-ref/grpc/instance_group_service.md#Create) gRPC API call.

API references are generated from specifications published on GitHub.

Some first-level fields and their nested fields are also described in the following documentation sections:

* [{#T}](instance-template.md) (the `instance_template` field).
* [{#T}](variables-in-the-template.md) (the `instance_template` and `variables` fields).
* [{#T}](policies/allocation-policy.md) (the `allocation_policy` field).
* [{#T}](policies/deploy-policy.md) (the `deploy_policy` field).
* [{#T}](policies/scale-policy.md) (the `scale_policy` field).
* [{#T}](policies/healing-policy.md) (the `auto_healing_policy` field).
* [{#T}](autohealing.md) (the `health_checks_spec` field).
* [{#T}](balancers.md) (the `load_balancer_spec` and `application_load_balancer_spec` fields).

These sections are updated manually. They may be not as up-to-date as the API references and our specification on GitHub.

## Converting JSON and Protobuf to YAML {#translation-to-yaml}

You can create a YAML specification from a JSON or Protobuf specification using the following rules:

* Objects (JSON), `message` structures, and such fields as `map` (Protobuf) are converted to YAML dictionary objects (key-value pairs). The object keys and field names are converted from `lowerCamelCase` and `CamelCase` to `snake_case`:

  {% list tabs group=data_format %}

  - JSON {#json}

      ```json
      "targetGroupSpec": {
        "name": "spec-example-tg",
        "description": "ALB target group for example instance group",
        "labels": {
          "foo": "bar",
          "environment": "production"
        }
      }
      ```

  - Protobuf {#protobuf}

    ```protobuf
    message TargetGroupSpec {
      string name = 1;
      string description = 2;
      map<string, string> labels = 3;
    }
    ```

  - YAML {#yaml}

    ```yaml
    target_group_spec:
      name: spec-example-tg
      description: ALB target group for example instance group
      labels:
        foo: bar
        environment: production
    ```

  {% endlist %}

* Arrays (JSON) and fields of the `repeated` type (Protobuf) are converted to YAML lists:

  {% list tabs group=data_format %}

  - JSON {#json}

      ```json
      "variables": [
        {
          "key": "foo",
          "value": "bar"
        },
        {
          "key": "baz",
          "value": "foobar"
        }
      ]
      ```

  - Protobuf {#protobuf}

      ```protobuf
      message Variable {
        string key = 1;
        string value = 2;
      }

      repeated Variable variables = 1;
      ```

  - YAML {#yaml}

    ```yaml
    variables:
      - key: foo
        value: bar
      - key: baz
        value: foobar
    ```

  {% endlist %}

* The `enum` (Protobuf) structures are converted to scalar YAML values, i.e., strings corresponding to field names in Protobuf:

  {% list tabs group=data_format %}

  - Protobuf {#protobuf}

      ```protobuf
      message AttachedDiskSpec {
        enum Mode {
          MODE_UNSPECIFIED = 0;
          READ_ONLY = 1;
          READ_WRITE = 2;
        }
        Mode mode = 1;
      }
      ```

  - YAML {#yaml}

    ```yaml
    attached_disk_spec:
      mode: READ_WRITE
    ```

  {% endlist %}

## Value format {#values}

In YAML format, all values in dictionary objects are implicitly strings, so you do not need to use quotation marks for them. The string contents must match the types specified in the API reference or in the Protobuf specification: `string`, `int64`, `bool`, etc.

### Suffixes for the `int64` type {#int64}

Values of the `int64` type support the following suffixes:

{% include [yaml-int64-suffixes](../../../_includes/instance-groups/yaml-int64-suffixes.md) %}

If a value uses a suffix, it must be prefixed by an integer.

### `boolean` type {#boolean}

`bool` or `boolean` fields support all values listed in the [YAML format specification](https://yaml.org/type/bool.html):

* True: `y`, `Y`, `yes`, `Yes`, `YES`, `true`, `True`, `TRUE`, `on`, `On`, `ON`.
* False: `n`, `N`, `no`, `No`, `NO`, `false`, `False`, `FALSE`, `off`, `Off`, `OFF`.

## Creating or editing an instance group based on a specification {#how}

You can create an instance group based on a YAML specification using the command line interface (CLI) or API. For more information, see these guides:

* [{#T}](../../operations/instance-groups/create-from-yaml.md)
* [{#T}](../../operations/instance-groups/update-from-yaml.md)