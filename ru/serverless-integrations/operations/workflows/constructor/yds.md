---
title: Добавить отправку сообщений в топик {{ yds-name }} в рабочий процесс {{ sw-name }}
description: Следуя данной инструкции, вы сможете добавить отправку сообщений в топик {{ yds-full-name }} в рабочий процесс {{ sw-full-name }} с помощью конструктора шагов рабочего процесса.
---

# Отправку сообщений в топик {{ yds-full-name }}

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. Из секции **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** в левой части экрана перетащите элемент ![yds-icon](../../../../_assets/yds-icon.svg) **{{ ui-key.yc-serverless-workflows.dynamic-forms.yds_integration_title }}** в нужное место рабочего процесса в окне конструктора.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **{{ ui-key.yc-serverless-workflows.dynamic-forms.yds_integration_title }}**, чтобы выбрать его.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.yds_properties_database_view_spec_layout_title }}** выберите бессерверную [базу данных {{ ydb-short-name }}](../../../../ydb/concepts/resources.md#serverless).
      1. В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.yds_properties_topic_view_spec_layout_title }}** укажите идентификатор топика.
      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}
  1. {% include [integrations-step-add-catch-rule](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-add-catch-rule.md) %}

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/integration/yds.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
