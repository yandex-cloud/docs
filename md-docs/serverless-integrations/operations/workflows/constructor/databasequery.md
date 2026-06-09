# Выполнение SQL-запросов к базам данных

{% list tabs %}

- Консоль управления {#console}

  1. В процессе [создания](../workflow/create-constructor.md) нового рабочего процесса или [изменения](../workflow/update.md) существующего в консоли управления в блоке **{{ ui-key.yacloud.serverless-workflows.label_create-workflow-title }}** / **{{ ui-key.yacloud.serverless-workflows.label_edit-workflow-title }}** выберите `{{ ui-key.yacloud.serverless-workflows.spec-editor-type_label_visual-editor }}`. 
  1. Из секции **Интеграционные шаги** в левой части экрана перетащите элемент ![database-magnifier](../../../../_assets/console-icons/database-magnifier.svg) **Database Query** в нужное место рабочего процесса в окне конструктора.

      Перетаскивать шаги можно в обозначенные пунктирной линией блоки на графической схеме рабочего процесса, такие как **Добавить шаг** и т.п.
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **Database Query**, чтобы выбрать его.
  1. В правой части окна на вкладке **{{ ui-key.yacloud.serverless-workflows.workflow-viewer_node-settings-label }}**:

      1. В поле **{{ ui-key.yacloud.serverless-workflows.workflow-editor_step-name-label }}** задайте имя шага рабочего процесса.
      1. В блоке **Параметры подключения** выберите:

          * `Подключение`, чтобы создать подключение к базе данных.

              1. Укажите в поле:

                  * **Тип базы данных** — тип базы данных, к которой нужно подключиться.

                      Для базы данных {{ MY }} устанавливается кодировка `utf8mb4` для значений полей.

                  * **Хост** — адрес сервера базы данных.
                  * **Порт** — порт для подключения к базе данных.
                  * **База данных** — имя базы данных.

              1. Выберите **Использовать SSL**, чтобы подключаться к базе данных, используя SSL-соединение.

                  Если опция выбрана, для базы данных:
                  * {{ PG }} включается шифрование SSL. 
                  * {{ CH }} разрешаются защищенные SSL-соединения.

              1. В блоке **Аутентификация** выберите:

                  * `Пароль`, чтобы подключаться к базе данных, используя имя пользователя и пароль. Укажите имя пользователя и выберите:

                      * `Lockbox`, чтобы хранить пароль в секрете {{ lockbox-full-name }}, и в блоке **Cекрет** выберите секрет, его [версию](../../../../lockbox/concepts/secret.md#version) и ключ, в которых сохранен пароль.

                          Если у вас еще нет секрета {{ lockbox-name }}, нажмите кнопку **Создать**, чтобы создать его.

                      * `Текст`, чтобы хранить пароль в спецификации в виде текста, и в поле **Значение** введите пароль.

                          {% note warning %}

                          Хранить пароль в открытом виде в тексте спецификации небезопасно.

                          {% endnote %}

                  * `IAM-токен`, чтобы подключаться к базе данных, используя IAM-токен сервисного аккаунта, указанного в настройках рабочего процесса.

                      {% note info %}

                      Аутентификация по IAM-токену доступна только для базы данных {{ ydb-short-name }}.

                      {% endnote %}

          * `DSN`, чтобы указать строку подключения к базе данных.

      1. В поле **SQL-запрос** укажите SQL-запрос, который нужно выполнить.
      1. В поле **Метод выполнения** выберите:

          * `Exec`, чтобы выполнить SQL-запрос и вернуть только служебные поля, например `RowsAffected` и `LastInsertId`.
          * `Query`, чтобы выполнить SQL-запрос и вернуть результат.

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

* [Спецификация YaWL](../../../concepts/workflows/yawl/integration/databasequery.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)