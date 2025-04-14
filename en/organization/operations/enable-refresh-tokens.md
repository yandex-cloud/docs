---
title: How to enable the use of refresh tokens in the {{ yandex-cloud }} CLI
description: Follow this guide to enable the use of refresh tokens by {{ org-full-name }} federated users in the {{ yandex-cloud }} CLI.
---

# Enabling the use of refresh tokens in the {{ yandex-cloud }} CLI

[Refresh token](../../iam/concepts/authorization/refresh-token.md) is a type of credentials that allows an OAuth application to automatically obtain a new IAM token after the user's [IAM token](../../iam/concepts/authorization/iam-token.md) expires.

To allow [federated users](../concepts/add-federation.md) to use refresh tokens in the [{{ yandex-cloud }} CLI](../../cli/index.yaml), enable this feature at the {{ org-name }} organization level.

{% include [enable-refresh-tokens](../../_includes/organization/enable-refresh-tokens.md) %}