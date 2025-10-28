---
title: Как удалить инстанс в {{ foundation-models-name }}
description: Следуя данной инструкции, вы сможете удалить инстанс в {{ foundation-models-name }} в консоли управления.
---

# Удалить инстанс

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, на который у вашего аккаунта есть [роль](../../security/index.md#ai-models-editor) `ai.models.editor` или выше.
  1. В списке сервисов выберите **{{ ui-key.yacloud.dashboard.DashboardPage.AiStudioSection.section_title_1sDGx }}**.
  1. На панели слева нажмите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.yagpt.YaGPT.instances-title_j9Cpb }}**
  1. В строке с нужным [инстансом](../../concepts/generation/dedicated-instance.md) нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне введите имя инстанса и нажмите **{{ ui-key.yacloud.common.delete }}**.

      Дождитесь завершения операции.

{% endlist %}