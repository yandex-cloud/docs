* `SQSServiceAccountId`: ID of the service account you are going to use to send messages from the topic to a {{ message-queue-name }}. This is an optional parameter. The service account must have the `ymq.writer` [role](../../message-queue/security/index.md#ymq-writer):

    * For the folder with the queues subscribed to the topic.
    * For the folder with the service account itself.

    {% note info %}

    To specify a service account in the `SQSServiceAccountId` attribute, the user must have the `iam.serviceAccounts.user` role for the folder with the service account. Otherwise, the command will fail with an authorization error.

    {% endnote %}
