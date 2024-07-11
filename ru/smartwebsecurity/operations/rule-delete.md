---
title: "Удалить правило из профиля безопасности"
description: "Следуя данной инструкции, вы сможете удалить правило из профиля безопасности."
---

# Удалить правило из профиля безопасности

Из профиля безопасности можно удалить базовые правила, Smart Protection и WAF. Правила ARL [удаляются из профиля ARL](arl-rule-delete.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите удалить [правило](../concepts/rules.md) из [профиля безопасности](../concepts/profiles.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Выберите профиль, в котором вы хотите удалить правило.
  1. На вкладке **{{ ui-key.yacloud.smart-web-security.overview.title_security-rules }}** напротив правила нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление.

- API {#api}

  {% include [api-profile-update](../../_includes/smartwebsecurity/api-profile-update.md) %}

{% endlist %}