# Добавить выбор дальнейшего пути выполнения Switch

Управляющий шаг Switch позволяет с помощью задаваемых условий выбрать дальнейший путь выполнения рабочего процесса. При этом выбран может быть только один путь — тот, для которого заданное условие первым вернуло значение `true`.

Если все условия вернули `false`, рабочий процесс будет выполняться по пути, заданному в условии по умолчанию, а при отсутствии условия по умолчанию запуск рабочего процесса завершится с ошибкой.

{% list tabs %}

- Консоль управления {#console}

  1. В процессе [создания](../workflow/create-constructor.md) нового рабочего процесса или [изменения](../workflow/update.md) существующего в консоли управления в блоке **{{ ui-key.yacloud.serverless-workflows.label_create-workflow-title }}** / **{{ ui-key.yacloud.serverless-workflows.label_edit-workflow-title }}** выберите `{{ ui-key.yacloud.serverless-workflows.spec-editor-type_label_visual-editor }}`. 
  1. Из секции **Управляющие шаги** в левой части экрана перетащите элемент ![switch-icon](../../../../_assets/serverless-integrations/switch-icon.svg) **Switch** в нужное место рабочего процесса в окне конструктора.

      Перетаскивать шаги можно в обозначенные пунктирной линией блоки на графической схеме рабочего процесса, такие как **Добавить шаг** и т.п.
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **Switch**, чтобы выбрать его.
  1. В правой части окна на вкладке **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_node-settings-label }}**:

      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_step-name-label }}** задайте имя шага рабочего процесса.
  1. (Опционально) Перейдите на вкладку **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_node-input-label }}** и задайте [jq-шаблон](../../../concepts/workflows/templating.md) для фильтрации [состояния рабочего процесса](../../../concepts/workflows/workflow.md#state), которое передается в шаг.
  1. Чтобы добавить новую ветку выполнения:
  
      1. В правом нижнем углу блока **Switch** нажмите значок ![circle-plus-fill](../../../../_assets/console-icons/circle-plus-fill.svg).

      1. В открывшемся окне добавьте условие, при котором будет выбрана ветка выполнения. Условие указывается в формате jq. Чтобы добавить условие по умолчанию, включите опцию **{{ ui-key.yacloud.serverless-workflows.edit-switch-choice_default-field }}**. Условие по умолчанию создается автоматически, если Switch не является первым шагом рабочего процесса. После добавления условия нажмите **{{ ui-key.yacloud.common.create }}**. 
  
      Чтобы удалить ветку выполнения, добавьте в нее любой интеграционный шаг и удалите его при помощи кнопки ![circle-xmark-fill](../../../../_assets/console-icons/circle-xmark-fill.svg).

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/management/switch.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)