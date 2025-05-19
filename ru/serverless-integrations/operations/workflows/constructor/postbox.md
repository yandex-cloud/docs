---
title: Добавить рассылку писем с помощью {{ postbox-short-name }} в рабочий процесс {{ sw-name }}
description: Следуя данной инструкции, вы сможете добавить рассылку писем с помощью {{ postbox-full-name }} в рабочий процесс {{ sw-full-name }} с помощью конструктора шагов рабочего процесса.
---

# Рассылка писем с помощью {{ postbox-full-name }}

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. Из секции **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** в левой части экрана перетащите элемент ![postbox-icon](../../../../_assets/postbox-icon.svg) **{{ postbox-short-name }}** в нужное место рабочего процесса в окне конструктора.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **{{ postbox-short-name }}**, чтобы выбрать его.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. В поле **Адрес отправителя** укажите адрес {{ postbox-full-name }}, с которого будут отправляться письма.

          {% note info %}

          [Сервисный аккаунт](../../../../iam/concepts/users/service-accounts.md), указанный в настройках рабочего процесса, и адрес, указанный в этом поле, должны находиться в одном [каталоге](../../../../resource-manager/concepts/resources-hierarchy.md#folder).
 
          {% endnote %}

      1. В блоке **Адреса получателей** выберите:

          * `Массив адресов`, чтобы задать адреса получателей по одному при помощи кнопки ![plus](../../../../_assets/console-icons/plus.svg) **Добавить получателя**.
          * `Сырая строка`, чтобы задать адреса получателей в виде списка через запятую.

      1. (Опционально) В блоке **Адреса скрытых копий** выберите:

          * `Массив адресов`, чтобы задать адреса получателей скрытых копий по одному при помощи кнопки ![plus](../../../../_assets/console-icons/plus.svg) **Добавить скрытую копию**.
          * `Сырая строка`, чтобы задать адреса получателей скрытых копий в виде списка через запятую.

      1. В блоке **Письмо** задайте содержимое отправляемого сообщения. Выберите:

          * `Текст`, чтобы задать содержимое письма с помощью формы:

              1. В поле **Тема** укажите заголовок сообщения.
              1. В поле **HTML-контент** укажите текст сообщения для отображения письма в почтовых клиентах, поддерживающих HTML.
              1. В поле **Текст** укажите текст сообщения для отображения письма в почтовых клиентах, не поддерживающих HTML.
              1. В поле **Кодировка** выберите кодировку отправляемого сообщения.

          * `Шаблон`, чтобы задать содержимое письма в виде шаблона. Подробнее см. в [документации {{ postbox-name }}](../../../../postbox/aws-compatible-api/api-ref/send-email.md).

      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/integration/postbox.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
