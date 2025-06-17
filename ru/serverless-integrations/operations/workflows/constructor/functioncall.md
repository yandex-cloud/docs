---
title: Добавить вызов функции {{ sf-short-name }} в рабочий процесс {{ sw-name }}
description: Следуя данной инструкции, вы сможете добавить вызов функции {{ sf-full-name }} в рабочий процесс {{ sw-full-name }} с помощью конструктора шагов рабочего процесса.
---

# Вызов функции {{ sf-full-name }}

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. Из секции **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** в левой части экрана перетащите элемент ![CurlyBracketsFunction](../../../../_assets/console-icons/curly-brackets-function.svg) **{{ sf-short-name }}** в нужное место рабочего процесса в окне конструктора.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **{{ sf-short-name }}**, чтобы выбрать его.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.functions_integration_properties_serverless_function_view_spec_layout_title }}** выберите функцию и [версию](../../../../functions/concepts/function.md#version) функции, которая будет вызываться во время выполнения шага.
      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/integration/functioncall.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
