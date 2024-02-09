---
title: "How to run automatic Docker image scans on push"
description: "This guide describes how you can run automatic Docker image scans on push."
---

# Automatic Docker image scan on push

{% note info %}

You can enable auto [scans](../concepts/vulnerability-scanner.md) of [Docker images](../concepts/docker-image.md) for vulnerabilities on push to {{ container-registry-name }} in the [vulnerability scanner settings](../operations/scanning-docker-image.md#automatically) without creating any [{{ sf-full-name }}](../../functions/) [functions](../../functions/concepts/function.md) and [triggers](../../functions/concepts/trigger).

{% endnote %}

In this tutorial, you will create a {{ container-registry-full-name }} registry to store a [Docker image](../concepts/docker-image.md) and set up automatic [scanning for vulnerabilities](../concepts/vulnerability-scanner.md) on push to the registry. Using a {{ sf-name }} trigger, you will track changes to the registry and a function will be invoked to start scanning an image on push to the registry.

To set up automatic Docker image scan on push:
1. [Prepare your cloud](#before-you-begin).
1. [Prepare the environment](#prepare).
1. [Create a function](#create-function).
1. [Create a trigger](#create-trigger).
1. [Push the image](#download-image).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

You can also deploy an infrastructure for automatic scanning of Docker images on push via {{ TF }} using a [ready-made configuration file](#terraform).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Prepare the environment {#prepare}

{% include [cli-install](../../_includes/cli-install.md) %}

1. [Install](https://www.docker.com) Docker.
1. Create a [registry](../concepts/registry.md) to push a Docker image to.

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create your registry in.
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

   - {{ TF }} {#tf}

      See [How to create an infrastructure using {{ TF }}](#terraform).

   - API {#api}

      Use the [create](../api-ref/Registry/create.md) method for the [Registry](../api-ref/Registry/) resource.

   {% endlist %}

1. Create a [service account](../../iam/concepts/users/service-accounts.md) named `scanner` and assign it the `container-registry.images.scanner` [role](../../iam/concepts/access-control/roles.md) for the folder where you created the registry.

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select a folder to create a service account in.
      1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
      1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. Enter a name for the service account.
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select `container-registry.images.scanner`.
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
         yc resource-manager folder add-access-binding <folder_id> \
           --role container-registry.images.scanner \
           --subject serviceAccount:<service_account_ID>
         ```

   - {{ TF }} {#tf}

      See [How to create an infrastructure using {{ TF }}](#terraform).

   - API {#api}

      Use the [create](../../iam/api-ref/ServiceAccount/create.md) method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/) resource and [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) for [Folder](../../resource-manager/api-ref/Folder/).

   {% endlist %}

1. Repeat the steps to create a service account named `invoker` and assign it the `{{ roles-functions-invoker }}` role for the folder where you created the registry.
1. Install Docker.

## Create a function {#create-function}

In {{ sf-name }}, create a function named `scan-on-push` that will run the Docker image scan:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a function.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
   1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
   1. Enter `scan-on-push` as the function name, and add a function description.
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
         * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `Scanner`
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

      {% include [handler-sh-function](../../_tutorials/_tutorials_includes/handler-sh-function.md) %}

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
      * `--function-name`: Name of the function you want to create a version of.
      * `--runtime`: Runtime environment.
      * `--entrypoint`: Entry point specified in the `<function_file_name>.<handler_name>` format.
      * `--memory`: Amount of RAM.
      * `--execution-timeout`: Maximum function execution time before the timeout is reached.
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

- {{ TF }} {#tf}

   See [How to create an infrastructure using {{ TF }}](#terraform).

- API {#api}

   Use the [create](../../functions/functions/api-ref/Function/create) and the [createVersion](../../functions/functions/api-ref/Function/createVersion) methods for the [Function](../../functions/functions/api-ref/Function/) resource.

{% endlist %}

## Create a trigger {#create-trigger}

Create a trigger that will invoke your function when creating a Docker image [tag](../concepts/docker-image.md#version).

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create your trigger.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
   1. Go to the **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}** tab.
   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:
      * Enter a name and description for the trigger.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_container-registry }}`.
   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_container-registry }}**:
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_container-registry }}** field, select the registry to push the Docker image to.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_event-types }}** field, select the `{{ ui-key.yacloud.serverless-functions.triggers.form.value_event-type-create-image-tag }}` [event](../../functions/concepts/trigger/cr-trigger.md#event).
   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**:
      * Select the `scan-on-push` function.
      * Specify the [function version tag](../../functions/concepts/function.md#tag): `$latest`.
      * Specify the `invoker` service account to invoke the function.
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
   * `--registry-id`: [ID of the registry](../operations/registry/registry-list.md) to push the Docker image to.
   * `--events`: [Events](../../functions/concepts/trigger/cr-trigger.md#event) activating the trigger.
   * `--invoke-function-id`: Function ID.
   * `--invoke-function-service-account-id`: ID of the service account with rights to invoke the function.

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

   Use the [Create](../../functions/triggers/api-ref/Trigger/create.md) method for the [Trigger](../../functions/triggers/api-ref/Trigger/) resource.

{% endlist %}

## Push the Docker image {#download-image}

1. Run Docker Desktop.
1. Log in to the registry under your username:

   {% list tabs %}

   - Using a Docker Credential Helper

      1. Configure Docker to use `docker-credential-yc`:

         ```bash
         yc container registry configure-docker
         ```

         Result:

         ```text
         Credential helper is configured in '/home/<user>/.docker/config.json'
         ```

         Settings are saved in the current user's profile.

         {% note warning %}

         Credential Helper only works when using Docker without `sudo`. Configuring Docker to run as the current user without using `sudo` is described in the [official Docker documentation](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).

         {% endnote %}

      1. Make sure that Docker is configured.

         The `/home/<user>/.docker/config.json` configuration file must include the following line:

         ```json
         "{{ registry }}": "yc"
         ```

      1. You can now use Docker, for example, to [push Docker images](../operations/docker-image/docker-image-push.md). You do not need to run the `docker login` command for that.

   
   - Using an OAuth token

      1. If you do not have an [OAuth token](../../iam/concepts/authorization/oauth-token.md) yet, get one by following [this link]({{ link-cloud-oauth }}).
      1. Run this command:

         ```bash
         echo <OAuth_token> | docker login --username oauth --password-stdin {{ registry }}
         ```

         Result:

         ```text
         Login succeeded
         ```


   - Using an IAM token

      {% note info %}

      {% include [iam-token-note](../../_includes/iam/iam-token-note.md) %}

      {% endnote %}

      1. [Get](../../iam/operations/iam-token/create.md) an [{{ iam-name }} token](../../iam/concepts/authorization/iam-token.md).
      1. Run this command:

         ```bash
         yc iam create-token | docker login --username iam --password-stdin {{ registry }}
         ```

         Result:

         ```text
         Login succeeded
         ```

   {% endlist %}

1. Pull a Docker image from [Docker Hub](https://hub.docker.com/):

   ```bash
   docker pull ubuntu:20.04
   ```

   Result:

   ```text
   20.04: Pulling from library/ubuntu
   Digest: sha256:cf31af331f38d1d7158470e095b132acd126a7180a54f263d386da88********
   Status: Image is up to date for ubuntu:20.04
   docker.io/library/ubuntu:20.04
   ```

1. Assign a tag to the Docker image:

   ```bash
   docker tag ubuntu:20.04 {{ registry }}/<registry_ID>/ubuntu:20.04
   ```

1. Push the Docker image to {{ container-registry-name }}:

   ```bash
   docker push {{ registry }}/<registry_ID>/ubuntu:20.04
   ```

   Result:

   ```text
   The push refers to repository [{{ registry }}/crpu20rpdc2f********/ubuntu]
   2f140462f3bc: Layer already exists
   63c99163f472: Layer already exists
   ccdbb80308cc: Layer already exists
   20.04: digest: sha256:86ac87f73641c920fb42cc9612d4fb57b5626b56ea2a19b894d0673f******** size: 943
   ```

## Check the result {#check-result}

1. View the `scan-on-push` function logs and make sure that it was executed.

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
      1. Go to the **{{ ui-key.yacloud.serverless-functions.switch_list }}** section and select the `scan-on-push` function.
      1. In the window that opens, go to **{{ ui-key.yacloud.serverless-functions.item.switch_logs }}** and specify the time period. The default time period is 1 hour.

   - CLI {#cli}

      {% include [function-list-note](../../_includes/functions/function-list-note.md) %}

      View the function execution log:

      ```bash
      yc serverless function logs scan-on-push
      ```

      Result:

      ```text
      2021-05-18 09:27:43  START RequestID: 34dc9533-ed6e-4468-b9f2-2aa0******** Version: b09i2s85a0c1********
      2021-05-18 09:27:43  END RequestID: 34dc9533-ed6e-4468-b9f2-2aa0********
      2021-05-18 09:27:43  REPORT RequestID: 34dc9533-ed6e-4468-b9f2-2aa0******** Duration: 538.610 ms Billed Duration: 538.700 ms Memory Size: 128 MB Max Memory Used: 13 MB
      2021-05-18 09:29:25  START RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f******** Version: b09i2s85a0c1********
      2021-05-18 09:29:26  END RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f********
      2021-05-18 09:29:26  REPORT RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f******** Duration: 554.904 ms Billed Duration: 555.000 ms Memory Size: 128 MB Max Memory Used: 13 MB
      ...
      ```

   {% endlist %}

1. Make sure that a new scan started when you pushed the Docker image.

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the parent folder for the registry containing the Docker image.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
      1. Select the registry where you pushed your Docker image.
      1. Open the repository with the Docker image.
      1. Select the relevant Docker image and check the **{{ ui-key.yacloud.cr.image.label_last-scan-time }}** parameter value.

   - CLI {#cli}

      To view scans by Docker image, run the command:

      ```bash
      yc container image list-scan-results --repository-name=<registry_ID>/<Docker_image_name>
      ```

      Result:

      ```text
      +----------------------+----------------------+---------------------+--------+--------------------------------+
      |          ID          |        IMAGE         |     SCANNED AT      | STATUS |        VULNERABILITIES         |
      +----------------------+----------------------+---------------------+--------+--------------------------------+
      | crpu20rpdc2f******** | crpqmsqp5mtb******** | 2021-05-18 14:34:02 | READY  | medium:6, low:13, negligible:3 |
      +----------------------+----------------------+---------------------+--------+--------------------------------+
      ```

   {% endlist %}


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

* [Delete the Docker image](../../container-registry/operations/docker-image/docker-image-delete.md) stored in [{{ cos-full-name }}](../../cos/), as well as the [registry](../../container-registry/operations/registry/registry-delete.md).
* [Delete](../../functions/operations/function/function-delete.md) the {{ sf-name }} function.
* [Delete](../../functions/operations/function/function-delete.md) the {{ sf-name }} trigger.

## How to create an infrastructure using {{ TF }} {#terraform}

{% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

To set up automatic Docker image scan on push using {{ TF }}:

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) and [get the authentication data](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials).
1. Specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare files with the infrastructure description:

   {% list tabs group=infrastructure_description %}

   - Ready-made archive {#ready}

      1. Create a directory for files.
      1. Download the [archive](https://{{ s3-storage-host }}/doc-files/image-auto-scan-tf.zip) (2 KB).
      1. Unpack the archive to the directory. As a result, it should contain the `image-auto-scan.tf` configuration file, the `image-auto-scan.auto.tfvars` file with user data, and the `function.zip` archive with the function code.

   - Manually {#manual}

      1. Create a directory for configuration files.
      1. In the directory, create a configuration file named `image-auto-scan.tf`:

         {% cut "image-auto-scan.tf" %}

         {% include [image-auto-scan-tf-config](../../_includes/web/image-auto-scan-tf-config.md) %}

         {% endcut %}

      1. Create the `image-auto-scan.auto.tfvars` file with user data:

         {% cut "image-auto-scan.auto.tfvars" %}

         {% include [image-auto-scan-tf-variables](../../_includes/web/image-auto-scan-tf-variables.md) %}

         {% endcut %}

      1. Prepare a ZIP archive with the function code:

         1. Create the `handler.sh` file and paste the following code to it:

            {% cut "handler.sh" %}

            {% include [warning-unix-lines](../../_tutorials/_tutorials_includes/warning-unix-lines.md) %}

            {% include [handler-sh-function](../../_tutorials/_tutorials_includes/handler-sh-function.md) %}

            {% endcut %}

         1. Create a ZIP archive named `function.zip` with the `handler.sh` file.

   {% endlist %}

   For more information about the parameters of resources used in {{ TF }}, see the provider documentation:

   * [yandex_iam_service_account]({{ tf-provider-resources-link }}/yandex_iam_service_account)
   * [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/yandex_resourcemanager_folder_iam_member)
   * [yandex_container_registry]({{ tf-provider-resources-link }}/yandex_container_registry)
   * [yandex_function]({{ tf-provider-resources-link }}/yandex_function)

1. In the `image-auto-scan.auto.tfvars` file, set the user-defined parameters:
   * `zone`: [Availability zone](../../overview/concepts/geo-scope.md) to create the infrastructure in.
   * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) to create the infrastructure in.

1. Create resources:

   {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

1. [Create a trigger](#create-trigger).

1. [Push the image](#download-image).

1. [Check the result](#check-result).
