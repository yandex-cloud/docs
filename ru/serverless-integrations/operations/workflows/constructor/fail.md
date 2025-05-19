---
title: Добавить шаг Fail в рабочий процесс {{ sw-name }}
description: Следуя данной инструкции, вы сможете добавить шаг Fail, завершающий запуск рабочего процесса с ошибкой, в рабочий процесс {{ sw-full-name }} с помощью конструктора шагов рабочего процесса.
---

# Добавить шаг Fail

Управляющий шаг Fail завершает запуск рабочего процесса с ошибкой. Если шаг находится внутри шагов [Foreach](./foreach.md) или [Parallel](./parallel.md), завершается запуск всего рабочего процесса, а не только текущей ветки выполнения.

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. Из секции **{{ ui-key.yacloud.serverless-workflows.workflow-editor_management-group-label }}** в левой части экрана перетащите элемент ![octagon-xmark](../../../../_assets/console-icons/octagon-xmark.svg) **Fail** в нужное место рабочего процесса в окне конструктора.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **Fail**, чтобы выбрать его.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}

      1. В поле **Текст ошибки** задайте текст сообщения об ошибке, которым будет завершаться запуск рабочего процесса.

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/management/fail.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)