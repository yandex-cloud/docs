---
title: How to manage static access keys in {{ iam-full-name }}
description: In this tutorial, you will learn how to create and delete static access keys in {{ iam-full-name }} via the management console, CLI, and API.
---

# Managing static access keys

[Some {{ yandex-cloud }} services](../../concepts/authorization/access-key.md#supported-services) support authentication with [static access keys](../../concepts/authorization/access-key.md).

Static access keys are created for [service accounts](../../concepts/users/service-accounts.md). If you do not have a service account yet, [create one](../sa/create.md) and [assign roles to it](../sa/assign-role-for-sa.md).

## Creating a static access key {#create-access-key}

To create a service account static access key:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder the service account belongs to.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. Select the service account to create a static access key for.
  1. In the top panel, click ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
  1. Specify the key description and click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Save the ID and secret key.

      {% note alert %}

      After you close this dialog, the key value will not be shown again.

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

  1. Save the ID (`key_id`) and secret key (`secret`). You will not be able to get the key again.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the configuration file, define the parameters of the resources you want to create:

      ```hcl
      resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
        service_account_id = "<service_account_ID>"
        description        = "<key_description>"
        pgp_key            = "keybase:keybaseusername"
        output_to_lockbox  {
          secret_id             = "<Lockbox_secret_ID>"
          entry_for_access_key  = "<secret’s_key_for_static_key_ID>"
          entry_for_secret_key  = "<secret’s_key_for_secret_key>"
        }
      }
     ```

     Where:

     * `service_account_id`: This is a required parameter.
     * `description`: Key description. This is an optional parameter.
     * `pgp_key`: Additional PGP key for encrypting a private key. This is an optional parameter. Specify the public part of the key in Base64 encoding or in `keybase:keybaseusername` format.

     * `output_to_lockbox`: Description of the {{ lockbox-full-name }} [secret](../../../lockbox/concepts/secret.md) to save the secret key values in to prevent their possible leakage through the `terraform.tfstate` file. This is an optional parameter. Nested parameters:
         * `secret_id`: ID of the {{ lockbox-full-name }} secret to store the key ID and secret key in. The secret must be [custom](../../../lockbox/concepts/secret.md#secret-type).
         * `entry_for_access_key`: Secret key to assign to the static access key ID value you are saving.
         * `entry_for_secret_key`: Secret key to assign to the secret key value you are saving.

     For more information about the `yandex_iam_service_account_static_access_key` parameters in {{ TF }}, see the [relevant {{ TF }} article]({{ tf-provider-resources-link }}/iam_service_account_static_access_key).
         
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

     1. Confirm creating the static access key: type `yes` in the terminal and press **Enter**.

        If any errors occur when creating the key, {{ TF }} will indicate them.
        If the key is successfully created, {{ TF }} will write it into its configuration, but will not show it to the user. The terminal will display only the ID of the created key.

        You can check the new service account key in the [management console]({{ link-console-main }}) or using the [CLI](../../../cli/quickstart.md) command:
         
        ```bash
        yc iam access-key list --service-account-name=<service_account_name>
        ```

- API {#api}

  Use the [create](../../awscompatibility/api-ref/AccessKey/create.md) REST API method for the [AccessKey](../../awscompatibility/api-ref/AccessKey/index.md) resource or the [AccessKeyService/Create](../../awscompatibility/api-ref/grpc/AccessKey/create.md) gRPC API call.

{% endlist %}

### Examples {#examples}

#### Add a description when creating a service account {#add-description}

Add a description when creating an access key.

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc iam access-key create \
    --service-account-name my-robot \
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
  curl \
    --request POST \
    --header 'Content-Type: application/json' \
    --header "Authorization: Bearer <IAM_token>" \
    --data '{
        "serviceAccountId": "<service_account_ID>",
        "description": "this key is for my bucket"
    }' \
    https://iam.{{ api-host }}/iam/aws-compatibility/v1/accessKeys
  ```

{% endlist %}

## Deleting a static access key {#delete-access-key}

To delete a service account static access key:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder the service account belongs to.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}** and select the service account.
  1. Under **{{ ui-key.yacloud.iam.folder.service-account.overview.section_service-account-keys }}**, click ![image](../../../_assets/console-icons/ellipsis.svg) in the row with the key to delete, and select **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-confirm_button_delete }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Get a list of static access keys of the service account by specifying its name:

     ```bash
     yc iam access-key list \
       --service-account-name <service_account_name>
     ```

     Result:

     ```text
     +----------------------+----------------------+----------------------+
     |          ID          |  SERVICE ACCOUNT ID  |        KEY ID        |
     +----------------------+----------------------+----------------------+
     | aje8bdtqec6l******** | ajeedllrkjma******** | R9JK04o1Dfaf******** |
     | ajegqpa91bta******** | ajeedllrkjma******** | cWXGkDoBRho5******** |
     +----------------------+----------------------+----------------------+
     ```

  1. Delete the static access key by specifying its ID:

     ```bash
     yc iam access-key delete <key_ID>
     ```

- {{ TF }} {#tf}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}

    1. Open the {{ TF }} configuration file and delete the section with the static access key description.

        Example of a static access key description in the {{ TF }} configuration:

        ```hcl
        resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
          service_account_id = "<service_account_ID>"
          description        = "<key_description>"
          pgp_key            = "keybase:keybaseusername"
          output_to_lockbox  {
            secret_id             = "<Lockbox_secret_ID>"
            entry_for_access_key  = "<secret’s_key_for_static_key_ID>"
            entry_for_secret_key  = "<secret’s_key_for_secret_key>"
          }
        }
        ```

        For more information about the resources you can create with {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/iam_service_account_static_access_key).

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
        yc iam access-key list --service-account-id <service_account_ID>
        ```

- API {#api}

  Use the [delete](../../awscompatibility/api-ref/AccessKey/delete.md) REST API method for the [AccessKey](../../awscompatibility/api-ref/AccessKey/index.md) REST API resource or the [AccessKeyService/Delete](../../awscompatibility/api-ref/grpc/AccessKey/delete.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/authorization/access-key.md)
* [Configuring tools to work with {{ objstorage-name }}](../../../storage/tools/index.md)
* [{#T}](../sa/assign-role-for-sa.md)
* [{#T}](../../tutorials/static-key-in-lockbox/index.md)