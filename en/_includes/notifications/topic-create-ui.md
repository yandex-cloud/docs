1. In the [management console]({{ link-console-main }}), select the folder.
1. [Navigate]({{ link-console-main }}/link/cns) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
1. Select **{{ ui-key.yacloud.cns.local.label_topics_vhBR3 }}** on the left.
1. Click **{{ ui-key.yacloud.cns.local.action_create-topic_qywb9 }}**.
1. Enter a name for the topic. The name must be unique within {{ cns-name }}.
1. Optionally, set up logging:
    1. Under **{{ ui-key.yacloud.cns.section_logging }}**, enable the **{{ ui-key.yacloud.cns.field_logging }}** option.
    1. In the **{{ ui-key.yacloud.cns.field_logging-folder }}** list, select a folder to house the [log group](../../logging/concepts/log-group.md).
    1. In the **{{ ui-key.yacloud.cns.field_log-group }}** field, select an existing log group or create a new one.
1. Optionally, enable **{{ message-queue-full-name }}** to send messages to {{ message-queue-name }} [queues](../../message-queue/concepts/queue.md) subscribed to the topic. Specify a service account assigned the `ymq.writer` [role](../../message-queue/security/index.md#ymq-writer):

    * For the folder with the queues subscribed to the topic.
    * For the folder with the service account itself.

    [How to assign a role](../../iam/operations/roles/grant.md#cloud-or-folder).

1. Click **{{ ui-key.yacloud.cns.Topics.button_create_r6PZn }}**.
