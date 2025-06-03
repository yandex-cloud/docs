---
title: Добавить цикл While в рабочий процесс {{ sw-name }}
description: Следуя данной инструкции, с помощью конструктора шагов рабочего процесса вы сможете добавить в рабочий процесс {{ sw-full-name }} последовательность шагов, которые будут выполняться над каждым элементом входных данных заданное количество раз или пока выполняется заданное условие.
---

# Добавить цикл While

Управляющий шаг While позволяет задать последовательность шагов, которые будут выполняться в цикле. Шаг выполняется, пока соблюдено заданное в поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_while-step-condition-field }}** условие, но не более чем заданное в поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_while-step-max-iterations-field }}** количество раз. Если условие не задано, шаг выполняется указанное количество раз. Если ограничение на количество итераций не задано, цикл будет выполняться, пока соблюдено условие или до достижения [таймаута](../../../concepts/limits.md) выполнения рабочего процесса.

Каждая ветка выполнения внутри шага While (с учетом всех шагов [Switch](./switch.md)) должна содержать [интеграционный шаг](./index.md#integration-steps) или шаг [Success](./success.md), [Fail](./fail.md) или [Wait](./wait.md).

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. Из секции **{{ ui-key.yacloud.serverless-workflows.workflow-editor_management-group-label }}** в левой части экрана перетащите элемент ![arrows-rotate-right](../../../../_assets/console-icons/arrows-rotate-right.svg) **While** в нужное место рабочего процесса в окне конструктора.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **While**, чтобы выбрать его.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_while-step-condition-field }}** задайте условие в формате jq, которое возвращает строку `true` или `false`. Поле является обязательным к заполнению, если не задано значение поля **{{ ui-key.yacloud.serverless-workflows.workflow-editor_while-step-max-iterations-field }}**.
      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_while-step-max-iterations-field }}** задайте максимальное количество итераций, которое может совершить цикл. Поле является обязательным к заполнению, если не задано значение поля **{{ ui-key.yacloud.serverless-workflows.workflow-editor_while-step-condition-field }}**.
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}
  1. Чтобы добавить новый шаг в ветку выполнения, перетащите нужный шаг из секции **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** или **{{ ui-key.yacloud.serverless-workflows.workflow-editor_management-group-label }}** в обозначенный пунктирной линией блок внутри ветки.

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/management/while.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
