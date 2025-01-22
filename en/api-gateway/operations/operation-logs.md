# Viewing operations with the service's resources

All actions with {{ api-gw-name }} resources are logged as a list of operations. Each operation is assigned a unique ID.

## Getting a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

  You can get a list of operations for a specific resource. The steps below describe how you can do this for an API gateway. The same steps apply to other service resources.

  1. In the [management console]({{ link-console-main }}), open the folder containing the API gateway.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/branches-right.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-gateways }}**.
  1. Select the API gateway you need.
  1. Go to the ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.serverless-functions.gateways.item.switch_operations }}** panel for the selected API gateway.

     You will see a list of operations with the selected API gateway.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of operations for an {{ api-gw-name }} resource, run this command:

  ```bash
  yc serverless <resource_type> list-operations <resource_name_or_ID>
  ```

  **Example**

  Getting a list of operations for an API gateway:

  ```bash
  yc serverless api-gateway list-operations epdplu8jn7sr********
  ```

  Result:

  ```text
  +----------------------+---------------------+----------------------+---------------------+--------+------------------+
  |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |   DESCRIPTION    |
  +----------------------+---------------------+----------------------+---------------------+--------+------------------+
  | d5d6ja2j20tj******** | 2024-06-21 09:59:41 | aje9k8luj4qf******** | 2024-06-21 09:59:43 | DONE   | operation_update |
  | d5dphtf4p0tp******** | 2024-06-21 09:51:17 | aje9k8luj4qf******** | 2024-06-21 09:51:20 | DONE   | operation_create |
  +----------------------+---------------------+----------------------+---------------------+--------+------------------+
  ```

  By default, information about operations is provided as text. To get detailed information, specify the `yaml` or `json` output data format using the `--format` flag:

  ```bash
  yc serverless api-gateway list-operations <API_gateway_name_or_ID> --format yaml
  ```

  Result:

  ```text
  - id: d5d6ja2j20tj********
    description: operation_update
    created_at: "2024-06-21T09:59:41.804Z"
    created_by: aje9k8luj4qf********
    modified_at: "2024-06-21T09:59:43.519Z"
    done: true
    metadata:
      '@type': type.googleapis.com/yandex.cloud.serverless.apigateway.v1.UpdateApiGatewayMetadata
      api_gateway_id: d5dig9e60uco********
  ...
  ```

- API {#api}

  Use the `listOperations` REST API method for the relevant resource or the `<service>/ListOperations` gRPC API call.

  For example, for an API gateway, use either the [listOperations](../apigateway/api-ref/ApiGateway/listOperations.md) REST API method for the [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) resource or the [ApiGatewayService/ListOperations](../apigateway/api-ref/grpc/ApiGateway/listOperations.md) gRPC API call.

{% endlist %}

## Getting detailed information about an operation {#get-operations-info}

1. [Get a list of operations](#get-operations) for the API gateway.
1. Copy the operation ID.
1. Get detailed information about the operation:

    {% list tabs group=instructions %}

    - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Run the following command:

      ```bash
      yc operation get <operation_ID>
      ```

      Result:

      ```text
        id: d5dphtf4p0tp********
        description: operation_create
        created_at: "2024-06-21T09:51:17.430Z"
        created_by: aje9k8luj4qf********
        modified_at: "2024-06-21T09:51:20.810Z"
        done: true
        metadata:
          '@type': type.googleapis.com/yandex.cloud.serverless.apigateway.v1.CreateApiGatewayMetadata
          api_gateway_id: d5dig9e60uco********
        response:
          '@type': type.googleapis.com/yandex.cloud.serverless.apigateway.v1.ApiGateway
          id: d5dig9e60uco********
          folder_id: b1g681qpemb4********
          created_at: "2024-06-21T09:51:17.489Z"
          name: operation-logs
          status: ACTIVE
          domain: {{ api-host-apigw }}
          connectivity: {}
          log_options:
            folder_id: b1g681qpemb4********
          execution_timeout: 300s
      ```

    - API {#api}

      Use the [OperationService/Get](../apigateway/api-ref/grpc/Operation/get.md) gRPC API call.

    {% endlist %}

#### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
