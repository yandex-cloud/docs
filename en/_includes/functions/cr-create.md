{% list tabs %}

- Web console

    To create a trigger:
    
    1. Open **{{ sf-name }}** in the folder where you want to create a trigger for {{ container-registry-name }}.
    1. Go to the **Triggers** tab.
    1. Click **Create trigger**.
    1. Under **Basic parameters**:
        * Enter a name and description for the trigger.
        * In the **Type** field, select **Container Registry**.
    1. Under **Container Registry settings**:
        * In the **Registry** field, select the registry whose image events you want to create a trigger for.
        * In the **Event types** field, select the events.
        * (optional) In the **Docker image name** field, enter an [image name](../../functions/concepts/trigger/cr-trigger.md#filter) for filtering.
        * (optional) In the **Docker image tag** field, enter an [image tag](../../functions/concepts/trigger/cr-trigger.md#filter) for filtering.
    1. Under **Repeat request settings**:
        * In the **Interval** field, specify 5 seconds.
        * In the **Message batch size** field, enter 5.
    1. Under **Function settings**:
        * Select the function for the trigger to call.
        * Specify [the function version tag](../../functions/concepts/function.md#tag).
        * Specify the service account that will be used to call the function.
    1. Click **Create trigger**.

    Trigger will be created and appear in the **Triggers** table.
 
- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Create a trigger: 

    - `--name` — Trigger name.
    - `--registry-id` — A [unique registry ID](../../container-registry/operations/registry/registry-list.md).
    - `--events` — [Events](../../functions/concepts/trigger/cr-trigger.md#event) you want to handle with trigger.
    - `--invoke-function-id` — Unique function ID.
    - `--invoke-function-service-account-id` — Service account with rights to call the function. 
           
    ```

    $ yc serverless trigger create container-registry \
        --name registry-trigger \
        --registry-id crtlds4t************ \
        --events create-image,delete-image,create-image-tag,delete-image-tag \
        --invoke-function-id b09q1un7************ \
        --invoke-function-service-account-id bfbm2ib6************
    ```
    Result:
    ```
    id: a1sp5170************
    folder_id: b1g7i3rf************
    created_at: "2020-09-08T06:26:22.651656Z"
    name: registry-trigger
    rule:
      container_registry:
        event_type:
        - CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE
        - CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE
        - CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE_TAG
        - CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE_TAG
        registry_id: crtlds4t************
        invoke_function:
          function_id: b09q1un7************
          function_tag: $latest
          service_account_id: bfbm2ib6************
    status: ACTIVE
    ```
    
{% endlist %}