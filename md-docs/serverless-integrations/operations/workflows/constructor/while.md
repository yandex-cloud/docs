# Добавить цикл While

Управляющий шаг While позволяет задать последовательность шагов, которые будут выполняться в цикле. Шаг выполняется, пока соблюдено заданное в поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_while-step-condition-field }}** условие, но не более чем заданное в поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_while-step-max-iterations-field }}** количество раз. Если условие не задано, шаг выполняется указанное количество раз. Если ограничение на количество итераций не задано, цикл будет выполняться, пока соблюдено условие или до достижения [таймаута](../../../concepts/limits.md) выполнения рабочего процесса.

Каждая ветка выполнения внутри шага While (с учетом всех шагов [Switch](switch.md)) должна содержать [интеграционный шаг](index.md#integration-steps) или шаг [Success](success.md), [Fail](fail.md) или [Wait](wait.md).

{% list tabs %}

- Консоль управления {#console}

  1. В процессе [создания](../workflow/create-constructor.md) нового рабочего процесса или [изменения](../workflow/update.md) существующего в консоли управления в блоке **{{ ui-key.yacloud.serverless-workflows.label_create-workflow-title }}** / **{{ ui-key.yacloud.serverless-workflows.label_edit-workflow-title }}** выберите `{{ ui-key.yacloud.serverless-workflows.spec-editor-type_label_visual-editor }}`. 
  1. Из секции **Управляющие шаги** в левой части экрана перетащите элемент ![arrows-rotate-right](../../../../_assets/console-icons/arrows-rotate-right.svg) **While** в нужное место рабочего процесса в окне конструктора.

      Перетаскивать шаги можно в обозначенные пунктирной линией блоки на графической схеме рабочего процесса, такие как **Добавить шаг** и т.п.
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **While**, чтобы выбрать его.
  1. В правой части окна на вкладке **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_node-settings-label }}**:

      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_step-name-label }}** задайте имя шага рабочего процесса.
      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_while-step-condition-field }}** задайте условие в формате jq, которое возвращает строку `true` или `false`. Поле является обязательным к заполнению, если не задано значение поля **{{ ui-key.yacloud.serverless-workflows.workflow-editor_while-step-max-iterations-field }}**.
      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_while-step-max-iterations-field }}** задайте максимальное количество итераций, которое может совершить цикл. Поле является обязательным к заполнению, если не задано значение поля **{{ ui-key.yacloud.serverless-workflows.workflow-editor_while-step-condition-field }}**.
  1. (Опционально) Перейдите на вкладку **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_node-input-label }}** и задайте [jq-шаблон](../../../concepts/workflows/templating.md) для фильтрации [состояния рабочего процесса](../../../concepts/workflows/workflow.md#state), которое передается в шаг.
  1. (Опционально) Перейдите на вкладку **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_node-output-label }}** и задайте [jq-шаблон](../../../concepts/workflows/templating.md) для фильтрации выходных данных шага, которые добавляются в [состояние рабочего процесса](../../../concepts/workflows/workflow.md#state).
  1. Чтобы добавить новый шаг в ветку выполнения, перетащите нужный шаг из секции **Интеграционные шаги** или **Управляющие шаги** в обозначенный пунктирной линией блок внутри ветки.

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/management/while.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)