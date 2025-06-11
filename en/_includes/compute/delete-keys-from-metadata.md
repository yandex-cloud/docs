{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder this VM belongs to.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. In the VM row, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Expand the **{{ ui-key.yacloud.common.metadata }}** section and remove the keys by clicking ![image](../../_assets/console-icons/xmark.svg).
  1. Click **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. See the description of the CLI command for removing metadata:

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
