---
title: Authenticating as a federated user
description: Follow this guide to authenticate in the CLI as a federated user.
---

# Authenticating with the {{ yandex-cloud }} CLI as a federated user

You can use a [federated account](../../../iam/concepts/users/accounts.md#saml-federation) to work with {{ yandex-cloud }} if your company has an [identity federation](../../../iam/concepts/federations.md) set up. In this case, no personal [Yandex account](../../../iam/concepts/users/accounts.md#passport) is required.

{% include [note-auth-without-gui](../../../_includes/cli/note-auth-without-gui.md) %}


{% note tip %}

{% include [cli-proxy-setup](../../../_includes/cli/cli-proxy-setup.md) %}

{% endnote %}


If you do not have the {{ yandex-cloud }} CLI yet, [install it](../install-cli.md).

{% include [include](../../../_includes/cli/auth-federated-user.md) %}
