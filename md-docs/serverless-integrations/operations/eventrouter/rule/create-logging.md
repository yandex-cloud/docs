# Создать правило с приемником {{ cloud-logging-full-name }}

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

      1. Укажите тип приемника `{{ cloud-logging-full-name }}`.
      1. Выберите [лог-группу](../../../../logging/concepts/log-group.md), в которую будут отправляться сообщения, соответствующие правилу, или [каталог](../../../../resource-manager/concepts/resources-hierarchy.md#folder). Если выбран каталог, то сообщения будут отправляться в лог-группу по умолчанию для этого каталога.
      1. Выберите [сервисный аккаунт](../../../../iam/concepts/users/service-accounts.md), которому назначена [роль](../../../../logging/security/index.md#logging-writer) `logging.writer` или выше на выбранную лог-группу, или [создайте](../../../../iam/operations/sa/create.md) новый.
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

  1. Создайте правило с приемником {{ cloud-logging-full-name }}:

      ```bash
      yc serverless eventrouter rule create \
        --bus-id <идентификатор_шины> \
        --filter '<jq-шаблон>' \
        --logging-target \
      log-group-id=<идентификатор_лог-группы>,\
      service-account-id=<сервисный_аккаунт_очереди>,\
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

      * `--logging-target` — параметр для настройки приемника с типом `{{ cloud-logging-full-name }}` и его свойства:

          * `log-group-id` — идентификатор [лог-группы](../../../../logging/concepts/log-group.md), в которую будут отправляться сообщения, соответствующие правилу.

              Вместо параметра `log-group-id` можно указать параметр `folder-id`. Тогда сообщения будут отправляться в лог-группу по умолчанию для того каталога, идентификатор которого вы укажете в параметре `folder-id`.

          * `service-account-id` — идентификатор [сервисного аккаунта](../../../../iam/concepts/users/service-accounts.md), которому назначена [роль](../../../../logging/security/index.md#logging-writer) `logging.writer` или выше на выбранную лог-группу.


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
        - logging:
            log_group_id: e23di6hvn5fm********
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
      deletion_protection: true
      status: ENABLED
      ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../../terraform/authentication.md) соответствующим способом.

  Чтобы создать [правило](../../../concepts/eventrouter/rule.md) с приемником {{ cloud-logging-full-name }}:

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_serverless_eventrouter_rule" "example_rule" {
        bus_id    = "<идентификатор_шины>"
        jq_filter = "<jq-шаблон>"

        logging {
          log_group_id       = "<идентификатор_лог-группы>"
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
      * `logging` — блок для настройки приемника с типом `{{ cloud-logging-full-name }}` и его параметры:

          * `log_group_id` — идентификатор [лог-группы](../../../../logging/concepts/log-group.md), в которую будут отправляться сообщения, соответствующие правилу.

              Вместо параметра `log_group_id` можно указать параметр `folder_id`. Тогда сообщения будут отправляться в лог-группу по умолчанию для того каталога, идентификатор которого вы укажете в параметре `folder-id`.

          * `service_account_id` — идентификатор [сервисного аккаунта](../../../../iam/concepts/users/service-accounts.md), которому назначена [роль](../../../../logging/security/index.md#logging-writer) `logging.writer` или выше на выбранную лог-группу.

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

  Чтобы создать [правило](../../../concepts/eventrouter/rule.md) с приемником {{ cloud-logging-full-name }}, воспользуйтесь методом REST API [Create](../../../eventrouter/api-ref/Rule/create.md) для ресурса [rule](../../../eventrouter/api-ref/Rule/index.md) или вызовом gRPC API [rule/Create](../../../eventrouter/api-ref/grpc/Rule/create.md).

{% endlist %}

По умолчанию правило создается включенным. Чтобы события, которые соответствуют правилу, перестали перенаправляться в приемник, [выключите](disable.md) правило.