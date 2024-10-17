---
title: How to create authorized keys in {{ iam-full-name }}
description: Follow this guide to create authorized keys.
---

# Creating authorized keys

To create an [authorized key](../../concepts/authorization/key.md):

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the service account belongs to.
   1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
   1. Choose a service account and click the row with its name.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** in the top panel.
   1. Select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_key }}**.
   1. Select the encryption algorithm.
   1. Specify the key description and click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
   1. In the window that opens:
      * Copy your public and private keys and save them securely. The private key is not saved in {{ yandex-cloud }}, and the public key is not shown in the management console.
      * Click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_close }}**.

         You can also download your keys in a single JSON file. To do this, click **{{ ui-key.yacloud.iam.folder.service-account.overview.action_download-keys-file }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   Create an authorized key for the `my-robot` service account:

   ```bash
   yc iam key create --service-account-name my-robot -o my-robot-key.json
   ```

   If successful, a private key (`privateKey`) and public key ID (`id`) are written to the `my-robot-key.json` file.

   Key file example:

   ```json
   {
      "id": "lfkoe35hsk58********",
      "service_account_id": "ajepg0mjt06s********",
      "created_at": "2019-03-20T10:04:56Z",
      "key_algorithm": "RSA_2048",
      "public_key": "-----BEGIN PUBLIC KEY-----\n...\n-----END PUBLIC KEY-----\n",
      "private_key": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
   }
   ```

- {{ TF }} {#tf}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   1. In the configuration file, describe the parameters of the resources you want to create:

      * `service_account_id`: Service account [ID](../sa/get-id.md). This is a required parameter.
      * `description`: Key description. This is an optional parameter.
      * `key_algorithm`: Key generation algorithm. This is an optional parameter. The default algorithm is `RSA_2048`. For more information about the acceptable parameter values, see the [API documentation](../../api-ref/Key/index.md).
      * `pgp_key`: Additional PGP key for encrypting a private key. This is an optional parameter. Specify the public part of the key in Base64 encoding or in the `keybase:keybaseusername` format.

      Here is an example of the configuration file structure:

      ```
      resource "yandex_iam_service_account_key" "sa-auth-key" {
        service_account_id = "<service_account_ID>"
        description        = "<key_description>"
        key_algorithm      = "<key_generation_algorithm>"
        pgp_key            = "<pgp_key>"
      }
      ```

      For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/iam_service_account_key).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```
         terraform apply
         ```

      1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

      All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) and this CLI command:

      ```
      yc iam key list --service-account-id <service_account_ID>
      ```

- API {#api}

   To create an access key, use the [create](../../api-ref/Key/create.md) REST API method for the [Key](../../api-ref/Key/index.md) resource or the [KeyService/Create](../../api-ref/grpc/Key/create.md) gRPC API call.

   Sample request using cURL for the `create` REST API method:

   ```bash
   curl -X POST \
     -H 'Content-Type: application/json' \
     -H "Authorization: Bearer <IAM_token>" \
     -d '{"serviceAccountId": "<service_account_ID>"}' \
     https://iam.{{ api-host }}/iam/v1/keys
   ```

   Where:

   * `<IAM_token>`: IAM token of the user with permissions to create keys for the specified service account.
   * `<service_account_ID>`: `ID` of the service account for which the keys are created.

   If successful, the server response will contain the private key (`privateKey`) and public key ID (`id`). Save this data. You will not be able to get the key value again.

   Sample server response:

   ```json
   {
       "key": {
           "createdAt": "2018-10-30T15:55:00+00:00",
           "description": "",
           "id": "lfkoe35hsk58********",
           "keyAlgorithm": "RSA_2048",
           "publicKey": "-----BEGIN PUBLIC KEY-----\n...\n-----END PUBLIC KEY-----\n",
           "serviceAccountId": "ajepg0mjt06s********"
       },
       "privateKey": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
   }
   ```

{% endlist %}

#### What's next {#what-is-next}

* [Get an IAM token for the service account](../iam-token/create-for-sa.md).
