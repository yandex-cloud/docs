# Настроить правило перехода по ошибкам

Для каждого [интеграционного шага](../../../concepts/workflows/yawl/index.md#integration-steps) рабочего процесса вы можете настраивать [правила перехода по ошибкам](../../../concepts/workflows/yawl/index.md#catchrule), возникшим во время выполнения этого шага. Правила применяются последовательно после применения политики повторных попыток.

Чтобы настроить правило перехода по ошибкам интеграционного шага рабочего процесса:

{% list tabs %}

- Консоль управления {#console}

  1. В процессе [создания](../workflow/create-constructor.md) нового рабочего процесса или [изменения](../workflow/update.md) существующего в консоли управления в блоке **{{ ui-key.yacloud.serverless-workflows.label_create-workflow-title }}** / **{{ ui-key.yacloud.serverless-workflows.label_edit-workflow-title }}** выберите `{{ ui-key.yacloud.serverless-workflows.spec-editor-type_label_visual-editor }}`.
  1. В правом нижнем углу блока с нужным [интеграционным шагом](../../../concepts/workflows/yawl/index.md#integration-steps) нажмите значок ![pencil](../../../../_assets/serverless-integrations/circle-plus-fill-red.svg).
  1. В блоке **{{ ui-key.yacloud.serverless-workflows.workflow-editor_catch-rule-label }}**:

      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_catch-rule-error-list-label }}** выберите ошибки, при возникновении которых будет (или, наоборот, не будет) выполнен переход к следующему шагу рабочего процесса.

          Подробную информацию о возможных ошибках см. в разделе [{#T}](../../../concepts/workflows/execution.md#errors).
      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_catch-rule-error-list-mode-label }}** выберите:

          * `INCLUDE` — чтобы выполнять переход к следующему шагу рабочего процесса при возникновении ошибок, указанных в поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_catch-rule-error-list-label }}**.
          * `EXCLUDE` — чтобы выполнять переход к следующему шагу рабочего процесса при возникновении любых ошибок, за исключением ошибок, указанных в поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_catch-rule-error-list-label }}**.
      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_catch-rule-output-field }}** задайте [jq-шаблон](../../../concepts/workflows/templating.md), фильтрующий выходные данные шага, которые добавляются в состояние рабочего процесса. При этом jq-шаблон, заданный для этого шага на вкладке **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_node-output-label }}**, не применяется.

  1. Чтобы добавить следующий шаг, на который будет выполняться переход по ошибкам, из секции **Интеграционные шаги** или **Управляющие шаги** перетащите нужный шаг в обозначенный пунктирной линией блок, который был добавлен в рабочий процесс одновременно с создаваемым правилом перехода по ошибкам.

{% endlist %}

## См. также {#see-also}

* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)