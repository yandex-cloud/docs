(Optional) Expand the **{{ ui-key.yacloud.serverless-event-router.label_target-dead-letter-settings }}** section:

1. Specify the `{{ message-queue-full-name }}` listener type.
1. Specify a folder or DLQ to which messages the target failed to process will be redirected.
1. Select the service account to which the `ymq.writer` [role](../../message-queue/security/index.md#ymq-writer) or higher is assigned for the selected DLQ or [create](../../iam/operations/sa/create.md) a new account.