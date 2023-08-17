# Secret version control

Secret version control enables you to:

* [Create a new version](#create-version).
* [Get information about a version](#get-version).
* [Create a version based on another version](#create-version-based-on-other).
* [Roll back to a version](#backup).
* [Schedule version deletion](#set-deleting-time).

## Creating a new version {#create-version}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
   1. In the list of services, select **{{ lockbox-short-name }}**.
   1. Click the name of the secret you need.
   1. Under **Versions**, click **Add version**.
   1. Add the following parameters:
      * (optional) **Description**: Version description.
      * **Key**: Non-secret name that identifies a value.
      * **Value**: Explicitly represented secret data.
         You can create multiple key-value pairs per version.
   1. Click **Add version**.

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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
          key        = "<secret1_key>"
          text_value = "<secret1_value>"
        }
        entries {
          key        = "<secret2_key>"
          text_value = "secret2_value>"
        }
      }
      ```



      Where:

      * `secret_id`: ID of the secret you are creating a version for. This parameter is required.
      * `entries`: Section with secret parameters. For each secret, create a separate `entries` section. It may contain the following parameters:
         * `key`: Secret key, which is a non-secret name that identifies a value. This parameter is required.
         * `text_value`: Explicitly represented secret data. This parameter is required.

      For more information about the parameters of the `yandex_lockbox_secret_version` resource in Terraform, see the [provider documentation]({{ tf-provider-resources-link }}/lockbox_secret_version).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

   This creates a new version of the specified secret. You can verify that the version is there and its configuration is correct using the [management console]({{ link-console-main }}) or the following [CLI](../../cli/quickstart.md) command:

   ```bash
   yc lockbox secret list-versions <secret_ID>
   ```

- API

   To create a new secret version, use the [addVersion](../api-ref/Secret/addVersion.md) REST API method for the [Secret](../api-ref/Secret/index.md) resource or the [SecretService/AddVersion](../api-ref/grpc/secret_service.md#AddVersion) gRPC API call.

{% endlist %}

## Getting information about a version {#get-version}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
   1. In the list of services, select **{{ lockbox-short-name }}**.
   1. Click the name of the secret you need.
   1. Under **Versions**, you will see a list of all secret versions with information about them.
   1. Click a version to see the details about its key-value pairs.

- API

   To get information about a version, use the [listVersions](../api-ref/Secret/listVersions.md) REST API method for the [Secret](../api-ref/Secret/index.md) resource or the [SecretService/ListVersions](../api-ref/grpc/secret_service.md#ListVersions) gRPC API call.

{% endlist %}

## Creating a version based on another version {#create-version-based-on-other}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
   1. In the list of services, select **{{ lockbox-short-name }}**.
   1. Click the name of the secret you need.
   1. Under **Versions**, click ![image](../../_assets/horizontal-ellipsis.svg) next to the appropriate version.
   1. Select **Create a new version based on this one**.
   1. Edit or add the following parameters:
      * (optional) **Description**: Version description.
      * **Key**: Non-secret name that identifies a value.
      * **Value**: Explicitly represented secret data.
         You can create multiple key-value pairs per version.
   1. Click **Add version**.

- API

   To create a version based on another version, use the [addVersion](../api-ref/Secret/addVersion.md) REST API method for the [Secret](../api-ref/Secret/index.md) resource or the [SecretService/AddVersion](../api-ref/grpc/secret_service.md#AddVersion) gRPC API call.

{% endlist %}

## Rolling back to a version {#backup}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
   1. In the list of services, select **{{ lockbox-short-name }}**.
   1. Click the name of the secret you need.
   1. Under **Versions**, click ![image](../../_assets/horizontal-ellipsis.svg) next to the appropriate version.
   1. Select **Roll back to this version**.
   1. Click **Roll back**.

- API

   To roll back to an existing version, use the [addVersion](../api-ref/Secret/addVersion.md) REST API method for the [Secret](../api-ref/Secret/index.md) resource or the [SecretService/AddVersion](../api-ref/grpc/secret_service.md#AddVersion) gRPC API call and specify the required version.

{% endlist %}

## Scheduling version destruction {#set-deleting-time}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
   1. In the list of services, select **{{ lockbox-short-name }}**.
   1. Click the name of the secret you need.
   1. Under **Versions**, click ![image](../../_assets/horizontal-ellipsis.svg) next to the appropriate version.
   1. Select **Schedule destruction**.
   1. Enter the time until destruction.
   1. Click **Schedule**.

- API

   To schedule a version deletion, use the [scheduleVersionDestruction](../api-ref/Secret/addVersion.md) REST API method for the [Secret](../api-ref/Secret/index.md) resource or the [SecretService/ScheduleVersionDestruction](../api-ref/grpc/secret_service.md#ScheduleVersionDestruction) gRPC API call.

{% endlist %}

## See also {#see-also}

* [{#T}](../concepts/secret.md)
