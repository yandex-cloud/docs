# Viewing operations with {{ sf-name }} resources

All actions with {{ sf-name }} resources are logged as a list of operations. Each operation gets its own unique ID.

## Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

  You can get a list of operations for a specific resource. The steps below describe how you can do this for a function. The same steps apply to other {{ sf-name }} resources.

  1. In the [management console]({{ link-console-main }}), open the folder with the function.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/curly-brackets-function.svg) **{{ ui-key.yacloud.serverless-functions.switch_list }}**.
  1. Select the function you need.
  1. Go to the ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** panel for the selected zone.

     You will see a list of operations with the selected function.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of operations for a {{ sf-name }} resource, run this command:

  ```bash
  yc serverless <resource_type> list-operations <resource_name_or_ID>
  ```

  **Example**

  Getting a list of operations for a function:

  ```bash
  yc serverless function list-operations epdplu8jn7sr********
  ```

  Result:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+-----------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |   DESCRIPTION   |
  +----------------------+---------------------+----------------------+---------------------+--------+-----------------+
  | d4e952nebqdb******** | 2024-06-19 08:33:11 | aje9k8luj4qf******** | 2024-06-19 08:33:12 | DONE   | Create session  |
  | d4elh7hqnj7g******** | 2024-06-19 08:33:04 | aje9k8luj4qf******** | 2024-06-19 08:33:04 | DONE   | Create function |
  +----------------------+---------------------+----------------------+---------------------+--------+-----------------+
  ```

  By default, information about operations is output as text. To get detailed information, specify the `yaml` or `json` output data format using the `--format` flag:

  ```bash
  yc serverless function list-operations <resource_name_or_ID> --format yaml
  ```

  Result:

  ```text
  - id: d4e952nebqdb********
    description: Create session
    created_at: "2024-06-19T08:33:11.658Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-06-19T08:33:12.345Z"
    done: true
    metadata:
      '@type': type.googleapis.com/google.protobuf.Empty
      value: {}
    response:
      '@type': type.googleapis.com/google.protobuf.Empty
      value: {}
  ...
  ```

- API {#api}

  Use the `listOperations` REST API method for the relevant resource or the `<service>/ListOperations` gRPC API call.

  For example, for a function, use either the [listOperations](../functions/api-ref/Function/listOperations.md) REST API method for the [Function](../functions/api-ref/Function/index.md) resource or the [FunctionService/ListOperations](../functions/api-ref/grpc/Function/listOperations.md) gRPC API call.

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
        id: d4elh7hqnj7g********
        description: Create function
        created_at: "2024-06-19T08:33:04.513Z"
        created_by: aje9k8luj4qf********
        modified_at: "2024-06-19T08:33:04.665Z"
        done: true
        metadata:
          '@type': type.googleapis.com/yandex.cloud.serverless.functions.v1.CreateFunctionMetadata
          function_id: d4e3f75v8kti********
        response:
          '@type': type.googleapis.com/yandex.cloud.serverless.functions.v1.Function
          id: d4e3f75v8kti********
          folder_id: b1g681qpemb4********
          created_at: "2024-06-19T08:33:04.587Z"
          name: my-db-function
          http_invoke_url: https://functions.yandexcloud.net/d4e3f75v8kti********
          status: ACTIVE
      ```

    - API {#api}

      Use the [OperationService/Get](../functions/api-ref/grpc/Operation/get.md) gRPC API call.

    {% endlist %}

#### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
