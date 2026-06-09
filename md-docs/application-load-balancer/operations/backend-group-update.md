# Изменить группу бэкендов

## Изменить базовые параметры группы {#update-group}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% note info %}

  Изменить [тип группы](../concepts/backend-group.md#group-types) можно только с помощью других инструментов: [CLI](../../cli/index.md), {{ TF }}, API.

  {% endnote %}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создана [группа бэкендов](../concepts/backend-group.md).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**.
  1. Нажмите на имя нужной группы.
  1. Нажмите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Измените параметры группы:
     * **{{ ui-key.yacloud.common.name }}** и **{{ ui-key.yc-ui-datasphere.common.description }}** группы бэкендов.
     * **{{ ui-key.yacloud.alb.label_session-affinity }}** — опция, при которой запросы в рамках одной пользовательской сессии обрабатывает один и тот же эндпоинт.

       {% note info %}
       
       Сейчас привязка сессий работает, только если в группе бэкендов активен (имеет положительный вес) один бэкенд, он состоит из одной или нескольких целевых групп и для него выбран [режим балансировки](../concepts/backend-group.md#balancing-mode) `MAGLEV_HASH`.
       
       {% endnote %}

       Для группы бэкендов типа `{{ ui-key.yacloud.alb.label_proto-http }}` или `{{ ui-key.yacloud.alb.label_proto-grpc }}` доступны режимы:
       * `{{ ui-key.yacloud.alb.label_affinity-connection }}`.
       * `{{ ui-key.yacloud.alb.label_affinity-header }}`.
       * `{{ ui-key.yacloud.alb.label_affinity-cookie }}`.

       Для типа `{{ ui-key.yacloud.alb.label_proto-stream }}` привязка сессий всегда работает по [IP-адресу](../../vpc/concepts/address.md).

       Подробнее о привязке сессий и ее режимах см. в [разделе](../concepts/backend-group.md#session-affinity).
  1. Внизу страницы нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../cli/index.md) для изменения базовых параметров [группы бэкендов](../concepts/backend-group.md):

     ```bash
     yc alb backend-group update --help
     ```

  1. Выполните команду:

     ```bash
     yc alb backend-group update \
       --name <имя_группы_бэкендов> \
       --new-name <новое_имя_группы_бэкендов> \
       --description <описание_группы_бэкендов> \
       --labels key=value[,<ключ>=<значение_метки>] \
       --connection-affinity source-ip=<режим_привязки_сессий_по_IP-адресу>
     ```

     Где:
     * `--name` — имя группы бэкендов.
     * `--new-name` — новое имя группы бэкендов. Требования к имени:

       * Длина — от 3 до 63 символов.
       * Может содержать строчные и заглавные буквы латинского и русского алфавита, цифры, дефисы, подчеркивания и пробелы.
       * Первый символ должен быть буквой. Последний символ не может быть дефисом, подчеркиванием или пробелом.

     * `--description` — описание группы бэкендов. Необязательный параметр.
     * `--labels key=value` — список меток в формате `ключ=значение`. Необязательный параметр.
     * `--connection-affinity` — режим [привязки сессий](../concepts/backend-group.md#session-affinity) по [IP-адресу](../../vpc/concepts/address.md) (`source-ip`). Может принимать значения `true` или `false`. Необязательный параметр. Также доступны режимы:
       * `--cookie-affinity` — привязка по cookie. Доступные параметры:
         * `name` — имя cookie. Обязательный параметр.
         * `path` — путь к разделу сайта, на котором будет действовать cookie. Если путь не указан, запросы от одного пользователя могут попадать в разные бэкенды.
         * `ttl` — время жизни cookie.
       * `--header-affinity` (по HTTP-заголовку). В параметре `name` укажите имя заголовка запроса, который будет использоваться для привязки.

       Может быть указан только один из режимов. Если группа бэкендов [типа Stream](../concepts/backend-group.md#group-types), режим привязки может быть только `--connection-affinity`.

       {% note info %}
       
       Сейчас привязка сессий работает, только если в группе бэкендов активен (имеет положительный вес) один бэкенд, он состоит из одной или нескольких целевых групп и для него выбран [режим балансировки](../concepts/backend-group.md#balancing-mode) `MAGLEV_HASH`.
       
       {% endnote %}

     Результат:

     ```text
     id: ds7mi7mlqgct********
     name: <имя_группы_бэкендов>
     description: update
     folder_id: b1g6hif00bod********
     labels:
       bar: buz
       foo: buz
     http:
       backends:
       - name: <имя_бэкенда>
         backend_weight: "2"
         load_balancing_config:
           panic_threshold: "90"
         port: "80"
         target_groups:
           target_group_ids:
           - ds75pc3146dh********
         healthchecks:
         - timeout: 10s
           interval: 2s
           healthy_threshold: "10"
           unhealthy_threshold: "15"
           healthcheck_port: "80"
           http:
             host: <адрес_хоста>
             path: <путь>
       connection:
         source_ip: true
     created_at: "2022-11-30T17:46:05.599491104Z"
     ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Откройте конфигурационный файл {{ TF }} и измените фрагмент с описанием [группы бэкендов](../concepts/backend-group.md):

     ```hcl
     resource "yandex_alb_backend_group" "test-backend-group" {
       name        = "<имя_группы_бэкендов>"
       description = "<описание_группы_бэкендов>"
       labels      = {
         new-label = "test-label"
       }
       session_affinity {
         connection {
           source_ip = <режим_привязки_сессий_по_IP-адресу>
         }
       }
     ...
     }
     ```

     Где `yandex_alb_backend_group` — параметры группы бэкендов:
     * `name` — имя группы бэкендов.
     * `description` — описание группы бэкендов. Необязательный параметр.
     * `labels` — список меток в формате `ключ=значение`. Необязательный параметр.
     * `session_affinity` — настройки [привязки сессий](../concepts/backend-group.md#session-affinity). Необязательный параметр. Укажите один из режимов:

       * `connection` — режим привязки сессий по [IP-адресу](../../vpc/concepts/address.md) (`source_ip`). Может принимать значения `true` или `false`.
       * `cookie` — режим привязки сессий по cookie. Укажите следующие параметры в формате `<параметр_1>=<значение>,<параметр_2>=<значение>`:
         * `name` — имя cookie. Обязательный параметр.
         * `path` — путь к разделу сайта, на котором будет действовать cookie. Если путь не указан, запросы от одного пользователя могут попадать в разные бэкенды.
         * `ttl` — время жизни cookie в секундах.
       * `header` — режим привязки сессий по заголовку. В параметре `header_name` укажите имя заголовка запроса, который будет использоваться для привязки.

       Если группа бэкендов имеет тип `Stream` (состоит из ресурсов `stream_backend`), то привязка сессий может иметь только режим `connection`.

       {% note info %}
       
       Сейчас привязка сессий работает, только если в группе бэкендов активен (имеет положительный вес) один бэкенд, он состоит из одной или нескольких целевых групп и для него выбран [режим балансировки](../concepts/backend-group.md#balancing-mode) `MAGLEV_HASH`.
       
       {% endnote %}

     Подробную информацию о параметрах ресурса `yandex_alb_backend_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-backendgroup }}).
  1. Примените изменения:

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

     Проверить изменения группы бэкендов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc alb backend-group get --name <имя_группы_бэкендов>
     ```

     {% note warning "Ограничения по времени" %}
     
     Провайдер {{ TF }} ограничивает время на выполнение операций с группами бэкендов {{ alb-name }} 10 минутами.
     
     Операции, которые длятся дольше указанного времени, прерываются.
     
     {% cut "Как изменить эти ограничения?" %}
     
     Добавьте к описанию группы бэкендов блок `timeouts`, например:
     
     ```hcl
     resource "yandex_alb_backend_group" "<имя_группы_бэкендов>" {
       ...
       timeouts {
         create = "60m"
         update = "60m"
         delete = "60m"
       }
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

- API {#api}

  Чтобы изменить базовые параметры [группы бэкендов](../concepts/backend-group.md), воспользуйтесь методом REST API [update](../api-ref/BackendGroup/update.md) для ресурса [BackendGroup](../api-ref/BackendGroup/index.md) или вызовом gRPC API [BackendGroupService/Update](../api-ref/grpc/BackendGroup/update.md).

{% endlist %}

## Добавить бэкенд в группу {#add-backend}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан бэкенд.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**.
  1. Нажмите на имя нужной группы.
  1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.alb.button_add-backend }}**.
  1. В открывшемся окне задайте настройки бэкенда:

     * **{{ ui-key.yacloud.common.name }}** бэкенда.
     * **{{ ui-key.yacloud.alb.label_backend-weight }}** — относительный вес бэкенда при распределении трафика. Если опция в поле отключена, эндпоинты бэкенда не будут получать трафик (вес будет равен 0).
     * **{{ ui-key.yacloud.common.type }}** бэкенда (для группы бэкендов типа `{{ ui-key.yacloud.alb.label_proto-http-plain }}`): `{{ ui-key.yacloud.alb.label_target-group }}` ([целевые группы](../concepts/target-group.md) {{ alb-name }}) или `{{ ui-key.yacloud.alb.label_bucket }}` ([бакет](../../storage/concepts/bucket.md) {{ objstorage-name }}). Для группы бэкендов типа `{{ ui-key.yacloud.alb.label_proto-grpc }}` или Stream тип любого бэкенда — `{{ ui-key.yacloud.alb.label_target-group }}`. Подробнее о типах бэкендов см. в разделе [{#T}](../concepts/backend-group.md#types).
     
     * Следующие настройки доступны только для типа бэкенда **{{ ui-key.yacloud.alb.label_target-group }}**:
     
       * В блоке **{{ ui-key.yacloud.alb.label_lb-settings }}**:
         
         * **{{ ui-key.yacloud.alb.label_load-balancing-mode }}** — [режим распределения трафика](../concepts/backend-group.md#balancing-mode) между эндпоинтами бэкенда.
         * **{{ ui-key.yacloud.alb.label_panic-threshold }}** — доля работоспособных эндпоинтов, при которой включится [режим паники](../concepts/backend-group.md#panic-mode): балансировщик будет распределять запросы во все эндпоинты, не учитывая результаты проверок состояния.
         * **{{ ui-key.yacloud.alb.label_locality-aware-routing }}** — доля входящего трафика, которую узел балансировщика передает бэкендам из своей зоны доступности. Остальной трафик поровну делится между другими зонами. Подробнее см. в разделе [{#T}](../concepts/backend-group.md#locality).
         * **{{ ui-key.yacloud.alb.label_strict-locality }}** — опция, при которой балансировщик будет отвечать ошибкой (`503 Service Unavailable`), если в зоне доступности, где был принят запрос, нет работающих бэкендов приложения.
      
       * В блоке **{{ ui-key.yacloud.alb.label_protocol-settings }}**:
         
         * Для группы бэкендов типа `{{ ui-key.yacloud.alb.label_proto-http }}`:
           
           * **{{ ui-key.yacloud.alb.label_use-http2 }}** — опция использования протокола HTTP/2 при отправке запросов к бэкенду для группы бэкендов типа `{{ ui-key.yacloud.alb.label_proto-http }}`. По умолчанию используется протокол версии 1.1. Группы бэкендов типа `{{ ui-key.yacloud.alb.label_proto-grpc }}` поддерживают только HTTP/2-соединения.
           * **{{ ui-key.yacloud.alb.label_protocol }}** — протокол соединений с бэкендом: `{{ ui-key.yacloud.alb.label_proto-http-plain }}` (без шифрования) или `{{ ui-key.yacloud.alb.label_proto-http-tls }}` (с TLS-шифрованием). Для протокола `{{ ui-key.yacloud.alb.label_proto-http-tls }}` укажите:
             
             * **{{ ui-key.yacloud.alb.label_sni }}**. Доменное имя хоста для Server Name Indication — расширения TLS.
             * **{{ ui-key.yacloud.alb.label_trusted-ca }}**. Укажите [корневой сертификат](https://en.wikipedia.org/wiki/Root_certificate) (Root CA) для цепочки сертификатов, установленной на эндпоинтах бэкендов.
     
               L7‑балансировщик поддерживает [X.509‑сертификаты](https://{{ lang }}.wikipedia.org/wiki/X.509), соответствующие требованиям [IETF](https://www.ietf.org/) (RFC [2459](https://www.ietf.org/rfc/rfc2459.txt)/[3280](https://www.ietf.org/rfc/rfc3280.txt)/[5280](https://www.ietf.org/rfc/rfc5280.txt)). Для сертификатов с алгоритмом [ECDSA](https://{{ lang }}.wikipedia.org/wiki/ECDSA) поддерживается только кривая P‑256.
         
         * Для группы бэкендов типа `{{ ui-key.yacloud.alb.label_proto-grpc }}`:
     
           * **{{ ui-key.yacloud.alb.label_protocol }}** — протокол соединений с бэкендом: `{{ ui-key.yacloud.alb.label_proto-grpc-plain }}` или `{{ ui-key.yacloud.alb.label_proto-grpc-tls }}`. Для зашифрованного протокола укажите **{{ ui-key.yacloud.alb.label_sni }}** и **{{ ui-key.yacloud.alb.label_trusted-ca }}** (см. выше).
         
         * Для группы бэкендов типа `{{ ui-key.yacloud.alb.label_proto-stream }}`:
           
           * **{{ ui-key.yacloud.alb.label_enable-proxy-protocol }}** — опция, при которой балансировщик передает бэкенду метаданные своего соединения с клиентом, в том числе его IP-адрес, по [протоколу PROXY от HAProxy](https://www.haproxy.org/download/1.9/doc/proxy-protocol.txt).
             
           * **{{ ui-key.yacloud.alb.label_protocol }}** — протокол соединений с бэкендом: `{{ ui-key.yacloud.alb.label_proto-grpc-plain }}` или `{{ ui-key.yacloud.alb.label_proto-grpc-tls }}`. Для зашифрованного протокола укажите **{{ ui-key.yacloud.alb.label_sni }}** и **{{ ui-key.yacloud.alb.label_trusted-ca }}** (см. выше).
     
     * Следующие настройки доступны только для типа бэкенда **{{ ui-key.yacloud.alb.label_bucket }}** для типа группы бэкендов **{{ ui-key.yacloud.alb.label_proto-http }}**:
     
       * **{{ ui-key.yacloud.mdb.forms.config_field_form-bucket-type }}** — выберите одну из опций: `{{ ui-key.yacloud.forms.label_form-list }}` или `{{ ui-key.yacloud.forms.label_form-id }}`.
       * **{{ ui-key.yacloud.alb.label_bucket }}** — выберите из списка или укажите идентификатор нужного бакета.
     
     * В блоке **HTTP проверка состояния**, **gRPC проверка состояния** или **Stream проверка состояния**:
       
       * **{{ ui-key.yacloud.alb.label_timeout }}** — время ожидания ответа. Максимальный период, на который может быть установлено соединение.
       * **{{ ui-key.yacloud.alb.label_interval }}** — интервал отправки проверочных запросов.
       * **{{ ui-key.yacloud.alb.label_healthy }}** — количество последовательных успешных проверок, после которых эндпоинт считается работоспособным. Игнорируется в начале работы балансировщика: достаточно одной проверки.
       * **{{ ui-key.yacloud.alb.label_unhealthy }}** — количество последовательных неуспешных проверок, после которых эндпоинт считается неработоспособным. Игнорируется, если бэкенд один раз ответил HTTP-кодом состояния `503 Service Unavailable`: он сразу считается неработоспособным.
       * **{{ ui-key.yacloud.alb.label_port }}**.
       * **{{ ui-key.yacloud.common.type }}** — протокол, по которому будет осуществляться проверка: `{{ ui-key.yacloud.alb.label_hc-type-http }}`, `{{ ui-key.yacloud.alb.label_hc-type-grpc }}` или `{{ ui-key.yacloud.alb.label_hc-type-stream }}`. Тип проверки может не совпадать с типом группы бэкендов. Дополнительно укажите:
         
         * Для типа `{{ ui-key.yacloud.alb.label_hc-type-http }}`:
           
           * **{{ ui-key.yacloud.alb.label_path }}** — путь в URI запроса к эндпоинту.
           * **{{ ui-key.yacloud.alb.label_hc_host }}** — значение заголовка `Host` для HTTP/1.1 или псевдо-заголовка `:authority` для HTTP/2, которое будет передаваться эндпоинтам бэкенда при проверках состояния.
           * **{{ ui-key.yacloud.alb.label_use-http2 }}** — опция использования протокола HTTP версии 2.
           * **{{ ui-key.yacloud.alb.label_expected-statuses }}** — список HTTP-кодов, которые считаются корректными при проверке состояния бэкенда.
          
         * Для типа `{{ ui-key.yacloud.alb.label_hc-type-grpc }}`:
           
           * **{{ ui-key.yacloud.alb.label_service-name }}** — имя проверяемого gRPC-сервиса. Если сервис не указан, проверяется общее состояние бэкенда.
          
         * Для типа `{{ ui-key.yacloud.alb.label_hc-type-stream }}`:
           
           * **{{ ui-key.yacloud.alb.label_send }}** — данные, которые отправляются на эндпоинт для проверки состояния.
           * **{{ ui-key.yacloud.alb.label_receive }}** — данные, которые должны поступить с эндпоинта, чтобы он прошел проверку состояния.
           
       {% note alert %}
       
       Если в зоне доступности все бэкенды с подключенными проверками состояния не прошли проверки, трафик перестанет поступать в зону, даже если в ней есть рабочие бэкенды без проверок состояния.
       
       Рекомендуется настраивать [проверки состояния](../concepts/backend-group.md#health-checks) для всех бэкендов. 
       
       {% endnote %}
     
       Чтобы добавить проверку состояния, внизу блока бэкенда нажмите кнопку **{{ ui-key.yacloud.alb.button_add-healthcheck }}** и задайте настройки проверки.
     
       Чтобы удалить проверку состояния, напротив заголовка **HTTP проверка состояния**, **gRPC проверка состояния** или **Stream проверка состояния** нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Добавьте в группу бэкенд и проверку состояния.

  {% note alert %}
  
  Если в зоне доступности все бэкенды с подключенными проверками состояния не прошли проверки, трафик перестанет поступать в зону, даже если в ней есть рабочие бэкенды без проверок состояния.
  
  Рекомендуется настраивать [проверки состояния](../concepts/backend-group.md#health-checks) для всех бэкендов. 
  
  {% endnote %}

  Внутри группы все бэкенды должны быть одного [типа](../concepts/backend-group.md#group-types) — `HTTP` или `Stream`.

  {% cut "HTTP-бэкенд" %}

  Выполните команду:

  ```bash
  yc alb backend-group add-http-backend \
    --backend-group-name <имя_бэкенд_группы> \
    --name <имя_добавляемого_бэкенда> \
    --weight <вес_бэкенда> \
    --port <порт_бэкенда> \
    --target-group-id=<идентификатор_целевой_группы> \
    --panic-threshold 90 \
    --http-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,expected-statuses=211,\
  timeout=10s,interval=2s,host=<адрес_хоста>,path=<путь>
  ```

  Где:
  * `--name` — имя существующего бэкенда, параметры которого хотите обновить, или имя нового бэкенда, который хотите добавить.
  * `--panic-threshold` — порог для режима паники.
  * `--http-healthcheck` — параметры проверки состояния ресурсов:
    * `port` — порт.
    * `healthy-threshold` — порог работоспособности.
    * `unhealthy-threshold` — порог неработоспособности.
    * `expected-statuses` — код состояния HTTP, который будет считаться корректным при проверке состояния бэкенда. Чтобы добавить несколько значений, укажите их через запятую: `expected-statuses=201,expected-statuses=205,expected-statuses=302`. Коды могут принимать значения от `100` до `599`. Если параметр не задан, код ответа будет один — `200`.
    * `timeout` — максимальный период, на который может быть установлено соединение.
    * `interval` — интервал.
    * `host` — адрес хоста.
    * `path` — путь.

  Результат:

  ```text
  id: a5dqkr2mk3rr********
  name: <имя_группы_бэкендов>
  folder_id: aoe197919j8e********
  ...
          host: <адрес_хоста>
          path: <путь>
  created_at: "2021-02-11T20:46:21.688940670Z"
  ```

  {% endcut %}

  {% cut "gRPC-бэкенд" %}

  Выполните команду:

  ```bash
  yc alb backend-group add-grpc-backend \
    --backend-group-name <имя_бэкенд_группы> \
    --name <имя_добавляемого_бэкенда> \
    --weight <вес_бэкенда> \
    --port <порт_бэкенда> \
    --target-group-id=<идентификатор_целевой_группы> \
    --panic-threshold 90 \
    --grpc-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,\
  timeout=10s,interval=2s,service-name=<имя_gRPC-сервиса>
  ```

  Где:
  * `--panic-threshold` — порог для режима паники.
  * `--grpc-healthcheck` — параметры проверки состояния ресурсов:
    * `port` — порт.
    * `healthy-threshold` — порог работоспособности.
    * `unhealthy-threshold` — порог неработоспособности.
    * `timeout` — максимальный период, на который может быть установлено соединение.
    * `interval` — интервал.
    * `service-name` — имя проверяемого gRPC-сервиса. Если сервис не указан, проверяется общее состояние бэкенда.

  Результат:

  ```text
  id: a5dqkr2mk3rr********
  name: <имя_группы_бэкендов>
  folder_id: aoe197919j8e********
  ...
            grpc:
              service_name: <имя_gRPC-сервиса>
  ...
  created_at: "2021-02-11T20:46:21.688940670Z"
  ```

  {% endcut %}

  {% cut "Stream-бэкенд" %}

  Выполните команду:

  ```bash
  yc alb backend-group add-stream-backend \
    --backend-group-name <имя_бэкенд_группы> \
    --name <имя_добавляемого_бэкенда> \
    --weight <вес_бэкенда> \
    --port <порт_бэкенда> \
    --target-group-id=<идентификатор_целевой_группы> \
    --panic-threshold 90 \
    --enable-proxy-protocol \
    --keep-connections-on-host-health-failure \
    --stream-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,\
  timeout=10s,interval=2s,send-text=<данные_к_эндпоинту>,receive-text=<данные_от_эндпоинта>
  ```

  Где:
  * `--panic-threshold` — порог для режима паники.
  * `--enable-proxy-protocol` — опция, при которой балансировщик передает бэкенду метаданные своего соединения с клиентом, в том числе его IP-адрес, по [протоколу PROXY от HAProxy](https://www.haproxy.org/download/1.9/doc/proxy-protocol.txt). Если опция не задана, в бэкенд передается только IP-адрес балансировщика.
  * `--keep-connections-on-host-health-failure` — опция позволяет сохранять соединение, даже когда проверка состояния неуспешна.
  * `--stream-healthcheck` — параметры проверки состояния ресурсов:
    * `port` — порт.
    * `healthy-threshold` — порог работоспособности.
    * `unhealthy-threshold` — порог неработоспособности.
    * `timeout` — максимальный период, на который может быть установлено соединение.
    * `interval` — интервал.
    * `send-text` — данные, которые отправляются на эндпоинт для проверки состояния.
    * `receive-text` — данные, которые должны поступить с эндпоинта, чтобы он прошел проверку состояния.

  Результат:

  ```text
  id: ds77tero4f5********
  name: <имя_группы_бэкендов>
  folder_id: b1gu6g9ielh6********
  ...
              text: <данные_к_эндпоинту>
            receive:
              text: <данные_от_эндпоинта>
      enable_proxy_protocol: true
  created_at: "2022-04-06T09:17:57.104324513Z"
  ```

  {% endcut %}

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Откройте конфигурационный файл {{ TF }} и добавьте блок с описанием бэкенда (`http_backend`, `grpc_backend` или `stream_backend`) во фрагмент с описанием группы бэкендов:

     ```hcl
     resource "yandex_alb_backend_group" "test-backend-group" {
       name                     = "<имя_группы_бэкендов>"
     
       stream_backend {
         name                   = "<имя_бэкенда>"
         weight                 = 1
         port                   = 80
         target_group_ids       = ["<идентификатор_целевой_группы>"]
         load_balancing_config {
           panic_threshold      = 90
         }
         enable_proxy_protocol  = true
         healthcheck {
           timeout              = "10s"
           interval             = "2s"
           healthy_threshold    = 10
           unhealthy_threshold  = 15 
           stream_healthcheck {
             send               = "<данные_к_эндпоинту>"
             receive            = "<данные_от_эндпоинта>"
           }
         }
       }
     }
     ```

     Где `yandex_alb_backend_group` — параметры группы бэкендов:
     * `name` — имя группы бэкендов.
     * `http_backend`, `grpc_backend` и `stream_backend` — [тип бэкенда](../concepts/backend-group.md#group-types). Внутри группы все бэкенды должны быть одного типа — `HTTP`, `gRPC` или `Stream`.

     Параметры бэкенда:
     * `name` — имя бэкенда.
     * `port` — порт бэкенда.
     * `weight` — вес бэкенда.
     * `target_group_ids` — идентификатор [целевой группы](../concepts/target-group.md). Получить список доступных целевых групп можно с помощью команды [CLI](../../cli/index.md): `yc alb target-group list`.
     * `load_balancing_config` — параметры балансировки:
       * `panic_threshold` — порог для режима паники.
     * `enable_proxy_protocol` — опция, при которой балансировщик передает бэкенду метаданные своего соединения с клиентом, в том числе его IP-адрес, по [протоколу PROXY от HAProxy](https://www.haproxy.org/download/1.9/doc/proxy-protocol.txt). Если опция не задана, в бэкенд передается только IP-адрес балансировщика. Параметр доступен только для бэкендов типа `Stream`.
     * `healthcheck` — параметры проверки состояния:
       * `timeout` — максимальный период, на который может быть установлено соединение.
       * `interval` — интервал.
       * `healthy_threshold` — порог работоспособности.
       * `unhealthy_threshold` — порог неработоспособности.
       * `keep_connections_on_host_health_failure` — опция, при которой соединения сохраняются открытыми, даже если целевой хост переходит в статус `Unhealthy`.
       * `http_healthcheck` — параметры проверки состояния типа `HTTP`:
         * `path` — путь, например `/health`.
         * `host` — адрес хоста, например `example.com`.
         * `expected_statuses` — список HTTP-кодов, соответствующих статусу `Healthy`. Например: `[200, 201, 202]`.
       * `grpc_healthcheck` — параметры проверки состояния типа `gRPC`:
         * `service_name` — имя проверяемого gRPC-сервиса. Если сервис не указан, проверяется общее состояние бэкенда.
       * `stream_healthcheck` — параметры проверки состояния типа `Stream`:
         * `send` — данные, которые отправляются на эндпоинт для проверки состояния.
         * `receive` — данные, которые должны поступить с эндпоинта, чтобы он прошел проверку состояния.
     
       {% note alert %}
       
       Если в зоне доступности все бэкенды с подключенными проверками состояния не прошли проверки, трафик перестанет поступать в зону, даже если в ней есть рабочие бэкенды без проверок состояния.
       
       Рекомендуется настраивать [проверки состояния](../concepts/backend-group.md#health-checks) для всех бэкендов. 
       
       {% endnote %}

     Подробную информацию о параметрах ресурса `yandex_alb_backend_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-backendgroup }}).
  1. Примените изменения:

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

     Проверить изменения группы бэкендов можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI:

     ```bash
     yc alb backend-group get --name <имя_группы_бэкендов>
     ```

     {% note warning "Ограничения по времени" %}
     
     Провайдер {{ TF }} ограничивает время на выполнение операций с группами бэкендов {{ alb-name }} 10 минутами.
     
     Операции, которые длятся дольше указанного времени, прерываются.
     
     {% cut "Как изменить эти ограничения?" %}
     
     Добавьте к описанию группы бэкендов блок `timeouts`, например:
     
     ```hcl
     resource "yandex_alb_backend_group" "<имя_группы_бэкендов>" {
       ...
       timeouts {
         create = "60m"
         update = "60m"
         delete = "60m"
       }
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

- API {#api}

  Чтобы изменить базовые параметры группы, воспользуйтесь методом REST API [addBackend](../api-ref/BackendGroup/addBackend.md) для ресурса [BackendGroup](../api-ref/BackendGroup/index.md) или вызовом gRPC API [BackendGroupService/AddBackend](../api-ref/grpc/BackendGroup/addBackend.md).

{% endlist %}

## Изменить параметры бэкенда в группе {#update-backend}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан бэкенд.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**.
  1. Нажмите на имя нужной группы.
  1. Напротив имени бэкенда нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. В открывшемся окне задайте настройки бэкенда. Подробнее о настройках см. [выше](#add-backend).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения параметров бэкенда:

     ```bash
     yc alb backend-group update-<тип_бэкенда>-backend --help
     ```

  1. Укажите новые параметры бэкенда в зависимости от его типа:

     {% cut "HTTP-бэкенд" %}

     Выполните команду:

     ```bash
     yc alb backend-group update-http-backend \
       --backend-group-name <имя_группы_бэкендов> \
       --name <имя_бэкенда> \
       --weight <вес_бэкенда> \
       --port <порт_бэкенда> \
       --target-group-id=<идентификатор_целевой_группы> \
       --panic-threshold 90 \
       --http-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,expected-statuses=211,\
     timeout=10s,interval=2s,host=your-host.com,path=/ping
     ```

     Где:
     * `--name` — имя существующего бэкенда, параметры которого хотите обновить, или имя нового бэкенда, который хотите добавить.
     * `--panic-threshold` — порог для режима паники.
     * `--http-healthcheck` — параметры проверки состояния ресурсов:
       * `port` — порт.
       * `healthy-threshold` — порог работоспособности.
       * `unhealthy-threshold` — порог неработоспособности.
       * `expected-statuses` — код состояния HTTP, который будет считаться корректным при проверке состояния бэкенда. Чтобы добавить несколько значений, укажите их через запятую: `expected-statuses=201,expected-statuses=205,expected-statuses=302`. Коды могут принимать значения от `100` до `599`. Если параметр не задан, код ответа будет один — `200`.
       * `timeout` — максимальный период, на который может быть установлено соединение.
       * `interval` — интервал.
       * `host` — адрес хоста.
       * `path` — путь.

     Результат:

     ```text
     id: a5dqkr2mk3rr********
     name: <имя_группы_бэкендов>
     folder_id: aoe197919j8e********
     ...
             host: <адрес_хоста>
             path: <путь>
     created_at: "2021-02-11T20:46:21.688940670Z"
     ```

     {% endcut %}

     {% cut "gRPC-бэкенд" %}

     Выполните команду:

     ```bash
     yc alb backend-group update-grpc-backend \
       --backend-group-name <имя_группы_бэкендов> \
       --name <имя_добавляемого_бэкенда> \
       --weight <вес_бэкенда> \
       --port <порт_бэкенда> \
       --target-group-id=<идентификатор_целевой_группы> \
       --panic-threshold 90 \
       --grpc-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,\
     timeout=10s,interval=2s,service-name=<имя_gRPC-сервиса>
     ```

     Где:
     * `--panic-threshold` — порог для режима паники.
     * `--grpc-healthcheck` — параметры проверки состояния ресурсов:
       * `port` — порт.
       * `healthy-threshold` — порог работоспособности.
       * `unhealthy-threshold` — порог неработоспособности.
       * `timeout` — максимальный период, на который может быть установлено соединение.
       * `interval` — интервал.
       * `service-name` — имя проверяемого gRPC-сервиса. Если сервис не указан, проверяется общее состояние бэкенда.

     Результат:

     ```text
     id: a5dqkr2mk3rr********
     name: <имя_группы_бэкендов>
     folder_id: aoe197919j8e********
     ...
               grpc:
                 service_name: <имя_gRPC-сервиса>
     ...
     created_at: "2021-02-11T20:46:21.688940670Z"
     ```

     {% endcut %}

     {% cut "Stream-бэкенд" %}

     Выполните команду:

     ```bash
     yc alb backend-group update-stream-backend \
       --backend-group-name <имя_группы_бэкендов> \
       --name <имя_добавляемого_бэкенда> \
       --weight <вес_бэкенда> \
       --port <порт_бэкенда> \
       --target-group-id=<идентификатор_целевой_группы> \
       --panic-threshold 90 \
       --enable-proxy-protocol \
       --keep-connections-on-host-health-failure \
       --stream-healthcheck port=80,healthy-threshold=10,unhealthy-threshold=15,\
     timeout=10s,interval=2s,send-text=<данные_к_эндпоинту>,receive-text=<данные_от_эндпоинта>
     ```

     Где:
     * `--panic-threshold` — порог для режима паники.
     * `--enable-proxy-protocol` — опция, при которой балансировщик передает бэкенду метаданные своего соединения с клиентом, в том числе его IP-адрес, по [протоколу PROXY от HAProxy](https://www.haproxy.org/download/1.9/doc/proxy-protocol.txt). Если опция не задана, в бэкенд передается только IP-адрес балансировщика.
     * `--keep-connections-on-host-health-failure` — опция позволяет сохранять соединение, даже когда проверка состояния неуспешна.
     * `--stream-healthcheck` — параметры проверки состояния ресурсов:
       * `port` — порт.
       * `healthy-threshold` — порог работоспособности.
       * `unhealthy-threshold` — порог неработоспособности.
       * `timeout` — максимальный период, на который может быть установлено соединение.
       * `interval` — интервал.
       * `send-text` — данные, которые отправляются на эндпоинт для проверки состояния.
       * `receive-text` — данные, которые должны поступить с эндпоинта, чтобы он прошел проверку состояния.

     Результат:

     ```text
     id: ds77tero4f5********
     name: <имя_группы_бэкендов>
     folder_id: b1gu6g9ielh6********
     ...
                 text: <данные_к_эндпоинту>
               receive:
                 text: <данные_от_эндпоинта>
         enable_proxy_protocol: true
     created_at: "2022-04-06T09:17:57.104324513Z"
     ```

     {% endcut %}

     {% note alert %}
     
     Если в зоне доступности все бэкенды с подключенными проверками состояния не прошли проверки, трафик перестанет поступать в зону, даже если в ней есть рабочие бэкенды без проверок состояния.
     
     Рекомендуется настраивать [проверки состояния](../concepts/backend-group.md#health-checks) для всех бэкендов. 
     
     {% endnote %}

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Откройте конфигурационный файл {{ TF }} и измените параметры блока с описанием бэкенда (`http_backend`, `grpc_backend` или `stream_backend`) во фрагменте с описанием группы бэкендов:

     ```hcl
     resource "yandex_alb_backend_group" "test-backend-group" {
       name                     = "<имя_группы_бэкендов>"
     
       stream_backend {
         name                   = "<имя_бэкенда>"
         weight                 = 1
         port                   = 80
         target_group_ids       = ["<идентификатор_целевой_группы>"]
         load_balancing_config {
           panic_threshold      = 90
         }
         enable_proxy_protocol  = true
         healthcheck {
           timeout              = "10s"
           interval             = "2s"
           healthy_threshold    = 10
           unhealthy_threshold  = 15 
           stream_healthcheck {
             send               = "<данные_к_эндпоинту>"
             receive            = "<данные_от_эндпоинта>"
           }
         }
       }
     }
     ```

     Где `yandex_alb_backend_group` — параметры группы бэкендов:
     * `name` — имя группы бэкендов.
     * `http_backend`, `grpc_backend` и `stream_backend` — [тип бэкенда](../concepts/backend-group.md#group-types). Внутри группы все бэкенды должны быть одного типа — `HTTP`, `gRPC` или `Stream`.

     Параметры бэкенда:
     * `name` — имя бэкенда.
     * `port` — порт бэкенда.
     * `weight` — вес бэкенда.
     * `target_group_ids` — идентификатор [целевой группы](../concepts/target-group.md). Получить список доступных целевых групп можно с помощью команды [CLI](../../cli/index.md): `yc alb target-group list`.
     * `load_balancing_config` — параметры балансировки:
       * `panic_threshold` — порог для режима паники.
     * `enable_proxy_protocol` — опция, при которой балансировщик передает бэкенду метаданные своего соединения с клиентом, в том числе его IP-адрес, по [протоколу PROXY от HAProxy](https://www.haproxy.org/download/1.9/doc/proxy-protocol.txt). Если опция не задана, в бэкенд передается только IP-адрес балансировщика. Параметр доступен только для бэкендов типа `Stream`.
     * `healthcheck` — параметры проверки состояния:
       * `timeout` — максимальный период, на который может быть установлено соединение.
       * `interval` — интервал.
       * `healthy_threshold` — порог работоспособности.
       * `unhealthy_threshold` — порог неработоспособности.
       * `keep_connections_on_host_health_failure` — опция, при которой соединения сохраняются открытыми, даже если целевой хост переходит в статус `Unhealthy`.
       * `http_healthcheck` — параметры проверки состояния типа `HTTP`:
         * `path` — путь, например `/health`.
         * `host` — адрес хоста, например `example.com`.
         * `expected_statuses` — список HTTP-кодов, соответствующих статусу `Healthy`. Например: `[200, 201, 202]`.
       * `grpc_healthcheck` — параметры проверки состояния типа `gRPC`:
         * `service_name` — имя проверяемого gRPC-сервиса. Если сервис не указан, проверяется общее состояние бэкенда.
       * `stream_healthcheck` — параметры проверки состояния типа `Stream`:
         * `send` — данные, которые отправляются на эндпоинт для проверки состояния.
         * `receive` — данные, которые должны поступить с эндпоинта, чтобы он прошел проверку состояния.
     
       {% note alert %}
       
       Если в зоне доступности все бэкенды с подключенными проверками состояния не прошли проверки, трафик перестанет поступать в зону, даже если в ней есть рабочие бэкенды без проверок состояния.
       
       Рекомендуется настраивать [проверки состояния](../concepts/backend-group.md#health-checks) для всех бэкендов. 
       
       {% endnote %}

     Подробную информацию о параметрах ресурса `yandex_alb_backend_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-backendgroup }}).
  1. Примените изменения:

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

     Проверить изменения группы бэкендов можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI:

     ```bash
     yc alb backend-group get --name <имя_группы_бэкендов>
     ```

     {% note warning "Ограничения по времени" %}
     
     Провайдер {{ TF }} ограничивает время на выполнение операций с группами бэкендов {{ alb-name }} 10 минутами.
     
     Операции, которые длятся дольше указанного времени, прерываются.
     
     {% cut "Как изменить эти ограничения?" %}
     
     Добавьте к описанию группы бэкендов блок `timeouts`, например:
     
     ```hcl
     resource "yandex_alb_backend_group" "<имя_группы_бэкендов>" {
       ...
       timeouts {
         create = "60m"
         update = "60m"
         delete = "60m"
       }
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

- API {#api}

  Чтобы изменить параметры бэкенда в группе, воспользуйтесь методом REST API [updateBackend](../api-ref/BackendGroup/updateBackend.md) для ресурса [BackendGroup](../api-ref/BackendGroup/index.md) или вызовом gRPC API [BackendGroupService/UpdateBackend](../api-ref/grpc/BackendGroup/updateBackend.md).

{% endlist %}

## Удалить бэкенд из группы {#delete-backend}

Чтобы удалить бэкенд из группы:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан бэкенд.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**.
  1. Нажмите на имя нужной группы.
  1. Напротив имени бэкенда нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для удаления бэкенда из группы:

     ```bash
     yc application-load-balancer delete-<тип_бэкенда>-backend --help
     ```

  1. В зависимости от типа бэкенда выполните команду для удаления:
     * HTTP-бэкенд:

       ```bash
       yc alb backend-group delete-http-backend \
         --backend-group-name=<имя_группы_бэкендов> \
         --name=<имя_удаляемого_бэкенда>
       ```

     * gRPC-бэкенд:

       ```bash
       yc alb backend-group delete-grpc-backend \
         --backend-group-name=<имя_группы_бэкендов> \
         --name=<имя_удаляемого_бэкенда>
       ```

     * Stream-бэкенд:

       ```bash
       yc alb backend-group delete-stream-backend \
         --backend-group-name=<имя_группы_бэкендов> \
         --name=<имя_удаляемого_бэкенда>
       ```

     Результат:

     ```text
     id: a5dqkr2mk3rr********
     name: <имя_бэкенда>
     folder_id: aoe197919j8e********
     created_at: "2021-02-11T20:46:21.688940670Z"
     ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Откройте конфигурационный файл {{ TF }} и удалите блок с описанием бэкенда (`http_backend`, `grpc_backend` или `stream_backend`) во фрагменте с описанием группы бэкендов.

     Пример описания группы бэкендов в конфигурации {{ TF }}:

     ```hcl
     resource "yandex_alb_backend_group" "test-backend-group" {
       name                     = "<имя_группы_бэкендов>"

       http_backend {
         name                   = "<имя_бэкенда>"
         weight                 = 1
         port                   = 80
         target_group_ids       = ["<идентификатор_целевой_группы>"]
         load_balancing_config {
           panic_threshold      = 90
         }
         healthcheck {
           timeout              = "10s"
           interval             = "2s"
           healthy_threshold    = 10
           unhealthy_threshold  = 15
           http_healthcheck {
             path               = "/"
           }
         }
       }
     }
     ```

     Подробную информацию о параметрах ресурса `yandex_alb_backend_group` см. в [документации провайдера {{ TF }}]({{ tf-provider-alb-backendgroup }}).
  1. Примените изменения:

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

     Проверить изменения группы бэкендов можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI:

     ```bash
     yc alb backend-group get --name <имя_группы_бэкендов>
     ```

- API {#api}

  Воспользуйтесь методом REST API [removeBackend](../api-ref/BackendGroup/removeBackend.md) для ресурса [BackendGroup](../api-ref/BackendGroup/index.md) или вызовом gRPC API [BackendGroupService/RemoveBackend](../api-ref/grpc/BackendGroup/removeBackend.md).

{% endlist %}

### См. также {#see-also}

* [{#T}](../concepts/best-practices.md)