---
title: Добавить взаимодействие с агентами {{ ai-studio-name }} в рабочий процесс {{ sw-name }}
description: Следуя данной инструкции, вы сможете добавить взаимодействие с агентами {{ ai-studio-name }} в рабочий процесс {{ sw-full-name }} с помощью конструктора шагов рабочего процесса.
---

# Взаимодействие с агентами {{ ai-studio-name }}

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. Из секции **{{ ai-studio-name }}** в левой части экрана перетащите элемент ![face-robot](../../../../_assets/console-icons/face-robot.svg) **Агент {{ ai-studio-name }}** в нужное место рабочего процесса в окне конструктора.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **Агент {{ ai-studio-name }}**, чтобы выбрать его.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. В поле **Идентификатор агента** укажите идентификатор [агента {{ ai-studio-name }}](../../../../ai-studio/concepts/agents/index.md).
      1. В поле **Переменные промта** нажмите кнопку **Добавить переменную**, чтобы добавить имена и значения переменных, которые будут использоваться в промте. Для значений переменных поддерживается [шаблонизация](../../../concepts/workflows/templating.md).

          Чтобы добавить несколько переменных, нажмите **Добавить переменную** необходимое количество раз.

      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}
  1. {% include [integrations-step-add-catch-rule](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-add-catch-rule.md) %}

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/integration/aistudioagent.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
