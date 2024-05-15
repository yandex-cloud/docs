---
title: "How to manage secret versions in {{ lockbox-full-name }}"
description: "Follow this guide to manage secret versions."
---

# Managing secret versions


Secret version control enables you to:

* [Create a new version](#create-version).
* [Get information about a version](#get-version).
* [Create a version based on another version](#create-version-based-on-other).
* [Roll back to a version](#backup).
* [Schedule version deletion](#set-deleting-time).

## Creating a new version {#create-version}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
   1. Click the name of the secret you need.
   1. Under **{{ ui-key.yacloud.lockbox.label_secret-versions-section }}**, click **{{ ui-key.yacloud.lockbox.button_add-version }}**.
   1. Add the following parameters:
      * (Optional) **{{ ui-key.yacloud.common.description }}**: Version description.
      * **{{ ui-key.yacloud.lockbox.forms.label_key }}**: Non-secret name that identifies a value.
      * **{{ ui-key.yacloud.lockbox.forms.label_value }}**: Explicitly represented secret data.
         You can create multiple key-value pairs per version.
   1. Click **{{ ui-key.yacloud.lockbox.button_add-version }}**.

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. In the configuration file, describe the parameters of the resources you want to create:

      
      ```
      terraform {
        required_providers {
          yandex = {
            source = "yandex-cloud/yandex"
          }
        }
        required_version = ">= 0.13"
      }
      provider "yandex" {
        zone = "{{ region-id }}-a"
      }

      resource "yandex_lockbox_secret_version" "my_version" {
        secret_id = "<secret_ID>"
        entries {
          key        = "<secret_1_key>"
          text_value = "<secret_1_value>"
        }
        entries {
          key        = "<secret_2_key>"
          text_value = "secret_2_value>"
        }
      }
      ```



      Where:

      * `secret_id`: ID of the secret you are creating a version for. This is a required parameter.
      * `entries`: Section with secret parameters. For each secret, create a separate `entries` section. It may contain the following parameters:
         * `key`: Secret key, which is a non-secret name that identifies a value. This is a required parameter.
         * `text_value`: Explicitly represented secret data. This is a required parameter.

      You can learn more about the parameters of the `yandex_lockbox_secret_version` resource in Terraform in the [provider documentation]({{ tf-provider-resources-link }}/lockbox_secret_version).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

   This creates a new version of the specified secret. You can check the new version and its configuration using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

   ```bash
   yc lockbox secret list-versions <secret_ID>
   ```

- API {#api}

   To create a new secret version, use the [addVersion](../api-ref/Secret/addVersion.md) REST API method for the [Secret](../api-ref/Secret/index.md) resource or the [SecretService/AddVersion](../api-ref/grpc/secret_service.md#AddVersion) gRPC API call.

{% endlist %}

## Getting information about a version {#get-version}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
   1. Click the name of the secret you need.
   1. Under **{{ ui-key.yacloud.lockbox.label_secret-versions-section }}**, you will see a list of all secret versions with information about them.
   1. Click a version to see the details about its key-value pairs.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View the description of the CLI command to view secret versions:

      ```bash
      yc lockbox secret list-version --help
      ```

   1. Run this command:

      ```bash
      yc lockbox secret list-version <secret_name>
      ```

   It will return information about all versions of the secret, key names included. Secret version values will not be displayed.

- API {#api}

   To get information about a version, use the [listVersions](../api-ref/Secret/listVersions.md) REST API method for the [Secret](../api-ref/Secret/index.md) resource or the [SecretService/ListVersions](../api-ref/grpc/secret_service.md#ListVersions) gRPC API call.

{% endlist %}

## Creating a version based on another version {#create-version-based-on-other}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
   1. Click the name of the secret you need.
   1. Under **{{ ui-key.yacloud.lockbox.label_secret-versions-section }}**, click ![image](../../_assets/console-icons/ellipsis.svg) next to the appropriate version.
   1. Select **{{ ui-key.yacloud.lockbox.button_action-open-version-add-dialog }}**.
   1. Edit or add the following parameters:
      * (Optional) **{{ ui-key.yacloud.common.description }}**: Version description.
      * **{{ ui-key.yacloud.lockbox.forms.label_key }}**: Non-secret name that identifies a value.
      * **{{ ui-key.yacloud.lockbox.forms.label_value }}**: Explicitly represented secret data.
         You can create multiple key-value pairs per version.
   1. Click **{{ ui-key.yacloud.lockbox.button_add-version }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View the description of the CLI command to create a new secret version:

      ```bash
      yc lockbox secret add-version --help
      ```

   1. Run this command:

      ```bash
      yc lockbox secret add-version <secret_name> \
        --description <secret_version_description> \
        --payload "<array_with_secret_version_contents>" \
        --base-version-id <ID_of_existing_secret_version>
      ```

      Where:
      * `<secret_name>`: Name of the secret to create a version for.
      * `--description`: Description of the new secret version (optional).
      * `--payload`: Contents of the new secret version as a YAML or JSON array.
      * `--base-version-id`: ID of the secret version used to create a new secret. If this parameter is not specified, the new version will be created based on the current version.

      Result:

      ```bash
      id: e6qor8pe3ju7********
      secret_id: e6qkkp3k29jf********
      created_at: "2024-04-25T13:49:26.621Z"
      status: ACTIVE
      payload_entry_keys:
        - secret-key1
        - secret-key2
      ```

- API {#api}

   To create a version based on another version, use the [addVersion](../api-ref/Secret/addVersion.md) REST API method for the [Secret](../api-ref/Secret/index.md) resource or the [SecretService/AddVersion](../api-ref/grpc/secret_service.md#AddVersion) gRPC API call.

{% endlist %}

## Changing the current version {#backup}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
   1. Click the name of the secret you need.
   1. Under **{{ ui-key.yacloud.lockbox.label_secret-versions-section }}**, click ![image](../../_assets/console-icons/ellipsis.svg) next to the appropriate version.
   1. Select **{{ ui-key.yacloud.lockbox.field_make-version-current }}**.
   1. Click **{{ ui-key.yacloud.lockbox.button_action-make-version-current }}**.

- API {#api}

   To change the current version, use the [addVersion](../api-ref/Secret/addVersion.md) REST API method for the [Secret](../api-ref/Secret/index.md) resource or the [SecretService/AddVersion](../api-ref/grpc/secret_service.md#AddVersion) gRPC API call and specify the required version.

{% endlist %}

## Scheduling version destruction {#set-deleting-time}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
   1. Click the name of the secret you need.
   1. Under **{{ ui-key.yacloud.lockbox.label_secret-versions-section }}**, click ![image](../../_assets/console-icons/ellipsis.svg) next to the appropriate version.
   1. Select **{{ ui-key.yacloud.lockbox.button_action-schedule-for-destruction }}**.
   1. Enter the destruction pending period.
   1. Click **{{ ui-key.yacloud.lockbox.forms.button_schedule-destruction }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to schedule version destruction:

      ```bash
      yc lockbox secret schedule-version-destruction --help
      ```
   1. Schedule a version for destruction by specifying the secret name, version ID, and the destruction pending period. For example, 1 week: `168h`:

      ```bash
      yc lockbox secret schedule-version-destruction <secret_name> \
        --version-id <version_ID> \
        --pending-period 168h
      ```
      Result:

      ```bash
      id: e6qor8pe3ju7********
      secret_id: e6qkkp3k29jf********
      created_at: "2023-11-08T13:14:34.676Z"
      destroy_at: "2023-11-15T17:06:28.795Z"
      status: SCHEDULED_FOR_DESTRUCTION
      payload_entry_keys:
        - secret-key
      ```

- API {#api}

   To schedule a version deletion, use the [scheduleVersionDestruction](../api-ref/Secret/addVersion.md) REST API method for the [Secret](../api-ref/Secret/index.md) resource or the [SecretService/ScheduleVersionDestruction](../api-ref/grpc/secret_service.md#ScheduleVersionDestruction) gRPC API call.

{% endlist %}

## See also {#see-also}

* [{#T}](../concepts/secret.md)
