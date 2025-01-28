# Viewing operations with {{ compute-name }} resources

All actions with {{ compute-name }} resources are logged as a list of operations. Each operation gets its own unique ID.

## Getting a list of operations {#get-operations}

{% note info %}

{{ compute-name }} stores data on resource operations for the last two weeks.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  To view all operations with {{ compute-name }} resources, select ![image](../../_assets/operations.svg) **{{ ui-key.yacloud.compute.switch_operations }}** in the left-hand panel. In the list that opens, you will also see operations with the resources that were deleted.
  
  You can get a list of operations for a specific resource. The steps below describe how you can do this for a VM. The same steps apply to other {{ compute-name }} resources.

  1. In the [management console]({{ link-console-main }}), open the folder with the VM.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/compute/vm-pic.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Select the VM.
  1. Go to the ![image](../../_assets/operations.svg) **{{ ui-key.yacloud.compute.switch_operations }}** panel for the selected VM.

     The list that opens shows operations with the selected VM and the resources connected to it.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of operations for a {{ compute-name }} resource, run this command:

  ```bash
  yc compute <resource_type> list-operations <resource_name_or_ID>
  ```

  **Example**

  Getting a list of operations for a VM:

  ```bash
  yc compute instance list-operations epdplu8jn7sr********
  ```

  Result:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+-----------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |   DESCRIPTION   |
  +----------------------+---------------------+----------------------+---------------------+--------+-----------------+
  | epd2ohv6ur6a******** | 2023-10-20 08:34:01 | ajeef73j5iq9******** | 2023-10-20 08:34:05 | DONE   | Update instance |
  | epd2lcg5na2r******** | 2023-10-20 08:32:28 | ajeef73j5iq9******** | 2023-10-20 08:32:55 | DONE   | Stop instance   |
  +----------------------+---------------------+----------------------+---------------------+--------+-----------------+
  ```

  By default, information about operations is output as text. To get detailed information, specify the `yaml` or `json` output data format using the `--format` flag:

  ```bash
  yc compute instance list-operations epdplu8jn7sr******** --format yaml
  ```

  Result:

  ```text
  - id: epd2ohv6ur6a********
    description: Update instance
    created_at: "2023-10-20T08:34:01Z"
    created_by: ajeef73j5iq9********
    modified_at: "2023-10-20T08:34:05Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.compute.v1.UpdateInstanceMetadata
      instance_id: epdplu8jn7sr********
    response:
      '@type': type.googleapis.com/yandex.cloud.compute.v1.Instance
      id: epdplu8jn7sr********
      folder_id: b1g86q4m5vej********
      created_at: "2023-10-02T13:19:45Z"
      name: rewq
      zone_id: {{ region-id }}-a
      platform_id: standard-v3
      resources:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      status: STOPPED
      ...
  - id: epd2lcg5na2r********
    description: Stop instance
    created_at: "2023-10-20T08:32:28Z"
    created_by: ajeef73j5iq9********
    modified_at: "2023-10-20T08:32:55Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.compute.v1.StopInstanceMetadata
      instance_id: epdplu8jn7sr********
    response:
      '@type': type.googleapis.com/google.protobuf.Empty
      value: {}
  ```

- API {#api}

  Use the `listOperations` REST API method for the relevant resource or the `<service>/ListOperations` gRPC API call.

  For example, for a VM, use either the [listOperations](../api-ref/Instance/listOperations.md) REST API method for the [Instance](../api-ref/Instance/index.md) resource or the [InstanceService/ListOperations](../api-ref/grpc/Instance/listOperations.md) gRPC API call.

{% endlist %}

## Getting detailed information about an operation {#get-operations-info}

1. [Get a list of operations](#get-operations) for the resource.
1. Copy the operation ID.
1. Get detailed information about the operation:

   {% list tabs group=instructions %}

   - CLI {#cli}

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     Run this command:

     ```bash
     yc operation get <operation_ID>
     ```

     Result:

     ```text
     id: ef3ovrdqhhf9********
     description: Delete instance
     created_at: "2023-10-17T16:08:10Z"
     created_by: ajejisqqifen********
     modified_at: "2023-10-17T16:08:41Z"
     done: true
     metadata:
       '@type': type.googleapis.com/yandex.cloud.compute.v1.DeleteInstanceMetadata
       instance_id: ef3su74qmfp4********
     response:
       '@type': type.googleapis.com/google.protobuf.Empty
       value: {}
     ```

   - API {#api}

     Use the [get](../api-ref/Operation/get.md) REST API method for the [Operation](../api-ref/Operation/index.md) resource or the [OperationService/Get](../api-ref/grpc/Operation/get.md) gRPC API call.

   {% endlist %}

#### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
