# Automatic Docker image scan at push

_The scanning service is at the [Preview stage](../../overview/concepts/launch-stages.md)._

This scenario describes how to configure automatic vulnerability [scanning](../concepts/vulnerability-scanner.md) of a [Docker image](../concepts/docker-image.md) at push.

## Prepare the environment {#prepare}

{% include [cli-install](../../_includes/cli-install.md) %}

1. Create a [registry](../concepts/registry.md) to push a Docker image to.

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create your registry in.
      1. In the list of services, select **{{ container-registry-name }}**.
      1. Specify a name for the registry.
      1. Click **Create registry**.

   - CLI

      Run the command:

      ```bash
      yc container registry create --name my-reg
      ```

      Result:

      ```bash
      done
      id: crpd50616s9a2t7gr8mi
      folder_id: b1g88tflru0ek1omtsu0
      name: my-reg
      status: ACTIVE
      created_at: "2019-01-09T14:34:06.601Z"
      ```

   - API

      Use the [create](../api-ref/Registry/create.md) method for the [Registry](../api-ref/Registry/) resource.

   {% endlist %}

1. Create a [service account](../../iam/concepts/users/service-accounts.md) named `editor` and assign it the `editor` role for the folder where you created the registry.

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select a folder where you wish to create a service account.
      1. Go to the **Service accounts** tab.
      1. Click **Create service account**.
      1. Enter the name of the service account.
      1. Click **Add role** and choose the `editor` role.
      1. Click **Create**.

   - CLI

      1. Create a service account:

         ```bash
         yc iam service-account create --name service-acc
         ```

         Result:

         ```bash
         id: ajelabcde12f33nol1v5
         folder_id: b0g12ga82bcv0cdeferg
         created_at: "2021-05-17T14:32:18.900092Z"
         name: service-acc
         ```

      1. Assign the role to the service account:

         ```bash
         yc resource-manager folder add-access-binding <folder ID> \
           --role editor \
           --subject serviceAccount:<service account ID>
         ```

   - API

      Use the [create](../../iam/api-ref/ServiceAccount/create.md) method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/) resource and [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) for [Folder](../../resource-manager/api-ref/Folder/).

   {% endlist %}

1. Similarly create a service account named `invoker` and assign it the `serverless.functions.invoker` role for the folder where you created the registry.

## Create a function {#create-function}

Create a [function](../../functions/concepts/function.md) in {{ sf-full-name }} named `scan-on-push` to start the image scan:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create a function.
   1. Select **{{ sf-name }}**
   1. Click **Create function**.
   1. Enter the name `scan-on-push` and a description of the function.
   1. Click **Create**.
   1. Go to **Editor** and create a version of the function:
      1. Under **Function code**:
         * Select the `Bash` runtime environment.
         * Select how you want to edit the function: **Code editor**.
         * In the function edit window, click **Create file**. In the window that opens, enter the name `handler.sh` and click **Create**.
         * Copy the following code to the `handler.sh` file:

            ```bash
            DATA=$(cat | jq -sr '.[0].messages[0].details')
            ID=$(echo $DATA | jq -r '.image_id')
            NAME=$(echo $DATA | jq -r '.repository_name')
            TAG=$(echo $DATA | jq -r '.tag')
            yc container image scan --id ${ID} --async 1>&2
            ```

         * Specify the entry point: `handler.sh`.
      1. Under **Parameters**, specify:
         * Timeout, sec: 60.
         * RAM: 128 MB.
         * Service account: `editor`.
      1. In the upper-right corner, click **Create version**.

- CLI

   1. Create a function named `scan-on-push`:

      ```bash
      yc serverless function create --name=scan-on-push
      ```

      Result:

      ```bash
      id: d4ejb1799eko6re4omb1
      folder_id: aoek49ghmknnpj1ll45e
      created_at: "2021-17-05T14:07:32.134Z"
      name: scan-on-push
      log_group_id: eolm8aoq9vcppsieej6h
      http_invoke_url: https://functions.yandexcloud.net/d4ejb1799eko6re4omb1
      status: ACTIVE
      ```

   1. Create the `handler.sh` file and copy the following code to it:

      ```bash
      DATA=$(cat | jq -sr '.[0].messages[0].details')
      ID=$(echo $DATA | jq -r '.image_id')
      NAME=$(echo $DATA | jq -r '.repository_name')
      TAG=$(echo $DATA | jq -r '.tag')
      yc container image scan --id ${ID} --async 1>&2
      ```

   1. Create a version of the `scan-on-push` function:

      ```bash
      yc serverless function version create \
        --function-name=<scan-on-push> \
        --runtime bash \
        --entrypoint handler.sh \
        --memory 128m \
        --execution-timeout 60s \
        --source-path handler.sh \
        --service-account-id <service account ID>
      ```

      Where:

      * `function-name`: The name of the function you want to create a version of.
      * `runtime`: The runtime environment.
      * `entrypoint`: The entry point specified in the `<function file name>.<handler name>` format.
      * `memory`: The amount of RAM.
      * `execution-timeout`: The maximum function execution time before the timeout is reached.
      * `source-path`: A file with the function code.
      * `service-account-id`: The ID of your service account.

      Result:

      ```bash
      done (1s)
      id: d4egi3pmsd1qcdmsqt5n
      function_id: d4e275oj7jtp2o6kdmim
      created_at: "2021-05-18T20:19:09.605Z"
      runtime: bash
      entrypoint: handler.sh
      resources:
        memory: "134217728"
      execution_timeout: 60s
      service_account_id: aje2stn6id9k43qk7n7l
      image_size: "4096"
      status: ACTIVE
      tags:
      - $latest
      log_group_id: ckg6nb0c7uf19oo8pvjj
      ```

- API

   Use the [create](../../functions/functions/api-ref/Function/create) and the [createVersion](../../functions/functions/api-ref/Function/createVersion) methods for the [Function](../../functions/functions/api-ref/Function/) resource.

{% endlist %}

## Create a trigger {#create-trigger}

Create a [trigger](../../functions/concepts/trigger/cr-trigger.md) that will invoke your function when creating an image tag.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create your trigger.
   1. Select **{{ sf-name }}**.
   1. Go to the **Triggers** tab.
   1. Click **Create trigger**.
   1. Under **Basic parameters**:
      * Enter a name and description for the trigger.
      * In the **Type** field, select **Container Registry**.
   1. Under **Container Registry settings**:
      * In the **Registry** field, select the registry where you want to push the image.
      * In the **Event types** field, select **Create Docker image tag** as your [event](../../functions/concepts/trigger/cr-trigger.md#event).
   1. Under **Function settings**:
      * Select the `scan-on-push` function.
      * Specify the [function version tag](../../functions/concepts/function.md#tag): `$latest`.
      * Specify the `invoker` service account to invoke the function.
   1. Click **Create trigger**.

- CLI

   To create a trigger, run the command:

   ```bash
   yc serverless trigger create container-registry \
     --name <trigger name> \
     --registry-id <registry ID> \
     --events 'create-image-tag' \
     --invoke-function-id <function ID> \
     --invoke-function-service-account-id <service account ID>
   ```

   Where:

   * `name`: Trigger name.
   * `registry-id`: The [ID of the registry](../operations/registry/registry-list.md) where you want to push the image.
   * `events`: [Events](../../functions/concepts/trigger/cr-trigger.md#event) after which the trigger activates.
   * `invoke-function-id`: Function ID.
   * `invoke-function-service-account-id`: The ID of the service account with rights to invoke the function.

   Result:

   ```bash
   id: a1spt834cjmk40si80sp
   folder_id: b1g86q4m5vej8lkljme5
   created_at: "2021-05-18T20:42:54.898949653Z"
   name: trig
   rule:
     container_registry:
       event_type:
       - CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE_TAG
       registry_id: crpu20rpdc2foid8p8b0
       invoke_function:
         function_id: d4e275oj7jtp2o6kdmim
         function_tag: $latest
         service_account_id: aje1insoe23e82t9mem2
   status: ACTIVE
   ```

- API

   Use the [Create](../../functions/triggers/api-ref/Trigger/create.md) method for the [Trigger](../../functions/triggers/api-ref/Trigger/) resource.

{% endlist %}

## Upload an image {#download-image}

1. Log in to the registry under your username:

   {% list tabs %}

   - Using a Docker Credential helper

      1. If you don't have a YC CLI profile yet, [create one](../../cli/quickstart.md#initialize).
      1. Configure Docker to use `docker-credential-yc`:

         ```bash
         yc container registry configure-docker
         ```

         Result:

         ```bash
         Credential helper is configured in '/home/<user>/.docker/config.json'
         ```

         Settings are saved in the current user's profile.

         {% note warning %}

         The Credential helper only works when using Docker without `sudo`. Configuring Docker to run as the current user without using `sudo` is described in the [official Docker documentation](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).

         {% endnote %}

      1. Make sure that Docker is configured.

         The `/home/<user>/.docker/config.json` configuration file must include the following line:

         ```json
         "{{ registry }}": "yc"
         ```

      1. You can now use Docker, for example, to [push Docker images](../operations/docker-image/docker-image-push.md). You don't need to run `docker login` for that.

   - With an OAuth token

   1. If you don't have an OAuth token, get one by following this [link]({{ link-cloud-oauth }}).
   1. Run the command:

      ```bash
      echo <oauth token> | docker login --username oauth --password-stdin {{ registry }}
      ```

      Result:

      ```bash
      Login Succeeded
      ```

      
   - Using an IAM token

      {% note info %}

      {% include [iam-token-note](../../_includes/iam/iam-token-note.md) %}

      {% endnote %}

      1. [Get](../../iam/operations/iam-token/create.md) an IAM token.
      1. Run the command:

         ```bash
         yc iam create-token | docker login --username iam --password-stdin {{ registry }}
         ```

         Result:

         ```bash
         Login succeeded
         ```

   {% endlist %}

1. Pull a Docker image from [Docker Hub](https://hub.docker.com/):

   ```bash
   docker pull ubuntu:20.04
   ```

   Result:

   ```bash
   20.04: Pulling from library/ubuntu
   Digest: sha256:cf31af331f38d1d7158470e095b132acd126a7180a54f263d386da88eb681d93
   Status: Image is up to date for ubuntu:20.04
   docker.io/library/ubuntu:20.04
   ```

1. Assign a tag to the Docker image:

   ```bash
   docker tag ubuntu:20.04 {{ registry }}/<registry ID>/ubuntu:20.04
   ```

1. Push the Docker image to {{ container-registry-name }}:

   ```bash
   docker push {{ registry }}/<registry ID>/ubuntu:20.04
   ```

   Result:

   ```bash
   The push refers to repository [{{ registry }}/crpu20rpdc2foid8p8b0/ubuntu]
   2f140462f3bc: Layer already exists
   63c99163f472: Layer already exists
   ccdbb80308cc: Layer already exists
   20.04: digest: sha256:86ac87f73641c920fb42cc9612d4fb57b5626b56ea2a19b894d0673fd5b4f2e9 size: 943
   ```

## Check the results {#check-result}

1. View the `scan-on-push` function logs and make sure that it was executed.

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select **{{ sf-name }}**.
      1. Go to the **Functions** section and select the `scan-on-push` function.
      1. In the window that opens, go to **Logs** and specify the time period. The default time period is 1 hour.

   - CLI

      {% include [function-list-note](../../_includes/functions/function-list-note.md) %}

      View the function execution log:

      ```bash
      yc serverless function logs scan-on-push
      ```

      Result:

      ```bash
      2021-05-18 09:27:43  START RequestID: 34dc9533-ed6e-4468-b9f2-2aa082266fad Version: b09i2s85a0c1fisjboft
      2021-05-18 09:27:43  END RequestID: 34dc9533-ed6e-4468-b9f2-2aa082266fad
      2021-05-18 09:27:43  REPORT RequestID: 34dc9533-ed6e-4468-b9f2-2aa082266fad Duration: 538.610 ms Billed Duration: 538.700 ms Memory Size: 128 MB Max Memory Used: 13 MB
      2021-05-18 09:29:25  START RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f279394ef Version: b09i2s85a0c1fisjboft
      2021-05-18 09:29:26  END RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f279394ef
      2021-05-18 09:29:26  REPORT RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f279394ef Duration: 554.904 ms Billed Duration: 555.000 ms Memory Size: 128 MB Max Memory Used: 13 MB
      ...
      ```

   {% endlist %}

1. Make sure that a new scan started when you pushed the Docker image.

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the parent folder for the registry containing the Docker image.
      1. Select **{{ container-registry-name }}**.
      1. Select the registry where you pushed your Docker image.
      1. Open the repository with the Docker image.
      1. Select the desired image and go to the **Scan history** tab.

   - CLI

      To view scans by Docker image, run the command:

      ```bash
      yc container image list-scan-results --repository-name=<registry ID>/<Docker image name>
      ```

      Result:

      ```bash
      +----------------------+----------------------+---------------------+--------+--------------------------------+
      |          ID          |        IMAGE         |     SCANNED AT      | STATUS |        VULNERABILITIES         |
      +----------------------+----------------------+---------------------+--------+--------------------------------+
      | crpu20rpdc2foid8p8b0 | crpqmsqp5mtbh627i7qs | 2021-05-18 14:34:02 | READY  | medium:6, low:13, negligible:3 |
      +----------------------+----------------------+---------------------+--------+--------------------------------+
      ```

   {% endlist %}