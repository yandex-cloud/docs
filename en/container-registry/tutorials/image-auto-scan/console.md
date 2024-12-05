---
title: How to run automatic Docker image scans on push using the management console, CLI, and API
description: Follow this guide to run automatic Docker image scans on push to {{ container-registry-full-name }} using the management console, CLI, and API.
---

# Automatic Docker image scans on push using the management console, CLI, and API


{% note info %}

You can enable auto [scans](../../concepts/vulnerability-scanner.md) of [Docker images](../../concepts/docker-image.md) for vulnerabilities on push to [{{ container-registry-full-name }}](../../../container-registry/) in the [vulnerability scanner settings](../../operations/scanning-docker-image.md#automatically) without creating any [{{ sf-full-name }}](../../../functions/) [functions](../../../functions/concepts/function.md) and [triggers](../../../functions/concepts/trigger/index.md).

{% endnote %}

To configure automatic vulnerability [scans](../../concepts/vulnerability-scanner.md) of [Docker images](index.md) on push to [{{ container-registry-full-name }}](../../../container-registry/):

1. [Prepare your cloud](#before-you-begin).
1. [Prepare the environment](#prepare).
1. [Create a function](#create-function).
1. [Create a trigger](#create-trigger).
1. [Push the Docker image](#download-image).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [paid-resources](../../../_tutorials/_tutorials_includes/image-auto-scan/paid-resources.md) %}

## Prepare the environment {#prepare}

{% include [cli-install](../../../_includes/cli-install.md) %}

1. [Install and configure](../../operations/configure-docker.md) Docker.
1. Create a registry to push a Docker image to.

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to create a registry in.
     1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
     1. Click **{{ ui-key.yacloud.cr.overview.button_create }}**.
     1. Specify a name for the registry.
     1. Click **{{ ui-key.yacloud.cr.overview.popup-create_button_create }}**.

   - CLI {#cli}

     Run this command:

     ```bash
     yc container registry create --name my-reg
     ```

     Result:

     ```text
     done
     id: crpd50616s9a********
     folder_id: b1g88tflru0e********
     name: my-reg
     status: ACTIVE
     created_at: "2019-01-09T14:34:06.601Z"
     ```

   - API {#api}

     Use the [create](../../api-ref/Registry/create.md) method for the [Registry](../../api-ref/Registry/) resource.

   {% endlist %}

1. Create a [service account](../../../iam/concepts/users/service-accounts.md) named `scanner` and assign it the `container-registry.images.scanner` [role](../../../iam/concepts/access-control/roles.md) for the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you created the registry.

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select a folder where you want to create a service account.
     1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
     1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
     1. Enter a name for the service account.
     1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `container-registry.images.scanner` role.
     1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

   - CLI {#cli}

     1. Create a service account:

        ```bash
        yc iam service-account create --name service-acc
        ```

        Result:

        ```text
        id: ajelabcde12f********
        folder_id: b0g12ga82bcv********
        created_at: "2021-05-17T14:32:18.900092Z"
        name: service-acc
        ```

     1. Assign the role to the service account:

        ```bash
        yc resource-manager folder add-access-binding <folder_ID> \
          --role container-registry.images.scanner \
          --subject serviceAccount:<service_account_ID>
        ```

   - API {#api}

     Use the [create](../../../iam/api-ref/ServiceAccount/create.md) method for the [ServiceAccount](../../../iam/api-ref/ServiceAccount/) resource and [updateAccessBindings](../../../resource-manager/api-ref/Folder/updateAccessBindings.md) for [Folder](../../../resource-manager/api-ref/Folder/).

   {% endlist %}

1. Repeat the steps to create a service account named `invoker` and assign it the `{{ roles-functions-invoker }}` role for the folder where you created the registry.

## Create a function {#create-function}

In {{ sf-name }}, create a function named `scan-on-push` that will run the Docker image scan:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a function.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
  1. Enter a name, e.g., `scan-on-push`, and description for the function.
  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Go to **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}** and create a version of the function:
     1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-source }}**:
        * Select the `Bash` runtime environment and click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
        * Select how you want to edit the function: `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-editor }}`.
        * In the function edit window, click **{{ ui-key.yacloud.serverless-functions.item.editor.create-file }}**. In the window that opens, enter `handler.sh` as the file name and click **{{ ui-key.yacloud.common.create }}**.
        * Copy the following code to the `handler.sh` file:

          ```bash
          DATA=$(cat | jq -sr '.[0].messages[0].details')
          ID=$(echo $DATA | jq -r '.image_id')
          NAME=$(echo $DATA | jq -r '.repository_name')
          TAG=$(echo $DATA | jq -r '.tag')
          yc container image scan --id ${ID} --async 1>&2
          ```

        * Specify the entry point: `handler.sh`.
     1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, specify:
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `60`
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud.common.units.label_megabyte }}`
        * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `scanner`
     1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

  1. Create a function named `scan-on-push`:

     ```bash
     yc serverless function create --name=scan-on-push
     ```

     Result:

     ```text
     id: d4ejb1799eko********
     folder_id: aoek49ghmknn********
     created_at: "2021-17-05T14:07:32.134Z"
     name: scan-on-push
     log_group_id: eolm8aoq9vcp********
     http_invoke_url: https://{{ sf-url }}/d4ejb1799eko********
     status: ACTIVE
     ```

  1. Create the `handler.sh` file and paste the following code to it:

     {% include [handler-sh-function](../../../_tutorials/_tutorials_includes/handler-sh-function.md) %}

  1. Create a version of the `scan-on-push` function:

     ```bash
     yc serverless function version create \
       --function-name=scan-on-push \
       --runtime bash \
       --entrypoint handler.sh \
       --memory 128m \
       --execution-timeout 60s \
       --source-path handler.sh \
       --service-account-id <service_account_ID>
     ```

     Where:
     * `--function-name`: Name of the function whose version you want to create.
     * `--runtime`: Runtime environment.
     * `--entrypoint`: Entry point in `<function_file_name>.<handler_name>` format.
     * `--memory`: Amount of RAM.
     * `--execution-timeout`: Maximum function running time before the timeout is reached.
     * `--source-path`: File with the function code.
     * `--service-account-id`: Service account ID.

     Result:

     ```text
     done (1s)
     id: d4egi3pmsd1q********
     function_id: d4e275oj7jtp********
     ...
     tags:
     - $latest
     log_group_id: ckg6nb0c7uf1********
     ```

- API {#api}

  Use the [create](../../../functions/functions/api-ref/Function/create.md) and the [createVersion](../../../functions/functions/api-ref/Function/createVersion.md) methods for the [Function](../../../functions/functions/api-ref/Function/) resource.

{% endlist %}

## Create a trigger {#create-trigger}

Create a trigger that will invoke your function when creating a Docker image [tag](../../concepts/docker-image.md#version).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a trigger.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Go to the **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}** tab.
  1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:
     * Enter a name and description for the trigger.
     * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_container-registry }}`.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_container-registry }}**:
     * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_container-registry }}** field, select the registry to push the Docker image to.
     * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_event-types }}** field, select the [event `{{ ui-key.yacloud.serverless-functions.triggers.form.value_event-type-create-image-tag }}`](../../../functions/concepts/trigger/cr-trigger.md#event).
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**:
     * Select the `scan-on-push` function.
     * Specify the `$latest` [function version tag](../../../functions/concepts/function.md#tag).
     * Specify the `invoker` service account which will invoke the function.
  1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

  To create a trigger, run the command:

  ```bash
  yc serverless trigger create container-registry \
    --name <trigger_name> \
    --registry-id <registry_ID> \
    --events 'create-image-tag' \
    --invoke-function-id <function_ID> \
    --invoke-function-service-account-id <service_account_ID>
  ```

  Where:
  * `--name`: Trigger name.
  * `--registry-id`: [ID of the registry](../../operations/registry/registry-list.md) to push the Docker image to.
  * `--events`: [Events](../../../functions/concepts/trigger/cr-trigger.md#event) activating the trigger.
  * `--invoke-function-id`: Function ID.
  * `--invoke-function-service-account-id`: ID of the service account with the permissions to invoke the function.

  Result:

  ```text
  id: a1spt834cjmk********
  folder_id: b1g86q4m5vej********
  created_at: "2021-05-18T20:42:54.898949653Z"
  ...
        function_tag: $latest
        service_account_id: aje1insoe23e********
  status: ACTIVE
  ```

- API {#api}

  Use the [Create](../../../functions/triggers/api-ref/Trigger/create.md) method for the [Trigger](../../../functions/triggers/api-ref/Trigger/) resource.

{% endlist %}

## Push the Docker image {#download-image}

{% include [upload-image](../../../_tutorials/_tutorials_includes/image-auto-scan/upload-image.md) %}

## Check the result {#check-result}

{% include [check-result](../../../_tutorials/_tutorials_includes/image-auto-scan/check-result.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete the Docker image](../../../container-registry/operations/docker-image/docker-image-delete.md) stored in [{{ cos-full-name }}](../../../cos/), as well as the [registry](../../../container-registry/operations/registry/registry-delete.md).
1. [Delete](../../../functions/operations/function/function-delete.md) the {{ sf-name }} function.
1. [Delete](../../../functions/operations/function/function-delete.md) the {{ sf-name }} trigger.

#### See also {#see-also}

* [{#T}](terraform.md)