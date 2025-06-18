---
title: Добавить логику Parallel в рабочий процесс {{ sw-name }}
description: Следуя данной инструкции, вы сможете добавить логику Parallel, выполняющую параллельно несколько веток — последовательностей шагов, в рабочий процесс {{ sw-full-name }} с помощью конструктора шагов рабочего процесса.
---

# Добавить логику Parallel

Управляющий шаг Parallel выполняет параллельно несколько веток — последовательностей шагов. Результат выполнения шага — объект, в котором ключами являются имена веток выполнения, а значениями — выходные данные соответствующих веток выполнения. Подробнее о [состоянии рабочего процесса при выполнении шага Parallel](../../../concepts/workflows/workflow.md#state-for-Parallel).

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. Из секции **{{ ui-key.yacloud.serverless-workflows.workflow-editor_management-group-label }}** в левой части экрана перетащите элемент ![parallel-step-icon](../../../../_assets/serverless-integrations/parallel-step-icon.svg) **Parallel** в нужное место рабочего процесса в окне конструктора.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **Parallel**, чтобы выбрать его.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_parallel-step-concurrency-field }}** задайте количество одновременно выполняющихся веток. Например, если задать значение `2`, а всего добавлено 5 веток, одновременно будут выполняться не больше 2 веток, выбранных случайным образом.
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}
  1. Чтобы добавить новую ветку выполнения:

      1. В правом нижнем углу блока **Parallel** нажмите значок ![circle-plus-fill](../../../../_assets/console-icons/circle-plus-fill.svg).
      1. В открывшемся окне задайте имя добавляемой ветки и нажмите **{{ ui-key.yacloud.common.create }}**.
  1. Чтобы добавить новый шаг в ветку выполнения, перетащите его в обозначенный пунктирной линией блок из секции **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** или **{{ ui-key.yacloud.serverless-workflows.workflow-editor_management-group-label }}**.

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/management/parallel.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
