---
title: How to enable the use of refresh tokens in the {{ yandex-cloud }} CLI
description: Follow this guide to enable refresh tokens in the {{ yandex-cloud }} CLI for {{ org-full-name }} users.
---

# Enabling the use of refresh tokens in the {{ yandex-cloud }} CLI

A [refresh token](../../iam/concepts/authorization/refresh-token.md) is a type of credential that allows an OAuth application to automatically obtain a new IAM token after the user's [IAM token](../../iam/concepts/authorization/iam-token.md) expires.

To allow users to use refresh tokens in the [{{ yandex-cloud }} CLI](../../cli/index.yaml), enable this feature at the {{ org-full-name }} level:

{% include [enable-refresh-tokens](../../_includes/organization/enable-refresh-tokens.md) %}