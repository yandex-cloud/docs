# Добавить шаг Fail

Управляющий шаг Fail завершает запуск рабочего процесса с ошибкой. Если шаг находится внутри шагов [Foreach](foreach.md) или [Parallel](parallel.md), завершается запуск всего рабочего процесса, а не только текущей ветки выполнения.

{% list tabs %}

- Консоль управления {#console}

  1. В процессе [создания](../workflow/create-constructor.md) нового рабочего процесса или [изменения](../workflow/update.md) существующего в консоли управления в блоке **{{ ui-key.yacloud.serverless-workflows.label_create-workflow-title }}** / **{{ ui-key.yacloud.serverless-workflows.label_edit-workflow-title }}** выберите `{{ ui-key.yacloud.serverless-workflows.spec-editor-type_label_visual-editor }}`. 
  1. Из секции **Управляющие шаги** в левой части экрана перетащите элемент ![octagon-xmark](../../../../_assets/console-icons/octagon-xmark.svg) **Fail** в нужное место рабочего процесса в окне конструктора.

      Перетаскивать шаги можно в обозначенные пунктирной линией блоки на графической схеме рабочего процесса, такие как **Добавить шаг** и т.п.
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **Fail**, чтобы выбрать его.
  1. В правой части окна на вкладке **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_node-settings-label }}**:

      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_step-name-label }}** задайте имя шага рабочего процесса.

      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_error-message-label }}** задайте текст сообщения об ошибке, которым будет завершаться запуск рабочего процесса.

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/management/fail.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)