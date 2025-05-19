---
title: Добавить шаг No op в рабочий процесс {{ sw-name }}
description: Следуя данной инструкции, вы сможете добавить шаг No op, не выполняющий никаких операций, в рабочий процесс {{ sw-full-name }} с помощью конструктора шагов рабочего процесса.
---

# Добавить шаг No op

Управляющий шаг No op не выполняет никаких действий. Этот шаг нужен, например, чтобы успешно завершить пайплайн, если в шаге [Switch](./switch.md) было выполнено условие по умолчанию, или если требуется сделать заглушку на месте одного из шагов на этапе прототипирования.

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. Из секции **{{ ui-key.yacloud.serverless-workflows.workflow-editor_management-group-label }}** в левой части экрана перетащите элемент ![no-op-icon](../../../../_assets/serverless-integrations/no-op-icon.svg) **No op** в нужное место рабочего процесса в окне конструктора.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **No op**, чтобы выбрать его.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/management/noop.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)