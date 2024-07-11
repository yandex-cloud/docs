---
title: "Удалить правило из профиля ARL"
description: "Следуя данной инструкции, вы сможете удалить правило из профиля ARL."
---

# Удалить правило из профиля ARL

Базовые правила, Smart Protection и WAF [удаляются из профиля безопасности](rule-delete.md). 

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите удалить [правило](../concepts/rules.md) из [профиля ARL](../concepts/arl.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Перейдите на вкладку ![image](../../_assets/smartwebsecurity/arl.svg) **Профили ARL**.
  1. Выберите профиль, в котором вы хотите удалить правило.
  1. На вкладке **{{ ui-key.yacloud.smart-web-security.overview.title_security-rules }}** напротив правила нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление.

{% endlist %}