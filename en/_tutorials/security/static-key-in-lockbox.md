If you are a frequent user of services with an AWS-compatible API, such as [{{ objstorage-full-name }}](../../storage/index.yaml), [{{ yds-full-name }}](../../data-streams/index.yaml), or [{{ message-queue-full-name }}](../../message-queue/index.yaml), it is up to you to take care of safe storage of your [static access keys](../../iam/concepts/authorization/access-key.md).

This guide covers a scenario where a {{ lockbox-full-name }} [secret](../../lockbox/concepts/secret.md) is used as the static access key storage. In this configuration, the access key value is neither stored locally on the user's computer, nor displayed on the screen.

{% include [index-common](../_tutorials_includes/static-key-in-lockbox/index-common.md) %}