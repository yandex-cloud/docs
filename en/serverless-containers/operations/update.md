# Updating a container

You can edit a [container name or description](#update-name) and [manage container labels](#manage-label). To change the operation parameters of a container, [create a new revision of the container](./manage-revision.md).

{% include [serverless-containers-list-note](../../_includes/serverless-containers/container-list-note.md) %}

## Updating a container's name or description {#update-name}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with your container.
   1. Select **{{ serverless-containers-name }}**.
   1. Select the container.
   1. Click **Edit**.
   1. Update a container's name or description Name format:

      {% include [name-format](../../_includes/name-format.md) %}

   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To update:
   * A container name, run the command:
      ```
      yc serverless container \
        --name <container_name> \
        --new-name <new_container_name>
      ```
   * A container description, run the command:
      ```
      yc serverless container \
        --name <container_name> \
        --description <new_container_description>
      ```

   Result:

   ```
   id: flh7r96juaqq********
   folder_id: aoek6qrs8tjh********
   created_at: "2021-08-17T07:53:10.219Z"
   name: my-beta-container
   description: my beta container description
   url: https://flh7r96juaqq********.containers.cloud-preprod.yandex.net/
   status: ACTIVE
   ```

- API

   You can change a container name or description using the API [update](../containers/api-ref/Container/update.md) method.


- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about the {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To modify the name or description of a container created with {{ TF }}:

   1. Open the {{ TF }} configuration file and edit the values in the `name` and `description` fields in the `yandex_serverless_container` resource description:

      ```hcl
      ...
      resource "yandex_serverless_container" "test-container" {
        name               = "my-conrainer"
        description        = "my first container with description"
        memory             = 256
        service_account_id = "ajec........34ova"
        image {
            url = "{{ registry }}/yc/test-image:v1"
        }
      }
      ...
      ```

      For more information about the `yandex_serverless_container` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/serverless_container).

   1. Check the configuration using the command:
      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:
      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

   You can verify the change to the container using the [management console]({{ link-console-main }}) or the following [CLI](../../cli/) command:

   ```
   yc serverless container get <container_ID>|<container_name>
   ```

{% endlist %}

## Managing container labels {#manage-label}

You can perform the following actions with container labels:

- [Add](#add-label)
- [Edit](#update-label)
- [Delete](#remove-label)

### Adding a label {#add-label}

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add a label to a container, run the command:

   ```
   yc serverless container add-labels <container_name> --labels <key>=<value>
   ```

   Result:

   ```
   id: flh7r96juaqq********
   folder_id: aoek6qrs8tjh********
   created_at: "2021-08-17T07:53:10.219Z"
   name: my-beta-container
   description: my beta container description
   labels:
     label: test
   url: https://flh7r96juaqq********.containers.cloud-preprod.yandex.net/
   status: ACTIVE
   ```

- API

   You can add a label to a container using the API [update](../containers/api-ref/Container/update.md) method.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about the {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To add a label to a container created using {{ TF }}:

   1. Open the {{ TF }} configuration file and, under the `yandex_serverless_container` resource, add a `labels section`:

      ```hcl
      ...
      resource "yandex_serverless_container" "test-container" {
        name   = "my first container with description"
        memory = 256
        image {
           url = "{{ registry }}/yc/test-image:v1"
        }
        labels = {
           label1 = "test"
        }
      }
      ...
      ```

      For more information about the `yandex_serverless_container` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/serverless_container).

   1. Check the configuration using the command:
      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:
      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

   You can verify that you have created the container labels using the [CLI](../../cli/):

   ```
   yc serverless container get <container_ID>|<container_name>
   ```

{% endlist %}

### Updating a label {#update-label}

{% list tabs %}

- CLI

   To update a container label, run the command:

   {% note warning %}

   The existing set of `labels` is completely replaced by the set transmitted.

   {% endnote %}

   ```
   yc serverless container update <container_name> --labels <key>=<value>
   ```

   Result:

   ```
   id: flh7r96juaqq********
   folder_id: aoek6qrs8tjh********
   created_at: "2021-08-17T07:53:10.219Z"
   name: my-beta-container
   description: my beta container description
   labels:
     new_label: new_test
   url: https://flh7r96juaqq********.containers.cloud-preprod.yandex.net/
   status: ACTIVE
   ```

- API

   You can update a container label using the [update](../containers/api-ref/Container/update.md) API method.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about the {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To modify the label of a container created with {{ TF }}:

   1. Open the {{ TF }} configuration file, and under the `yandex_serverless_container` resource, edit the `labels` section:

      ```hcl
      ...
      resource "yandex_serverless_container" "test-container" {
        name   = "my first container with description"
        memory = 256
        image {
           url = "{{ registry }}/yc/test-image:v1"
        }
        labels = {
           label1 = "new-label"
        }
      }
      ...
      ```

      For more information about the `yandex_serverless_container` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/serverless_container).

   1. Check the configuration using the command:
      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:
      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

   You can verify that you have modified a container label using the [CLI](../../cli/):

   ```
   yc serverless container get <container_ID>|<container_name>
   ```

{% endlist %}

### Deleting a label {#remove-label}

{% list tabs %}

- CLI

   To delete a container label, run the command:

   ```
   yc serverless container remove-labels <container_name> --labels <key>
   ```

   Result:

   ```
   id: flh7r96juaqq********
   folder_id: aoek6qrs8tjh********
   created_at: "2021-08-17T07:53:10.219Z"
   name: my-beta-container
   description: my beta container description
   url: https://flh7r96juaqq********.containers.cloud-preprod.yandex.net/
   status: ACTIVE
   ```

- API

   You can delete a container label using the [update](../containers/api-ref/Container/update.md) API method.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about the {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete the label of a container created using {{ TF }}:

   1. Open the {{ TF }} configuration file and, under the `yandex_serverless_container` resource, delete the label in the `labels` section:
      ```hcl
      ...
      resource "yandex_serverless_container" "test-container" {
        name   = "my first container with description"
        memory = 256
        image {
           url = "{{ registry }}/yc/test-image:v1"
        }
        labels = {
           label1 = "new-label"
        }
      }
      ...
      ```

      For more information about the `yandex_serverless_container` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/serverless_container).

   1. Check the configuration using the command:
      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:
      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

   You can verify that you have deleted a container label using the [CLI](../../cli/):

   ```
   yc serverless container get <container_ID>|<container_name>
   ```

{% endlist %}