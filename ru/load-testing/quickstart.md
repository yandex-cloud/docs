# Как начать работать с {{ load-testing-full-name }}

С помощью этой инструкции вы создадите в своем облаке агент тестирования, сконфигурируете простейший нагрузочный тест и посмотрите на его результаты.

## Перед началом работы {#before-you-begin}

1. Войдите в [консоль управления]({{ link-console-main }}). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. На странице [**Биллинг**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md).
1. Если у вас еще нет каталога, [создайте его](../resource-manager/operations/folder/create.md). Во время создания каталога вы можете создать виртуальную сеть по умолчанию с подсетями во всех зонах доступности.
1. Создайте [сервисный аккаунт](../iam/operations/sa/create.md) в каталоге, где будут размещаться агенты, с которых будет подаваться нагрузка. [Назначьте](../iam/operations/roles/grant.md) ему [роль](./security/#roles-list) `loadtesting.generatorClient`.
1. Агент подключается к сервису {{ load-testing-name }} через публичное [API](../glossary/rest-api.md). Чтобы обезопасить себя, [создайте группу безопасности](../vpc/operations/security-group-create.md). Для соединения с управляющим сервисом агенту нужно разрешить исходящий трафик на порт 443. Для этого в вашей группе безопасности [добавьте следующее правило](../vpc/operations/security-group-add-rule.md) для исходящего трафика:
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `443`;
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `TCP`;
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `CIDR`;
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

    {% include [security-groups-note](../_includes/vpc/security-groups-note-services.md) %}

1. Агенту потребуется доступ в подсеть, в которой находится цель тестирования. Чтобы агент мог подключиться к сервису {{ load-testing-name }}, настройте для подсети [NAT-шлюз](../vpc/operations/create-nat-gateway.md).
1. Если у вас еще нет пары SSH-ключей, [создайте их](../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

## Создайте агент {#create-agent}

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан агент.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
1. На вкладке **{{ ui-key.yacloud.load-testing.label_agents-list }}** нажмите кнопку **{{ ui-key.yacloud.load-testing.button_create-agent }}**.
1. Укажите имя агента: `test-agent`.
1. Укажите ту же зону доступности, в которой находится цель тестирования.
1. Выберите подходящий тип агента. Подробнее см. в разделе [Производительность агентов](concepts/agent.md#benchmark).
1. Укажите подсеть, в которой находится цель тестирования. В подсети должен быть [создан и настроен NAT-шлюз](../vpc/operations/create-nat-gateway.md).
1. Если вам доступны группы безопасности, выберите заранее настроенную группу. 
1. Выберите сервисный аккаунт с ролью `loadtesting.generatorClient`. У вас должно быть [право на его использование](../iam/operations/sa/set-access-bindings.md).
1. Введите логин пользователя. Он будет создан на виртуальной машине.
1. Вставьте содержимое файла [открытого ключа](../compute/operations/vm-connect/ssh.md#copy-key).
1. Нажмите **{{ ui-key.yacloud.common.create }}**.
1. Дождитесь запуска виртуальной машины. Статус агента должен смениться на `Ready for test`.

В вашем каталоге будет создана [ВМ](../glossary/vm.md), с которой можно будет проводить нагрузочное тестирование целей в пределах выбранной подсети.

## Запуск теста {#run-test}

В этом примере будет проведено тестирование сервиса, находящегося по адресу `example.myservice.ru`.
В качестве генератора нагрузки будет использоваться Pandora, как наиболее подходящий для тестов облачных приложений генератор.

1. Откройте вкладку ![image](../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}** в сервисе **{{ load-testing-name }}**. Нажмите кнопку **{{ ui-key.yacloud.load-testing.button_create-test }}**. Задайте параметры теста:
   1. **{{ ui-key.yacloud.load-testing.label_agents-list }}** — выберите агент `test-agent`.
   1. **{{ ui-key.yacloud.load-testing.field_settings-type }}** — выберите `{{ ui-key.yacloud.load-testing.label_settings-type-form }}`.
   1. **{{ ui-key.yacloud.load-testing.field_load-generator }}** — выберите генератор `Pandora`.
   1. **{{ ui-key.yacloud.load-testing.field_target-address }}** — введите адрес тестируемого сервиса: `example.myservice.ru`.
   1. **{{ ui-key.yacloud.load-testing.field_target-port }}** — укажите `80` (порт для HTTP по умолчанию).
   1. **Тестирующие потоки** — `1000`.
        Это будет означать, что генератор сможет параллельно обрабатывать 1000 операций (создать 1000 соединений или ждать 1000 ответов от сервиса одновременно).

        {% note warning %}

        Важно, чтобы агент имел доступ к `example.myservice.ru:80`.

        {% endnote %}

   1. **Тип нагрузки** — выберите тип `RPS`.
   1. Добавьте **Профиль нагрузки**:
      * **Профиль 1** — выберите `line`.
      * **От** — укажите `1`.
      * **До** — укажите `100`.
      * **Длительность** — укажите `60s`.
   1. Добавьте еще один **Профиль нагрузки**:
      * **Профиль 2** — выберите `const`.
      * **{{ ui-key.yacloud.load-testing.label_rps }}** — укажите `100`.
      * **Длительность** — укажите `300s`.

      Эти настройки дадут генератору указание наращивать нагрузку от 1 до 100 запросов в секунду первые 60 секунд, а потом 5 минут поддерживать нагрузку 100 запросов в секунду.		
   1. **Тип запросов** — укажите тип `URI`.
   1. В меню **Задать запросы через форму**:
      * В подменю **Запросы** добавьте запросы:
        * `/ index`
        * `/test?param1=1&param2=2 get_test`

        Запросы отмечены тегами `index` и `get_test`. Генератор будет повторять их по очереди в пределах заданного профиля нагрузки.
      * В подменю **Заголовки запросов** добавьте заголовки:
        * `[Host: example.myservice.ru]`
        * `[Connection: Close]`

        Обратите внимание на заголовок `Connection: Close` — каждое соединение будет закрываться после запроса. Для приложения и генератора такой режим тяжелее. Если не нужно закрывать соединения, то следует указать значение `Keep-Alive`.
   1. В блоке **{{ ui-key.yacloud.load-testing.meta-section }}** укажите название, описание и номер версии теста. Это поможет сделать отчет читаемым.
   1. Нажмите **{{ ui-key.yacloud.common.create }}**.

После этого конфигурация пройдет проверки, и агент начнет нагружать тестируемое приложение. Отчет можно посмотреть на вкладке **{{ ui-key.yacloud.load-testing.label_tests-list }}**.
