# Нагрузочное тестирование с нескольких агентов

{{ load-testing-name }} можно использовать для тестирования сервиса с помощью нескольких [агентов тестирования](../../load-testing/concepts/agent.md).

Нагрузочное тестирование с нескольких агентов применяется если:
* Цель тестирования состоит из нескольких [виртуальных машин](../../compute/concepts/vm.md), а суммарный входящий и исходящий трафик с них превышает [возможности одного агента](../../load-testing/concepts/agent.md#benchmark).
* Запросы, которые направляются в цель тестирования, требуют много вычислительных мощностей.
* Цель тестирования намного эффективнее [генератора нагрузки](../../load-testing/concepts/load-generator.md).

Агенты запускаются и подают нагрузку на цель тестирования синхронно. [Результаты тестирования](../../load-testing/concepts/load-test-results.md) доступны в обобщенных и независимых [отчетах](../../load-testing/concepts/reports.md) с каждого агента.

Чтобы провести нагрузочное тестирование с нескольких агентов:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте инфраструктуру](#infrastructure-prepare).
1. [Создайте агенты тестирования](#create-agents).
1. [Запустите тест](#run-test).
1. [Посмотрите результаты тестирования](#see-results).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

Если агент размещается на платформе {{ yandex-cloud }}, взимается плата за вычислительные ресурсы (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).

На стадии [Preview](../../overview/concepts/launch-stages.md) использование сервиса {{ load-testing-name }} не тарифицируется.

## Подготовьте инфраструктуру {#infrastructure-prepare}

### Создайте сервисный аккаунт {#sa-create}

1. [Создайте](../../iam/operations/sa/create.md) [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) `sa-loadtest` в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder), где будут размещаться агенты.
1. [Назначьте](../../iam/operations/roles/grant.md) сервисному аккаунту [роль](../../load-testing/security/index.md#roles-list) `loadtesting.generatorClient`.

### Настройте сеть {#network-setup}

[Настройте](../../vpc/operations/create-nat-gateway.md) [NAT-шлюз](../../vpc/concepts/gateways.md) в [подсети](../../vpc/concepts/network.md#subnet), в которой будут размещаться агенты. Это обеспечит доступ агентов к сервису {{ load-testing-name }}.

### Настройте группу безопасности {#security-group-setup}

{% note info %}

{% include [security-groups-note-services](../../_includes/vpc/security-groups-note-services.md) %}

{% endnote %}

1. [Создайте](../../vpc/operations/security-group-create.md) [группу безопасности](../../vpc/concepts/security-groups.md) для агентов `agent-sg`.
1. [Добавьте правила](../../vpc/operations/security-group-add-rule.md):
   * Правило для исходящего HTTPS-трафика к публичному API {{ load-testing-name }}:
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `443`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `TCP`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `CIDR`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

     Это позволит подключить агенты к сервису {{ load-testing-name }}, чтобы управлять тестами из интерфейса и получать результаты тестирования.
   * Правило для исходящего HTTP-трафика при подаче нагрузки к цели тестирования:
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `80`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `TCP`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `CIDR`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

     Это позволит агентам подавать нагрузку к цели тестирования.
   * Правило для входящего SSH-трафика:
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `22`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `TCP`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `CIDR`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

     Это позволит подключаться к агентам по протоколу SSH и управлять тестами из консоли или собирать отладочную информацию.

В этом примере нагрузка будет подаваться на внешний сервис `example.myservice.ru`. Подробности о настройке групп безопасности для тестирования сервисов, которые размещены внутри [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud), см. в разделах:
* [{#T}](../../load-testing/operations/security-groups-agent.md).
* [{#T}](../../load-testing/operations/security-groups-target.md).

## Создайте агенты тестирования {#create-agents}

1. Если у вас еще нет пары [SSH-ключей](../../glossary/ssh-keygen.md), [создайте их](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
1. Создайте первый агент:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан агент.
     1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
     1. На вкладке ![image](../../_assets/load-testing/agent.svg) **{{ ui-key.yacloud.load-testing.label_agents-list }}** нажмите **{{ ui-key.yacloud.load-testing.button_create-agent }}**.
     1. Укажите имя агента, например, `agent-008`.
     1. Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет размещен агент.
     1. В блоке **{{ ui-key.yacloud.load-testing.section_agent }}**:
        * Выберите подходящий [тип агента](../../load-testing/concepts/agent.md#benchmark).
        * Укажите подсеть, в которой будет размещен агент. В подсети должен быть [создан и настроен NAT-шлюз](../../vpc/operations/create-nat-gateway.md).
        * Если вам доступны группы безопасности, выберите заранее настроенную группу безопасности агента.
     1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа к агенту:
        * Выберите сервисный аккаунт `sa-loadtest`.
        * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.

          {% note alert %}

          Не используйте логин `root` или другие имена, зарезервированные операционной системой. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.

          {% endnote %}

        * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла открытого ключа.
     1. Нажмите **{{ ui-key.yacloud.common.create }}**.
     1. Дождитесь завершения процесса создания ВМ. Статус агента должен смениться на `Ready for test`.

        {% note info %}

        Процесс создания агента может остановиться на статусе `Initializing connection`, если не выполнены условия:
        * У агента есть [доступ](../../load-testing/operations/security-groups-agent.md) к `loadtesting.{{ api-host }}:443` и [публичный IP-адрес](../../vpc/concepts/address.md).
        * В целевой подсети [настроен](../../vpc/operations/create-nat-gateway.md) NAT-шлюз.
        * У сервисного аккаунта, который назначен агенту, есть необходимые [роли](../../load-testing/operations/create-agent.md#infrastructure-prepare).

        {% endnote %}

   {% endlist %}

1. Аналогично создайте второй агент с именем `agent-009`.

Если вам нужно [подключиться](../../compute/operations/vm-connect/ssh.md#vm-connect) к агентам по протоколу SSH, [привяжите](../../compute/operations/vm-control/vm-attach-public-ip.md) к ним публичный IP-адрес.

## Запустите тест {#run-test}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
  1. На панели слева выберите ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}**.
  1. Нажмите **{{ ui-key.yacloud.load-testing.button_create-test }}**.
  1. В блоке **{{ ui-key.yacloud.load-testing.label_test-config }} 1** укажите параметры тестирования для первого агента:
     1. **{{ ui-key.yacloud.load-testing.label_agents-list }}** — выберите агент `agent-008`.

        В этом примере конфигурация теста для агентов будет разной. Чтобы задать одинаковую конфигурацию, выберите в поле **{{ ui-key.yacloud.load-testing.label_agents-list }}** все агенты, которые нужно применить.
     1. В блоке **{{ ui-key.yacloud.load-testing.label_test-settings }}**:
        * **{{ ui-key.yacloud.load-testing.field_settings-type }}** — выберите `{{ ui-key.yacloud.load-testing.label_settings-type-form }}`.
        * **{{ ui-key.yacloud.load-testing.field_load-generator }}** — выберите генератор нагрузки `Pandora`.
        * **{{ ui-key.yacloud.load-testing.field_target-address }}** — введите адрес тестируемого сервиса: `example.myservice.ru`.
        * **{{ ui-key.yacloud.load-testing.field_target-port }}** — укажите `80` (порт для протокола HTTP по умолчанию).
        * **Тестирующие потоки** — `1000`.

        Это будет означать, что генератор нагрузки сможет параллельно обрабатывать 1000 операций (создать 1000 соединений или ждать 1000 ответов от сервиса одновременно). [Подробнее о тестирующих потоках](../../load-testing/concepts/testing-stream.md).

        {% note warning %}

        Важно, чтобы агент имел доступ к `example.myservice.ru:80`.

        {% endnote %}

        * В меню **Тип нагрузки**:
          * Выберите тип `RPS`.
          * Добавьте **Профиль нагрузки**:
            * **Профиль 1** — `line`.
            * **От** — `1`.
            * **До** — `100`.
            * **Длительность** — `60s`.
          * Добавьте еще один **Профиль нагрузки**:
            * **Профиль 2** — `const`.
            * **{{ ui-key.yacloud.load-testing.label_rps }}** — `100`.
            * **Длительность** — `300s`.

          Эти настройки дадут генератору нагрузки указание наращивать нагрузку от 1 до 100 запросов в секунду первые 60 секунд, а потом 5 минут поддерживать нагрузку 100 запросов в секунду. [Подробнее о профиле нагрузки](../../load-testing/concepts/load-profile.md).
        * **Тип запросов** — укажите [тип](../../load-testing/concepts/payloads/uri.md) `URI`.
        * В поле **{{ ui-key.yacloud.load-testing.test-data-section }}** выберите **{{ ui-key.yacloud.load-testing.label_settings-type-form }}** и в открывшемся меню:
          * В меню **Запросы** добавьте запросы:
            * `/ index`.
            * `/test?param1=1&param2=2 get_test`.

          Запросы отмечены тегами `index` и `get_test`. Генератор нагрузки будет повторять их по очереди в пределах заданного профиля нагрузки.
        * В меню **Заголовки запросов** добавьте заголовки:
          * `[Host: example.myservice.ru]`.
          * `[Connection: Close]`.

            Обратите внимание на заголовок `Connection: Close` — каждое соединение будет закрываться после запроса. Для тестируемого сервиса и генератора нагрузки такой режим тяжелее. Если не нужно закрывать соединения, следует указать значение `Keep-Alive`.
  1. Нажмите ![image](../../_assets/plus-sign.svg) **{{ ui-key.yacloud.load-testing.button_duplicate-configuration }}**. Параметры тестирования будут скопированы в блок **{{ ui-key.yacloud.load-testing.label_test-config }} 2**.
  1. В блоке **{{ ui-key.yacloud.load-testing.label_test-config }} 2** укажите параметры тестирования для второго агента:
     1. **{{ ui-key.yacloud.load-testing.label_agents-list }}** — выберите агент `agent-009`.
     1. В блоке **{{ ui-key.yacloud.load-testing.label_test-settings }}** измените параметры тестирования.

        Например, в меню **Автостоп** нажмите ![image](../../_assets/plus-sign.svg) **Автостоп** и введите описание:
        * **Тип автостопа** — `INSTANCES`.
        * **Предел** — `90%`.
        * **Размер окна** — `60s`.

        Этот критерий остановит тест, если в течение 60 секунд будет занято 90% тестирующих потоков, что свидетельствует о возникновении проблем тестирования.
  1. В блоке **{{ ui-key.yacloud.load-testing.meta-section }}** укажите имя, описание и номер версии теста. Это сделает отчеты читаемыми.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

  После этого конфигурации пройдут проверки и агенты начнут нагружать тестируемое приложение. Отчет можно посмотреть на вкладке **{{ ui-key.yacloud.load-testing.label_tests-list }}**.

{% endlist %}

## Посмотрите результаты тестирования {#see-results}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
  1. На панели слева перейдите на вкладку ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}**.
  1. Выберите тест, созданный ранее. Тесты с несколькими агентами отображаются с меткой `Multi`.
  1. Чтобы посмотреть обобщенные результаты, перейдите на вкладку ![image](../../_assets/load-testing/results.svg) **{{ ui-key.yacloud.load-testing.label_test-report }}**.
  1. Чтобы посмотреть результаты тестирования по каждому агенту:
     1. Перейдите на вкладку ![image](../../_assets/load-testing/overview.svg) **{{ ui-key.yacloud.common.overview }}**.
     1. В блоке **{{ ui-key.yacloud.load-testing.label_tests-list }}** выберите нужный агент.
     1. Перейдите на вкладку ![image](../../_assets/load-testing/results.svg) **{{ ui-key.yacloud.load-testing.label_test-report }}**.

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, [удалите](../../compute/operations/vm-control/vm-delete.md) агенты тестирования.