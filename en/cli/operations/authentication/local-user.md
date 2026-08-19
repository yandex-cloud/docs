---
title: Authenticating in the {{ yandex-cloud }} CLI as a local user
description: Follow this guide to get authenticated in the {{ yandex-cloud }} CLI as a local user.
---

# Authenticating in the {{ yandex-cloud }} CLI as a local user

You can use a [local user](../../../iam/concepts/users/accounts.md#local) account to work with {{ yandex-cloud }} if your [organization](../../../organization/concepts/organization.md) has a [user pool](../../../organization/concepts/user-pools.md) configured. In this case, you can get authenticated without an individual [Yandex account](../../../iam/concepts/users/accounts.md#passport).

{% include [note-auth-without-gui](../../../_includes/cli/note-auth-without-gui.md) %}


{% note tip %}

{% include [cli-proxy-setup](../../../_includes/cli/cli-proxy-setup.md) %}

{% endnote %}


If you do not have the {{ yandex-cloud }} CLI yet, [install it](../install-cli.md).

{% include [auth-local-user](../../../_includes/cli/auth-local-user.md) %}
