---
title: How to manage authorized keys in {{ iam-full-name }}
description: In this tutorial, you will learn how to create and delete authorized keys in {{ iam-full-name }} via the management console, CLI, and API.
---

# Managing authorized keys

[An authorized key](../../concepts/authorization/key.md) is a key with an unlimited TTL, used to [obtain](../iam-token/create-for-sa.md#via-cli) a service account [IAM token](../../concepts/authorization/iam-token.md): the private part of the authorized key is used to generate a [JSON Web Token](https://tools.ietf.org/html/rfc7519) (JWT), which is then exchanged for an [IAM token](../../concepts/authorization/iam-token.md).

Authorized keys are created for [service accounts](../../concepts/users/service-accounts.md). If you do not have a service account yet, [create one](../sa/create.md) and [assign roles to it](../sa/assign-role-for-sa.md).

## Creating an authorized key {#create-authorized-key}

To create a service account authorized key:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the service account belongs to.
   1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. In the left-hand panel, select ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
   1. In the list that opens, select the service account to create an authorized key for.
   1. In the top panel, click ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_key }}**.
   1. Select the encryption algorithm; if required, specify the key description and click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**. In the window that opens:
       1. Copy and save both the public and private parts of the key in a secure location. The private part of the key is not stored in {{ yandex-cloud }} and you will not be able to get it again. You will not be able to view the public part of the key in the management console.

           You can also download your keys in a single JSON file. To do this, click **{{ ui-key.yacloud.iam.folder.service-account.overview.action_download-keys-file }}**.
       1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_close }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the command for creating an authorized key:

      ```bash
      yc iam key create --help
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

  1. Create an authorized key for the `my-robot` service account:

      ```bash
      yc iam key create \
        --service-account-name my-robot \
        -o my-robot-key.json
      ```

      If successful, the created authorized key will be saved to the `my-robot-key.json` file.

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

      Copy both the public and private parts of the key (`public_key` and `private_key` values) and save them in a secure location. The private part of the key is not stored in {{ yandex-cloud }} and you will not be able to get it again.

- {{ TF }} {#tf}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}

    1. In the configuration file, define the parameters of the resources you want to create:

       ```
       resource "yandex_iam_service_account_key" "sa-auth-key" {
         service_account_id = "<service_account_ID>"
         description        = "<key_description>"
         key_algorithm      = "<key_generation_algorithm>"
         pgp_key            = "<PGP_key>"
         output_to_lockbox  {
           secret_id             = "<Lockbox_secret_ID>"
           entry_for_private_key = "<secret_key>"
         }
       }
       ```

       Where:
       * `service_account_id`: Service account [ID](../sa/get-id.md). This is a required parameter.
       * `description`: Key description. This is an optional parameter.
       * `key_algorithm`: Key generation algorithm. This is an optional parameter. The default algorithm is `RSA_2048`. For more information about the acceptable parameter values, see the [API documentation](../../api-ref/Key/index.md).
       * `pgp_key`: Additional PGP key for encrypting a private key. This is an optional parameter. Specify the public part of the key in Base64 encoding or in `keybase:keybaseusername` format.
       * `output_to_lockbox`: Description of the {{ lockbox-full-name }} [secret](../../../lockbox/concepts/secret.md) to save the secret key value in to prevent its possible leakage through the `terraform.tfstate` file. This is an optional parameter. Nested parameters:
           * `secret_id`: ID of the {{ lockbox-full-name }} secret to save the private part of the authorized key value to. The secret must be [custom](../../../lockbox/concepts/secret.md#secret-type).
           * `entry_for_secret_key`: Secret key to assign to the private part of the authorized key value you are saving.

       To learn more about the resources you can create with {{ TF }}, see the [{{ TF }} documentation]({{ tf-provider-resources-link }}/iam_service_account_key).

    1. Make sure the configuration files are correct.

       1. In the command line, go to the directory where you created the configuration file.
       1. Run a check using this command:

          ```
          terraform plan
          ```

       If you described the configuration correctly, the terminal will display a list of the resources being created and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

    1. Deploy the cloud resources.

       1. If the configuration does not contain any errors, run this command:

          ```
          terraform apply
          ```

       1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

       This will create all the resources you need in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}) and this CLI command:

       ```
       yc iam key list --service-account-id <service_account_ID>
       ```

- API {#api}

  Use the [create](../../api-ref/Key/create.md) REST API method for the [Key](../../api-ref/Key/index.md) resource or the [KeyService/Create](../../api-ref/grpc/Key/create.md) gRPC API call.

  Request example with cURL for the `create` REST API method:

  ```bash
  curl \
    --request POST \
    --header 'Content-Type: application/json' \
    --header "Authorization: Bearer <IAM_token>" \
    --data '{"serviceAccountId": "<service_account_ID>"}' \
    https://iam.{{ api-host }}/iam/v1/keys
  ```

  Where:

  * `<IAM_token>`: IAM token of the user with permissions to create keys for the specified service account.
  * `<service_account_id>`: [ID](../sa/get-id.md) of the service account the keys are created for.

  If successful, the server response will include both the public (`publicKey`) and private (`privateKey`) parts of the authorized key. Save this data. You will not be able to get the private key value again.

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

## Deleting an authorized key {#delete-authorized-key}

To delete a service account authorized key:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the service account belongs to.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}** and select the required service account.
  1. Under **{{ ui-key.yacloud.iam.folder.service-account.overview.section_keys }}**, click ![image](../../../_assets/console-icons/ellipsis.svg) in the row with the key to delete, and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_action-delete }}**.
  1. In the window that opens, confirm the deletion.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Get a list of authorized keys for a service account by entering its name:

     ```bash
     yc iam key list \
       --service-account-name <service_account_name>
     ```

     Result:

     ```text
     +----------------------+-------------------------------------+-----------+---------------------+
     |          ID          |               SUBJECT               | ALGORITHM |     CREATED AT      |
     +----------------------+-------------------------------------+-----------+---------------------+
     | ajeave7oktut******** | serviceAccount:ajeedllrkjma******** | RSA_2048  | 2022-03-13 20:14:22 |
     | ajeb794igb80******** | serviceAccount:ajeedllrkjma******** | RSA_2048  | 2022-03-13 20:06:13 |
     +----------------------+-------------------------------------+-----------+---------------------+
     ```

  1. Delete the authorized key by specifying its ID:

     ```bash
     yc iam key delete <key_ID>
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and delete the section with the authorized key description.

      Example authorized key description in the {{ TF }} configuration:

      ```
      resource "yandex_iam_service_account_key" "sa-auth-key" {
        service_account_id = "<service_account_ID>"
        description        = "<key_description>"
        key_algorithm      = "<key_generation_algorithm>"
        pgp_key            = "<PGP_key>"
        output_to_lockbox  {
          secret_id             = "<Lockbox_secret_ID>"
          entry_for_private_key = "<secret_key>"
        }
      }
      ```

      For more information about the resources you can create with {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/iam_service_account_key).

  1. Make sure the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

          ```bash
          terraform plan
          ```

      If you described the configuration correctly, the terminal will display a list of the resources being created and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

  1. Deploy the cloud resources.

      1. If the configuration does not contain any errors, run this command:

          ```bash
          terraform apply
          ```

      1. Confirm creating and deleting the resources by typing `yes` in the terminal and clicking **Enter**.

      This will create or delete all resources you need in the specified folder. You can check the new resources and their settings or make sure the resources were deleted using the [management console]({{ link-console-main }}) and this CLI command:

      ```bash
      yc iam key list --service-account-id <service_account_ID>
      ```

- API {#api}

  Use the [delete](../../api-ref/Key/delete.md) REST API method for the [Key](../../api-ref/Key/index.md) resource or the [KeyService/Delete](../../api-ref/grpc/Key/delete.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/authorization/key.md)
* [{#T}](../iam-token/create-for-sa.md)
