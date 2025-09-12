---
title: Добавить синхронный запуск рабочего процесса {{ sw-name }} в другой рабочий процесс {{ sw-name }}
description: Следуя данной инструкции, вы сможете добавить синхронный запуск рабочего процесса {{ sw-full-name }} в другой рабочий процесс {{ sw-name }} с помощью конструктора шагов рабочего процесса.
---

# Синхронный запуск другого рабочего процесса {{ sw-full-name }}

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. Из секции **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** в левой части экрана перетащите элемент ![graph-node](../../../../_assets/console-icons/graph-node.svg) **{{ sw-name }}** в нужное место рабочего процесса в окне конструктора.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **{{ sw-name }}**, чтобы выбрать его.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.workflow_properties_serverless_workflow_view_spec_layout_title }}** выберите другой рабочий процесс {{ sw-full-name }}, который вы хотите запускать синхронно с текущим.
      1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.workflow_properties_workflow_input_view_spec_layout_title }}** укажите входные данные для запуска рабочего процесса.
      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}
  1. {% include [integrations-step-add-catch-rule](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-add-catch-rule.md) %}

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/integration/workflow.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
