---
title: Добавить цикл Foreach в рабочий процесс {{ sw-name }}
description: Следуя данной инструкции, вы сможете добавить последовательность шагов, которые будут выполняться над каждым элементом входных данных, в рабочий процесс {{ sw-full-name }} с помощью конструктора шагов рабочего процесса.
---

# Добавить цикл Foreach

Управляющий шаг Foreach позволяет задать последовательность шагов, которые будут выполняться над каждым элементом входных данных. Выходные данные — массив результатов выполнения всех шагов последовательности. Подробнее о [состоянии рабочего процесса при выполнении шага Foreach](../../../concepts/workflows/workflow.md#state-for-Foreach).

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. Из секции **{{ ui-key.yacloud.serverless-workflows.workflow-editor_management-group-label }}** в левой части экрана перетащите элемент ![code-fork](../../../../_assets/console-icons/code-fork.svg) **Foreach** в нужное место рабочего процесса в окне конструктора.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **Foreach**, чтобы выбрать его.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_foreach-step-concurrency-field }}** задайте количество элементов входных данных, над которыми одновременно будет выполняться указанная последовательность шагов.
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}
  1. Чтобы добавить новый шаг в последовательность, перетащите его в обозначенный пунктирной линией блок из секции **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** или **{{ ui-key.yacloud.serverless-workflows.workflow-editor_management-group-label }}**.

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/management/foreach.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
