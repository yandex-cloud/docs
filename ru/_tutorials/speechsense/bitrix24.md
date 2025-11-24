Чтобы настроить интеграцию {{ speechsense-name }} с {{ bitrix24-name }}:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Настройте выгрузку из {{ bitrix24-name }} в {{ speechsense-name }}](#bitrix24-export).
1. [Проверьте результат](#check-result).

{% include [prepare-cloud](../_tutorials_includes/speechsense-integration/prepare-cloud.md) %}


### Создайте подключение {#create-connection}

{% list tabs group=instructions %}

- Интерфейс {{ speechsense-name }} {#speechsense}

  1. В [интерфейсе]({{ link-speechsense-main }}) {{ speechsense-name }} перейдите в нужное пространство.
  1. Перейдите на вкладку **{{ ui-key.yc-ui-talkanalytics.connections.connections }}** и выберите шаблон для создания подключения, либо нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**:

     {% include [metadata](../../_includes/speechsense/data/templates-connection.md) %}

  1. Укажите название подключения.
  1. Выберите тип данных `{{ ui-key.yc-ui-talkanalytics.connections.type.two-channel-key-value }}`.
  1. В блоках **{{ ui-key.yc-ui-talkanalytics.dialogs.operator }}** и **{{ ui-key.yc-ui-talkanalytics.dialogs.client }}** укажите:

      1. Каналы, в которых записаны голос оператора и голос клиента.
      1. Ключи из файла метаданных для оператора и клиента. Этот файл содержит информацию о звонке, полученную из CRM-систем, АТС или других источников.

        По умолчанию в подключение добавлены ключи с именем и идентификатором оператора и клиента. В поле **{{ ui-key.yc-ui-talkanalytics.connections.column.name }}** введите название, под которым ключ будет отображаться в {{ speechsense-name }}.

        Чтобы указать дополнительные метаданные для оператора и клиента, нажмите **{{ ui-key.yc-ui-talkanalytics.connections.add-key }}**.

  1. В блоке **{{ ui-key.yc-ui-talkanalytics.connections.fields.metadata }}** укажите не связанные с оператором и клиентом ключи из файла метаданных.

      По умолчанию в подключение добавлены ключи с датой, направлением звонка и языком диалога. Дополнительно можно задать набор ключей, которые вы хотите получать из внешнего сервиса. В поле **{{ ui-key.yc-ui-talkanalytics.connections.column.name }}** введите название, под которым ключ будет отображаться в {{ speechsense-name }}.

      {% cut "Список доступных полей" %}

      Список актуален для текущей версии приложения.

      ```json
      {
          "id",
          "portal_user_id",
          "portal_number",
          "phone_number",
          "call_id",
          "external_call_id",
          "call_category",
          "call_duration",
          "call_start_date",
          "call_record_url",
          "call_vote",
          "cost",
          "cost_currency",
          "call_failed_code",
          "call_failed_reason",
          "crm_entity_type",
          "crm_entity_id",
          "crm_activity_id",
          "rest_app_id",
          "rest_app_name",
          "transcript_id",
          "transcript_pending",
          "session_id",
          "redial_attempt",
          "comment",
          "record_duration",
          "record_file_id",
          "call_type"
      }
      ```

      {% endcut %}

      Чтобы указать дополнительные метаданные, нажмите **{{ ui-key.yc-ui-talkanalytics.connections.add-key }}**.

  1. Нажмите **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**.
  1. На странице подключения в левом верхнем углу нажмите **ID** ![image](../../_assets/console-icons/copy-transparent.svg), чтобы скопировать идентификатор подключения. Сохраните его — он понадобится позднее.

{% endlist %}


### Создайте проект {#create-project}

{% include [speechsense-integration/create-project](../_tutorials_includes/speechsense-integration/create-project.md) %}


## Настройте выгрузку из {{ bitrix24-name }} в {{ speechsense-name }} {#bitrix24-export}


### Установите приложение в {{ bitrix24-name }} {#bitrix24-app}

{% list tabs group=instructions %}

- Интерфейс {{ bitrix24-name }} {#bitrix24}

  1. Перейдите в раздел **Маркет** в вашем личном кабинете {{ bitrix24-name }}.
  1. В строке поиска введите `{{ speechsense-full-name }}`.
  1. Нажмите **Установить**.
  1. Включите опции **Я ознакомлен и согласен с...** и нажмите **Установить**.
  1. Нажмите **Открыть приложение**.

{% endlist %}


### Настройте выгрузку из {{ bitrix24-name }} {#bitrix24-config}

{% list tabs group=instructions %}

- Интерфейс {{ bitrix24-name }} {#bitrix24}

  1. {% include [config-external-connection](../_tutorials_includes/speechsense-integration/config-external-connection.md) %}

  1. Настройте остальные параметры:

      * Укажите период, за который нужно загрузить звонки.

          {% note info %}

          Начальная и конечная даты будут включены в выгрузку.

          {% endnote %}

          Чтобы выгрузить звонки за все время, не указывайте даты.

      * **Список пользователей** — укажите пользователей {{ bitrix24-name }} через запятую, звонки с которыми нужно выгрузить (список ваших операторов). Чтобы выгрузить звонки всех пользователей, оставьте список пустым.

      * **Направление звонка** выберите один или несколько вариантов :

          * `Все` — выгрузка всех типов звонков.
          * `Исходящий` — выгрузка всех исходящих звонков.
          * `Входящий` — выгрузка всех входящих звонков.
          * `Входящий с перенаправлением на мобильный` — выгрузка входящих звонков, которые были
          перенаправлены на мобильный номер оператора.
          * `Обратный звонок` — выгрузка звонков, которые заказали клиенты после заполнения CRM-формы.

      * **Минимальная длина разговора** — укажите длительность разговора в секундах. Рекомендуется выгружать звонки длительностью от 30 секунд.
      * **ID последнего обработанного звонка** — поле недоступно для редактирования. Здесь отображается значение, по которому можно определить, какой звонок был обработан последним. 

          Чтобы обнулить значение поля, нажмите **Сбросить**.

  1. Нажмите **Сохранить**.
  1. Нажмите **Запустить выгрузку**.

      Дождитесь завершения выгрузки.

{% endlist %}


## Проверьте результат {#check-result}

{% include [check-result](../_tutorials_includes/speechsense-integration/check-result.md) %}