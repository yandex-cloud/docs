# Интеграция {{ speechsense-name }} с {{ amocrm-name }}

Чтобы настроить интеграцию {{ speechsense-name }} с [{{ amocrm-name }}](https://www.amocrm.ru/):

1. [Подготовьте облако к работе](#before-you-begin).
1. [Настройте выгрузку из {{ amocrm-name }} в {{ speechsense-name }}](#amocrm-export).
1. [Проверьте результат](#check-result).

## Подготовьте облако к работе {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы. О том, как начать работать с {{ yandex-cloud }}, см. в документе [Начало работы с {{ yandex-cloud }}](../../../getting-started/index.md).
1. Примите пользовательское соглашение.
1. В сервисе [{{ billing-name }}]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md#create_billing_account), если платежный аккаунт находится в статусе `TRIAL_ACTIVE`, [активируйте платную версию](../../../billing/operations/activate-commercial.md) аккаунта.
1. [Назначьте](../../../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роль `speech-sense.spaces.creator`.

    {% note info %}
    
    Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.
    
    {% endnote %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость инфраструктуры для интеграции с внешними системами входит плата за сервис {{ speechsense-name }}: длительность каждого двухканального аудиофайла (см. [тарифы {{ speechsense-name }}]({{ link-docs-ai }}speechsense/pricing)).

### Создайте сервисный аккаунт {#create-sa}

Создайте сервисный аккаунт с [ролью]({{ link-docs-ai }}speechsense/security/#speechsense-data-editor) `speech-sense.data.editor` для доступа amoCRM к проекту {{ speechsense-name }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя [сервисного аккаунта]({{ link-docs }}/iam/concepts/users/service-accounts): `speechsense`.
  1. Нажмите ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите `speech-sense.data.editor`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}


### Создайте API-ключ для сервисного аккаунта {#create-key}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором был создан сервисный аккаунт.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. Выберите сервисный аккаунт `speechsense`.
  1. На панели сверху нажмите ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
  1. В открывшемся окне в поле **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-scope }}** выберите [область действия](../../../iam/concepts/authorization/api-key.md#scoped-api-keys) `yc.speech-sense.use`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Сохраните идентификатор и секретный ключ — они понадобятся позднее.

      {% note alert %}

      После закрытия диалога значение ключа будет недоступно.

      {% endnote %}

{% endlist %}


### Создайте пространство и привяжите платежный аккаунт {#create-space}

{% list tabs group=instructions %}

- Интерфейс {{ speechsense-name }} {#speechsense}

  1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
  1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.spaces.create-space }}**.
  1. Введите название [пространства]({{ link-docs-ai }}speechsense/concepts/resources-hierarchy#space).
  1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.common.create }}**.
  1. [Привяжите платежный аккаунт]({{ link-docs-ai }}speechsense/operations/space/link-ba) к пространству для оплаты {{ speechsense-name }}.

      {% note info %}
      
      Для управления платежным аккаунтом у пользователя должна быть [назначена](../../../billing/security/index.md#set-role) роль `billing.accounts.editor`, `billing.accounts.admin` или `billing.accounts.owner` на нужный платежный аккаунт.
      
      {% endnote %}

{% endlist %}


### Добавьте сервисный аккаунт в пространство {#add-sa-to-space}

{% list tabs group=instructions %}

- Интерфейс {{ speechsense-name }} {#speechsense}

  1. В [интерфейсе]({{ link-speechsense-main }}) {{ speechsense-name }} перейдите в [новое пространство](#create-space).
  1. Нажмите кнопку ![image](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yc-ui-talkanalytics.projects.add-participant }}** → ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yc-ui-talkanalytics.team.add-from-organization-key-value }}**.
  1. Скопируйте идентификатор [созданного ранее сервисного аккаунта](#create-sa) `speechsense` и вставьте в строку поиска.
  1. Выберите сервисный аккаунт `speechsense` и укажите роль [{{ roles-speechsense-data-editor }}]({{ link-docs-ai }}speechsense/security/#speechsense-data-editor). Эта роль позволит сервисному аккаунту загружать данные в {{ speechsense-name }}.
  1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.common.add }}**.

{% endlist %}


### Создайте подключение {#create-connection}

{% list tabs group=instructions %}

- Интерфейс {{ speechsense-name }} {#speechsense}

  1. В [интерфейсе]({{ link-speechsense-main }}) {{ speechsense-name }} перейдите в нужное пространство.
  1. Перейдите на вкладку **{{ ui-key.yc-ui-talkanalytics.connections.connections }}** и выберите шаблон для создания подключения, либо нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**:

     * **{{ ui-key.yc-ui-talkanalytics.connections.template.default.name }}** — подключение с возможностью добавить ваши собственные ключи для метаданных.
     * **{{ ui-key.yc-ui-talkanalytics.connections.template.bitrix24.name }}** — подключение с предустановленным набором ключей для {{ bitrix24-name }}. Дополнительно можно добавить собственные ключи.
     * **{{ ui-key.yc-ui-talkanalytics.connections.template.amo-crm.name }}** — подключение с предустановленным набором ключей для {{ amocrm-name }}. Дополнительно можно добавить собственные ключи.
 
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

{% list tabs group=instructions %}

- Интерфейс {{ speechsense-name }} {#speechsense}

  1. В [интерфейсе]({{ link-speechsense-main }}) {{ speechsense-name }} перейдите в нужное пространство.
  1. Нажмите ![create](../../../_assets/console-icons/folder-plus.svg) **{{ ui-key.yc-ui-talkanalytics.projects.create-project }}**.
  1. Введите имя проекта.
  1. В блоке **{{ ui-key.yc-ui-talkanalytics.connections.connection }}** нажмите **{{ ui-key.yc-ui-talkanalytics.projects.add-connection }}** и выберите подключение, созданное [ранее](#create-connection).
  1. Нажмите **{{ ui-key.yc-ui-talkanalytics.projects.create-project }}**.

{% endlist %}


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
  1. Настройте подключение:
     
     1. **Язык** — выберите язык для распознавания.
     1. **ID подключения {{ speechsense-name }}** — укажите идентификатор подключения, которое вы создали [ранее](#create-audio-connection).
     1. **API-ключ** — укажите секретную часть API-ключа, который вы создали [ранее](#create-key).
     1. Нажмите **Проверить подключение**.
     
         Если API-ключ и идентификатор подключения указаны правильно, отобразится сообщение:
     
         ```text
         Успешный запрос к {{ speechsense-name }}
         ```

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

{% list tabs group=instructions %}

- Интерфейс {{ speechsense-name }} {#speechsense}

  1. В [интерфейсе]({{ link-speechsense-main }}) {{ speechsense-name }} перейдите в нужное пространство.
  1. Выберите созданный [ранее](#create-project) проект.

      На панели проекта вы увидите загруженные звонки и расшифровки. После этого вы сможете [настраивать отчеты]({{ link-docs-ai }}speechsense/operations/data/manage-reports).

{% endlist %}

В случае возникновения проблем [свяжитесь](#contact-form) со специалистом {{ yandex-cloud }}.