# Creating a trigger for {{ container-registry-name }} that sends messages to WebSocket connections

Create a [trigger for {{ container-registry-name }}](../../concepts/trigger/cr-trigger.md) to send messages to [WebSocket connections](../../concepts/extensions/websocket.md) when you create or delete {{ container-registry-name }} [Docker images](../../../container-registry/concepts/docker-image.md) or Docker image tags.

## Getting started {#before-begin}

{% include [trigger-before-you-begin](../../../_includes/api-gateway/trigger-before-you-begin.md) %}

* [Registry](../../../container-registry/concepts/registry.md) whose [Docker image](../../../container-registry/concepts/docker-image.md) events will fire the trigger. If you do not have a registry, [create one](../../../container-registry/operations/registry/registry-create.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a trigger.

   1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.

   1. In the left-hand panel, select ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

      * Enter a name and description for the trigger.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_container-registry }}`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_gateway-broadcast }}`.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_container-registry }}**:

      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_container-registry }}** field, select the registry where you want to create a trigger for image events.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_event-types }}** field, select the [events](../../concepts/trigger/cr-trigger.md#event) that will fire the trigger.
      * (Optional) In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_image-name }}** field, enter an image name for [filtering](../../concepts/trigger/cr-trigger.md#filter). To find out the Docker image name, [get a list of Docker images in the registry](../../../container-registry/operations/docker-image/docker-image-list.md).
      * (Optional) In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_tag }}** field, enter the image tag for filtering.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}**, specify:

      * Event batch size. The values may range from 1 to 1,000. The default value is 1.
      * Maximum wait time. The values may range from 1 to 60 seconds. The default value is 1 second.

      The trigger groups events for a period not exceeding the specified wait time and sends them to WebSocket connections. The number of events cannot exceed the specified batch size.

   1. {% include [api-gateway-settings](../../../_includes/api-gateway/api-gateway-settings.md) %}

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To create a trigger that sends messages to WebSocket connections, run this command:

   ```bash
   yc serverless trigger create container-registry \
     --name <trigger_name> \
     --registry-id <registry_ID> \
     --events 'create-image','delete-image','create-image-tag','delete-image-tag' \
     --batch-size <batch_size> \
     --batch-cutoff <maximum_wait_time> \
     --gateway-id <API_gateway_ID> \
     --gateway-websocket-broadcast-path <path> \
     --gateway-websocket-broadcast-service-account-id <service_account_ID>
   ```

   Where:

   * `--name`: Trigger name.
   * `--registry-id`: [Registry ID](../../../container-registry/operations/registry/registry-list.md).
   * `--events`: [Events](../../concepts/trigger/cr-trigger.md#event) activating the trigger.

   {% include [batch-settings-events](../../../_includes/api-gateway/batch-settings-events.md) %}

   {% include [trigger-cli-param](../../../_includes/api-gateway/trigger-cli-param.md) %}

   Result:

   ```text
   id: a1s5msktijh2********
   folder_id: b1gmit33hgh2********
   created_at: "2023-08-04T15:19:15.353909857Z"
   name: registry-trigger
   rule:
     container_registry:
       event_type:
       - CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE
       - CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE
       - CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE_TAG
       - CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE_TAG
       registry_id: crtlds4tdfg12kil77h2********
       batch_settings:
         size: "3"
         cutoff: 20s
       gateway_websocket_broadcast:
         gateway_id: d4eofc7n0mh2********
         path: /
         service_account_id: aje3932acdh2********
   status: ACTIVE
   ```

- API {#api}

   To create a trigger for {{ container-registry-name }}, use the [create](../../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../../_includes/api-gateway/check-result.md) %}

## See also {#see-also}

* [Trigger for {{ container-registry-name }} that invokes a {{ sf-name }} function](../../../functions/operations/trigger/cr-trigger-create.md)
* [Trigger for {{ container-registry-name }} that invokes a {{ serverless-containers-name }} container](../../../serverless-containers/operations/cr-trigger-create.md)
