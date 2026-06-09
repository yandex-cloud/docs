# Создать коннектор для Data Streams

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите создать [коннектор](../../../concepts/eventrouter/connector.md).
  1. Перейдите в сервис **Serverless Integrations**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **EventRouter**.
  1. Выберите нужную [шину](../../../concepts/eventrouter/bus.md).
  1. Перейдите на вкладку ![image](../../../../_assets/console-icons/broadcast-signal.svg) **Коннекторы**.
  1. В правом верхнем углу нажмите **Создать коннектор**.
  1. В поле **Источник** выберите `Yandex Data Streams`.
  1. В блоке **Настройки Data Streams**:

      * Выберите [поток данных](../../../../data-streams/concepts/glossary.md#stream-concepts) и [выделенного потребителя данных](../../../../data-streams/concepts/glossary.md#consumers).
      * Выберите [сервисный аккаунт](../../../../iam/concepts/users/service-accounts.md), у которого есть права на чтение из потока данных.

  1. Раскройте блок **Дополнительные параметры**:
     
     * Введите имя и описание [коннектора](../../../concepts/eventrouter/connector.md). Требования к имени:
     
         * Длина — от 3 до 63 символов.
         * Может содержать строчные и заглавные буквы латинского и русского алфавита, цифры, дефисы, подчеркивания и пробелы.
         * Первый символ должен быть буквой. Последний символ не может быть дефисом, подчеркиванием или пробелом.
     
     * (Опционально) Добавьте метки:
     
         * Нажмите **Добавить метку**.
         * Введите метку в формате `ключ: значение`.
         * Нажмите **Enter**.
     
     * (Опционально) Включите защиту от удаления. Пока опция включена, удалить коннектор невозможно.
  1. Нажмите **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для создания [коннектора](../../../concepts/eventrouter/connector.md):

      ```bash
      yc serverless eventrouter connector create data-stream --help
      ```

  1. Создайте коннектор для Data Streams:

      ```bash
      yc serverless eventrouter connector create data-stream \
        --bus-id <идентификатор_шины> \
        --database <путь_к_БД>
        --stream-name <имя_потока>
        --consumer <имя_потребителя>
        --service-account-id <идентификатор_сервисного_аккаунта> \
        --name <имя_коннектора> \
        --description "<описание_коннектора>" \
        --labels <список_меток> \
        --deletion-protection
      ```

      Где:

      * `--bus-id` — идентификатор [шины](../../../concepts/eventrouter/bus.md) EventRouter.
      * `--database` — [путь](../../../../ydb/operations/connection.md#endpoint-and-path) к [базе данных](../../../../ydb/concepts/resources.md#database) Yandex Managed Service for YDB, указанной в настройках [потока данных](../../../../data-streams/concepts/glossary.md#stream-concepts), например `/ru-central1/b1gia87mbaom********/etnudu2n9ri3********`.
      * `--stream-name` — имя потока данных.
      * `--consumer` — имя [выделенного потребителя данных](../../../../data-streams/concepts/glossary.md#consumers).
      * `--service-account-id` — идентификатор [сервисного аккаунта](../../../../iam/concepts/users/service-accounts.md), у которого есть права на чтение из потока данных.
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
      id: f66g6jcnc5no********
      bus_id: f66qn4p7uk6p********
      folder_id: b1g681qpemb4********
      cloud_id: b1gia87mbaom********
      created_at: "2025-02-21T10:53:25.994124Z"
      name: yds-via-cli
      description: created via cli
      labels:
        interface: yccli
        owner: admin
      source:
        data_stream:
          database: /ru-central1/b1gia87mbaom********/etntd0p5tauu********
          stream_name: my-ydb-flow
          consumer: consumer-one
          service_account_id: ajelprpohp7r********
      deletion_protection: true
      status: RUNNING
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../../terraform/authentication.md) соответствующим способом.

  Чтобы создать [коннектор](../../../concepts/eventrouter/connector.md) для Data Streams:

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_serverless_eventrouter_connector" "example_connector" {
        bus_id              = "<идентификатор_шины>"
        name                = "<имя_коннектора>"
        description         = "<описание_коннектора>"
        deletion_protection = <true|false>

        labels = {
          <ключ_1> = "<значение_1>"
          <ключ_2> = "<значение_2>"
          ...
          <ключ_n> = "<значение_n>"
        }

        ymq {
          database           = "<путь_к_БД>"
          stream_name        = "<имя_потока>"
          consumer           = "<имя_потребителя>"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
        }
      }
      ```

      Где:

      * `bus_id` — идентификатор [шины](../../../concepts/eventrouter/bus.md) EventRouter.
      * `name` — имя коннектора. Требования к имени:

          * Длина — от 3 до 63 символов.
          * Может содержать строчные и заглавные буквы латинского и русского алфавита, цифры, дефисы, подчеркивания и пробелы.
          * Первый символ должен быть буквой. Последний символ не может быть дефисом, подчеркиванием или пробелом.

      * `description` — описание коннектора. Необязательный параметр.
      * `deletion_protection` — защита от удаления коннектора: `true` или `false`. Пока опция включена, удалить коннектор невозможно. Необязательный параметр.
      * `labels` — список меток. Метки задаются в формате `<ключ> = "<значение>"`. Необязательный параметр.
      * `database` — [путь](../../../../ydb/operations/connection.md#endpoint-and-path) к [базе данных](../../../../ydb/concepts/resources.md#database) Yandex Managed Service for YDB, указанной в настройках [потока данных](../../../../data-streams/concepts/glossary.md#stream-concepts), например `/ru-central1/b1gia87mbaom********/etnudu2n9ri3********`.
      * `stream_name` — имя потока данных.
      * `consumer` — имя [выделенного потребителя данных](../../../../data-streams/concepts/glossary.md#consumers).
      * `service_account_id` — идентификатор [сервисного аккаунта](../../../../iam/concepts/users/service-accounts.md), у которого есть права на чтение из потока данных.

      Более подробную информацию о параметрах ресурса `yandex_serverless_eventrouter_connector` см. в [документации провайдера](../../../../terraform/resources/serverless_eventrouter_connector.md).

  1. Создайте ресурсы:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
         ```bash
         terraform validate
         ```
      
         Если конфигурация является корректной, появится сообщение:
      
         ```bash
         Success! The configuration is valid.
         ```
      
      1. Выполните команду:
      
         ```bash
         terraform plan
         ```
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Terraform создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../../cli/index.md):

      ```bash
      yc serverless eventrouter connector list
      ```

- API {#api}

  Чтобы создать [коннектор](../../../concepts/eventrouter/connector.md) для Data Streams, воспользуйтесь методом REST API [Create](../../../eventrouter/api-ref/Connector/create.md) для ресурса [connector](../../../eventrouter/api-ref/Connector/index.md) или вызовом gRPC API [connector/Create](../../../eventrouter/api-ref/grpc/Connector/create.md).

{% endlist %}

По умолчанию коннектор создается запущенным. Чтобы коннектор перестал отправлять сообщения в шину, [остановите](stop.md) его.