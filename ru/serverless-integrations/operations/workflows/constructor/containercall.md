---
title: Добавить вызов контейнера {{ serverless-containers-name }} в рабочий процесс {{ sw-name }}
description: Следуя данной инструкции, вы сможете добавить вызов контейнера {{ serverless-containers-full-name }} в рабочий процесс {{ sw-full-name }} с помощью конструктора шагов рабочего процесса.
---

# Вызов контейнера {{ serverless-containers-full-name }}

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. Из секции **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** в левой части экрана перетащите элемент ![serverless-container-icon](../../../../_assets/serverless-container-icon.svg) **{{ serverless-containers-short-name }}** в нужное место рабочего процесса в окне конструктора.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **{{ serverless-containers-short-name }}**, чтобы выбрать его.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. В поле **Контейнер** выберите контейнер, который будет вызываться во время выполнения шага.
      1. В поле **Метод запроса** выберите HTTP-метод запроса.
      1. (Опционально) В поле **Путь запроса** укажите HTTP-путь запроса.
      1. (Опционально) В поле **Query-параметры запроса** нажмите кнопку ![plus](../../../../_assets/console-icons/plus.svg) **Добавить параметр**, чтобы добавить к HTTP-запросу query-параметр в формате `<Имя_параметра>`:`<Значение_параметра>`.

          Чтобы добавить в запрос несколько query-параметров, нажмите ![plus](../../../../_assets/console-icons/plus.svg) **Добавить параметр** необходимое количество раз.

          Чтобы удалить ненужный query-параметр, в строке с этим параметром нажмите значок ![trash-bin](../../../../_assets/console-icons/trash-bin.svg).
      1. (Опционально) В поле **Заголовки запроса** нажмите кнопку ![plus](../../../../_assets/console-icons/plus.svg) **Добавить заголовок**, чтобы добавить к HTTP-запросу заголовок в формате `<Имя_заголовка>`:`<Значение_заголовка>`.

          Чтобы добавить в запрос несколько заголовков, нажмите ![plus](../../../../_assets/console-icons/plus.svg) **Добавить заголовок** необходимое количество раз.

          Чтобы удалить ненужный заголовок, в строке с этим заголовком нажмите значок ![trash-bin](../../../../_assets/console-icons/trash-bin.svg).
      1.  (Опционально) В поле **Тело запроса** укажите тело HTTP-запроса.
      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/integration/containercall.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
