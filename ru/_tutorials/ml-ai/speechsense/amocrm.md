Чтобы настроить интеграцию {{ speechsense-name }} с [{{ amocrm-name }}](https://www.amocrm.ru/):

1. [Подготовьте облако к работе](#before-you-begin).
1. [Настройте выгрузку из {{ amocrm-name }} в {{ speechsense-name }}](#amocrm-export).
1. [Проверьте результат](#check-result).

{% include [prepare-cloud](../../_tutorials_includes/speechsense-integration/prepare-cloud.md) %}


### Создайте подключение {#create-connection}

{% list tabs group=instructions %}

- Интерфейс {{ speechsense-name }} {#speechsense}

  1. В [интерфейсе]({{ link-speechsense-main }}) {{ speechsense-name }} перейдите в нужное пространство.
  1. Перейдите на вкладку **{{ ui-key.yc-ui-talkanalytics.connections.connections }}** и выберите шаблон для создания подключения, либо нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**:

     {% include [metadata](../../../_includes/speechsense/data/templates-connection.md) %}
 
  1. Укажите название подключения.
  1. Выберите тип данных `{{ ui-key.yc-ui-talkanalytics.connections.type.two-channel-key-value }}`.
  1. В блоках **{{ ui-key.yc-ui-talkanalytics.dialogs.operator }}** и **{{ ui-key.yc-ui-talkanalytics.dialogs.client }}** укажите:

      1. Каналы, в которых записаны голос оператора и голос клиента.
      1. Ключи из файла метаданных для оператора и клиента. Этот файл содержит информацию о звонке, полученную из CRM-систем, АТС или других источников.

        По умолчанию в подключение добавлены ключи с именем и идентификатором оператора и клиента. В поле **{{ ui-key.yc-ui-talkanalytics.connections.column.name }}** введите название, под которым ключ будет отображаться в {{ speechsense-name }}.

        Чтобы указать дополнительные метаданные для оператора и клиента, нажмите **{{ ui-key.yc-ui-talkanalytics.connections.add-key }}**.

  1. В блоке **{{ ui-key.yc-ui-talkanalytics.connections.fields.metadata }}** укажите не связанные с оператором и клиентом ключи из файла метаданных:

      * В поле **Ключ** укажите транслитерированное название поля — оно понадобится при сопоставлении полей в настройках модуля обмена. Например, `Дата звонка` → `data_zvonka`. Укажите название в системе и описание — они будут отображаться в формах и отчетах {{ speechsense-name }}.
      * В поле **Тип** на данный момент поддерживается только значение `Строка`.

      По умолчанию в подключение добавлены ключи с датой, направлением звонка и языком диалога. Дополнительно можно задать набор ключей, которые вы хотите получать из внешнего сервиса. В поле **{{ ui-key.yc-ui-talkanalytics.connections.column.name }}** введите название, под которым ключ будет отображаться в {{ speechsense-name }}.

      Чтобы указать дополнительные метаданные, нажмите **{{ ui-key.yc-ui-talkanalytics.connections.add-key }}**.

  1. Нажмите **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**.
  1. На странице подключения в левом верхнем углу нажмите **ID** ![image](../../../_assets/console-icons/copy-transparent.svg), чтобы скопировать идентификатор подключения. Сохраните его — он понадобится позднее.

{% endlist %}


### Создайте проект {#create-project}

{% include [speechsense-integration/create-project](../../_tutorials_includes/speechsense-integration/create-project.md) %}


## Настройте выгрузку из {{ amocrm-name }} в {{ speechsense-name }} {#amocrm-export}


### Установите приложение в {{ amocrm-name }} {#amocrm-app}

{% list tabs group=instructions %}

- Интерфейс {{ amocrm-name }} {#amocrm}

  1. Перейдите в раздел **amoМаркет** в вашем личном кабинете {{ amocrm-name }}.
  1. В строке поиска введите `Экспорт в {{ speechsense-name }}`.
  1. Нажмите **Установить бесплатно**.
  1. Включите опцию **Согласен на передачу персональных данных...**.
  1. Нажмите **Установить**.
  1. На вкладке **Описание** нажмите **Сохранить**.

      Приложение появится в разделе **amoМаркет** на вкладке **Установленные**.

{% endlist %}


### Настройте выгрузку из {{ amocrm-name }} {#amocrm-config}

{% list tabs group=instructions %}

- Интерфейс {{ amocrm-name }} {#amocrm}

  1. Перейдите в раздел **Настройки** в вашем личном кабинете {{ amocrm-name }}.
  1. Перейдите на вкладку **Настройки выгрузки {{ speechsense-name }}**.
  1. {% include [config-external-connection](../../_tutorials_includes/speechsense-integration/config-external-connection.md) %}

  1. Настройте остальные параметры:

      * Укажите период, за который нужно загрузить звонки.

          {% note info %}

          Начальная и конечная даты будут включены в выгрузку.

          {% endnote %}

      * **Список пользователей** — укажите пользователей {{ amocrm-name }}, звонки с которыми нужно выгрузить (список ваших операторов). Чтобы выгрузить звонки всех пользователей, оставьте список пустым.

      * **Направление звонка**:

          * `Все` — выгрузка всех типов звонков.
          * `Исходящий` — выгрузка только исходящих звонков.
          * `Входящий` — выгрузка только входящих звонков.

      * **Перевыгружать звонки** — включите эту опцию, если нужно заново выгрузить ранее выгруженные звонки, например, в новое подключение или пространство {{ speechsense-name }}. Если опция включена, система не будет проверять, выгружались ли до этого звонки, и все звонки будут выгружены снова.
      * Укажите минимальную и максимальную длительность разговора в секундах. Чтобы выгрузить все звонки, оставьте значения `0`.
      * Настройте соответствие полей {{ amocrm-name }} и {{ speechsense-name }}:

          1. В столбце **{{ amocrm-name }}** выберите ключ поля в {{ amocrm-name }}.
          1. В столбце **{{ speechsense-name }}** введите ключ поля, доступного в подключении {{ speechsense-name }}, которое вы создали [ранее](#create-audio-connection).

          Чтобы добавить новое соответствие, нажмите ![image](../../../_assets/console-icons/plus.svg) **Добавить**.

          {% note info %}

          Звонки могут быть привязаны к различным сущностям системы {{ amocrm-name }}. Передаваемые со звонком метаданные могут отличаться в зависимости от связанной сущности: сделка, контакт, компания или звонок. Привязанные к звонку сущности разделены на блоки.

          {% endnote %}

  1. Нажмите **Сохранить настройки**.
  1. Нажмите **Начать выгрузку**.

      Дождитесь завершения выгрузки.

      {% note tip %}

      Чтобы принудительно остановить выгрузку, нажмите **Остановить выгрузку**.

      {% endnote %}

{% endlist %}


## Проверьте результат {#check-result}

{% include [check-result](../../_tutorials_includes/speechsense-integration/check-result.md) %}