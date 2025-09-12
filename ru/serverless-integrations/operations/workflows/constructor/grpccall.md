---
title: Добавить gRPC-вызов в рабочий процесс {{ sw-name }}
description: Следуя данной инструкции, вы сможете добавить gRPC-вызов заданного эндпоинта в рабочий процесс {{ sw-full-name }} с помощью конструктора шагов рабочего процесса.
---

# gRPC-вызов

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. Из секции **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** в левой части экрана перетащите элемент ![ArrowRightToSquare](../../../../_assets/console-icons/arrow-right-to-square.svg) **{{ ui-key.yc-serverless-workflows.dynamic-forms.grpc_integration_title }}** в нужное место рабочего процесса в окне конструктора.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **{{ ui-key.yc-serverless-workflows.dynamic-forms.grpc_integration_title }}**, чтобы выбрать его.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.grpc_properties_endpoint_view_spec_layout_title }}** укажите адрес сервера.
      1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.grpc_properties_method_view_spec_layout_title }}** укажите gRPC-метод.
      1. (Опционально) Включите опцию **{{ ui-key.yc-serverless-workflows.dynamic-forms.grpc_properties_use_service_account_view_spec_layout_title }}**, чтобы в запрос автоматически добавлялся заголовок с [IAM-токеном](../../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, указанного в настройках рабочего процесса.
      1. (Опционально) В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.grpc_properties_headers_view_spec_layout_title }}** при помощи кнопки ![plus](../../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-serverless-workflows.dynamic-forms.grpc_properties_headers_view_spec_item_label }}** добавьте необходимые заголовки в формате `<Имя>`:`<Значение>`.
      1. (Опционально) В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.grpc_properties_body_view_spec_layout_title }}** задайте тело gRPC-запроса.
      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}
  1. {% include [integrations-step-add-catch-rule](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-add-catch-rule.md) %}

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/integration/grpccall.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
