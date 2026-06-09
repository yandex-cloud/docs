# Добавить шаг Wait

Управляющий шаг Wait приостанавливает выполнение рабочего процесса на заданный интервал времени или до наступления заданной временной метки. Если заданный интервал времени отрицательный или равен нулю, а также если указанная временная метка уже наступила, данный шаг завершится мгновенно.

{% list tabs %}

- Консоль управления {#console}

  1. В процессе [создания](../workflow/create-constructor.md) нового рабочего процесса или [изменения](../workflow/update.md) существующего в консоли управления в блоке **{{ ui-key.yacloud.serverless-workflows.label_create-workflow-title }}** / **{{ ui-key.yacloud.serverless-workflows.label_edit-workflow-title }}** выберите `{{ ui-key.yacloud.serverless-workflows.spec-editor-type_label_visual-editor }}`. 
  1. Из секции **Управляющие шаги** в левой части экрана перетащите элемент ![clock](../../../../_assets/console-icons/clock.svg) **Wait** в нужное место рабочего процесса в окне конструктора.

      Перетаскивать шаги можно в обозначенные пунктирной линией блоки на графической схеме рабочего процесса, такие как **Добавить шаг** и т.п.
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **Wait**, чтобы выбрать его.
  1. В правой части окна на вкладке **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_node-settings-label }}**:

      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_step-name-label }}** задайте имя шага рабочего процесса.
      1. В блоке **{{ ui-key.yacloud.serverless-workflows.workflow-editor_wait-step-type-field }}** выберите:

          * `{{ ui-key.yacloud.serverless-workflows.workflow-editor_wait-step-type-field-duration-label }}`, чтобы задать длительность ожидания в секундах, и в поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_wait-step-duration-field }}** укажите нужное значение.
          * `{{ ui-key.yacloud.serverless-workflows.workflow-editor_wait-step-type-field-until-label }}`, чтобы задать ожидание до наступления определенного момента во времени, и в поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_wait-step-until-field }}** укажите нужный момент времени в формате [ISO 8601](https://{{ lang }}.wikipedia.org/wiki/ISO_8601) или найдите нужную дату с помощью интерактивного календаря ![calendar](../../../../_assets/console-icons/calendar.svg).
          
          Чтобы получить длительности ожидания или временную метку из состояния рабочего процесса, включите опцию **{{ ui-key.yacloud.serverless-workflows.workflow-editor_wait-step-use-jq-expression-field }}** и в поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_wait-step-jq-expression-field }}** задайте шаблон в формате jq. Подробнее см. [{#T}](../../../concepts/workflows/templating.md).

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/management/wait.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)