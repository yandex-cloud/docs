---
title: Аутентификация в {{ yandex-cloud }} CLI от имени локального пользователя
description: Следуя данной инструкции, вы сможете аутентифицироваться в {{ yandex-cloud }} CLI от имени локального пользователя.
---

# Аутентификация в {{ yandex-cloud }} CLI от имени локального пользователя

Вы можете использовать аккаунт [локального пользователя](../../../iam/concepts/users/accounts.md#local) для работы с {{ yandex-cloud }}, если в вашей [организации](../../../organization/concepts/organization.md) настроен [пул пользователей](../../../organization/concepts/user-pools.md). В этом случае для аутентификации не требуется личный [аккаунт на Яндексе](../../../iam/concepts/users/accounts.md#passport).

{% include [note-auth-without-gui](../../../_includes/cli/note-auth-without-gui.md) %}


{% note tip %}

{% include [cli-proxy-setup](../../../_includes/cli/cli-proxy-setup.md) %}

{% endnote %}


Если у вас еще нет интерфейса командной строки {{ yandex-cloud }}, [установите его](../install-cli.md).

{% include [auth-local-user](../../../_includes/cli/auth-local-user.md) %}
