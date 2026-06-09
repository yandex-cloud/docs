# Нагрузочный тест с помощью JMeter

{% note warning %}

С 1 июля 2026 года сервис Load Testing прекращает работу. Подробнее на странице [Закрытие сервиса Yandex Load Testing](../sunset.md).

{% endnote %}


Load Testing можно использовать для тестирования сервиса с постоянной нагрузкой по протоколу HTTPS с помощью [генератора нагрузки](../concepts/load-generator.md) [JMeter](../concepts/load-generator.md#jmeter).

Чтобы провести нагрузочное тестирование:
1. [Подготовьте облако к работе](#before-begin).
1. [Подготовьте цель тестирования](#target-prepare).
1. [Подготовьте инфраструктуру](#infrastructure-prepare).
1. [Создайте агент](#create-agent).
1. [Подготовьте файл с тестовыми данными](#test-file).
1. [Запустите тест](#run-test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

Если [агент](../concepts/agent.md) размещается на платформе Yandex Cloud, взимается плата за вычислительные ресурсы (см. [тарифы Yandex Compute Cloud](../../compute/pricing.md)).

На стадии [Preview](../../overview/concepts/launch-stages.md) использование сервиса Load Testing не тарифицируется.

## Подготовьте цель тестирования {#target-prepare}

В этом примере будет тестироваться сервис с [внутренним IP-адресом](../../vpc/concepts/address.md#internal-addresses) `172.17.0.10` в той же [подсети](../../vpc/concepts/network.md#subnet), где будет размещен агент.

Убедитесь, что для доступа к сервису по протоколу HTTPS используется порт по умолчанию — `443`.

Load Testing также можно использовать для нагрузочного тестирования сервиса, доступного публично или находящегося в другой подсети и [группе безопасности](../../vpc/concepts/security-groups.md) относительно агента.

Для сервиса, доступного публично, разрешите входящий HTTPS-трафик на порт `443`.

Для сервиса, находящегося в другой подсети и группе безопасности относительно агента, [создайте](#security-group-setup) правило для входящего HTTPS-трафика на порт `443` в группе безопасности, где размещается цель тестирования.

## Подготовьте инфраструктуру {#infrastructure-prepare}

### Создайте сервисный аккаунт {#sa-create}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт `sa-loadtest` в каталоге, где будет размещаться агент, с которого будет подаваться нагрузка.
1. [Назначьте](../../iam/operations/roles/grant.md) сервисному аккаунту [роль](../security/index.md#roles-list) `loadtesting.generatorClient`.

### Настройте сеть {#network-setup}

[Создайте и настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) в подсети, где размещается цель тестирования и будет размещен агент. Это обеспечит доступ агента к сервису Load Testing.

### Настройте группы безопасности {#security-group-setup}

1. Настройте группу безопасности агента тестирования:

   1. [Создайте группу безопасности](../../vpc/operations/security-group-create.md) [агента](../concepts/agent.md) `agent-sg`.
   1. [Добавьте правила](../../vpc/operations/security-group-add-rule.md):
      1. Правило для исходящего HTTPS-трафика к публичному API Load Testing:
         * **Диапазон портов**: `443`.
         * **Протокол**: `TCP`.
         * **Назначение**: `CIDR`.
         * **CIDR блоки**: `0.0.0.0/0`.
   
         Это позволит подключить агент к сервису Load Testing, чтобы управлять тестами из интерфейса и получать результаты тестирования.
      1. Правило для входящего [SSH-трафика](../../glossary/ssh-keygen.md):
         * **Диапазон портов**: `22`.
         * **Протокол**: `TCP`.
         * **Назначение**: `CIDR`.
         * **CIDR блоки**: `0.0.0.0/0`.
   
         Это позволит подключаться к агенту по протоколу SSH и управлять тестами из консоли или собирать отладочную информацию.
      1. Правило для исходящего трафика при подаче нагрузки к цели тестирования:
         * **Диапазон портов**: `0-65535`.
         * **Протокол**: `Любой`.
         * **Назначение**: `Группа безопасности`.
           Выберите `Из списка`. Укажите [группу безопасности](../../vpc/concepts/security-groups.md), в которой находится нужная цель тестирования.
   
         Создайте такое правило для каждой цели тестирования с уникальной группой безопасности.

1. Настройте группу безопасности цели тестирования:

   1. [Создайте](../../vpc/operations/security-group-create.md) группу безопасности цели тестирования `load-target-sg`.
   1. [Добавьте правило](../../vpc/operations/security-group-add-rule.md) для входящего трафика при подаче нагрузки к цели тестирования:
       * **Диапазон портов**: `0-65535`.
       * **Протокол**: `Любой`.
       * **Назначение**: `Группа безопасности`.
         Выберите `Из списка`. Укажите [группу безопасности](../../vpc/concepts/security-groups.md), в которой находится нужная цель тестирования.
   
       Это правило позволит агентам подавать нагрузку на эту цель или подключать дополнительные средства мониторинга.

## Создайте агент тестирования {#create-agent}

<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplv7ro3actj5mipszpt?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

[Смотреть видео на YouTube](https://www.youtube.com/watch?v=YDcw9Bci8EM).



1. Если у вас еще нет пары [SSH-ключей](../../glossary/ssh-keygen.md), [создайте их](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
1. Создайте агент:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создан [агент](../concepts/agent.md).
     1. Перейдите в сервис **Load Testing**.
     1. На вкладке **Агенты** нажмите кнопку **Создать агент**.
     1. Укажите имя агента, например `agent-008`.
     1. Укажите ту же [зону доступности](../../overview/concepts/geo-scope.md), в которой находится цель тестирования.
     1. В блоке **Агент**:
        * Выберите подходящий тип агента. Подробнее см. в разделе [Производительность агентов](../concepts/agent.md#benchmark).
        * Укажите [подсеть](../../vpc/concepts/network.md#subnet), в которой находится цель тестирования. В подсети должен быть создан и [настроен NAT-шлюз](../../vpc/operations/create-nat-gateway.md).
        * Если вам доступны [группы безопасности](../../vpc/concepts/security-groups.md), выберите заранее настроенную группу безопасности агента.
     1. В блоке **Доступ** укажите данные для доступа к агенту:
        * Выберите [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) `sa-loadtest`.
        * В поле **Логин** введите имя пользователя.

          {% note alert %}

          Не используйте логин `root` или другие имена, зарезервированные операционной системой. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.

          {% endnote %}
              
        * В поле **SSH-ключ** вставьте содержимое файла [открытого ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
     1. Нажмите **Создать**.
     1. Дождитесь завершения процесса создания [виртуальной машины](../../compute/concepts/vm.md). Статус агента должен смениться на `Ready for test`.

        {% note info %}

        Если процесс создания агента остановился на статусе `Initializing connection`, проверьте выполнение условий:
        * У агента есть [доступ](../operations/security-groups-agent.md) к `loadtesting.api.cloud.yandex.net:443` и [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses).
        * В целевой подсети настроен NAT-шлюз.
        * У сервисного аккаунта, который назначен агенту, есть необходимые [роли](../operations/create-agent.md#infrastructure-prepare).

        {% endnote %}

   - CLI {#cli}

     Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

     По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

     1. Посмотрите описание команды [CLI](../../cli/index.md) для создания [агента](../concepts/agent.md):
   
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
        | e2lfkhps7bol******** |   default-ru-central1-b   | enpnf7hajqmd******** |                |   ru-central1-b   | [10.129.0.0/24] |
        | e9bgnq1bggfa******** |   default-ru-central1-a   | enpnf7hajqmd******** |                |   ru-central1-a   | [10.128.0.0/24] |
        | fl841n5ilklr******** |   default-ru-central1-d   | enpnf7hajqmd******** |                |   ru-central1-d   | [10.130.0.0/24] |
        +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
        ```

     1. Выберите [группу безопасности](../../vpc/concepts/security-groups.md). Группа безопасности должна быть заранее [настроена](../operations/security-groups-agent.md).

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
          --zone default-ru-central1-a \
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

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором размещен агент.
     1. Перейдите в сервис **Compute Cloud**.
     1. Выберите ВМ с именем `agent-008`.
     1. В блоке **Сетевой интерфейс** в правом верхнем углу нажмите ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Добавить публичный IP-адрес**.
     1. В открывшемся окне:
        * В поле **Публичный адрес** выберите получение адреса **Автоматически**.
        * Нажмите **Добавить**.

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

## Подготовьте сценарий нагрузочного тестирования {#test-scenario}

Создайте сценарий нагрузочного тестирования в UI JMeter и сохраните его в файл с расширением `.jmx`. Подробнее см. в [документации JMeter](https://jmeter.apache.org/usermanual/index.html)

{% cut "Пример сценария JMeter" %}

Создайте файл `test.jmx` и поместите в него следующий код, указав в поле `HTTPSampler.domain` актуальный IP-адрес вашей цели тестирования:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<jmeterTestPlan version="1.2" properties="5.0" jmeter="5.6.2">
  <hashTree>
    <TestPlan guiclass="TestPlanGui" testclass="TestPlan" testname="Test Plan" enabled="true">
      <boolProp name="TestPlan.functional_mode">false</boolProp>
      <boolProp name="TestPlan.tearDown_on_shutdown">false</boolProp>
      <boolProp name="TestPlan.serialize_threadgroups">false</boolProp>
      <elementProp name="TestPlan.user_defined_variables" elementType="Arguments" guiclass="ArgumentsPanel" testclass="Arguments" testname="User Defined Variables" enabled="true">
        <collectionProp name="Arguments.arguments"/>
      </elementProp>
    </TestPlan>
    <hashTree>
      <ThreadGroup guiclass="ThreadGroupGui" testclass="ThreadGroup" testname="Thread Group" enabled="true">
        <stringProp name="ThreadGroup.on_sample_error">continue</stringProp>
        <elementProp name="ThreadGroup.main_controller" elementType="LoopController" guiclass="LoopControlPanel" testclass="LoopController" testname="Loop Controller" enabled="true">
          <stringProp name="LoopController.loops">600</stringProp>
          <boolProp name="LoopController.continue_forever">false</boolProp>
        </elementProp>
        <stringProp name="ThreadGroup.num_threads">1</stringProp>
        <stringProp name="ThreadGroup.ramp_time">1</stringProp>
        <boolProp name="ThreadGroup.delayedStart">false</boolProp>
        <boolProp name="ThreadGroup.scheduler">false</boolProp>
        <stringProp name="ThreadGroup.duration"></stringProp>
        <stringProp name="ThreadGroup.delay"></stringProp>
        <boolProp name="ThreadGroup.same_user_on_next_iteration">true</boolProp>
      </ThreadGroup>
      <hashTree>
        <HTTPSamplerProxy guiclass="HttpTestSampleGui" testclass="HTTPSamplerProxy" testname="HTTP Request" enabled="true">
          <boolProp name="HTTPSampler.postBodyRaw">false</boolProp>
          <elementProp name="HTTPsampler.Arguments" elementType="Arguments" guiclass="HTTPArgumentsPanel" testclass="Arguments" testname="User Defined Variables" enabled="true">
            <collectionProp name="Arguments.arguments"/>
          </elementProp>
          <stringProp name="HTTPSampler.domain">172.17.0.10</stringProp>
          <stringProp name="HTTPSampler.path">/test?sleep=100</stringProp>
          <stringProp name="HTTPSampler.method">GET</stringProp>
          <boolProp name="HTTPSampler.follow_redirects">true</boolProp>
          <boolProp name="HTTPSampler.auto_redirects">false</boolProp>
          <boolProp name="HTTPSampler.use_keepalive">true</boolProp>
          <boolProp name="HTTPSampler.DO_MULTIPART_POST">false</boolProp>
          <boolProp name="HTTPSampler.BROWSER_COMPATIBLE_MULTIPART">false</boolProp>
          <boolProp name="HTTPSampler.image_parser">false</boolProp>
          <boolProp name="HTTPSampler.concurrentDwn">false</boolProp>
          <stringProp name="HTTPSampler.concurrentPool">6</stringProp>
          <boolProp name="HTTPSampler.md5">false</boolProp>
          <intProp name="HTTPSampler.ipSourceType">0</intProp>
        </HTTPSamplerProxy>
        <hashTree/>
        <ConstantThroughputTimer guiclass="TestBeanGUI" testclass="ConstantThroughputTimer" testname="Constant Throughput Timer" enabled="true">
          <intProp name="calcMode">1</intProp>
          <doubleProp>
            <name>throughput</name>
            <value>600.0</value>
            <savedValue>0.0</savedValue>
          </doubleProp>
        </ConstantThroughputTimer>
        <hashTree/>
      </hashTree>
    </hashTree>
  </hashTree>
</jmeterTestPlan>
```

В этом примере создается одна Thread-группа с одним HTTP-запросом (запрос `sleep` на 100 миллисекунд) и задается IP-адрес тестируемого ресурса. Запросы отправляются с периодичностью 600 запросов в минуту, длительность теста составляет 600 запросов.

{% endcut %}

## Запустите тест {#run-test}

1. Откройте [консоль управления](https://console.yandex.cloud).
1. Перейдите в сервис **Load Testing**.
1. На панели слева выберите ![image](../../_assets/load-testing/test.svg) **Тесты**. Нажмите **Создать тест**. 
1. В поле **Агенты** выберите агент `agent-008`.
1. В блоке **Прикрепленные файлы** нажмите **Выбрать файлы** и выберите файл со сценарием, созданный [ранее](#test-scenario).
1. В блоке **Настройки теста**:

    1. В поле **Генератор нагрузки** выберите `JMETER`.
    1. В поле **Сценарий jmx** выберите `Прикрепленный файл`.
    
        Если в блоке **Прикрепленные файлы** вы загрузили несколько файлов, выберите `Указать файл` и в поле **Имя прикрепленного файла или URL для скачивания** укажите имя файла со сценарием. Если ваш сценарий недоступен локально, укажите в этом поле URL для его скачивания.

1. (опционально) В меню **Переопределить значения переменных jmx сценария** вы можете добавить переменные со значениями в формате `var=value`. В этом случае в сценарий будут переданы пользовательские переменные, а внутри сценария к таким переменным можно будет обращаться в формате `${var}`.
1. (опционально) В меню **Параметры запуска JMeter**:

    1. Если вы используете свою версию JMeter, которую предварительно вручную скопировали на агент, в поле **Путь до исполняемого файла jmeter** укажите путь к исполняемому файлу JMeter.
    1. В поле **Дополнительные аргументы запуска jmeter** укажите дополнительные аргументы — они позволяют использовать команды запуска Non-GUI режима. Подробнее см. в [документации JMeter](https://jmeter.apache.org/usermanual/get-started.html#non_gui).

1. В меню **Автостоп** нажмите ![image](../../_assets/plus-sign.svg) **Автостоп** и введите описание:
    * **Тип автостопа 1** — `QUANTILE`.
    * **Квантиль** — `75`.
    * **Лимит времени ответов** — `100ms`.
    * **Размер окна** — `10s`.

    Этот критерий остановит тест, если в течение 10 секунд 75 процентиль превысит 100 миллисекунд (в течение 10 секунд время обработки 25% запросов превысит 100 миллисекунд).
1. В поле **Время принудительной остановки теста** укажите время, после которого сработает автостоп, если тест не будет остановлен по другим причинам. Значение параметра должно быть немного больше ожидаемой продолжительности теста.
1. В блоке **Информация о тесте** укажите имя, описание и номер тестируемой версии. Это поможет сделать отчет читаемым.
1. Нажмите **Создать**.

После этого конфигурация пройдет проверки, и агент начнет нагружать тестируемый сервис.

Чтобы наблюдать за результатами выполнения тестирования, выберите созданный тест и перейдите на вкладку **Результаты теста**.

## Как удалить созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите агент](../../compute/operations/vm-control/vm-delete.md).
1. [Удалите таблицу маршрутизации](../../vpc/operations/delete-route-table.md).
1. [Удалите NAT-шлюз](../../vpc/operations/delete-nat-gateway.md).