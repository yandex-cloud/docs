---
title: Добавить шаг Success в рабочий процесс {{ sw-name }}
description: Следуя данной инструкции, вы сможете добавить шаг Success, успешно завершающий запуск рабочего процесса, в рабочий процесс {{ sw-full-name }} с помощью конструктора шагов рабочего процесса.
---

# Добавить шаг Success

Управляющий шаг Success успешно завершает запуск рабочего процесса. Если шаг находится внутри шагов [Foreach](./foreach.md) или [Parallel](./parallel.md), завершается запуск всего рабочего процесса, а не только текущей ветки выполнения.

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. Из секции **{{ ui-key.yacloud.serverless-workflows.workflow-editor_management-group-label }}** в левой части экрана перетащите элемент ![seal-check](../../../../_assets/console-icons/seal-check.svg) **Success** в нужное место рабочего процесса в окне конструктора.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **Success**, чтобы выбрать его.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/management/success.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)