---
title: Как клонировать инстанс в {{ foundation-models-name }}
description: Следуя данной инструкции, вы сможете клонировать инстанс в {{ foundation-models-name }} в консоли управления.
---

# Клонировать инстанс

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, на который у вашего аккаунта есть [роль](../../security/index.md#ai-models-editor) `ai.models.editor` или выше.
  1. В списке сервисов выберите **{{ ui-key.yacloud.dashboard.DashboardPage.AiStudioSection.section_title_1sDGx }}**.
  1. На панели слева нажмите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.yagpt.YaGPT.instances-title_j9Cpb }}**
  1. В строке с нужным [инстансом](../../concepts/generation/dedicated-instance.md) нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/files.svg) **{{ ui-key.yacloud.common.clone }}**.
  1. Укажите имя [инстанса](../../concepts/generation/dedicated-instance.md). Требования к формату имени:

      {% include [name-format-3](../../../_includes/name-format-3.md) %}

  1. (Опционально) Укажите описание инстанса.
  1. (Опционально) Добавьте метки.
  1. Выберите [модель](../../concepts/generation/dedicated-instance.md#models).
  1. Выберите [конфигурацию](../../concepts/generation/dedicated-instance.md#config) инстанса.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}