{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Click the VM name.
  1. In the top-right corner of the page, click ![image](../../_assets/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}**.
  1. Open the **{{ ui-key.yacloud.common.metadata }}** menu and remove the keys by clicking ![image](../../_assets/cross.svg).

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. View a description of the CLI command to remove metadata:

      ```bash
      yc compute instance remove-metadata --help
      ```

  1. Remove the keys:

      ```bash
      yc compute instance remove-metadata <VM_ID> --keys <SSH_key_name>
      ```

- API {#api}

  To remove SSH keys from the VM metadata, use the [updateMetadata](../../compute/api-ref/Instance/updateMetadata.md) REST API method for the [Instance](../../compute/api-ref/Instance/) resource or the [InstanceService/UpdateMetadata](../../compute/api-ref/grpc/Instance/updateMetadata.md) gRPC API call.

  In your request, provide the `delete` parameter with the SSH key.

  **REST API request example**

  ```bash
  curl \
    --request POST \
    --header "Authorization: Bearer <IAM_token>" \
    --data '{"delete":["<SSH_key_name>"]}' \
    https://compute.{{ api-host }}/compute/v1/instances/<VM_ID>/updateMetadata
  ```

{% endlist %}
