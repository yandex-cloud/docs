---
title: Authentication in {{ ytsaurus-name }}
description: You can access {{ ytsaurus-name }} resources through the web interface (for users) or with an API key (for service accounts).
---

# Authentication in {{ ytsaurus-name }}

You can access {{ myt-name }} resources:
* [through the {{ ytsaurus-name }} web interface](#users) (for users).
* [with an IAM token or API key](#service-accounts) (for service accounts).

{{ iam-full-name }} manages access to {{ myt-name }} resources. For more information, see [Access management](../security/index.md).

## User authentication in {{ ytsaurus-name }} {#users}

To access the {{ ytsaurus-name }} web interface, a user needs the [managed-ytsaurus.user](../security/index.md#managed-ytsaurus-user) role or higher for the {{ myt-name }} cluster folder.

Upon the first successful authentication, the system automatically creates a new {{ ytsaurus-name }} user with a username matching the user ID in {{ yandex-cloud }}. You cannot edit the {{ ytsaurus-name }} username. {{ ytsaurus-name }} does not support creating new users directly.

### {{ ytsaurus-name }} user groups {#user-groups}

{{ ytsaurus-name }} supports two user groups: `users` and `managers`. 

Upon first logging into the web interface, all users are automatically added to the `users` group.

The `managers` group automatically includes users from the `users` group who have the `managed-ytsaurus.editor` role or higher. Updating the group's user list may take up to 15 minutes.

{{ ytsaurus-name }} does not support editing user groups directly.

## Service account authentication in {{ myt-name }} {#service-accounts}

To access {{ ytsaurus-name }}, a service account needs the [managed-ytsaurus.user](../security/index.md#managed-ytsaurus-user) role or higher for the {{ myt-name }} cluster folder. 

[Service accounts](../../iam/concepts/users/service-accounts.md) can access {{ ytsaurus-name }} by using:
* [IAM token](../../iam/concepts/authorization/iam-token.md): For short-term operations; the IAM token lifetime is 12 hours.
* [API key](../../iam/concepts/authorization/api-key.md): For long-running operations when you cannot get a new IAM token automatically.

Upon the first successful authentication of a service account, the system automatically creates a new {{ ytsaurus-name }} user with a username matching the service account ID. You cannot edit the {{ ytsaurus-name }} username.

### How to use API keys in {{ myt-name }} {#api-key}

[Provide](../../iam/concepts/authorization/iam-token.md#use) API keys instead of IAM tokens.

When [creating an API key](../../iam/operations/authentication/manage-api-keys.md#create-api-key), specify `yc.managed-ytsaurus.cluster.use` as its [scope](../../iam/concepts/authorization/api-key.md#scoped-api-keys).

Here is an example of the command for creating an API key to access {{ ytsaurus-name }}:

```bash
yc iam api-key create \
   --service-account-name <service_account_name> \
   --scopes yc.managed-ytsaurus.cluster.use \
   --expires-at <date_and_time> \
   > api_key.yaml
```
