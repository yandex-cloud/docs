# Creating a trigger for {{ container-registry-name }} that invokes a {{ serverless-containers-name }} container

Create a [trigger for {{ container-registry-name }}](../concepts/trigger/cr-trigger.md) that invokes a {{ serverless-containers-name }} [container](../concepts/container.md) when you create or delete {{ container-registry-name }} [Docker images](../../container-registry/concepts/docker-image.md) or Docker image tags.

## Getting started {#before-begin}

{% include [trigger-before-you-begin](../../_includes/serverless-containers/trigger-before-you-begin.md) %}

* [Registry](../../container-registry/concepts/registry.md) whose [Docker image](../../container-registry/concepts/docker-image.md) events will fire the trigger. If you do not have a registry, [create one](../../container-registry/operations/registry/registry-create.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create your trigger.

   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.

   1. In the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

      * Enter a name and description for the trigger.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_container-registry }}`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_container }}`.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_container-registry }}**:

      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_container-registry }}** field, select the registry where you want to create a trigger for image events.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_event-types }}** field, select the [events](../concepts/trigger/cr-trigger.md#event) that will fire the trigger.
      * (Optional) In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_image-name }}** field, enter an image name for [filtering](../concepts/trigger/cr-trigger.md#filter). To find out the Docker image name, [get a list of Docker images in the registry](../../container-registry/operations/docker-image/docker-image-list.md).
      * (Optional) In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_tag }}** field, enter the image tag for filtering.

   1. {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

   1. (Optional) Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

      {% include [repeat-request](../../_includes/serverless-containers/repeat-request.md) %}

   1. (Optional) Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}**, select the Dead Letter Queue and the service account with write privileges for this queue.

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a trigger that invokes a container, run this command:

   
   ```bash
   yc serverless trigger create container-registry \
     --name <trigger_name> \
     --registry-id <registry_ID> \
     --events 'create-image','delete-image','create-image-tag','delete-image-tag' \
     --batch-size <batch_size> \
     --batch-cutoff <maximum_wait_time> \
     --invoke-container-id <container_ID> \
     --invoke-container-service-account-id <service_account_ID> \
     --retry-attempts 1 \
     --retry-interval 10s \
     --dlq-queue-id <Dead_Letter_Queue_ID> \
     --dlq-service-account-id <service_account_ID>
   ```


   Where:

   * `--name`: Trigger name
   * `--registry-id`: [Registry ID](../../container-registry/operations/registry/registry-list.md)
   * `--events`: [Events](../concepts/trigger/cr-trigger.md#event) activating the trigger

   {% include [batch-settings-events](../../_includes/functions/batch-settings-events.md) %}

   {% include [batch-settings-events](../../_includes/serverless-containers/batch-settings-events.md) %}

   {% include [trigger-cli-param](../../_includes/serverless-containers/trigger-cli-param.md) %}

   Result:

   
   ```text
   id: a1s5msktij**********
   folder_id: b1gmit33hg**********
   created_at: "2022-10-24T15:19:15.353909857Z"
   name: registry-trigger
   rule:
     container_registry:
       event_type:
       - CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE
       - CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE
       - CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE_TAG
       - CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE_TAG
       registry_id: crtlds4tdfg12kil77**********
       batch_settings:
         size: "3"
         cutoff: 20s
       invoke_container:
         container_id: bba5jb38o8**********
         service_account_id: aje3932acd**********
         retry_settings:
           retry_attempts: "1"
           interval: 10s
         dead_letter_queue:
           queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmk**********:dlq
           service-account-id: aje3932acd**********
   status: ACTIVE
   ```


- API

   To create a trigger for {{ container-registry-name }}, use the [create](../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## See also {#see-also}

* [Trigger for {{ container-registry-name }} that invokes a {{ sf-name }} function](../../functions/operations/trigger/cr-trigger-create.md).
