---
title: Authenticating as a user
description: Follow this guide to authenticate in the CLI as a user.
---

# Authenticating as a user


To get started with {{ yandex-cloud }}, you need a [Yandex account](../../../iam/concepts/users/accounts.md#passport).

You can authenticate in the [profile creation](../profile/profile-create.md#interactive-create) wizard using the `yc init` command or following these steps:

1. Get an [OAuth token](../../../iam/concepts/authorization/oauth-token.md).


1. [Create a profile](../profile/profile-create.md#create).
1. Specify your OAuth token in the `token` parameter:
    ```
    yc config set token <OAuth token>
    ```

The OAuth token is saved in the profile configuration for automatically authenticating.


