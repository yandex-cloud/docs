# Creating a trigger for {{ container-registry-name }} that invokes a {{ serverless-containers-name }} container

Create a [trigger for {{ container-registry-name }}](../concepts/trigger/cr-trigger.md) that invokes a {{ serverless-containers-name }} [container](../concepts/container.md) when you create or delete {{ container-registry-name }} [Docker images](../../container-registry/concepts/docker-image.md) or Docker image tags.

## Getting started {#before-begin}

{% include [trigger-before-you-begin](../../_includes/serverless-containers/trigger-before-you-begin.md) %}

* [Registry](../../container-registry/concepts/registry.md) whose [Docker image](../../container-registry/concepts/docker-image.md) events will fire the trigger. If you do not have a registry, [create one](../../container-registry/operations/registry/registry-create.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a trigger.

   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.

   1. In the left-hand panel, select ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

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

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}**, specify:

      {% include [batch-settings](../../_includes/functions/batch-settings.md) %}

      {% include [batch-events](../../_includes/serverless-containers/batch-events.md) %}

   1. {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

   1. (Optional) Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

      {% include [repeat-request](../../_includes/serverless-containers/repeat-request.md) %}

   1. Optionally, under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}**, select the dead-letter queue and the service account with write permissions for this queue.

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a trigger that invokes a container, run this command:

   
   ```bash
   yc serverless trigger create container-registry \
     --name <trigger_name> \
     --registry-id <registry_ID> \
     --events 'create-image', 'delete-image', 'create-image-tag', 'delete-image-tag' \
     --batch-size <batch_size> \
     --batch-cutoff <maximum_wait_time> \
     --invoke-container-id <container_ID> \
     --invoke-container-service-account-id <service_account_ID> \
     --retry-attempts 1 \
     --retry-interval 10s \
     --dlq-queue-id <dead_letter_queue_ID> \
     --dlq-service-account-id <service_account_ID>
   ```


   Where:

   * `--name`: Trigger name.
   * `--registry-id`: [Registry ID](../../container-registry/operations/registry/registry-list.md).
   * `--events`: [Events](../concepts/trigger/cr-trigger.md#event) activating the trigger.

   {% include [batch-settings-events](../../_includes/serverless-containers/batch-settings-events.md) %}

   {% include [trigger-cli-param](../../_includes/serverless-containers/trigger-cli-param.md) %}

   Result:

   
   ```text
   id: a1s5msktijh2********
   folder_id: b1gmit33hgh2********
   created_at: "2022-10-24T15:19:15.353909857Z"
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
       invoke_container:
         container_id: bba5jb38o8h2********
         service_account_id: aje3932acdh2********
         retry_settings:
           retry_attempts: "1"
           interval: 10s
         dead_letter_queue:
           queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmkh2********:dlq
           service-account-id: aje3932acdh2********
   status: ACTIVE
   ```


- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To create a trigger for {{ container-registry-name }}:

   1. In the {{ TF }} configuration file, describe the parameters of the resources you want to create:

      ```
      resource "yandex_function_trigger" "my_trigger" {
        name = "<trigger_name>"
        container {
          id                 = "<container_ID>"
          service_account_id = "<service_account_ID>"
          retry_attempts     = "<number_of_retry_invocation_attempts>"
          retry_interval     = "<interval_between_retry_attempts>"
        }
        container_registry {
          registry_id      = "<registry_ID>"
          image_name       = "<image_name>"
          tag              = "<image_tag>"
          create_image     = true
          delete_image     = true
          create_image_tag = true
          delete_image_tag = true
          batch_cutoff     = "<timeout>"
          batch_size       = "<event_batch_size>"
        }
        dlq {
          queue_id           = "<queue_ID>"
          service_account_id = "<service_account_ID>"
        }
      }
      ```

      Where:

      * `name`: Trigger name. The name format is as follows:

         {% include [name-format](../../_includes/name-format.md) %}

      * `container-name`: Container parameters:

         {% include [tf-container-params](../../_includes/serverless-containers/tf-container-params.md) %}

         {% include [tf-retry-params](../../_includes/serverless-containers/tf-retry-params.md) %}

      * `container_registry`: Trigger parameters:

         * `registry_id`: Registry ID.
         * `image_name`: Docker image name.
         * `tag`: Docker image tag.
         * Select one or more event types to be handled by the trigger:

            * `create_image`: Trigger will invoke the container when a new Docker image is created in the registry. It may take either the `true` or `false` value.
            * `delete_image`: Trigger will invoke the container when a Docker image is deleted from the registry. It may take either the `true` or `false` value.
            * `create_image_tag`: Trigger will invoke the container when a new Docker image tag is created in the registry. It may take either the `true` or `false` value.
            * `delete_image_tag`: Trigger will invoke the container when a Docker image tag is deleted from the registry. It may take either the `true` or `false` value.

         {% include [tf-batch-msg-params](../../_includes/serverless-containers/tf-batch-msg-params.md) %}

         {% include [tf-dlq-params](../../_includes/serverless-containers/tf-dlq-params.md) %}

      For more information about the `yandex_function_trigger` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/function_trigger).

   1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```bash
      yc serverless trigger get <trigger_ID>
      ```

- API {#api}

   To create a trigger for {{ container-registry-name }}, use the [create](../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## See also {#see-also}

* [{#T}](../../functions/operations/trigger/cr-trigger-create.md)
* [{#T}](../../api-gateway/operations/trigger/cr-trigger-create.md)
