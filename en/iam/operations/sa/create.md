# Creating a service account

Create a [service account](../../concepts/users/service-accounts.md) to manage resources under a different account.

You must have the `{{ roles-iam-sa-admin }}` [role](../../../iam/security/#iam-serviceAccounts-admin) or higher for the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to create a service account.

{% note info %}

A service account is created inside a [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder). Once a service account has been created, you cannot change the folder.

{% include [sa-binding-roles](../../../_includes/iam/sa-binding-roles.md) %}

{% endnote %}

## Create a service account {#create-sa}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [create-sa-via-console-without-role](../../../_includes/iam/create-sa-via-console-without-role.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Check the description of the command for creating a service account:

      ```bash
      yc iam service-account create --help
      ```

  1. Create a service account named `my-robot`:

      ```bash
      yc iam service-account create --name my-robot
      ```

      The name should match the following format:

      {% include [name-format](../../../_includes/name-format.md) %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the configuration file, define the parameters of the resources you want to create:
    
     ```hcl
     resource "yandex_iam_service_account" "sa" {
       name        = "<service_account_name>"
       description = "<service_account_description>"
       folder_id   = "<folder_ID>"
     }
     ```

     * `name`: Service account name. This is a required parameter.
     * `description`: Service account description. This is an optional parameter.
     * `folder_id`: [Folder ID](../../../resource-manager/operations/folder/get-id.md). This is an optional parameter. By default, the value specified in the provider settings is used.

     For more information about the `yandex_iam_service_account` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/iam_service_account).
    
  1. Make sure the configuration files are correct.

     1. In the command line, go to the directory where you created the configuration file.
     1. Run a check using this command:

        ```bash
        terraform plan
        ```

     If the configuration is specified correctly, the terminal will display information about the service account. If there are errors in the configuration, Terraform will point them out. 

  1. Deploy the cloud resources.

     1. If the configuration does not contain any errors, run this command:

        ```bash
        terraform apply
        ```

     1. Confirm creating the service account: type `yes` in the terminal and press **Enter**.

        The service account will then be created. You can check the new service account using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:
        
        ```bash
        yc iam service-account list
        ```

- API {#api}

  To create a service account, use the [create](../../api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../api-ref/grpc/ServiceAccount/create.md) gRPC API call.

{% endlist %}


## Examples {#examples}

### Add a description when creating a service account {#add-description}

Create a service account with the following name and description:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc iam service-account create --name my-robot \
    --description "this is my favorite service account"
  ```

- {{ TF }} {#tf}

  ```hcl
   resource "yandex_iam_service_account" "sa" {
     name        = "my-robot"
     description = "this is my favorite service account"
   }
  ```

- API {#api}

  ```bash
  curl \
    --request POST \
    --header 'Content-Type: application/json' \
    --header "Authorization: Bearer <IAM_token>" \
    --data '{
      "folderId": "b1gvmob95yys********",
      "name": "my-robot",
      "description": "this is my favorite service account"
    }' \
    https://iam.{{ api-host }}/iam/v1/serviceAccounts
  ```

{% endlist %}

#### See also {#see-also}

* [{#T}](assign-role-for-sa.md).
* [{#T}](set-access-bindings.md).
* [{#T}](../../concepts/users/service-accounts.md#sa-key).
