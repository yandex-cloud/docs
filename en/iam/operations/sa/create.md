# Creating a service account

Create a [service account](../../concepts/users/service-accounts.md) to manage resources under a different account.

## Create a service account {#create-sa}

{% list tabs %}

- Management console

   {% include [create-sa-via-console](../../../_includes/iam/create-sa-via-console.md) %}

- CLI

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

      The name format requirements are as follows:

      {% include [name-format](../../../_includes/name-format.md) %}

- API

   To create a service account, use the [create](../../api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../api-ref/grpc/service_account_service.md#Create) gRPC API call.

- {{ TF }}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   1. In the configuration file, describe the parameters of the resources you want to create:

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

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays information about the service account. If there are errors in the configuration, Terraform points them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm creating the service account by typing `yes` in the terminal and pressing **Enter**.

         The service account will then be created. You can check the new service account using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

         ```bash
         yc iam service-account list
         ```

{% endlist %}


## Examples {#examples}

### Add a description when creating {#add-description}

Create a service account with the following name and description:

{% list tabs %}

- CLI

   ```bash
   yc iam service-account create --name my-robot \
     --description "this is my favorite service account"
   ```

- API

   ```bash
   curl -X POST \
       -H 'Content-Type: application/json' \
       -H "Authorization: Bearer <IAM-TOKEN>" \
       -d '{
           "folderId": "b1gvmob95yysaplct532",
           "name": "my-robot",
           "description": "this is my favorite service account"
       }' \
       https://iam.{{ api-host }}/iam/v1/serviceAccounts
   ```

- {{ TF }}

   ```hcl
    resource "yandex_iam_service_account" "sa" {
      name        = "my-robot"
      description = "this is my favorite service account"
    }
   ```

{% endlist %}

#### What's next {#what-is-next}

* [{#T}](assign-role-for-sa.md)
* [{#T}](create-access-key.md)
* [{#T}](set-access-bindings.md)
