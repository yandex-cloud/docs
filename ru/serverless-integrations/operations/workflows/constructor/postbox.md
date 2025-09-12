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
      1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_from_address_view_spec_layout_title }}** укажите адрес {{ postbox-full-name }}, с которого будут отправляться письма.

          {% note info %}

          [Сервисный аккаунт](../../../../iam/concepts/users/service-accounts.md), указанный в настройках рабочего процесса, и адрес, указанный в этом поле, должны находиться в одном [каталоге](../../../../resource-manager/concepts/resources-hierarchy.md#folder).
 
          {% endnote %}

      1. В блоке **{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_to_addresses_view_spec_layout_title }}** выберите:

          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_to_addresses_properties_address_array_view_spec_layout_title }}`, чтобы задать адреса получателей по одному при помощи кнопки ![plus](../../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_to_addresses_properties_address_array_view_spec_item_label }}**.
          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_to_addresses_properties_raw_string_view_spec_layout_title }}`, чтобы задать адреса получателей в виде списка через запятую.

      1. (Опционально) В блоке **{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_cc_to_addresses_view_spec_layout_title }}** выберите:

          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_cc_to_addresses_properties_address_array_view_spec_layout_title }}`, чтобы задать адреса получателей скрытых копий по одному при помощи кнопки ![plus](../../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_cc_to_addresses_properties_address_array_view_spec_item_label }}**.
          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_cc_to_addresses_properties_raw_string_view_spec_layout_title }}`, чтобы задать адреса получателей скрытых копий в виде списка через запятую.

      1. В блоке **{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_message_view_spec_layout_title }}** задайте содержимое отправляемого сообщения. Выберите:

          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_message_properties_simple_properties_body_text_view_spec_layout_title }}`, чтобы задать содержимое письма с помощью формы:

              1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_message_properties_simple_properties_subject_view_spec_layout_title }}** укажите заголовок сообщения.
              1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_message_properties_simple_properties_body_html_view_spec_layout_title }}** укажите текст сообщения для отображения письма в почтовых клиентах, поддерживающих HTML.
              1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_message_properties_simple_view_spec_layout_title }}** укажите текст сообщения для отображения письма в почтовых клиентах, не поддерживающих HTML.
              1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_message_properties_simple_properties_charset_view_spec_layout_title }}** выберите кодировку отправляемого сообщения.

          * `{{ ui-key.yc-serverless-workflows.dynamic-forms.postbox_properties_message_properties_raw_view_spec_layout_title }}`, чтобы задать содержимое письма в виде шаблона. Подробнее см. в [документации {{ postbox-name }}](../../../../postbox/aws-compatible-api/api-ref/send-email.md).

      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}
  1. {% include [integrations-step-add-catch-rule](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-add-catch-rule.md) %}

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/integration/postbox.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
