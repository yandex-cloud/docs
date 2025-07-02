---
title: Как включить возможность использования refresh-токенов в {{ yandex-cloud }} CLI
description: Следуя данной инструкции, вы сможете включить возможность использования refresh-токенов федеративными пользователями {{ org-name }} в {{ yandex-cloud }} CLI.
---

# Включить возможность использования refresh-токенов в {{ yandex-cloud }} CLI

[Refresh-токен](../../iam/concepts/authorization/refresh-token.md) — это тип учетных данных, позволяющий OAuth-приложению при истечении срока действия [IAM-токена](../../iam/concepts/authorization/iam-token.md) пользователя автоматически получать новый IAM-токен.

Чтобы [федеративные](../concepts/add-federation.md) пользователи могли использовать refresh-токены в [{{ yandex-cloud }} CLI](../../cli/index.yaml), включите эту функциональность на уровне организации {{ org-name }}:

{% include [enable-refresh-tokens](../../_includes/organization/enable-refresh-tokens.md) %}