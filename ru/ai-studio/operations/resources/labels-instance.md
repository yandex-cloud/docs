---
title: Как управлять метками инстанса в {{ foundation-models-name }}
description: Следуя данной инструкции, вы сможете управлять метками инстанса в {{ foundation-models-name }} в консоли управления.
---

# Управлять метками инстанса

## Добавить метку {#add-label}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, на который у вашего аккаунта есть [роль](../../security/index.md#ai-models-editor) `ai.models.editor` или выше.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_ai-studio }}**.
  1. На панели слева нажмите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.yagpt.YaGPT.instances-title_j9Cpb }}**
  1. В строке с нужным [инстансом](../../concepts/generation/dedicated-instance.md) нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
  1. Введите ключ и нажмите **Enter**.
  1. Введите значение и нажмите **Enter**.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}


## Удалить метку {#add-label}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, на который у вашего аккаунта есть [роль](../../security/index.md#ai-models-editor) `ai.models.editor` или выше.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_ai-studio }}**.
  1. На панели слева нажмите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.yagpt.YaGPT.instances-title_j9Cpb }}**
  1. В строке с нужным [инстансом](../../concepts/generation/dedicated-instance.md) нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. в поле **Метки** выберите нужную метку. Нажмите ![image](../../../_assets/console-icons/xmark.svg) справа от ее имени.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}