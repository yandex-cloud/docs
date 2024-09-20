# Viewing operations with the service's resources

All actions with {{ resmgr-name }} resources are logged as a list of operations. Each operation is assigned a unique ID.

## Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

  To view operations with a cloud or a folder:
  
  1. Go to the appropriate cloud or folder.
  1. At the top of the screen, go to the **{{ ui-key.yacloud.common.operations-key-value }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of operations for a {{ resmgr-name }} resource, run this command:

  ```bash
  yc resource-manager <resource_type> list-operations <resource_name_or_ID>
  ```

  **Example**

  To get a list of operations for a folder:

  ```bash
  yc resource-manager folder list-operations b1g681qpemb4********
  ```

  Result:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |          DESCRIPTION           |
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------------+
  | b1g4jml98i8c******** | 2023-06-07 12:35:50 | aje9k8luj4qf******** | 2023-06-07 12:35:50 | DONE   | Update resource-manager.folder |
  |                      |                     |                      |                     |        | access bindings                |
  | b1g3cmmtt3u4******** | 2023-04-05 06:05:45 | ajeuddo5f7pj******** | 2023-04-05 06:05:45 | DONE   | Create folder                  |
  +----------------------+---------------------+----------------------+---------------------+--------+--------------------------------+
  ```

  By default, information about operations is provided as text. To get more detailed information, specify the `yaml` or `json` output data format using the `--format` flag:

  ```bash
  yc resource-manager folder list-operations b1g681qpemb4******** --format yaml
  ```

  Result:

  ```text
  - id: b1g4jml98i8c********
    description: Update resource-manager.folder access bindings
    created_at: "2023-06-07T12:35:50.143Z"
    created_by: aje9k8luj4qf********
    modified_at: "2023-06-07T12:35:50.543823061Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.access.UpdateAccessBindingsMetadata
      resource_id: b1g681qpemb4********
    response:
      '@type': type.googleapis.com/google.protobuf.Empty
      value: {}
  - id: b1g3cmmtt3u4********
    description: Create folder
    created_at: "2023-04-05T06:05:45.617732162Z"
    created_by: ajeuddo5f7pj********
    modified_at: "2023-04-05T06:05:45.617995551Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.resourcemanager.v1.CreateFolderMetadata
      folder_id: b1g681qpemb4********
    response:
      '@type': type.googleapis.com/google.protobuf.Empty
      value: {}
  ```

- API {#api}

  Use the `listOperations` REST API method for the relevant resource or the `<service>/ListOperations` gRPC API call.

  For example, to get a list of operations for a folder, use either the [listOperations](../api-ref/Folder/listOperations.md) REST API method for the [Folder](../api-ref/Folder/index.md) resource or the [FolderService/ListOperations](../api-ref/grpc/folder_service.md#ListOperations) gRPC API call.

{% endlist %}

## Getting detailed information about an operation {#get-operations-info}

1. [Get a list of operations](#get-operations) for the resource.
1. Copy the ID of the operation.
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
      id: b1g4jml98i8c********
      description: Update resource-manager.folder access bindings
      created_at: "2023-06-07T12:35:50.143Z"
      created_by: aje9k8luj4qf********
      modified_at: "2023-06-07T12:35:50.543Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.access.UpdateAccessBindingsMetadata
        resource_id: b1g681qpemb4********
      response:
        '@type': type.googleapis.com/yandex.cloud.access.AccessBindingsOperationResult
      ```

   - API {#api}

     Use the [OperationService/Get](../api-ref/grpc/operation_service.md#Get) gRPC API call.

   {% endlist %}

#### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
