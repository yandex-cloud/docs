---
title: Настроить правило перехода по ошибкам для шага рабочего процесса {{ sw-name }}
description: Следуя данной инструкции, вы сможете настроить правило перехода по ошибкам для интеграционного шага рабочего процесса {{ sw-full-name }} с помощью конструктора шагов рабочего процесса.
---

# Настроить правило перехода по ошибкам

Для каждого [интеграционного шага](../../../concepts/workflows/yawl/index.md#integration-steps) рабочего процесса вы можете настраивать [правила перехода по ошибкам](../../../concepts/workflows/yawl/index.md#catchrule), возникшим во время выполнения этого шага. Правила применяются последовательно после применения политики повторных попыток.

Чтобы настроить правило перехода по ошибкам интеграционного шага рабочего процесса:

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %}
  1. В правом нижнем углу блока с нужным [интеграционным шагом](../../../concepts/workflows/yawl/index.md#integration-steps) нажмите значок ![pencil](../../../../_assets/serverless-integrations/circle-plus-fill-red.svg).
  1. В блоке **{{ ui-key.yacloud.serverless-workflows.workflow-editor_catch-rule-label }}**:

      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_catch-rule-error-list-label }}** выберите ошибки, при возникновении которых будет (или, наоборот, не будет) выполнен переход к следующему шагу рабочего процесса.

          {% include [error-details](../../../../_includes/serverless-integrations/workflows-constructor/error-details.md) %}
      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_catch-rule-error-list-mode-label }}** выберите:

          * `INCLUDE` — чтобы выполнять переход к следующему шагу рабочего процесса при возникновении ошибок, указанных в поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_catch-rule-error-list-label }}**.
          * `EXCLUDE` — чтобы выполнять переход к следующему шагу рабочего процесса при возникновении любых ошибок, за исключением ошибок, указанных в поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_catch-rule-error-list-label }}**.
      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_catch-rule-output-field }}** задайте [jq-шаблон](../../../concepts/workflows/templating.md), фильтрующий выходные данные шага, которые добавляются в состояние рабочего процесса. При этом jq-шаблон, заданный для этого шага на вкладке **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_node-output-label }}**, не применяется.

  1. Чтобы добавить следующий шаг, на который будет выполняться переход по ошибкам, из секции **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** или **{{ ui-key.yacloud.serverless-workflows.workflow-editor_management-group-label }}** перетащите нужный шаг в обозначенный пунктирной линией блок, который был добавлен в рабочий процесс одновременно с создаваемым правилом перехода по ошибкам.

{% endlist %}

## См. также {#see-also}

* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)