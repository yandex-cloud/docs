# Viewing operations with a secret

All actions with {{ lockbox-name }} resources are logged as a list of operations. Each operation is assigned a unique ID.

## Get a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
   1. In the left-hand menu, select **{{ ui-key.yacloud.lockbox.label_section-secrets }}**.
   1. Click the name of the secret you need.
   1. In the left-hand panel, select the ![image](../../_assets/operations.svg) **{{ ui-key.yacloud.common.operations-key-value }}** section.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of operations for a secret, run this command:

   ```bash
   yc lockbox secret list-operations <secret_name_or_ID>
   ```

   Result:

   ```text
   +----------------------+---------------------+----------------------+---------------------+--------+---------------+
   |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |  DESCRIPTION  |
   +----------------------+---------------------+----------------------+---------------------+--------+---------------+
   | e6qj8hr2mfoj******** | 2024-03-27 02:47:03 | aje9k8luj4qf******** | 2024-03-27 02:47:03 | DONE   | Update secret |
   | e6q4145hccpl******** | 2024-03-27 02:46:40 | aje9k8luj4qf******** | 2024-03-27 02:46:40 | DONE   | Update secret |
   +----------------------+---------------------+----------------------+---------------------+--------+---------------+
   ```

   By default, information about operations is provided as text. To get more detailed information, specify the `yaml` or `json` output data format using the `--format` flag:

   ```bash
   yc lockbox secret list-operations <secret_name_or_ID> --format yaml
   ```

   Result:

   ```yaml
   - id: e6qj8hr2mfoj********
     description: Update secret
     created_at: "2024-03-27T02:47:03.482004186Z"
     created_by: aje9k8luj4qf********
     modified_at: "2024-03-27T02:47:03.482036369Z"
     done: true
     metadata:
       '@type': type.googleapis.com/yandex.cloud.lockbox.v1.UpdateSecretMetadata
       secret_id: e6qnva6ntl66********
     response:
       '@type': type.googleapis.com/google.protobuf.Empty
       value: {}
   - id: e6q4145hccpl********
     description: Update secret
     created_at: "2024-03-27T02:46:40.035110019Z"
     created_by: aje9k8luj4qf********
     modified_at: "2024-03-27T02:46:40.035138179Z"
     done: true
     metadata:
       '@type': type.googleapis.com/yandex.cloud.lockbox.v1.UpdateSecretMetadata
       secret_id: e6qnva6ntl66********
     response:
       '@type': type.googleapis.com/google.protobuf.Empty
       value: {}
   ```

- API {#api}

   Use either the [listOperations](../api-ref/Secret/listOperations.md) REST API method for the [Secret](../api-ref/Secret/index.md) resource or the [SecretService/ListOperations](../api-ref/grpc/secret_service.md#ListOperations) gRPC API call.

{% endlist %}

## Get detailed information about an operation {#get-operations-info}

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

      ```yaml
      id: e6qj8hr2mfoj********
      description: Update secret
      created_at: "2024-03-27T02:47:03.482Z"
      created_by: aje9k8luj4qf********
      modified_at: "2024-03-27T02:47:03.482Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.lockbox.v1.UpdateSecretMetadata
        secret_id: e6qnva6ntl66********
      response:
        '@type': type.googleapis.com/yandex.cloud.lockbox.v1.Secret
        id: e6qnva6ntl66********
        folder_id: b1g681qpemb4********
        created_at: "2024-03-27T02:45:05.184Z"
        name: top-secret
        labels:
          key2: value2
        status: ACTIVE
        current_version:
          id: e6qo5a6imnm0********
          secret_id: e6qnva6ntl66********
          created_at: "2024-03-27T02:45:05.184Z"
          status: ACTIVE
          payload_entry_keys:
            - key
        deletion_protection: true
      ```

   - API {#api}

      Use the [OperationService/Get](../api-ref/grpc/operation_service.md#Get) gRPC API call.

   {% endlist %}

#### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
