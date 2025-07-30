---
title: Добавить обращение к Telegram Bot API в рабочий процесс {{ sw-name }}
description: Следуя данной инструкции, вы сможете добавить обращение к Telegram Bot API в рабочий процесс {{ sw-full-name }} с помощью конструктора шагов рабочего процесса.
---

# Обращение к Telegram Bot API

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. Из секции **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** в левой части экрана перетащите элемент ![foundation-models-icon](../../../../_assets/console-icons/logo-telegram.svg) **Telegram-бот** в нужное место рабочего процесса в окне конструктора.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **Telegram-бот**, чтобы выбрать его.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. В блоке **Токен** укажите [токен бота](https://core.telegram.org/bots/features#creating-a-new-bot) или [секрет](../../../../lockbox/concepts/secret.md) {{ lockbox-name }}, в котором сохранен этот токен. Выберите:

          * `Lockbox`, чтобы хранить токен бота в секрете, и в блоке **Cекрет** выберите секрет, его [версию](../../../../lockbox/concepts/secret.md#version) и ключ, в которых сохранен токен бота.

              Если у вас еще нет секрета {{ lockbox-name }}, нажмите кнопку **Создать**, чтобы создать его.

          * `Текст`, чтобы хранить токен бота в спецификации в виде текста, и в поле **Значение** введите токен бота.

              {% note warning %}

              Хранить токен бота в открытом виде в тексте спецификации небезопасно.

              {% endnote %}

      1. В блоке **Действие**:

          1. В поле **Идентификатор чата** укажите идентификатор чата или имя канала в формате `@channelusername`.
          1. В поле **Текст** введите текст сообщения, который нужно отправить.
          1. (Опционально) В поле **Ответить на сообщение** укажите идентификатор сообщения, на которое нужно ответить.
          1. (Опционально) В поле **Режим форматирования** выберите режим форматирования сообщения. Подробнее см. [документацию Telegram Bot API](https://core.telegram.org/bots/api#formatting-options).

      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/integration/telegrambot.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
