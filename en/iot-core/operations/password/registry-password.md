# Managing registry passwords

{% include [iot-sunset-warning](../../../_includes/iot-core/sunset-warning.md) %}

To start exchanging data and commands between devices and registries, you need to [authenticate](../../concepts/authorization.md). This section describes how to manage registry passwords for the relevant authentication method.

{% include [pass-priority-note](../../../_includes/iot-core/pass-priority-note.md) %}

* [Adding a password](#create-or-add)
* [Viewing a password list](#list)
* [Deleting a password](#delete)

## Adding a password to a registry {#create-or-add}

You can add a password to an already created registry or set it when creating a registry using the `--password` parameter.

{% include [read-pass](../../../_includes/iot-core/read-pass.md) %}

### Adding a password to an existing registry {#add}

{% list tabs group=instructions %}

- Management console {#console}

   To add a password to an existing registry:

   1. In the [management console]({{ link-console-main }}), select the folder where you want to add a password to an existing registry.
   1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Select the registry from the list.
   1. Under **{{ ui-key.yacloud.iot.label_passwords }}**, click **{{ ui-key.yacloud.iot.button_add-password }}**.
   1. In the **{{ ui-key.yacloud.common.password }}** field, enter a password you will use to access your registry.<br/>You can use [this password generator](https://passwordsgenerator.net/) to generate a password.<br/>Make sure to save the password, as you will need it later.
   1. Click **{{ ui-key.yacloud.common.add }}**.

- CLI {#cli}
  
    {% include [cli-install](../../../_includes/cli-install.md) %}

    To add a password: 
    1. Get a list of registries in the folder: 
    
        ```
        yc iot registry list
		```
		
		Result:
		```
        +----------------------+-------------------+
        |          ID          |       NAME        |
        +----------------------+-------------------+
        | arenou2oj4ct******** | my-registry       |
        +----------------------+-------------------+
        ```    
    1. Add a password to the registry:
    
        ```
        yc iot registry password add --registry-name my-registry --password Passw0rdForRegistry
        ```
		
		Result:
		```
		registry_id: arenou2oj4ct********
        id: areuu2hgsv6k********
        created_at: "2019-12-16T15:32:46.655139Z"
        ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}
  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To add a password to a registry created with {{ TF }}:

  1. In the configuration file, specify the properties of the resources you want to create:

     * `yandex_iot_core_registry`: Registry settings:
       * `name`: Registry name.
       * `description`: Registry description.
       * `passwords`: List of registry passwords for [username and password](../../concepts/authorization.md#log-pass) authentication.

      Here is an example of a resource structure in the configuration file:

      ```hcl
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
      ...
        passwords = [
          "<password_1>",
          "<password_2>"
        ]
      ...
      }
      ```

      For more information about `yandex_iot_core_registry` properties in {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/iot_core_registry).
  1. In the terminal, navigate to the directory where you edited the configuration file.
  1. Make sure the configuration file is correct using this command:

      ```bash
      terraform validate
      ```
     
      If the configuration is valid, you will get this message:
     
      ```bash
      Success! The configuration is valid.
      ```

  1. Run this command:

      ```bash
      terraform plan
      ```
  
      You will see a list of resources and their properties. No changes will be made at this step. {{ TF }} will show any errors detected in the configuration.
  1. Apply the configuration changes:

      ```bash
      terraform apply
      ```
     
  1. Type `yes` and press **Enter** to confirm the changes.

      You can check registry passwords using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot registry password list --registry-name <registry_name>
      ```

- API {#api}

  To add a password to a registry, use the [addPassword](../../api-ref/Registry/addPassword.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/AddPassword](../../api-ref/grpc/Registry/addPassword.md) gRPC API call.

{% endlist %}

### Setting a password for a registry when creating it {#create}

{% list tabs group=instructions %}

- Management console {#console}

   For information on how to set a password for a registry when creating it, see [{#T}](../registry/registry-create.md).

- CLI {#cli}
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    Create a registry with a password:       
    
    ```
    yc iot registry create --name registry-with-pass --password Passw0rdForDevice
    ```
	
	Result:
	```
	done (1s)
    id: areg96c8loru********
    folder_id: b1g88tflru0e********
    created_at: "2019-12-16T15:34:25.563Z"
    name: registry-with-pass
    status: ACTIVE
    log_group_id: ckghhil3b5o9********
    ```

- {{ TF }} {#tf}

   For information on how to set a password for a registry when creating it, see [{#T}](../registry/registry-create.md).

- API {#api}

  To set a password for a registry when creating it, use the [create](../../api-ref/Registry/create.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/Create](../../api-ref/grpc/Registry/create.md) gRPC API call.

{% endlist %}

## Getting a list of registry passwords {#list}

{% list tabs group=instructions %}

- Management console {#console}

   To view a list of registry passwords:

   1. In the [management console]({{ link-console-main }}), select the folder where you want to get a list of registry passwords.
   1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Select the registry from the list.
   1. On the **{{ ui-key.yacloud.common.overview }}** page, go to the **{{ ui-key.yacloud.iot.label_passwords }}** section.

- CLI {#cli}
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    To get a list of passwords:  
    1. Get a list of registries in the folder: 
    
        ```
        yc iot registry list
		```
		
		Result:
		```
        +----------------------+--------------------+
        |          ID          |        NAME        |
        +----------------------+--------------------+
        | areg96c8loru******** | registry-with-pass |
        | arenou2oj4ct******** | my-registry        |
        +----------------------+--------------------+
        ```
    1. Get a list of registry passwords: 
    
        ```
        yc iot registry password list --registry-name registry-with-pass
        ```
		
		Result:
		```
		+----------------------+---------------------+
        |          ID          |     CREATED AT      |
        +----------------------+---------------------+
        | are0gffs957e******** | 2019-12-16 15:34:25 |
        +----------------------+---------------------+
        ```

- API {#api}

  To get a list of registry passwords, use the [listPasswords](../../api-ref/Registry/listPasswords.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/ListPasswords](../../api-ref/grpc/Registry/listPasswords.md) gRPC API call.

{% endlist %}
   
## Deleting a registry password {#delete}

{% list tabs group=instructions %}

- Management console {#console}

   To delete a registry password:

   1. In the [management console]({{ link-console-main }}), select the folder where you want to delete a registry password.
   1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Select the registry from the list.
   1. In the row with the password, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}** from the drop-down list.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    To delete a password:  
    1. Get a list of registry passwords: 
    
        ```
        yc iot registry password list --registry-name registry-with-pass
        ```
		
		Result:
		```
		+----------------------+---------------------+
        |          ID          |     CREATED AT      |
        +----------------------+---------------------+
        | are0gffs957e******** | 2019-12-16 15:34:25 |
        +----------------------+---------------------+
        ```
    1. Delete the password: 
    
        ```
        yc iot registry password delete --registry-name registry-with-pass --password-id are0gffs957e********
        ```
    1. Make sure the password has been deleted: 
        
        ```
        yc iot registry password list --registry-name registry-with-pass
        ```
		
		Result:
		```
		+----+------------+
        | ID | CREATED AT |
        +----+------------+
        +----+------------+
        ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}
  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To delete the password of a registry created with {{ TF }}:

  1. Open the {{ TF }} configuration file and delete the password value from the `passwords` section in the registry description. To remove all passwords, delete the entire `passwords` section.

      Here is an example of a registry description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_iot_core_registry" "my_registry" {
        name        = "test-registry"
        description = "test registry for terraform provider documentation"
      ...
        passwords = [
          "<password_1>",
          "<password_2>"
        ]
      ...
      }
      ```

      For more information about `yandex_iot_core_registry` properties in {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/iot_core_registry).
  1. In the terminal, navigate to the directory where you edited the configuration file.
  1. Make sure the configuration file is correct using this command:

      ```bash
      terraform validate
      ```
     
      If the configuration is valid, you will get this message:
     
      ```bash
      Success! The configuration is valid.
      ```

  1. Run this command:

      ```bash
      terraform plan
      ```
  
      You will see a list of resources and their properties. No changes will be made at this step. {{ TF }} will show any errors detected in the configuration.
  1. Apply the configuration changes:

      ```bash
      terraform apply
      ```
     
  1. Type `yes` and press **Enter** to confirm the changes.

      You can check registry passwords using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iot registry password list --registry-name <registry_name>
      ```

- API {#api}

  To delete a registry password, use the [deletePassword](../../api-ref/Registry/deletePassword.md) REST API method for the [Registry](../../api-ref/Registry/index.md) resource or the [RegistryService/DeletePassword](../../api-ref/grpc/Registry/deletePassword.md) gRPC API call.

{% endlist %}       