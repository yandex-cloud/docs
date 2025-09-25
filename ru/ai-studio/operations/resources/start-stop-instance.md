---
title: Как остановить и запустить инстанс в {{ foundation-models-name }}
description: Следуя данной инструкции, вы сможете остановить и запустить инстанс в {{ foundation-models-name }} в консоли управления.
---

# Остановить и запустить инстанс

## Остановить инстанс {#stop}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, на который у вашего аккаунта есть [роль](../../security/index.md#ai-models-editor) `ai.models.editor` или выше.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_foundation-models }}**.
  1. На панели слева нажмите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.yagpt.YaGPT.instances-title_j9Cpb }}**
  1. В строке с нужным [инстансом](../../concepts/generation/dedicated-instance.md) нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/square.svg) **{{ ui-key.yacloud.common.stop }}**.
  1. В открывшемся окне введите имя инстанса и нажмите **{{ ui-key.yacloud.common.stop }}**.

      Дождитесь завершения операции и обновите страницу. Статус инстанса изменится на `Stopped`.

{% endlist %}


## Запустить инстанс {#start}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, на который у вашего аккаунта есть [роль](../../security/index.md#ai-models-editor) `ai.models.editor` или выше.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_foundation-models }}**.
  1. На панели слева нажмите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.yagpt.YaGPT.instances-title_j9Cpb }}**
  1. В строке с нужным [инстансом](../../concepts/generation/dedicated-instance.md) нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/play.svg) **{{ ui-key.yacloud.common.start }}**.

      Обновите страницу. Статус инстанса изменится на `Starting` и через некоторое время на `Ready`.

{% endlist %}