# Creating static access keys

Follow this guide to learn how to create [static access keys](../../concepts/authorization/access-key.md) for a [service account](../../concepts/users/service-accounts.md) when using [services](../../concepts/authorization/access-key.md#supported-services) that support this authorization method.

If you do not have a service account yet, [create one](create.md) and [assign roles to it](assign-role-for-sa.md).

To create a static access key:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the service account belongs to.
   1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
   1. Choose a service account and click the row with its name.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** in the top panel.
   1. Select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
   1. Specify the key description and click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
   1. Save the ID and private key.

      {% note alert %}

      After you close the dialog, the private key value will become unavailable.

      {% endnote %}

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. See the description of the create static access key command:

      ```bash
      yc iam access-key create --help
      ```

   1. Select a service account, e.g., `my-robot`:

      ```bash
      yc iam service-account list
      ```

      Result:

      ```text
      +----------------------+------------------+-------------------------------+
      |          ID          |       NAME       |          DESCRIPTION          |
      +----------------------+------------------+-------------------------------+
      | aje6o61dvog2******** | my-robot         |                               |
      | aje9sda1ufvq******** | account_name     | account_description           |
      +----------------------+------------------+-------------------------------+
      ```
   1. Create an access key for the `my-robot` service account:

      ```bash
      yc iam access-key create --service-account-name my-robot
      ```

      Result:

      ```text
      access_key:
        id: aje6t3vsbj8l********
        service_account_id: ajepg0mjt06s********
        created_at: "2018-11-22T14:37:51Z"
        key_id: 0n8X6WY6S24N********
      secret: JyTRFdqw8t1kh2-OJNz4JX5ZTz9Dj1rI********
      ```

   1. Save the ID (`key_id`) and secret key (`secret`). You will not be able to get the key value again.

- {{ TF }} {#tf}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   1. In the configuration file, describe the parameters of the resources you want to create:

      ```hcl
      resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
       service_account_id = "<service_account_ID>"
       description        = "<key_description>"
       pgp_key            = "keybase:keybaseusername"
       }
      ```

      Where:

      * `service_account_id`: Service account ID. This is a required parameter.
      * `description`: Key description. This is an optional parameter.
      * `pgp_key`: Additional PGP key for encrypting a private key. This is an optional parameter. Specify the public part of the key in Base64 encoding or in the `keybase:keybaseusername` format.

      For more information about the `yandex_iam_service_account_static_access_key` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/iam_service_account_static_access_key).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm the static access key creation by typing `yes` in the terminal and pressing **Enter**.

         If any errors occur when creating the key, {{ TF }} will indicate them.
         If the key is successfully created, {{ TF }} will write it into its configuration, but will not show it to the user. The terminal will display only the ID of the created key.

         You can verify that the key of the service account is there in the [management console]({{ link-console-main }}) or using the [CLI](../../../cli/quickstart.md) command:

         ```bash
         yc iam access-key list --service-account-name=<service_account_name>
         ```

- API {#api}

   To create an access key, use the [create](../../api-ref/AccessKey/create.md) REST API method for the [AccessKey](../../api-ref/AccessKey/index.md) resource or the [AccessKeyService/Create](../../api-ref/grpc/access_key_service.md#Create) gRPC API call.

{% endlist %}

## Examples {#examples}

### Add a description when creating a service account {#add-description}

Add a description when creating an access key.

{% list tabs group=instructions %}

- CLI {#cli}

   ```bash
   yc iam access-key create --service-account-name my-robot \
     --description "this key is for my bucket"
   ```

- {{ TF }} {#tf}

   ```hcl
   resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
   service_account_id = "<service_account_ID>"
   description        = "this key is for my bucket"
   pgp_key            = "BIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA+x....."
   }
   ```

- API {#api}

   ```bash
   curl -X POST \
     -H 'Content-Type: application/json' \
     -H "Authorization: Bearer <IAM_token>" \
     -d '{
         "serviceAccountId": "<service_account_ID>",
         "description": "this key is for my bucket"
     }' \
     https://iam.{{ api-host }}/iam/aws-compatibility/v1/accessKeys
   ```

{% endlist %}

#### What's next {#what-is-next}

* [Configuring tools to work with {{ objstorage-name }}](../../../storage/tools/)
* [{#T}](assign-role-for-sa.md)
