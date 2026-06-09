# Добавить цикл Foreach

Управляющий шаг Foreach позволяет задать последовательность шагов, которые будут выполняться над каждым элементом входных данных. Выходные данные — массив результатов выполнения всех шагов последовательности. Подробнее о [состоянии рабочего процесса при выполнении шага Foreach](../../../concepts/workflows/workflow.md#state-for-Foreach).

{% list tabs %}

- Консоль управления {#console}

  1. В процессе [создания](../workflow/create-constructor.md) нового рабочего процесса или [изменения](../workflow/update.md) существующего в консоли управления в блоке **{{ ui-key.yacloud.serverless-workflows.label_create-workflow-title }}** / **{{ ui-key.yacloud.serverless-workflows.label_edit-workflow-title }}** выберите `{{ ui-key.yacloud.serverless-workflows.spec-editor-type_label_visual-editor }}`. 
  1. Из секции **Управляющие шаги** в левой части экрана перетащите элемент ![code-fork](../../../../_assets/console-icons/code-fork.svg) **Foreach** в нужное место рабочего процесса в окне конструктора.

      Перетаскивать шаги можно в обозначенные пунктирной линией блоки на графической схеме рабочего процесса, такие как **Добавить шаг** и т.п.
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **Foreach**, чтобы выбрать его.
  1. В правой части окна на вкладке **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_node-settings-label }}**:

      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_step-name-label }}** задайте имя шага рабочего процесса.
      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_foreach-step-concurrency-field }}** задайте количество элементов входных данных, над которыми одновременно будет выполняться указанная последовательность шагов.
  1. (Опционально) Перейдите на вкладку **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_node-input-label }}** и задайте [jq-шаблон](../../../concepts/workflows/templating.md) для фильтрации [состояния рабочего процесса](../../../concepts/workflows/workflow.md#state), которое передается в шаг.
  1. (Опционально) Перейдите на вкладку **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_node-output-label }}** и задайте [jq-шаблон](../../../concepts/workflows/templating.md) для фильтрации выходных данных шага, которые добавляются в [состояние рабочего процесса](../../../concepts/workflows/workflow.md#state).
  1. Чтобы добавить новый шаг в последовательность, перетащите его в обозначенный пунктирной линией блок из секции **Интеграционные шаги** или **Управляющие шаги**.

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/management/foreach.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)