# HTTPS-тест с постоянной нагрузкой с помощью Phantom

{% note warning %}

С 1 июля 2026 года сервис {{ load-testing-name }} прекращает работу. Подробнее на странице [Закрытие сервиса Yandex Load Testing](../../load-testing/sunset.md).

{% endnote %}


{{ load-testing-name }} можно использовать для тестирования сервиса с постоянной нагрузкой по протоколу [HTTPS](../../glossary/ssl-certificate.md) с помощью [генератора нагрузки](../../load-testing/concepts/load-generator.md) [Phantom](../../load-testing/concepts/load-generator.md#phantom).

Чтобы провести нагрузочное тестирование:
1. [Подготовьте облако к работе](#before-begin).
1. [Подготовьте цель тестирования](#target-prepare).
1. [Подготовьте инфраструктуру](#infrastructure-prepare).
1. [Создайте агент](#create-agent).
1. [Подготовьте файл с тестовыми данными](#test-file).
1. [Создайте и запустите тест](#run-test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

Если [агент](../../load-testing/concepts/agent.md) размещается на платформе {{ yandex-cloud }}, взимается плата за вычислительные ресурсы (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).

На стадии [Preview](../../overview/concepts/launch-stages.md) использование сервиса {{ load-testing-name }} не тарифицируется.

## Подготовьте цель тестирования {#target-prepare}

В качестве цели тестирования [создайте виртуальную машину](../../compute/operations/vm-create/create-linux-vm.md) из публичного образа Linux.

В этом примере будет тестироваться сервис с [внутренним IP-адресом](../../vpc/concepts/address.md#internal-addresses) `172.17.0.10` в той же [подсети](../../vpc/concepts/network.md#subnet), где будет размещен агент.

Убедитесь, что для доступа к сервису по протоколу HTTPS используется порт по умолчанию — `443`.

{{ load-testing-name }} также можно использовать для нагрузочного тестирования сервиса, доступного публично или находящегося в другой подсети и [группе безопасности](../../vpc/concepts/security-groups.md) относительно агента.

Для сервиса, доступного публично, разрешите входящий HTTPS-трафик на порт `443`.

Для сервиса, находящегося в другой подсети и группе безопасности относительно агента, [создайте](#security-group-setup) правило для входящего HTTPS-трафика на порт `443` в группе безопасности, где размещается цель тестирования.

## Подготовьте инфраструктуру {#infrastructure-prepare}

### Создайте сервисный аккаунт {#sa-create}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт `sa-loadtest` в каталоге, где будет размещаться агент, с которого будет подаваться нагрузка.
1. [Назначьте](../../iam/operations/roles/grant.md) сервисному аккаунту [роль](../../load-testing/security/index.md#roles-list) `loadtesting.generatorClient`.

### Настройте сеть {#network-setup}

[Создайте и настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) в подсети, где размещается цель тестирования и будет размещен агент. Это обеспечит доступ агента к сервису {{ load-testing-name }}.

### Настройте группы безопасности {#security-group-setup}

1. Настройте группу безопасности агента тестирования:

   1. [Создайте группу безопасности](../../vpc/operations/security-group-create.md) [агента](../../load-testing/concepts/agent.md) `agent-sg`.
   1. [Добавьте правила](../../vpc/operations/security-group-add-rule.md):
      1. Правило для исходящего HTTPS-трафика к публичному API {{ load-testing-name }}:
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `443`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.
   
         Это позволит подключить агент к сервису {{ load-testing-name }}, чтобы управлять тестами из интерфейса и получать результаты тестирования.
      1. Правило для входящего [SSH-трафика](../../glossary/ssh-keygen.md):
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `22`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.
   
         Это позволит подключаться к агенту по протоколу SSH и управлять тестами из консоли или собирать отладочную информацию.
      1. Правило для исходящего трафика при подаче нагрузки к цели тестирования:
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
           Выберите `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-list }}`. Укажите [группу безопасности](../../vpc/concepts/security-groups.md), в которой находится нужная цель тестирования.
   
         Создайте такое правило для каждой цели тестирования с уникальной группой безопасности.

1. Настройте группу безопасности цели тестирования:

   1. [Создайте](../../vpc/operations/security-group-create.md) группу безопасности цели тестирования `load-target-sg`.
   1. [Добавьте правило](../../vpc/operations/security-group-add-rule.md) для входящего трафика при подаче нагрузки к цели тестирования:
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
         Выберите `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-list }}`. Укажите [группу безопасности](../../vpc/concepts/security-groups.md), в которой находится нужная цель тестирования.
   
       Это правило позволит агентам подавать нагрузку на эту цель или подключать дополнительные средства мониторинга.

## Создайте агент тестирования {#create-agent}

<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplv7ro3actj5mipszpt?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

[Смотреть видео на YouTube](https://www.youtube.com/watch?v=YDcw9Bci8EM).



1. Если у вас еще нет пары [SSH-ключей](../../glossary/ssh-keygen.md), [создайте их](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
1. Создайте агент:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создан [агент](../../load-testing/concepts/agent.md).
     1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
     1. На вкладке **{{ ui-key.yacloud.load-testing.label_agents-list }}** нажмите кнопку **{{ ui-key.yacloud.load-testing.button_create-agent }}**.
     1. Укажите имя агента, например `agent-008`.
     1. Укажите ту же [зону доступности](../../overview/concepts/geo-scope.md), в которой находится цель тестирования.
     1. В блоке **{{ ui-key.yacloud.load-testing.section_agent }}**:
        * Выберите подходящий тип агента. Подробнее см. в разделе [Производительность агентов](../../load-testing/concepts/agent.md#benchmark).
        * Укажите [подсеть](../../vpc/concepts/network.md#subnet), в которой находится цель тестирования. В подсети должен быть создан и [настроен NAT-шлюз](../../vpc/operations/create-nat-gateway.md).
        * Если вам доступны [группы безопасности](../../vpc/concepts/security-groups.md), выберите заранее настроенную группу безопасности агента.
     1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа к агенту:
        * Выберите [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) `sa-loadtest`.
        * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.

          {% note alert %}

          Не используйте логин `root` или другие имена, зарезервированные операционной системой. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.

          {% endnote %}
              
        * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла [открытого ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
     1. Нажмите **{{ ui-key.yacloud.common.create }}**.
     1. Дождитесь завершения процесса создания [виртуальной машины](../../compute/concepts/vm.md). Статус агента должен смениться на `Ready for test`.

        {% note info %}

        Если процесс создания агента остановился на статусе `Initializing connection`, проверьте выполнение условий:
        * У агента есть [доступ](../../load-testing/operations/security-groups-agent.md) к `loadtesting.{{ api-host }}:443` и [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses).
        * В целевой подсети настроен NAT-шлюз.
        * У сервисного аккаунта, который назначен агенту, есть необходимые [роли](../../load-testing/operations/create-agent.md#infrastructure-prepare).

        {% endnote %}

   - CLI {#cli}

     Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

     По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

     1. Посмотрите описание команды [CLI](../../cli/index.md) для создания [агента](../../load-testing/concepts/agent.md):
   
        ```bash
        yc loadtesting agent create --help
        ```

     1. Выберите ту же [зону доступности](../../overview/concepts/geo-scope.md), в которой находится цель тестирования.

     1. Выберите [подсеть](../../vpc/concepts/network.md#subnet), в которой находится цель тестирования. В подсети должен быть [создан и настроен NAT-шлюз](../../vpc/operations/create-nat-gateway.md).
   
        Чтобы получить список доступных подсетей с помощью CLI, выполните следующую команду:
      
        ```bash
        yc vpc subnet list
        ```

        Результат:

        ```text
        +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
        |          ID          |           NAME            |      NETWORK ID      | ROUTE TABLE ID |       ZONE        |      RANGE      |
        +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
        | e2lfkhps7bol******** |   default-{{ region-id }}-b   | enpnf7hajqmd******** |                |   {{ region-id }}-b   | [10.129.0.0/24] |
        | e9bgnq1bggfa******** |   default-{{ region-id }}-a   | enpnf7hajqmd******** |                |   {{ region-id }}-a   | [10.128.0.0/24] |
        | fl841n5ilklr******** |   default-{{ region-id }}-d   | enpnf7hajqmd******** |                |   {{ region-id }}-d   | [10.130.0.0/24] |
        +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
        ```

     1. Выберите [группу безопасности](../../vpc/concepts/security-groups.md). Группа безопасности должна быть заранее [настроена](../../load-testing/operations/security-groups-agent.md).

        Чтобы получить список доступных групп безопасности с помощью CLI, выполните следующую команду:

        ```bash
        yc vpc security-group list
        ```
   
        Результат:
   
        ```text
        +----------------------+---------------------------------+--------------------------------+----------------------+
        |          ID          |              NAME               |          DESCRIPTION           |      NETWORK-ID      |
        +----------------------+---------------------------------+--------------------------------+----------------------+
        | enp414a2tnnp******** | default-sg-enpnf7hajqmd******** | Default security group for     | enpnf7hajqmd******** |
        |                      |                                 | network                        |                      |
        | enpctpve7951******** | sg-load-testing-agents          |                                | enpnf7hajqmd******** |
        | enpufo9ms0gi******** | sg-load-testing-targets         |                                | enpnf7hajqmd******** |
        +----------------------+---------------------------------+--------------------------------+----------------------+
        ```

     1. Узнайте идентификатор [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) `sa-loadtest` по его имени:

        ```bash
        yc iam service-account get sa-loadtest
        ```

        Результат:
   
        ```text
        id: ajespasg04oc********
        folder_id: b1g85uk96h3f********
        created_at: "2024-12-04T17:38:57Z"
        name: sa-loadtest
        last_authenticated_at: "2024-12-12T19:10:00Z"
        ```

     1. Создайте агента в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:
   
        ```bash
        yc loadtesting agent create \
          --name agent-008 \
          --labels origin=default,label-key=label-value \
          --zone default-{{ region-id }}-a \
          --network-interface subnet-id=e9bgnq1bggfa********,security-group-ids=enpctpve7951******** \
          --cores 2 \
          --memory 2G \
          --service-account-id ajespasg04oc********
          --metadata-from-file user-data=metadata.yaml
        ```
   
        Где:
        * `--name` — имя агента.
        * `--labels` — [метки](../../resource-manager/concepts/labels.md) агента.
        * `--zone` — зона доступности, в которой будет размещен агент.
        * `--network-interface` — настройки [сетевого интерфейса](../../compute/concepts/network.md) агента:
            * `subnet-name` — идентификатор выбранной подсети.
            * `security-group-ids` — идентификаторы групп безопасности.
        * `--cores` — сколько ядер процессора может задействовать агент.
        * `--memory` — сколько памяти отведено агенту.
        * `--service-account-id` — идентификатор сервисного аккаунта.
        * `--metadata-from-file` — пара `<ключ>=<значение>` с именем файла, содержащим путь к публичному SSH-ключу. Пример содержимого файла конфигурации `metadata.yaml` можно посмотреть в разделе [Метаданные виртуальной машины](../../compute/concepts/vm-metadata.md#how-to-send-metadata).

        Подробнее о создании агента с помощью CLI см. в [репозитории Yandex Cloud Examples](https://github.com/yandex-cloud-examples/yc-load-testing-create-agent).

   {% endlist %}

1. Привяжите публичный IP-адрес к агенту для доступа по протоколу SSH:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором размещен агент.
     1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
     1. Выберите ВМ с именем `agent-008`.
     1. В блоке **{{ ui-key.yacloud.compute.instance.overview.label_network-interface }}** в правом верхнем углу нажмите ![image](../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.instance.overview.button_add-public-ip }}**.
     1. В открывшемся окне:
        * В поле **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** выберите получение адреса **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_auto }}**.
        * Нажмите **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.button_submit }}**.

   - CLI {#cli}
   
     Чтобы привязать к агенту публичный IP-адрес выполните команду [CLI](../../cli/index.md):
   
     ```bash
     yc compute instance add-one-to-one-nat \
       --id=<идентификатор_ВМ> \
       --network-interface-index=<номер_сетевого_интерфейса_ВМ> \
       --nat-address=<IP-адрес>
     ```
   
     Где:
     * `--id` — идентификатор ВМ. Получите список идентификаторов ВМ, доступных в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder), с помощью [команды CLI](../../cli/cli-ref/compute/cli-ref/instance/list.md) `yc compute instance list`.
     * `--network-interface-index` — номер сетевого интерфейса ВМ. По умолчанию — `0`. Чтобы получить список сетевых интерфейсов ВМ и их номера, выполните команду `yc compute instance get <идентификатор_ВМ>`.
     * `--nat-address` — публичный IP-адрес, который нужно присвоить ВМ. Необязательный параметр. Если параметр `--nat-address` не задан, публичный IP-адрес будет присвоен ВМ автоматически.
   
       Получите список зарезервированных публичных IP-адресов, доступных в каталоге, с помощью [команды CLI](../../cli/cli-ref/vpc/cli-ref/address/list.md) `yc vpc address list`. IP-адрес и ВМ должны находиться в одной зоне доступности.
   
     Пример использования:
   
     ```bash
     yc compute instance add-one-to-one-nat \
       --id=fhmsbag62taf******** \
       --network-interface-index=0 \
       --nat-address=51.250.*.***
     ```
   
     Результат:
   
     ```text
     id: fhmsbag62taf********
     folder_id: b1gv87ssvu49********
     created_at: "2022-05-06T10:41:56Z"
     ...
     network_settings:
       type: STANDARD
     placement_policy: {}
     ```
   
     Подробнее о команде `yc compute instance add-one-to-one-nat` см. в [справочнике CLI](../../cli/cli-ref/compute/cli-ref/instance/add-one-to-one-nat.md).

   {% endlist %}

## Подготовьте файл с тестовыми данными {#test-file}

1. Сформируйте тестовые данные в формате [URI](../../load-testing/concepts/payloads/uri.md):

   ```text
   [Host: 172.17.0.10]
   [Connection: Close]
   / index
   /test?param1=1&param2=2 get_test
   ```

   Параметр `Host` — определяет IP-адрес цели тестирования.
   Параметр `Connection: Close` — указывает, будет ли соединение закрываться после каждого запроса. Для приложения и генератора нагрузки такой режим тяжелее. В случае, если нет необходимости закрывать соединения, выберите значение `Keep-Alive`.

   Также указаны два запроса, отмеченные тегами `index` и `get_test`. Генератор нагрузки будет повторять их по очереди в пределах заданного [профиля нагрузки](../../load-testing/concepts/load-profile.md).
1. Сохраните тестовые данные в файл `data.uri`.

## Создайте и запустите тест {#run-test}

1. Откройте [консоль управления]({{ link-console-main }}).
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
1. На панели слева выберите ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}** и нажмите **{{ ui-key.yacloud.load-testing.button_create-test }}**. 
1. В параметре **{{ ui-key.yacloud.load-testing.label_agents-list }}** выберите агент `agent-008`.
1. В блоке **{{ ui-key.yacloud.load-testing.test-data-section }}** нажмите **Выбрать файлы** и выберите сохраненный ранее файл `data.uri`.
1. В блоке **{{ ui-key.yacloud.load-testing.label_test-settings }}** выберите способ настройки: `{{ ui-key.yacloud.load-testing.label_settings-type-form }}` или `{{ ui-key.yacloud.load-testing.label_settings-type-config }}`.
1. В зависимости от выбранного способа задайте параметры теста:

   {% list tabs %}

   - Форма

     1. В поле **{{ ui-key.yacloud.load-testing.field_load-generator }}** выберите `PHANTOM`.
     1. В поле **Адрес цели** укажите IP-адрес тестируемого сервиса: `172.17.0.10`.
     1. В поле **Порт цели** укажите `443` (порт для HTTPS по умолчанию). Разрешите использовать защищенное соединение.
     1. В поле **Тестирующие потоки** укажите значение `5000`.

        Это означает, что генератор нагрузки сможет параллельно обрабатывать 5000 операций: создать 5000 соединений или ждать 5000 ответов от сервиса одновременно.

        {% note tip %}

        Для большинства тестов хватит 1000–10 000 [потоков](../../load-testing/concepts/testing-stream.md).

        Использование большего количества потоков задействует больше ресурсов [виртуальной машины](../../compute/concepts/vm.md), на которой запущен агент. Также существует ограничение {{ compute-name }} на 50 000 одновременных соединений с ВМ.

        {% endnote %}

     1. В меню **Тип нагрузки** выберите `RPS`.
     1. Добавьте **Профиль нагрузки**:
        * **Профиль** — `const`.
        * **Ответов в секунду** — `2000`.
        * **Длительность** — `10m`.

        Это указание генератору нагрузки обеспечивать нагрузку 2000 запросов в секунду в течение 10 минут.
     1. В поле **Тип запросов** выберите `URI`.
     1. В поле **{{ ui-key.yacloud.load-testing.test-data-section }}** выберите **Прикрепленный файл**.
     1. В меню **Автостоп** нажмите ![image](../../_assets/plus-sign.svg) **Автостоп** и введите описание:
        * **Тип автостопа** — `INSTANCES`.
        * **Предел** — `90%`.
        * **Размер окна** — `60s`.

        Этот критерий остановит тест, если в течение 60 секунд будет занято 90% тестирующих потоков, что свидетельствует о возникновении проблем тестирования. [Подробнее об автостопе](../../load-testing/concepts/auto-stop.md).
     1. В поле **Время принудительной остановки теста** укажите время, после которого сработает автостоп, если тест не будет остановлен по другим причинам. Значение параметра должно быть немного больше ожидаемой продолжительности теста.
     1. В блоке **{{ ui-key.yacloud.load-testing.meta-section }}** укажите имя, описание и номер тестируемой версии. Это поможет сделать отчет читаемым.

   - Конфигурационный файл

     В поле для ввода конфигурации введите настройки тестирующих потоков в формате `yaml`:

        ```yaml
        phantom:
          enabled: true
          package: yandextank.plugins.Phantom
          address: 172.17.0.10:443 # IP-адрес цели тестирования.
          ammo_type: uri
          load_profile:
            load_type: rps
            schedule: const(2000,5m) # Расписание нагрузки: 2000 запросов в секунду в течение 5 минут.
          ssl: true
          instances: 5000 # Количество потоков.
          ammofile: data.uri
        core: {}
        autostop: # Автостоп.
          enabled: true
          package: yandextank.plugins.Autostop
          autostop:
            - limit (5m) # Обязательно укажите предельное время работы теста.
            - instances(90%,60s) # Завершение теста, если в течение 60 секунд будет занято 90%
                                # тестирующих потоков, что свидетельствует о возникновении
                                # проблем тестирования.
        uploader:
          enabled: true
          package: yandextank.plugins.DataUploader
          job_name: '[example][phantom][const]'
          job_dsc: 'example'
          ver: '0.5.5'
          api_address: loadtesting.{{ api-host }}:443
        ```

        [Подробнее об автостопе](../../load-testing/concepts/auto-stop.md).

        {% note tip %}

        Посмотрите [пример файла конфигурации](../../load-testing/concepts/testing-stream.md#config_example). Также пример файла конфигурации можно посмотреть в уже имеющихся тестах.

        {% endnote %}

   {% endlist %}

1. Нажмите **{{ ui-key.yacloud.common.create }}**.

После этого конфигурация пройдет проверки и агент начнет нагружать тестируемый сервис.

Чтобы наблюдать за результатами выполнения тестирования, выберите созданный тест и перейдите на вкладку **{{ ui-key.yacloud.load-testing.label_test-report }}**.

## Как удалить созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите агент](../../compute/operations/vm-control/vm-delete.md).
1. [Удалите таблицу маршрутизации](../../vpc/operations/delete-route-table.md).
1. [Удалите NAT-шлюз](../../vpc/operations/delete-nat-gateway.md).