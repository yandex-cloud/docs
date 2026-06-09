# Создать правило с приемником {{ yds-full-name }}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать [правило](../../../concepts/eventrouter/rule.md).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Выберите нужную [шину](../../../concepts/eventrouter/bus.md).
  1. Перейдите на вкладку ![image](../../../../_assets/console-icons/target-dart.svg) **{{ ui-key.yacloud.serverless-event-router.label_rules }}**.
  1. В правом верхнем углу нажмите **{{ ui-key.yacloud.serverless-event-router.button_create-rule }}**.

  1. (Опционально) Раскройте блок **{{ ui-key.yacloud.serverless-event-router.label_filter }}** и введите [jq-шаблон](https://jqlang.github.io/jq/manual/) для [фильтрации](../../../concepts/eventrouter/rule.md#filter) событий.
  1. В блоке **{{ ui-key.yacloud.serverless-event-router.label_targets }}** нажмите **{{ ui-key.yacloud.common.add }}** и настройте приемник:

      1. Укажите тип приемника `{{ yds-full-name }}`.
      1. Выберите [базу данных](../../../../ydb/concepts/resources.md#database) {{ ydb-name }}, указанную в настройках [потока данных](../../../../data-streams/concepts/glossary.md#stream-concepts) {{ yds-name }}, в который будут отправляться сообщения, соответствующие правилу.
      1. Введите имя потока данных, в который будут отправляться сообщения, соответствующие правилу.
      1. Выберите [сервисный аккаунт](../../../../iam/concepts/users/service-accounts.md), которому назначена [роль](../../../../data-streams/security/index.md#yds-writer) `yds.writer` или выше на выбранный поток данных, или [создайте](../../../../iam/operations/sa/create.md) новый.
      1. (Опционально) Нажмите ![plus](../../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-eventrouter.dynamic-forms.template_target_retry_title }}** и укажите:
         
         * **{{ ui-key.yc-eventrouter.dynamic-forms.template_target_retry_max_attempts }}** — количество повторных попыток отправки сообщений, которые будут сделаны, прежде чем {{ er-name }} отправит сообщения в Dead Letter Queue (DLQ). Допустимые значения от 0 до 1 000, значение по умолчанию — 3.
         * **{{ ui-key.yc-eventrouter.dynamic-forms.template_target_retry_max_age }}** — время в часах, через которое будет сделана повторная попытка отправить сообщения, если текущая завершилась неуспешно. Допустимые значения от 0 до 60 часов, значение по умолчанию — 10 минут.
      1. (Опционально) Раскройте поле **{{ ui-key.yacloud.serverless-event-router.label_target-transformer }}** и введите [jq-шаблон](https://jqlang.github.io/jq/manual/) для преобразования событий. Если шаблон не указан, событие не преобразовывается.
      1. (Опционально) Раскройте блок **{{ ui-key.yacloud.serverless-event-router.label_target-dead-letter-settings }}**:
         
         1. Укажите тип обработчика `{{ message-queue-full-name }}`.
         1. Выберите каталог и очередь DLQ, в которую будут перенаправляться сообщения, которые не смог обработать приемник.
         1. Выберите сервисный аккаунт, которому назначена [роль](../../../../message-queue/security/index.md#ymq-writer) `ymq.writer` или выше на выбранную очередь DLQ, или [создайте](../../../../iam/operations/sa/create.md) новый.

  1. Раскройте блок **{{ ui-key.yacloud.serverless-event-router.label_additional-parameters }}**:
     
     
     1. Введите имя и описание правила. Требования к имени:
     
         * Длина — от 3 до 63 символов.
         * Может содержать строчные и заглавные буквы латинского и русского алфавита, цифры, дефисы, подчеркивания и пробелы.
         * Первый символ должен быть буквой. Последний символ не может быть дефисом, подчеркиванием или пробелом.
     
     1. (Опционально) Добавьте метки:
     
         * Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
         * Введите метку в формате `ключ: значение`.
         * Нажмите **Enter**.
     
     1. (Опционально) Включите защиту от удаления. Пока опция включена, удалить правило невозможно.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для создания [правила](../../../concepts/eventrouter/rule.md):

      ```bash
      yc serverless eventrouter rule create --help
      ```

  1. Создайте правило с приемником {{ yds-full-name }}:

      ```bash
      yc serverless eventrouter rule create \
        --bus-id <идентификатор_шины> \
        --filter '<jq-шаблон>' \
        --yds-target \
      database=<путь_к_базе_данных>,\
      stream-name=<имя_потока_данных>,\
      service-account-id=<сервисный_аккаунт_потока>,\
      retry-attempts=<количество_попыток>,\
      maximum-age=<интервал>,\
      transformer=<jq-шаблон>,\
      dlq-arn=<очередь_DLQ>,\
      dlq-service-account-id=<идентификатор_сервисного_аккаунта_DLQ> \
        --name <имя_правила> \
        --description "<описание_правила>" \
        --deletion-protection \
        --labels <список_меток>
      ```

      Где:

      * `--bus-id` — идентификатор [шины](../../../concepts/eventrouter/bus.md) {{ er-name }}.
      * `--filter` — [jq-шаблон](https://jqlang.github.io/jq/manual/) для [фильтрации](../../../concepts/eventrouter/rule.md#filter) событий.

      * `--yds-target` — параметр для настройки приемника с типом `{{ yds-full-name }}` и его свойства:

          * `database` — [путь](../../../../ydb/operations/connection.md#endpoint-and-path) к [базе данных](../../../../ydb/concepts/resources.md#database) {{ ydb-name }}, указанной в настройках [потока данных](../../../../data-streams/concepts/glossary.md#stream-concepts) {{ yds-name }}, в который будут отправляться сообщения, соответствующие правилу.
          * `stream-name` — имя потока данных, в который будут отправляться сообщения, соответствующие правилу.
          * `service-account-id` — идентификатор [сервисного аккаунта](../../../../iam/concepts/users/service-accounts.md), которому назначена [роль](../../../../data-streams/security/index.md#yds-writer) `yds.writer` или выше на выбранный поток данных.


          * `retry-attempts` — количество повторных попыток отправки сообщений, которые будут сделаны, прежде чем {{ er-name }} отправит сообщения в Dead Letter Queue (DLQ). Допустимые значения от 0 до 1 000. Необязательный параметр.
          * `maximum-age` — время, через которое будет сделана повторная попытка отправить сообщения, если текущая завершилась неуспешно. Допустимые значения от 0 до 60 часов. Необязательный параметр.

          * `transformer` — [jq-шаблон](https://jqlang.github.io/jq/manual/) для преобразования событий. Если шаблон не указан, событие не преобразовывается. Необязательный параметр.


          * `dlq-arn` — ARN очереди DLQ в которую будут перенаправляться сообщения, которые не смог обработать приемник. Необязательный параметр.
          * `dlq-service-account-id` — идентификатор сервисного аккаунта, которому назначена [роль](../../../../message-queue/security/index.md#ymq-writer) `ymq.writer` или выше на выбранную очередь DLQ. Необязательный параметр.

      * `--name` — имя правила. Требования к имени:
      
          * Длина — от 3 до 63 символов.
          * Может содержать строчные и заглавные буквы латинского и русского алфавита, цифры, дефисы, подчеркивания и пробелы.
          * Первый символ должен быть буквой. Последний символ не может быть дефисом, подчеркиванием или пробелом.
      
      * `--description` — описание правила. Необязательный параметр.
      * `--deletion-protection` — защита от удаления правила. По умолчанию защита выключена. Пока опция включена, удалить правило невозможно. Чтобы отключить защиту от удаления, укажите параметр `--no-deletion-protection`. Необязательный параметр.
      * `--labels` — список меток. Необязательный параметр.
      
          Можно указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.

      Результат:

      ```text
      id: f66vfpjrkc35********
      bus_id: f66epjc9llqt********
      folder_id: b1g681qpemb4********
      cloud_id: b1gia87mbaom********
      created_at: "2025-02-26T14:04:47.710918Z"
      name: new-rule
      description: created via cli
      labels:
        owner: admin
        version: beta
      filter:
        jq_filter: .firstName == "Ivan"
      targets:
        - yds:
            database: /{{ region-id }}/b1gia87mbaom********/etnvqsesnr5g********
            stream_name: new-stream
            service_account_id: ajelprpohp7r********
          transformer:
            jq_transformer: .
          retry_settings:
            retry_attempts: "3"
            maximum_age: 600s
          dead_letter_queue:
            queue_arn: yrn:yc:ymq:{{ region-id }}:b1g681qpemb4********:dlq-42
            service_account_id: ajelprpohp7r********
          status: ENABLED
      status: ENABLED
      ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../../terraform/authentication.md) соответствующим способом.

  Чтобы создать [правило](../../../concepts/eventrouter/rule.md) с приемником {{ yds-full-name }}:

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_serverless_eventrouter_rule" "example_rule" {
        bus_id    = "<идентификатор_шины>"
        jq_filter = "<jq-шаблон>"

        yds {
          database           = "<путь_к_базе_данных>"
          stream_name        = "<имя_потока_данных>"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
        }
      
        name        = "<имя_правила>"
        description = "<описание_правила>"

        labels = {
          <ключ_1> = "<значение_1>"
          <ключ_2> = "<значение_2>"
          ...
          <ключ_n> = "<значение_n>"
        }
      }
      ```

      Где:

      * `bus_id` — идентификатор [шины](../../../concepts/eventrouter/bus.md) {{ er-name }}.
      * `jq_filter` — [jq-шаблон](https://jqlang.github.io/jq/manual/) для [фильтрации](../../../concepts/eventrouter/rule.md#filter) событий.
      * `yds` — блок для настройки приемника с типом `{{ yds-full-name }}` и его параметры:

          * `database` — [путь](../../../../ydb/operations/connection.md#endpoint-and-path) к [базе данных](../../../../ydb/concepts/resources.md#database) {{ ydb-name }}, указанной в настройках [потока данных](../../../../data-streams/concepts/glossary.md#stream-concepts) {{ yds-name }}, в который будут отправляться сообщения, соответствующие правилу.
          * `stream_name` — имя потока данных, в который будут отправляться сообщения, соответствующие правилу.
          * `service_account_id` — идентификатор [сервисного аккаунта](../../../../iam/concepts/users/service-accounts.md), которому назначена [роль](../../../../data-streams/security/index.md#yds-writer) `yds.writer` или выше на выбранный поток данных.

      * `name` — имя правила. Требования к имени:
      
          * Длина — от 3 до 63 символов.
          * Может содержать строчные и заглавные буквы латинского и русского алфавита, цифры, дефисы, подчеркивания и пробелы.
          * Первый символ должен быть буквой. Последний символ не может быть дефисом, подчеркиванием или пробелом.
      
      * `description` — описание правила. Необязательный параметр.
      * `labels` — список меток. Метки задаются в формате `<ключ> = "<значение>"`. Необязательный параметр.

      Более подробную информацию о параметрах ресурса `yandex_serverless_eventrouter_rule` см. в [документации провайдера]({{ tf-provider-resources-link }}/serverless_eventrouter_rule).

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
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../../cli/index.md):

      ```bash
      yc serverless eventrouter rule list
      ```

- API {#api}

  Чтобы создать [правило](../../../concepts/eventrouter/rule.md) с приемником {{ yds-full-name }}, воспользуйтесь методом REST API [Create](../../../eventrouter/api-ref/Rule/create.md) для ресурса [rule](../../../eventrouter/api-ref/Rule/index.md) или вызовом gRPC API [rule/Create](../../../eventrouter/api-ref/grpc/Rule/create.md).

{% endlist %}

По умолчанию правило создается включенным. Чтобы события, которые соответствуют правилу, перестали перенаправляться в приемник, [выключите](disable.md) правило.