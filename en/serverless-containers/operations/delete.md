---
title: Deleting a container
description: Follow this guide to delete a container.
---

# Deleting a container

{% list tabs group=instructions %}

- Management console {#console}

	1. In the [management console]({{ link-console-main }}), go to the folder with your container.
	1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
	1. In the container row, click ![image](../../_assets/console-icons/ellipsis.svg).
	1. In the menu that opens, click **{{ ui-key.yacloud.common.delete }}**.
	1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

	To delete a container, run this command:

	```
	yc serverless container delete --name <container_name>
	```

	Result:

	```
	done (2s)
	```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To delete a container created with {{ TF }}:

  1. Open the {{ TF }} configuration file and delete the section with the container description.

     Example container description in the {{ TF }} configuration:
     
     ```hcl
     ...
     resource "yandex_serverless_container" "test-container" {
       name               = "my-container"
       memory             = 256
       service_account_id = "ajecvjv1lv01********"
       image {
           url = "{{ registry }}/yc/test-image:v1"
       }
     }
     ...
     ```

	 For more information about `yandex_serverless_container` properties, see [this {{ TF }} article]({{ tf-provider-resources-link }}/serverless_container).

  1. Check the configuration using this command:
     ```
     terraform validate
     ```
     
     If the configuration is correct, you will get this message:
     
     ```
     Success! The configuration is valid.
     ```

  1. Run this command:
     ```
     terraform plan
     ```
  
     You will see a detailed list of resources. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will show them.

  1. Apply the changes:
     ```
     terraform apply
     ```
     
  1. Type `yes` and press **Enter** to confirm the changes.

  You can check the deletion of the container using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

  ```
  yc serverless container list
  ```

- API {#api}

  To delete a container, use the [delete](../containers/api-ref/Container/delete.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/Delete](../containers/api-ref/grpc/Container/delete.md) gRPC API call.

{% endlist %}