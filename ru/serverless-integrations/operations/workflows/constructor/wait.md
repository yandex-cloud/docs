---
title: Добавить шаг Wait в рабочий процесс {{ sw-name }}
description: Следуя данной инструкции, вы сможете добавить шаг Wait, дожидающийся наступления заданного момента во времени, в рабочий процесс {{ sw-full-name }} с помощью конструктора шагов рабочего процесса.
---

# Добавить шаг Wait

Управляющий шаг Wait приостанавливает выполнение рабочего процесса на заданный интервал времени или до наступления заданной временной метки. Если заданный интервал времени отрицательный или равен нулю, а также если указанная временная метка уже наступила, данный шаг завершится мгновенно.

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. Из секции **{{ ui-key.yacloud.serverless-workflows.workflow-editor_management-group-label }}** в левой части экрана перетащите элемент ![clock](../../../../_assets/console-icons/clock.svg) **Wait** в нужное место рабочего процесса в окне конструктора.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **Wait**, чтобы выбрать его.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. В блоке **{{ ui-key.yacloud.serverless-workflows.workflow-editor_wait-step-type-field }}** выберите:

          * `{{ ui-key.yacloud.serverless-workflows.workflow-editor_wait-step-type-field-duration-label }}`, чтобы задать длительность ожидания в секундах, и в поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_wait-step-duration-field }}** укажите нужное значение.
          * `{{ ui-key.yacloud.serverless-workflows.workflow-editor_wait-step-type-field-until-label }}`, чтобы задать ожидание до наступления определенного момента во времени, и в поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_wait-step-until-field }}** укажите нужный момент времени в формате [ISO 8601](https://{{ lang }}.wikipedia.org/wiki/ISO_8601) или найдите нужную дату с помощью интерактивного календаря ![calendar](../../../../_assets/console-icons/calendar.svg).
          
          Чтобы получить длительности ожидания или временную метку из состояния рабочего процесса, включите опцию **{{ ui-key.yacloud.serverless-workflows.workflow-editor_wait-step-use-jq-expression-field }}** и в поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_wait-step-jq-expression-field }}** задайте шаблон в формате jq. Подробнее см. [{#T}](../../../concepts/workflows/templating.md).

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/management/wait.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
