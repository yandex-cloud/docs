---
title: Как получить информацию об инстансе в {{ foundation-models-name }}
description: Следуя данной инструкции, вы сможете получить информацию об инстансе в {{ foundation-models-name }} в консоли управления.
---

# Получить информацию об инстансе

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, на который у вашего аккаунта есть [роль](../../security/index.md#ai-models-editor) `ai.models.editor` или выше.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_ai-studio }}**.
  1. На панели слева нажмите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.yagpt.YaGPT.instances-title_j9Cpb }}**
  1. Выберите нужный [инстанс](../../concepts/generation/dedicated-instance.md).

      На странице **{{ ui-key.yacloud.common.overview }}** отобразится информация об инстансе.

      Чтобы получить код запроса к инстансу, нажмите ![image](../../../_assets/console-icons/code.svg) **Посмотреть код**.

{% endlist %}