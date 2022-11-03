# Specification of an instance group in YAML format

You can create or edit an instance group based on the specification in the [YAML](https://en.wikipedia.org/wiki/YAML) format. The specification describes:

* The basic attributes and settings of the group: name, description, [labels](../../../overview/concepts/services.md#labels), [service account](../../../iam/concepts/users/service-accounts.md), and deletion protection.
* The [VM instance template](instance-template.md) and [variables](variables-in-the-template.md) used in it.
* Policies for [allocation](policies/allocation-policy.md), [deployment](policies/deploy-policy.md), and [scaling](policies/scale-policy.md).
* Settings for balancing the traffic between VM instances using [{{ network-load-balancer-full-name }}](../../../network-load-balancer/) or [{{ alb-full-name }}](../../../application-load-balancer/).

## Example {#example}

You can use the specification below to create an automatically scalable VM group, as in the message [processing scenario from the {{ message-queue-full-name }} queue](../../tutorials/autoscale-monitoring.md):

```yaml
folder_id: b1gken0eihqn2oa0fm2k
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
      image_id: fd8m5bal0bi9tjhu7av2
  network_interface_specs:
  - network_id: enpocgefm44fp31qpdru
    subnet_ids:
    - e2ljvdp4j2762fl4qh1i
    primary_v4_address_spec:
      one_to_one_nat_spec:
        ip_version: IPV4
  scheduling_policy: {}
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
allocation_policy:
  zones:
  - zone_id: {{ region-id }}-b
service_account_id: ajefnb8427bhl9t0pvf8
```

## Fields {#fields}

The list, structure, and  descriptions of specification fields are provided:

* In the specification of the [CreateInstanceGroupRequest](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/compute/v1/instancegroup/instance_group_service.proto#L219) structure and other [structures used in it](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/compute/v1/instancegroup/instance_group.proto), in the API repository on GitHub ([Protobuf](https://en.wikipedia.org/wiki/Protocol_Buffers) format).
* In the description of the method [Create](../../api-ref/InstanceGroup/create) of the `InstanceGroup` resource in the REST API ([JSON](https://en.wikipedia.org/wiki/JSON) format).
* In the description of the call [InstanceGroupService/Create](../../api-ref/grpc/instance_group_service.md#Create) gRPC API.

API references are generated from specifications published on GitHub.

Some first-level fields and their nested fields are also described  in the following documentation sections:

* [{#T}](instance-template.md) (the `instance_template` field).
* [{#T}](variables-in-the-template.md) (the `instance_template` and `variables` fields).
* [{#T}](policies/allocation-policy.md) (the `allocation_policy` field).
* [{#T}](policies/deploy-policy.md) (the `deploy_policy` field).
* [{#T}](policies/scale-policy.md) (the `scale_policy` field).

These sections are updated manually. They may be less up-to-date than the API references and our specification on GitHub.

## Converting JSON and Protobuf to YAML {#translation-to-yaml}

You can create a YAML specification from a JSON or Protobuf specification using the following rules:

* The objects (JSON), `message` structures, and such fields as `map` (Protobuf) are converted to YAML dictionary objects (key-value pairs). The object keys and field names are converted from `lowerCamelCase` and `CamelCase` to `snake_case`.

   {% list tabs %}

   - JSON

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

   - Protobuf

      ```protobuf
      message TargetGroupSpec {
        string name = 1;
        string description = 2;
        map<string, string> labels = 3;
      }
      ```

   - YAML

      ```yaml
      target_group_spec:
        name: spec-example-tg
        description: ALB target group for example instance group
        labels:
          foo: bar
          environment: production
      ```

   {% endlist %}

* Arrays (JSON) and fields of the `repeated` type (Protobuf) are converted to YAML lists.

   {% list tabs %}

   - JSON

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

   - Protobuf

      ```protobuf
      message Variable {
        string key = 1;
        string value = 2;
      }
      
      repeated Variable variables = 1;
      ```

   - YAML

      ```yaml
      variables:
        - key: foo
          value: bar
        - key: baz
          value: foobar
      ```

   {% endlist %}

* The `enum` (Protobuf) structures are converted to scalar YAML values, that is, strings corresponding to field names in Protobuf.

   {% list tabs %}

   - Protobuf

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

   - YAML

      ```yaml
      attached_disk_spec:
        mode: READ_WRITE
      ```

   {% endlist %}

## Value format {#values}

In YAML format, all values in dictionary objects are implicitly strings, so you don't need to use quotation marks for them. The string contents must match the types specified in the API reference or in the Protobuf specification: `string`, `int64`, `bool`, and so on.

### Suffixes for the `int64` type {#int64}

Values of the `int64` type support the following suffixes:

{% include [yaml-int64-suffixes](../../../_includes/instance-groups/yaml-int64-suffixes.md) %}

If a value uses a suffix, it must be prefixed by an integer.

### The `boolean` type {#boolean}

In fields of `bool` or `boolean` type, all values listed in the [YAML format specification](https://yaml.org/type/bool.html) are supported:

* True: `y`, `Y`, `yes`, `Yes`, `YES`, `true`, `True`, `TRUE`, `on`, `On`, `ON`.
* False: `n`, `N`, `no`, `No`, `NO`, `false`, `False`, `FALSE`, `off`, `Off`, `OFF`.

## How to create or edit an instance group based on a specification {#how}

You can create an instance group based on a YAML specification using the command line interface (CLI) or API. For more information, see the instructions:

* [{#T}](../../operations/instance-groups/create-from-yaml.md)
* [{#T}](../../operations/instance-groups/update-from-yaml.md)