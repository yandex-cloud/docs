# Создать коннектор для API {{ er-name }}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать [коннектор](../../../concepts/eventrouter/connector.md).

  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.

  1. На панели слева выберите ![object-align-center-vertical](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.

  1. Выберите нужную [шину](../../../concepts/eventrouter/bus.md).

  1. В меню слева выберите ![broadcast-signal](../../../../_assets/console-icons/broadcast-signal.svg) **{{ ui-key.yacloud.serverless-event-router.label_connectors }}**.

  1. В правом верхнем углу нажмите **{{ ui-key.yacloud.serverless-event-router.button_create-connector }}**.

  1. В поле **{{ ui-key.yacloud.serverless-event-router.label_connector-source }}** выберите `{{ ui-key.yc-eventrouter.dynamic-forms.event_service_name }}`.

  1. Раскройте блок **{{ ui-key.yacloud.serverless-event-router.label_additional-parameters }}**:
     
     * Введите имя и описание [коннектора](../../../concepts/eventrouter/connector.md). Требования к имени:
     
         * Длина — от 3 до 63 символов.
         * Может содержать строчные и заглавные буквы латинского и русского алфавита, цифры, дефисы, подчеркивания и пробелы.
         * Первый символ должен быть буквой. Последний символ не может быть дефисом, подчеркиванием или пробелом.
     
     * (Опционально) Добавьте метки:
     
         * Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
         * Введите метку в формате `ключ: значение`.
         * Нажмите **Enter**.
     
     * (Опционально) Включите защиту от удаления. Пока опция включена, удалить коннектор невозможно.

  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для создания [коннектора](../../../concepts/eventrouter/connector.md):

      ```bash
      yc serverless eventrouter connector create event-service --help
      ```

  1. Создайте коннектор для API {{ er-name }}:

      ```bash
      yc serverless eventrouter connector create event-service \
        --bus-id <идентификатор_шины> \
        --name <имя_коннектора> \
        --description <описание_коннектора> \
        --labels <список_меток> \
        --deletion-protection
      ```

      Где:

      * `--bus-id` — идентификатор [шины](../../../concepts/eventrouter/bus.md) {{ er-name }}.
      * `--name` — имя коннектора. Требования к имени:

          * Длина — от 3 до 63 символов.
          * Может содержать строчные и заглавные буквы латинского и русского алфавита, цифры, дефисы, подчеркивания и пробелы.
          * Первый символ должен быть буквой. Последний символ не может быть дефисом, подчеркиванием или пробелом.

      * `--description` — описание коннектора. Необязательный параметр.
      * `--labels` — список меток. Необязательный параметр.

          Можно указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.
      * `--deletion-protection` — защита от удаления коннектора. По умолчанию защита выключена. Пока опция включена, удалить коннектор невозможно. Чтобы отключить защиту от удаления, укажите параметр `--no-deletion-protection`. Необязательный параметр.

      Результат:

      ```text
      id: f667savopsoe********
      bus_id: f66klk4lvvjf********
      folder_id: b1gt6g8ht345********
      cloud_id: b1gia87mbaom********
      created_at: "2025-06-18T16:44:03.849030Z"
      name: my-sample-connector
      description: my description
      labels:
        no: label
      source:
        event_service_source: {}
      deletion_protection: true
      status: RUNNING
      ```

- API {#api}

  Чтобы создать коннектор для API {{ er-name }}, воспользуйтесь методом REST API [Create](../../../eventrouter/api-ref/Connector/create.md) для ресурса [connector](../../../eventrouter/api-ref/Connector/index.md) или вызовом gRPC API [ConnectorService/Create](../../../eventrouter/api-ref/grpc/Connector/create.md).

{% endlist %}

По умолчанию коннектор создается запущенным. Чтобы коннектор перестал отправлять сообщения в шину, [остановите](stop.md) его.