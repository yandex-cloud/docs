# Updating a trigger

You can edit a trigger [name](#update-name) or [description](#update-description) and [manage trigger labels](#manage-label).

{% include [trigger-list-note](../../../_includes/functions/trigger-list-note.md) %}

## Changing the name of a trigger {#update-name}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your trigger.
   1. Select **{{ sf-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/functions/triggers.svg) **Triggers**.
   1. Select the trigger you want to update.
   1. In the upper-right corner of the page, click **Edit**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To change the trigger name, run the command:

   ```
   yc serverless trigger update <trigger name> --new-name <new trigger name>
   ```

   Result:

   ```
   id: dd0gj5tsj2pq9at8ja8i
   folder_id: aoek49ghmknnpj1ll45e
   created_at: "2019-08-28T12:26:25.675Z"
   name: my-trigger
   rule:
     message_queue:
       queue_id: yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:my-mq
       service_account_id: bfbqqeo6jkpls2tse5o6
       batch_settings:
         size: "10"
         cutoff: 10s
       invoke_function:
         function_id: b09e5lu91ta21vdrrgma
         function_tag: $latest
         service_account_id: bfbqqeo6jkpls2tse5o6
   status: ACTIVE
   ```

- API

   You can change the trigger name using the [update](../../triggers/api-ref/Trigger/update.md) API method.

{% endlist %}


## Updating the description of a trigger {#update-description}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your trigger.
   1. Select **{{ sf-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/functions/triggers.svg) **Triggers**.
   1. Select the trigger you want to update.
   1. In the upper-right corner of the page, click **Edit**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To update the trigger description, run the command:

   ```
   yc serverless trigger update <trigger name> --description "<trigger description>"
   ```

   Result:

   ```
   id: dd0gj5tsj2pq9at8ja8i
   folder_id: aoek49ghmknnpj1ll45e
   created_at: "2019-08-28T12:26:25.675Z"
   name: my-trigger
   description: My YMQ trigger.
   rule:
     message_queue:
       queue_id: yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:my-mq
       service_account_id: bfbqqeo6jkpls2tse5o6
       batch_settings:
         size: "10"
         cutoff: 10s
       invoke_function:
         function_id: b09e5lu91ta21vdrrgma
         function_tag: $latest
         service_account_id: bfbqqeo6jkpls2tse5o6
   status: ACTIVE
   ```

- API

   You can update the trigger description using the [update](../../triggers/api-ref/Trigger/update.md) API method.

{% endlist %}


## Managing trigger labels {#manage-label}

You can perform the following actions with trigger labels:

* [Add](#add-label)
* [Edit](#update-label)
* [Delete](#remove-label)

### Adding a label {#add-label}

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To add a label to a trigger, run the command:

   ```
   yc serverless trigger add-labels <trigger name> --labels <key>=<value>
   ```

   Result:

   ```
   id: dd0gj5tsj2pq9at8ja8i
   folder_id: aoek49ghmknnpj1ll45e
   created_at: "2019-08-28T12:26:25.675Z"
   name: my-trigger
   description: My YMQ trigger.
   labels:
     version: beta
   rule:
     message_queue:
       queue_id: yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:my-mq
       service_account_id: bfbqqeo6jkpls2tse5o6
       batch_settings:
         size: "10"
         cutoff: 10s
       invoke_function:
         function_id: b09e5lu91ta21vdrrgma
         function_tag: $latest
         service_account_id: bfbqqeo6jkpls2tse5o6
   status: ACTIVE
   ```

- API

   You can add a trigger label using the [update](../../triggers/api-ref/Trigger/update.md) API method.

{% endlist %}

### Updating a label {#update-label}

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To update a trigger label, run the command:

   {% note warning %}

   The existing set of `labels` is completely replaced by the set transmitted.

   {% endnote %}

   ```
   yc serverless trigger update <trigger name> --labels <key>=<value>
   ```

   Result:

   ```
   id: dd0gj5tsj2pq9at8ja8i
   folder_id: aoek49ghmknnpj1ll45e
   created_at: "2019-08-28T12:26:25.675Z"
   name: my-trigger
   description: My YMQ trigger.
   labels:
     new_labels: my-beta-trigger
   rule:
     message_queue:
       queue_id: yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:my-mq
       service_account_id: bfbqqeo6jkpls2tse5o6
       batch_settings:
         size: "10"
         cutoff: 10s
       invoke_function:
         function_id: b09e5lu91ta21vdrrgma
         function_tag: $latest
         service_account_id: bfbqqeo6jkpls2tse5o6
   status: ACTIVE
   ```

- API

   You can update a trigger label using the [update](../../triggers/api-ref/Trigger/update.md) API method.

{% endlist %}

### Deleting a label {#remove-label}

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To delete a trigger label, run the command:

   ```
   yc serverless trigger remove-labels <trigger name> --labels <key>
   ```

   Result:

   ```
   id: dd0gj5tsj2pq9at8ja8i
   folder_id: aoek49ghmknnpj1ll45e
   created_at: "2019-08-28T12:26:25.675Z"
   name: my-trigger
   description: My YMQ trigger.
   rule:
     message_queue:
       queue_id: yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:my-mq
       service_account_id: bfbqqeo6jkpls2tse5o6
       batch_settings:
         size: "10"
         cutoff: 10s
       invoke_function:
         function_id: b09e5lu91ta21vdrrgma
         function_tag: $latest
         service_account_id: bfbqqeo6jkpls2tse5o6
   status: ACTIVE
   ```

- API

   You can delete a trigger label using the [update](../../triggers/api-ref/Trigger/update.md) API method.

{% endlist %}
