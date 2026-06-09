# Обращение к Telegram Bot API

{% list tabs %}

- Консоль управления {#console}

  1. В процессе [создания](../workflow/create-constructor.md) нового рабочего процесса или [изменения](../workflow/update.md) существующего в консоли управления в блоке **{{ ui-key.yacloud.serverless-workflows.label_create-workflow-title }}** / **{{ ui-key.yacloud.serverless-workflows.label_edit-workflow-title }}** выберите `{{ ui-key.yacloud.serverless-workflows.spec-editor-type_label_visual-editor }}`. 
  1. Из секции **Интеграционные шаги** в левой части экрана перетащите элемент ![foundation-models-icon](../../../../_assets/console-icons/logo-telegram.svg) **Telegram-бот** в нужное место рабочего процесса в окне конструктора.

      Перетаскивать шаги можно в обозначенные пунктирной линией блоки на графической схеме рабочего процесса, такие как **Добавить шаг** и т.п.
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **Telegram-бот**, чтобы выбрать его.
  1. В правой части окна на вкладке **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_node-settings-label }}**:

      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_step-name-label }}** задайте имя шага рабочего процесса.
      1. В блоке **Токен** укажите [токен бота](https://core.telegram.org/bots/features#creating-a-new-bot) или [секрет](../../../../lockbox/concepts/secret.md) {{ lockbox-name }}, в котором сохранен этот токен. Выберите:

          * `Lockbox`, чтобы хранить токен бота в секрете, и в блоке **Cекрет** выберите секрет, его [версию](../../../../lockbox/concepts/secret.md#version) и ключ, в которых сохранен токен бота.

              Если у вас еще нет секрета {{ lockbox-name }}, нажмите кнопку **Создать**, чтобы создать его.

          * `Текст`, чтобы хранить токен бота в спецификации в виде текста, и в поле **Значение** введите токен бота.

              {% note warning %}

              Хранить токен бота в открытом виде в тексте спецификации небезопасно.

              {% endnote %}

      1. В блоке **Действие**:

          1. В поле **Идентификатор чата** укажите идентификатор чата или имя канала в формате `@channelusername`.
          1. В поле **Текст** введите текст сообщения, который нужно отправить.
          1. (Опционально) В поле **Ответить на сообщение** укажите идентификатор сообщения, на которое нужно ответить.
          1. (Опционально) В поле **Режим форматирования** выберите режим форматирования сообщения. Подробнее см. [документацию Telegram Bot API](https://core.telegram.org/bots/api#formatting-options).

      1. (Опционально) В поле **{{ ui-key.yc-serverless-workflows.dynamic-forms.common_timeout_view_spec_layout_title }}** задайте максимальное время выполнения текущего шага.
      1. (Опционально) Чтобы задать для шага собственную политику повторных попыток, разверните блок **{{ ui-key.yc-serverless-workflows.dynamic-forms.common_retry_policy_view_spec_layout_title }}** и нажмите кнопку ![plus](../../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-serverless-workflows.dynamic-forms.common_retry_policy_view_spec_layout_title }}**. В появившейся форме:
         
         1. (Опционально) В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_initial-delay-field }}** задайте начальное значение задержки между повторными попытками выполнения шага.
         1. (Опционально) В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_backoff-rate-field }}** задайте коэффициент, на который будет умножаться время задержки перед каждой повторной попыткой выполнения шага.
         1. (Опционально) В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_max-delay-field }}** задайте значение максимальной задержки между повторными попытками выполнения шага.
         1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_error-list-field }}** выберите ошибки, для которых будут (или, наоборот, не будут) сделаны повторные попытки выполнения шага.
         
             Подробную информацию о возможных ошибках см. в разделе [{#T}](../../../concepts/workflows/execution.md#errors).
         1. (Опционально) В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_retry-count-field }}** задайте максимальное количество повторных попыток выполнения шага.
         1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_error-list-mode-field }}** выберите:
         
             * `INCLUDE` — чтобы делать для шага повторные попытки выполнения при возникновении ошибок, указанных в поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_error-list-field }}**.
             * `EXCLUDE` — чтобы делать для шага повторные попытки выполнения при возникновении любых ошибок, за исключением ошибок, указанных в поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_error-list-field }}**.
         
         Если вы хотите удалить политику повторных попыток, ранее созданную для шага, в строке **{{ ui-key.yc-serverless-workflows.dynamic-forms.common_retry_policy_view_spec_layout_title }}** нажмите ![ellipsis](../../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
         
         Если для шага не настроена собственная политика повторных попыток, к нему будет применяться политика повторных попыток, [заданная для всего рабочего процесса](setup-restart-policy.md).
  1. (Опционально) Перейдите на вкладку **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_node-input-label }}** и задайте [jq-шаблон](../../../concepts/workflows/templating.md) для фильтрации [состояния рабочего процесса](../../../concepts/workflows/workflow.md#state), которое передается в шаг.
  1. (Опционально) Перейдите на вкладку **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_node-output-label }}** и задайте [jq-шаблон](../../../concepts/workflows/templating.md) для фильтрации выходных данных шага, которые добавляются в [состояние рабочего процесса](../../../concepts/workflows/workflow.md#state).
  1. (Опционально) [Добавьте](setup-catch-rule.md) для создаваемого шага [правило перехода по ошибкам](../../../concepts/workflows/yawl/index.md#catchrule), которые могут возникать во время выполнения этого шага.

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/integration/telegrambot.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)