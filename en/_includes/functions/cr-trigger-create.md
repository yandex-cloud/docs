Create a [{{ container-registry-name }} trigger](../../functions/concepts/trigger/cr-trigger.md) to invoke a {{ sf-name }} [function](../../functions/concepts/function.md) when you create or delete {{ container-registry-name }} [Docker images](../../container-registry/concepts/docker-image.md) or [Docker image tags](../../container-registry/concepts/docker-image.md#version).

## Getting started {#before-you-begin}

{% include [trigger-before-you-begin](trigger-before-you-begin.md) %}

* [Registry](../../container-registry/concepts/registry.md) whose Docker image [events](../../functions/concepts/trigger/cr-trigger.md#event) will fire the trigger. If you do not have a registry, [create one](../../container-registry/operations/registry/registry-create.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](trigger-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a trigger.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. In the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

     * Enter a name and description for the trigger.
     * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select **{{ ui-key.yacloud.serverless-functions.triggers.form.label_container-registry }}**.
     * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select **{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}**.

  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_container-registry }}**:

     * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_container-registry }}** field, select the registry where you want to create a trigger for image events.
     * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_event-types }}** field, select the [events](../../functions/concepts/trigger/cr-trigger.md#event) that will fire the trigger.
     * (Optional) In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_image-name }}** field, enter an image name for [filtering](../../functions/concepts/trigger/cr-trigger.md#filter). To find out the Docker image name, [get a list of Docker images in the registry](../../container-registry/operations/docker-image/docker-image-list.md).
     * (Optional) In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_tag }}** field, enter the [image tag](../../functions/concepts/trigger/cr-trigger.md#filter) for filtering.

  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}**, specify:

     {% include [batch-settings](batch-settings.md) %}

     {% include [batch-events](batch-events.md) %}

  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**, select a function and specify:

     {% include [function-settings](function-settings.md) %}

  1. Optionally, under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

     {% include [repeat-request.md](repeat-request.md) %}


  1. Optionally, under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}**, select the dead-letter queue and the service account with write permissions for this queue.


  1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  To create a trigger that invokes a function, run this command:

  ```bash
  yc serverless trigger create container-registry \
    --name <trigger_name> \
    --registry-id <registry_ID> \
    --events 'create-image', 'delete-image', 'create-image-tag', 'delete-image-tag' \
    --batch-size <event_group_size> \
    --batch-cutoff <maximum_timeout> \
    --invoke-function-id <function_ID> \
    --invoke-function-service-account-id <service_account_ID> \
    --retry-attempts <number_of_retry_attempts> \
    --retry-interval <interval_between_retry_attempts> \
    --dlq-queue-id <dead-letter_queue_ID> \
    --dlq-service-account-id <service_account_ID>
  ```

  Where:

  * `--name`: Trigger name.
  * `--registry-id`: [Registry ID](../../container-registry/operations/registry/registry-list.md).
  * `--events`: [Events](../../functions/concepts/trigger/cr-trigger.md#event) activating the trigger.
  
  {% include [batch-settings-events](batch-settings-events.md) %}

  {% include [trigger-cli-param](trigger-cli-param.md) %}

  Result:

  ```text
  id: a1s92agr8m**********
  folder_id: b1g88tflru**********
  created_at: "2020-09-08T06:26:22.651656Z"
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
      invoke_function:
        function_id: d4eofc7n0m**********
        function_tag: $latest
        service_account_id: aje3932acd**********
        retry_settings:
          retry_attempts: "1"
          interval: 10s
        dead_letter_queue:
          queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmk**********:dlq
          service-account-id: aje3932acd**********
  status: ACTIVE
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a trigger for {{ container-registry-name }}:

  1. In the {{ TF }} configuration file, describe the parameters of the resources you want to create:

      ```hcl
      resource "yandex_function_trigger" "my_trigger" {
        name = "<trigger_name>"
        function {
          id                 = "<function_ID>"
          service_account_id = "<service_account_ID>"
          retry_attempts     = "<number_of_retry_attempts>"
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
          batch_cutoff     = "<maximum_timeout>"
          batch_size       = "<event_group_size>"
        }
        dlq {
          queue_id           = "<dead-letter_queue_ID>"
          service_account_id = "<service_account_ID>"
        }
      }
      ```

      Where:

      {% include [tf-function-params](tf-function-params.md) %}

      * `container_registry`: Trigger properties:

        * `registry_id`: [Registry ID](../../container-registry/operations/registry/registry-list.md).
        * `image_name`: Docker image name.
        * `tag`: Docker image tag.
        * [Events](../../functions/concepts/trigger/cr-trigger.md#event) activating the trigger:

          * `create_image`: Trigger will call the function when a new Docker image is created in the registry. It can either be `true` or `false`.
          * `delete_image`: Trigger will call the function when a Docker image is deleted from the registry. It can either be `true` or `false`.
          * `create_image_tag`: Trigger will call the function when a new Docker image tag is created in the registry. It can either be `true` or `false`.
          * `delete_image_tag`: Trigger will call the function when a Docker image tag is deleted from the registry. It can either be `true` or `false`.

        {% include [tf-batch-params-events](../../_includes/functions/tf-batch-params-events.md) %}

      {% include [tf-dlq-params](../serverless-containers/tf-dlq-params.md) %}

      For more information about the `yandex_function_trigger` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/function_trigger).

  1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {% include [terraform-check-result](../../_tutorials/_tutorials_includes/terraform-check-result.md) %}

      ```bash
      yc serverless trigger list
      ```

- API {#api}

  To create a trigger for {{ container-registry-name }}, use the [create](../../functions/triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../../functions/triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../functions/triggers/api-ref/grpc/Trigger/create.md) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](check-result.md) %}

## See also {#see-also}

* [{#T}](../../serverless-containers/operations/cr-trigger-create.md)
* [{#T}](../../api-gateway/operations/trigger/cr-trigger-create.md)
