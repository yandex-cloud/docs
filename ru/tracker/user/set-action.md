# Настроить действие триггера

В блоке **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.label_actions }}** с помощью кнопки **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.action_add-action }}** настройте одно или несколько действий:

- [{{ ui-key.startrek.blocks-desktop_trigger-action.select-action--transition }}](set-action.md#section_change_status)
- [{{ ui-key.startrek.blocks-desktop_trigger-action.select-action--field }}](set-action.md#section_mod_fields)
- [{{ ui-key.startrek.blocks-desktop_trigger-action.select-action--comment }}](set-action.md#create-comment)
- [{{ ui-key.startrek.blocks-desktop_trigger-action.select-action--checklist }}](set-action.md#create-checklist)
- [{{ ui-key.startrek.blocks-desktop_trigger-action.select-action--formula }}](set-action.md#section_calc_field)
- [{{ ui-key.startrek.blocks-desktop_trigger-action.select-action--move }}](set-action.md#sec_move)
- [{{ ui-key.startrek.blocks-desktop_trigger-action.select-action--createissue }}](set-action.md#sec_create_issue)
- [{{ ui-key.startrek.blocks-desktop_trigger-action.title_webhook }}](set-action.md#create-http)

## {{ ui-key.startrek.blocks-desktop_trigger-action.select-action--transition }} {#section_change_status}

Задайте новый статус задачи. Доступные статусы определяются настройками [воркфлоу](../manager/workflow-status-edit.md).

Если для перехода в статус настроен [экран перехода](../manager/workflow-action-edit.md#section_uf2_sks_gcb), проверьте, что в нем отсутствуют обязательные для заполнения поля. Иначе не удастся изменить статус с помощью триггера.


## {{ ui-key.startrek.blocks-desktop_trigger-action.select-action--field }} {#section_mod_fields}

Задайте новые значения для одного или нескольких полей:

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_trigger-action.action_select-field }}** и укажите поле. 

1. Выберите действие:

    Действие | Описание
    ----- | -----
    {{ ui-key.startrek.blocks-desktop_trigger-action.field-action_set }} | Присвоить полю заданное значение.
    {{ ui-key.startrek.blocks-desktop_trigger-action.field-action_unset }} | Удалить значение поля.
    {{ ui-key.startrek.blocks-desktop_trigger-action.field-action_add }} | Добавить еще одно значение поля (для полей, которые могут содержать несколько элементов).
    {{ ui-key.startrek.blocks-desktop_trigger-action.field-action_remove }} | Убрать одно из значений поля (для полей, которые могут содержать несколько элементов).

1. Укажите новое значение поля.


## {{ ui-key.startrek.blocks-desktop_trigger-action.select-action--comment }} {#create-comment}

Напишите текст комментария, который будет добавлен к задаче.

Вы можете подставить в комментарий [значения полей задачи](vars.md). Для этого нажмите кнопку **{{ ui-key.startrek.blocks-desktop_trigger-action.action_add-variable }}** и выберите одно или несколько значений. В поле **{{ ui-key.startrek-backend.fields.issue.meta.comment }}** появится конструкция вида `{{issue.<ключ поля>}}`.


## {{ ui-key.startrek.blocks-desktop_trigger-action.select-action--checklist }} {#create-checklist}

Создайте [чеклист](checklist.md), который будет добавлен к задаче.

{% note info %}

Действие не сработает, если в задаче уже есть чеклист.

{% endnote %}

Чтобы добавить пункт чеклиста:

1. Нажмите **{{ ui-key.startrek.components_Checklist.new-item-button-caption }}**.

1. Введите описание пункта. При необходимости укажите исполнителя и дедлайн.

1. Нажмите **{{ ui-key.startrek.components_ChecklistItem_ChecklistItemForm.button-submit }}**.


## {{ ui-key.startrek.blocks-desktop_trigger-action.select-action--formula }} {#section_calc_field}

Вы можете настроить поле, значение которого вычисляется автоматически на основе значений других полей задачи. Например, вы можете автоматически рассчитывать значение какой-либо метрики.

Чтобы автоматически вычислять значение поля:

1. Добавьте действие триггера **{{ ui-key.startrek-backend.types.types.trigger.action.calc.formula }}**.

1. Задайте формулу для вычисления значения: 
    - С помощью кнопки **{{ ui-key.startrek.blocks-desktop_trigger-action.calculateformula-add-variable }}** добавьте в формулу поля с числовыми значениями. В формулу будет подставлена [конструкция](vars.md) вида `{{issue.<ключ поля>}}`. 
      Если нужного поля нет в {{ tracker-name }}, вы можете его [создать](create-param.md).
    - Используйте символы математических операций сложения `+`, вычитания `-`, умножения `*`, деления `/`.
    - Чтобы задать приоритет операций, используйте скобки.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_trigger-action.calculateformula-output-field }}** и задайте поле, в которое будет записано вычисленное значение. 

    {% note info %}

    Если выбранное поле поддерживает только целые числа, значение будет округлено.

    {% endnote %}

1. В блоке [**{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.label_conditions }}**](set-condition.md#section_set_condition) задайте условие, при выполнении которого будет вычисляться значение поля. Рекомендуем выбрать событие **{{ ui-key.startrek-backend.messages.trigger.condition.type.calculate.formula.watch }}**. Также вы можете задать любое условие, которое подходит для вашего процесса работы с задачами.


## {{ ui-key.startrek.blocks-desktop_trigger-action.select-action--move }} {#sec_move}

1. Добавьте действие триггера **{{ ui-key.startrek.blocks-desktop_trigger-action.select-action--move }}**.

1. Укажите очередь, в которую будет перенесена задача.

Задача будет перенесена, только если у пользователя, запустившего триггер, есть права на создание задач в выбранной очереди.

## {{ ui-key.startrek.blocks-desktop_trigger-action.select-action--createissue }} {#sec_create_issue}

Можно настроить триггер, который автоматически создает задачу при выполнении заданных условий. Например, с помощью триггера можно создавать задачу на тестирование, когда программист заканчивает разработку новой возможности и переводит задачу в статус <q>{{ ui-key.startrek-backend.applinks.samsara.status.resolved }}</q>.

Чтобы настроить создание задачи:

1. Добавьте действие триггера **{{ ui-key.startrek.blocks-desktop_trigger-action.select-action--createissue }}**.

1. Нажмите кнопку **{{ ui-key.startrek.blocks-desktop_trigger-action.createissue-create }}**.

1. В окне **{{ ui-key.startrek.blocks-desktop_trigger-action.title_createissue }}**: 

    1. Укажите очередь, в которой будет автоматически создана задача.

    1. Задайте параметры задачи и нажмите кнопку **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.action_save }}**.

1. Чтобы автором созданной задачи был Робот сервиса Tracker, включите опцию **{{ ui-key.startrek.blocks-desktop_trigger-action.createissue-fromRobot }}**. Убедитесь, что у робота есть права на создание задач в выбранной очереди. 
   
   Если эта опция выключена, автором задачи будет пользователь, действие которого запустило триггер. В этом случае задача будет создана, только если у пользователя есть права на создание задач в выбранной очереди.

1. Чтобы связать автоматически созданную задачу с задачей, в которой сработал триггер, включите опцию **{{ ui-key.startrek.blocks-desktop_trigger-action.createissue-linkWithInitialIssue }}**.

## {{ ui-key.startrek.blocks-desktop_trigger-action.select-action--webhook }} {#create-http}

Чтобы при срабатывании триггера отправлять HTTP-запрос:

1. Выберите метод HTTP-запроса.

1. Укажите [полный адрес ресурса](https://tools.ietf.org/html/rfc3986), по которому будет отправлен запрос. Например: `http://example.org/newfolder/newfile`.


1. Выберите способ авторизации:
    - **{{ ui-key.startrek.blocks-desktop_trigger-action.webhook-auth--noauth }}**

        Без авторизации.

    - [**{{ ui-key.startrek.blocks-desktop_trigger-action.webhook-auth--basic }}**](https://tools.ietf.org/html/rfc2617)

        Требует ввести логин и пароль.

    - [**{{ ui-key.startrek.blocks-desktop_trigger-action.webhook-auth--oauth }}**](https://tools.ietf.org/html/rfc6749)

        Требует ввести токен, заголовок авторизации и тип токена.

   Данные авторизации (логин, пароль, токен, заголовок авторизации, тип токена) передаются в соответствующих полях и не требуют повторного указания в заголовках.

1. Введите тело запроса.

   В тело запроса можно подставлять [значения полей задачи](vars.md) или пользовательские переменные. Для этого справа от поля ввода нажмите кнопку **{ }** и выберите имя поля или переменной. В тело запроса будет подставлена конструкция вида `{{имя переменной}}`.

   {% note info %}

   Также вы можете подставить переменные в адрес ресурса и значение заголовка.

   {% endnote %}

1. Введите заголовки и их значения.

1. При необходимости добавьте новые переменные для использования в теле запроса или заголовках. Например, вы можете добавить ключ аутентификации или другую секретную информацию. 

   {% note info %}

   После того как вы сохраните триггер, значение переменной будет скрыто, его нельзя будет посмотреть.

   {% endnote %}

Примеры настройки HTTP-запросов:

- [отправка уведомлений из {{ tracker-name }} в Slack и Telegram](../messenger.md);

- [создание и обновление чеклиста в задаче](../manager/trigger-examples.md#checklist);

- [создание задачи со значениями полей из родительской задачи](../manager/trigger-examples.md#create-ticket-with-params).

