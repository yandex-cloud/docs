# Creating static access keys

These are instructions for how to create [static access keys](../../concepts/authorization/access-key.md) for a [service account](../../concepts/users/service-accounts.md).

If you don't have a service account yet, [create one](../sa/create.md) and [assign it roles](../sa/assign-role-for-sa.md).

To create a static access key:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the service account belongs to.
   1. Go to the **Service accounts** tab.
   1. Choose a service account and click the line with its name.
   1. Click **Create new key** in the top panel.
   1. Select **Create static access key**.
   1. Specify the key description and click **Create**.
   1. Save the ID and private key.

      {% note alert %}

      After the dialog is closed, the private key value will be unavailable.

      {% endnote %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. See the description of the create static access key command:

      ```bash
      yc iam access-key create --help
      ```

   1. Select a service account (for example, `my-robot`):

      ```bash
      yc iam service-account list
      ```

      Result:

      ```text
      +----------------------+------------------+-------------------------------+
      |          ID          |       NAME       |          DESCRIPTION          |
      +----------------------+------------------+-------------------------------+
      | aje6o61dvog2h6g9a33s | my-robot         |                               |
      | aje9sda1ufvqcmfksd3f | blabla           | bla bla bla is my description |
      +----------------------+------------------+-------------------------------+
      ```
   1. Create an access key for the `my-robot` service account:

      ```bash
      yc iam access-key create --service-account-name my-robot
      ```

      Result:

      ```text
      access_key:
        id: aje6t3vsbj8lp9r4vk2u
        service_account_id: ajepg0mjt06siuj65usm
        created_at: "2018-11-22T14:37:51Z"
        key_id: 0n8X6WY6S24N7OjXQ0YQ
      secret: JyTRFdqw8t1kh2-OJNz4JX5ZTz9Dj1rI9hxtzMP1
      ```

   1. Save the ID `key_id` and `secret` key. You will not be able to get the key value again.

- API

   To create an access key, use the [create](../../api-ref/AccessKey/create.md) REST API method for the [AccessKey](../../api-ref/AccessKey/index.md) resource or the [AccessKeyService/Create](../../api-ref/grpc/access_key_service.md#Create) gRPC API call.

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the parameters of the resources you want to create:

      ```hcl
      resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
       service_account_id = "<service_account_ID>"
       description        = "<key_description>"
       pgp_key            = "keybase:keybaseusername"
       }
      ```

      Where:

      * `service_account_id` = service account ID. This parameter is required.
      * `description`: Key description. This is an optional parameter.
      * `pgp_key`: An additional PGP key for encrypting a private key. This is an optional parameter. Specify the public part of the key in base64 encoding or in the `keybase:keybaseusername` format.

      For more information about the `yandex_iam_service_account_static_access_key` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/iam_service_account_static_access_key).

   1. Make sure that the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

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

{% endlist %}

## Examples {#examples}

### Add a description when creating {#add-description}

Add a description when creating an access key.

{% list tabs %}

- CLI

   ```bash
   yc iam access-key create --service-account-name my-robot \
     --description "this key is for my bucket"
   ```

- API

   ```bash
   curl -X POST \
     -H 'Content-Type: application/json' \
     -H "Authorization: Bearer <IAM-TOKEN>" \
     -d '{
         "serviceAccountId": "aje6o61dvog2h6g9a33s",
         "description": "this key is for my bucket"
     }' \
     https://iam.{{ api-host }}/iam/aws-compatibility/v1/accessKeys
   ```

- {{ TF }}

   ```hcl
   resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
   service_account_id = "aje6o61dvog2h6g9a33s"
   description        = "this key is for my bucket"
   pgp_key            = "BIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA+x....."
   }
   ```

{% endlist %}

#### What's next {#what-is-next}

* [Configuring tools to work with {{ objstorage-name }}](../../../storage/tools/)
* [{#T}](assign-role-for-sa.md).
