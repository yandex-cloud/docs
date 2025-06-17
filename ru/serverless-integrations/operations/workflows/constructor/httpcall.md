---
title: Добавить HTTP-запрос в рабочий процесс {{ sw-name }}
description: Следуя данной инструкции, вы сможете добавить HTTP-запрос к заданному эндпоинту в рабочий процесс {{ sw-full-name }} с помощью конструктора шагов рабочего процесса.
---

# HTTP-запрос

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. Из секции **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** в левой части экрана перетащите элемент ![ArrowShapeRightToLine](../../../../_assets/console-icons/arrow-shape-right-to-line.svg) **{{ ui-key.yacloud.common.label_http }}** в нужное место рабочего процесса в окне конструктора.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **{{ ui-key.yacloud.common.label_http }}**, чтобы выбрать его.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.http_properties_http_method_view_spec_layout_title }}** выберите HTTP-метод запроса: `OPTIONS`, `GET`, `HEAD`, `POST`, `PUT`, `PATCH`, `DELETE` или `TRACE`.
      1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.http_properties_url_view_spec_layout_title }}** укажите URL запроса.
      1. (Опционально) В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.http_properties_query_view_spec_layout_title }}** при помощи кнопки ![plus](../../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-serverless-workflows.dynamic-forms.http_properties_query_view_spec_item_label }}** добавьте необходимые query-параметры в формате `<Имя>`:`<Значение>`.
      1. (Опционально) В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.http_properties_headers_view_spec_layout_title }}** при помощи кнопки ![plus](../../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-serverless-workflows.dynamic-forms.http_properties_headers_view_spec_item_label }}** добавьте необходимые заголовки в формате `<Имя>`:`<Значение>`.
      1. (Опционально) В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.http_properties_body_view_spec_layout_title }}** задайте тело запроса.
      1. (Опционально) Включите опцию **{{ ui-key.yc-serverless-workflows.dynamic-forms.http_properties_use_service_account_view_spec_layout_title }}**, чтобы в запрос автоматически добавлялся заголовок с [IAM-токеном](../../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, указанного в настройках рабочего процесса.
      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/integration/httpcall.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
