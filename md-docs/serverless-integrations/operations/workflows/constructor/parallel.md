# Добавить логику Parallel

Управляющий шаг Parallel выполняет параллельно несколько веток — последовательностей шагов. Результат выполнения шага — объект, в котором ключами являются имена веток выполнения, а значениями — выходные данные соответствующих веток выполнения. Подробнее о [состоянии рабочего процесса при выполнении шага Parallel](../../../concepts/workflows/workflow.md#state-for-Parallel).

{% list tabs %}

- Консоль управления {#console}

  1. В процессе [создания](../workflow/create-constructor.md) нового рабочего процесса или [изменения](../workflow/update.md) существующего в консоли управления в блоке **{{ ui-key.yacloud.serverless-workflows.label_create-workflow-title }}** / **{{ ui-key.yacloud.serverless-workflows.label_edit-workflow-title }}** выберите `{{ ui-key.yacloud.serverless-workflows.spec-editor-type_label_visual-editor }}`. 
  1. Из секции **Управляющие шаги** в левой части экрана перетащите элемент ![parallel-step-icon](../../../../_assets/serverless-integrations/parallel-step-icon.svg) **Parallel** в нужное место рабочего процесса в окне конструктора.

      Перетаскивать шаги можно в обозначенные пунктирной линией блоки на графической схеме рабочего процесса, такие как **Добавить шаг** и т.п.
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **Parallel**, чтобы выбрать его.
  1. В правой части окна на вкладке **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_node-settings-label }}**:

      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_step-name-label }}** задайте имя шага рабочего процесса.
      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_parallel-step-concurrency-field }}** задайте количество одновременно выполняющихся веток. Например, если задать значение `2`, а всего добавлено 5 веток, одновременно будут выполняться не больше 2 веток, выбранных случайным образом.
  1. (Опционально) Перейдите на вкладку **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_node-input-label }}** и задайте [jq-шаблон](../../../concepts/workflows/templating.md) для фильтрации [состояния рабочего процесса](../../../concepts/workflows/workflow.md#state), которое передается в шаг.
  1. (Опционально) Перейдите на вкладку **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_node-output-label }}** и задайте [jq-шаблон](../../../concepts/workflows/templating.md) для фильтрации выходных данных шага, которые добавляются в [состояние рабочего процесса](../../../concepts/workflows/workflow.md#state).
  1. Чтобы добавить новую ветку выполнения:

      1. В правом нижнем углу блока **Parallel** нажмите значок ![circle-plus-fill](../../../../_assets/console-icons/circle-plus-fill.svg).
      1. В открывшемся окне задайте имя добавляемой ветки и нажмите **{{ ui-key.yacloud.common.create }}**.
  1. Чтобы добавить новый шаг в ветку выполнения, перетащите его в обозначенный пунктирной линией блок из секции **Интеграционные шаги** или **Управляющие шаги**.

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/management/parallel.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)