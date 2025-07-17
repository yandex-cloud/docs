---
title: How to manage secret versions in {{ lockbox-full-name }}
description: Follow this guide to manage secret versions.
---

# Secret version management


With secret version management, you can:

* [Create a new user secret version](#create-version).
* [Create a new generated secret version](#create-generated-version).
* [Get information about a version](#get-version).
* [Create a version based on an existing version](#create-version-based-on-other).
* [Roll back to a particular version](#backup).
* [Schedule a version for deletion](#set-deleting-time).

## Creating a new user secret version {#create-version}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
    1. Click the name of the secret you need.
    1. Under **{{ ui-key.yacloud.lockbox.label_secret-versions-section }}**, click **{{ ui-key.yacloud.lockbox.button_add-version }}**.
    1. Add the following parameters:
        * (Optional) **{{ ui-key.yacloud.common.description }}**: Version description.
        * **{{ ui-key.yacloud.lockbox.forms.label_key }}**: Non-secret name  you will use to identify a value.
        * **{{ ui-key.yacloud.lockbox.forms.label_value }}**: Explicitly represented secret data.
        You can create multiple key-value pairs per version.
        
    1. Click **{{ ui-key.yacloud.lockbox.button_add-version }}**.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In the configuration file, define the parameters of the resources you want to create:

      ```hcl
      resource "yandex_lockbox_secret_version_hashed" "my_version" {
        secret_id    = "<secret_ID>"

        key_1        = "<secret_1_key>"
        text_value_1 = "<secret_1_value>"

        key_2        = "<secret_2_key>"
        text_value_2 = "<secret_2_value>"
      }
      ```

      Where:

      * `secret_id`: ID of the secret you are creating a version for.
      * (Optional) `description`: Any comment on the secret version.
      * `key_N`: Secret key. Non-secret name you will use to identify a value.
      * `text_value_N`: Explicitly represented secret data.

      The `key_N/text_value_N` pairs are numbered sequentially from 1 to 10 (10 pairs are supported). If only one pair is required, use `key_1/text_value_1`.

      {% include [secret-version-tf-note](../../_includes/lockbox/secret-version-tf-note.md) %}

  1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  This creates a new version of the specified secret. You can check the new version and its settings using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

  ```bash
  yc lockbox secret list-versions <secret_ID>
  ```

- API {#api}

  To create a new secret version, use the [addVersion](../api-ref/Secret/addVersion.md) REST API method for the [Secret](../api-ref/Secret/index.md) resource or the [SecretService/AddVersion](../api-ref/grpc/Secret/addVersion.md) gRPC API call.

{% endlist %}

## Creating a new generated secret version {#create-generated-version}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
    1. Click the name of the secret you need.
    1. Under **{{ ui-key.yacloud.lockbox.label_secret-versions-section }}**, click **{{ ui-key.yacloud.lockbox.button_add-version }}**.
    1. (Optional) Add **{{ ui-key.yacloud.common.description }}** of the version.
    1. (Optional) To change other parameters, click **{{ ui-key.yacloud.lockbox.forms.alert_generated-version-edit_button }}** and specify:
       * **{{ ui-key.yacloud.lockbox.forms.title_secret-type }}**: You can either leave the generated type or select the user type.
       * **{{ ui-key.yacloud.lockbox.forms.label_key }}** and **{{ ui-key.yacloud.lockbox.forms.title_auto-generation_params_section }}**, for the generated secret type.
       * **{{ ui-key.yacloud.lockbox.forms.label_key }}** and **{{ ui-key.yacloud.lockbox.forms.label_value }}**, for the user secret type.

          You can create multiple key-value pairs per version.
    1. Click **{{ ui-key.yacloud.lockbox.button_add-version }}** or **{{ ui-key.yacloud.common.save }}**.


- {{ TF }} {#tf}

    #### Secret generation with {{ yandex-cloud }}

    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../_includes/terraform-install.md) %}

    1. You can create a new generated secret version when [creating](secret-create.md) it. Specify the secret generation parameters in the `yandex_lockbox_secret` resource description under `password_payload_specification` and create a new secret version with a reference to the secret:
  
       ```hcl
       # Creating a generated secret
       resource "yandex_lockbox_secret" "my_secret" {
         name = "<secret_name>"

         password_payload_specification {
           password_key        = "<secret_key>"
           length              = "<length>"
           include_uppercase   = true
           include_lowercase   = true
           include_digits      = true
           include_punctuation = true
         }
       }

       # Creating a secret version
       resource "yandex_lockbox_secret_version" "my_version" {
         secret_id = yandex_lockbox_secret.my_secret.id
       }
       ```
  
       Where:
       * `password_payload_specification`: Secret generating parameters:
         * `password_key`: Secret key. Non-secret name you will use to identify a value.
         * `length`: Length of the generated secret value. This is a required parameter.
         * `include_uppercase `: Use uppercase Latin letters (A...Z). The default value is `true`.
         * `include_lowercase`: Use lowercase Latin letters (a...z). The default value is `true`.
         * `include_digits`: Use numbers (0...9). The default value is `true`.
         * `include_punctuation`: Use special characters. The default value is `true`.

       For more information about the `yandex_lockbox_secret` resource parameters in {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/lockbox_secret).

    1. Apply the changes:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
  
    You can check the new secret and its contents using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:
  
    ```bash
    yc lockbox payload get <secret_name_or_ID>
    ```

    #### Secret generation with a custom script

    You can create a new generated secret version using a secret generation script of your own. The script's output value will not be displayed in {{ TF }} State.

    {% cut "Example of a bash secret generation script" %}
    
    ```bash
    #!/bin/bash
    choose() { echo ${1:RANDOM%${#1}:1}; }
    
    {
        choose 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
        choose 'abcdefghijklmnopqrstuvwxyz'
        choose '0123456789'
        choose '!@#$%^\&'
        for i in $( seq 1 $(( 4 + RANDOM % 8 )) )
        do
            choose '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
        done
    } | sort -R | tr -d '\n'
    ```
   
    {% endcut %}

    1. In the `yandex_lockbox_secret_version` resource description under `entries`, specify the `command.path` parameter, i.e., path to the secret generation script.

       ```hcl
       # Creating a secret version with a password generation script
       resource "yandex_lockbox_secret_version" "my_version" {
         secret_id = "<secret_ID>"

         entries {
           key = "<secret_key>"
           command {
             path = "<path_to_script>"
           }
         }
       }
       ```

       Where:
       * `secret_id`: ID of the secret you are creating a version for.
       * `key`: Secret key. Non-secret name you will use to identify a value.
       * `path`: Path to the secret generation script.

       For more information about the `yandex_lockbox_secret_version` resource parameters in {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/lockbox_secret_version).

    1. Apply the changes:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
  
    You can check the new secret and its contents using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:
  
    ```bash
    yc lockbox payload get <secret_name_or_ID>
    ```

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

  To get information about a version, use the [listVersions](../api-ref/Secret/listVersions.md) REST API method for the [Secret](../api-ref/Secret/index.md) resource or the [SecretService/ListVersions](../api-ref/grpc/Secret/listVersions.md) gRPC API call.

{% endlist %}

## Creating a version based on an existing version {#create-version-based-on-other}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
    1. Click the name of the secret you need.
    1. Under **{{ ui-key.yacloud.lockbox.label_secret-versions-section }}**, next to the appropriate version, click ![image](../../_assets/console-icons/ellipsis.svg).
    1. Select **{{ ui-key.yacloud.lockbox.button_action-open-version-add-dialog }}**.
    1. Edit or add the following parameters:
        * (Optional) **{{ ui-key.yacloud.common.description }}**: Version description.
        * **{{ ui-key.yacloud.lockbox.forms.label_key }}**: Non-secret name  you will use to identify a value.
        * For a user secret, **{{ ui-key.yacloud.lockbox.forms.label_value }}**: Secret data in an explicit form.
        You can create multiple key-value pairs per version.
        * For a generated secret, you can change the key and the value parameters. To do this, click **Edit secret** and [specify new parameters](secret-update.md).
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
        --base-version-id <existing_secret_version_ID>
      ```

      Where:
     * `<secret_name>`: Name of the secret you are creating a version for.
     * `--description`: Description of the new secret version (optional).
     * `--payload`: Contents of the new secret version as a YAML or JSON array.
     * `--base-version-id`: ID of the secret version used to create a new secret. If this parameter is not specified, the new version will be created based on the current version.

      Result:

      ```text
      id: e6qor8pe3ju7********
      secret_id: e6qkkp3k29jf********
      created_at: "2024-04-25T13:49:26.621Z"
      status: ACTIVE
      payload_entry_keys:
        - secret-key1
        - secret-key2
      ```

- API {#api}

  To create a version based on an existing version, use the [addVersion](../api-ref/Secret/addVersion.md) REST API method for the [Secret](../api-ref/Secret/index.md) resource or the [SecretService/AddVersion](../api-ref/grpc/Secret/addVersion.md) gRPC API call.

{% endlist %}

## Changing the current version {#backup}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
    1. Click the name of the secret you need.
    1. Under **{{ ui-key.yacloud.lockbox.label_secret-versions-section }}**, next to the appropriate version, click ![image](../../_assets/console-icons/ellipsis.svg).
    1. Select **{{ ui-key.yacloud.lockbox.field_make-version-current }}**.
    1. Click **{{ ui-key.yacloud.lockbox.button_action-make-version-current }}**.

- API {#api}

  To change the current version, use the [addVersion](../api-ref/Secret/addVersion.md) REST API method for the [Secret](../api-ref/Secret/index.md) resource or the [SecretService/AddVersion](../api-ref/grpc/Secret/addVersion.md) gRPC API call and specify the required version.

{% endlist %}

## Scheduling a version for deletion {#set-deleting-time}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
    1. Click the name of the secret you need.
    1. Under **{{ ui-key.yacloud.lockbox.label_secret-versions-section }}**, next to the appropriate version, click ![image](../../_assets/console-icons/ellipsis.svg).
    1. Select **{{ ui-key.yacloud.lockbox.button_action-schedule-for-destruction }}**.
    1. Enter the deletion pending period.
    1. Click **{{ ui-key.yacloud.lockbox.forms.button_schedule-destruction }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to schedule version deletion:

      ```bash
      yc lockbox secret schedule-version-destruction --help
      ```
  1. Schedule a version for deletion by specifying the secret name, version ID, and the deletion pending period. For example, 1 week: `168h`:

      ```bash
      yc lockbox secret schedule-version-destruction <secret_name> \
        --version-id <version_ID> \
        --pending-period 168h
      ```
      Result:

      ```text
      id: e6qor8pe3ju7********
      secret_id: e6qkkp3k29jf********
      created_at: "2023-11-08T13:14:34.676Z"
      destroy_at: "2023-11-15T17:06:28.795Z"
      status: SCHEDULED_FOR_DESTRUCTION
      payload_entry_keys:
        - secret-key
      ```

- {{ TF }} {#tf}

  To schedule the removal of a version, remove the resource description for that version from the configuration file. You cannot use {{ TF }} to set time to deletion, it will be set by default: 7 days.

- API {#api}

  To schedule a version for deletion, use the [scheduleVersionDestruction](../api-ref/Secret/addVersion.md) REST API method for the [Secret](../api-ref/Secret/index.md) resource or the [SecretService/ScheduleVersionDestruction](../api-ref/grpc/Secret/scheduleVersionDestruction.md) gRPC API call.

{% endlist %}

## See also {#see-also}

* [{#T}](../concepts/secret.md)
