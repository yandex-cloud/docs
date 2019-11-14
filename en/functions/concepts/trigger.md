# Triggers

{% include [triggers-preview](../../_includes/functions/triggers-preview-stage.md) %}

_Triggers_ are conditions that automatically launch a specific function when met. They let you automate work with other Yandex.Cloud services.

At the Preview stage, you can set a [trigger for {{ message-queue-full-name }}](#ymq-trigger).

## Triggers for {{ message-queue-short-name }} {#ymq-trigger}

The {{ message-queue-short-name }} trigger is used to unload a message queue. It takes messages from the queue and passes them to a function for processing. The trigger must be in the same cloud as the queue that messages are read from. Only one trigger can be created for each message queue.

{{ message-queue-short-name }} triggers require service accounts to read messages from a message queue and to call a function. You can use the same service account for both operations.

### Roles required for the proper operation of a trigger for {{ message-queue-short-name }} {#role}

- You need roles to create a trigger:
    - `{{ roles-viewer }}` for the folder with the message queue that the trigger reads messages from.
    - `{{ roles-viewer }}` for the folder with the function that the trigger calls.
    - `iam.serviceAccounts.user` for the service accounts on whose behalf the trigger performs operations.
- Service accounts need roles for the trigger to work:
    - `{{ roles-viewer }}` for the folder with the message queue that the trigger reads messages from.
    - `{{ roles-functions-ivoker }}` for the folder with the function that the trigger calls.

Learn more about [access management](../security/index.md).

Triggers call functions for processing messages within the set [quotas and limits](limits.md).

