# HTTPS-тест со ступенчатой нагрузкой с помощью Pandora

{{ load-testing-name }} можно использовать для тестирования сервиса со ступенчатой нагрузкой по протоколу HTTPS с помощью [генератора нагрузки](../../load-testing/concepts/load-generator.md) [Pandora](../../load-testing/concepts/load-generator.md#pandora).

Чтобы провести нагрузочное тестирование:
1. [Подготовьте облако к работе](#before-begin).
1. [Подготовьте цель тестирования](#target-prepare).
1. [Подготовьте инфраструктуру](#infrastructure-prepare).
1. [Создайте агент](#create-agent).
1. [Подготовьте файл с тестовыми данными](#test-file).
1. [Запустите тест](#run-test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

Если [агент](../../load-testing/concepts/agent.md) размещается на платформе {{ yandex-cloud }}, взимается плата за вычислительные ресурсы (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).

На стадии [Preview](../../overview/concepts/launch-stages.md) использование сервиса {{ load-testing-name }} не тарифицируется.

## Подготовьте цель тестирования {#target-prepare}

В этом примере будет тестироваться сервис с [внутренним IP-адресом](../../vpc/concepts/address.md#internal-addresses) `172.17.0.10` в той же [подсети](../../vpc/concepts/network.md#subnet), где будет размещен агент.

Убедитесь, что для доступа к сервису по протоколу HTTPS используется порт по умолчанию — `443`.

{{ load-testing-name }} также можно использовать для нагрузочного тестирования сервиса, доступного публично или находящегося в другой подсети и [группе безопасности](../../vpc/concepts/security-groups.md) относительно агента.

Для сервиса, доступного публично, разрешите входящий HTTPS-трафик на порт `443`.

Для сервиса, находящегося в другой подсети и группе безопасности относительно агента, [создайте](#security-group-setup) правило для входящего HTTPS-трафика на порт `443` в группе безопасности, где размещается цель тестирования.

## Подготовьте инфраструктуру {#infrastructure-prepare}

### Создайте сервисный аккаунт {#sa-create}

{% include [sa-create](../../_includes/load-testing/sa-create.md) %}

### Настройте сеть {#network-setup}

[Создайте и настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) в подсети, где размещается цель тестирования и будет размещен агент. Это обеспечит доступ агента к сервису {{ load-testing-name }}.

### Настройте группы безопасности {#security-group-setup}

{% note info %}

{% include [security-groups-note](../../_includes/vpc/security-groups-note-services.md) %}

{% endnote %}

1. Настройте группу безопасности агента тестирования:

   {% include [security-groups-agent](../../_includes/load-testing/security-groups-agent.md) %}

1. Настройте группу безопасности цели тестирования:

   {% include [security-groups-target](../../_includes/load-testing/security-groups-target.md) %}

## Создайте агент тестирования {#create-agent}

{% include [create-agent](../../_includes/load-testing/create-agent.md) %}

## Подготовьте файл с тестовыми данными {#test-file}

1. Сформируйте тестовые данные в формате [URI](../../load-testing/concepts/payloads/uri.md):

   ```text
   [Host: 172.17.0.10]
   [Connection: Close]
   / index
   /test?param1=1&param2=2 get_test
   ```

   Обратите внимание на заголовок `Connection: Close` — каждое соединение будет закрываться после запроса. Для приложения и генератора нагрузки такой режим тяжелее. Если не нужно закрывать соединения, следует указать значение `Keep-Alive`.

   Также указаны два запроса, отмеченные тегами `index` и `get_test`. Генератор будет повторять их по очереди в пределах заданного [профиля нагрузки](../../load-testing/concepts/load-profile.md).
1. Сохраните тестовые данные в файл `data.uri`.

## Запустите тест {#run-test}

1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
1. На панели слева выберите ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}**. Нажмите **{{ ui-key.yacloud.load-testing.button_create-test }}**.
1. В параметре **{{ ui-key.yacloud.load-testing.label_agents-list }}** выберите агент `agent-008`.
1. В блоке **{{ ui-key.yacloud.load-testing.test-data-section }}** выберите **{{ ui-key.yacloud.load-testing.label_local-source }}**, нажмите **Прикрепить файл** и выберите файл `data.uri`.
1. В блоке **{{ ui-key.yacloud.load-testing.label_test-settings }}** выберите способ настройки: **{{ ui-key.yacloud.load-testing.label_settings-type-form }}** или **{{ ui-key.yacloud.load-testing.label_settings-type-config }}**.
1. В зависимости от выбранного способа задайте параметры теста:

   {% list tabs %}

   - {{ ui-key.yacloud.load-testing.label_settings-type-form }}

     1. В поле **{{ ui-key.yacloud.load-testing.field_load-generator }}** выберите **PANDORA**.
     1. В поле **{{ ui-key.yacloud.load-testing.field_target-address }}** укажите IP-адрес тестируемого сервиса: `172.17.0.10`.
     1. В поле **{{ ui-key.yacloud.load-testing.field_target-port }}** укажите `443` (порт для HTTPS по умолчанию). Разрешите использовать защищенное соединение.
     1. В поле **Тестирующие потоки** укажите значение `5000`.

        Это означает, что генератор нагрузки сможет параллельно обрабатывать 5000 операций: создать 5000 соединений или ждать 5000 ответов от сервиса одновременно.

        {% note tip %}

        Для большинства тестов хватит 1000–10 000 [потоков](../../load-testing/concepts/testing-stream.md).

        Использование большего количества тестирующих потоков задействует больше ресурсов [виртуальной машины](../../compute/concepts/vm.md), на которой запущен агент. Также существует ограничение {{ compute-name }} на 50 000 одновременных соединений с ВМ.

        {% endnote %}

     1. В меню **Тип нагрузки** выберите `RPS`.
     1. Нажмите ![image](../../_assets/plus-sign.svg) **Профиль нагрузки** и введите описание:
        * **Профиль 1** — `step`.
        * **От** — `1000`.
        * **До** — `5000`.
        * **Шаг** — `1000`.
        * **Длительность** — `120s`.

        Это указание генератору наращивать нагрузку от 1000 до 5000 запросов в секунду в течение 120 секунд с шагом в 1000 запросов.
     1. В поле **Тип запросов** выберите `URI`.
     1. В меню **Автостоп** нажмите ![image](../../_assets/plus-sign.svg) **Автостоп** и введите описание:
        * **Тип автостопа 1** — `QUANTILE`.
        * **Квантиль** — `75`.
        * **Лимит времени ответов** — `100ms`.
        * **Размер окна** — `10s`.

        Этот критерий остановит тест, если в течение 10 секунд 75 процентиль превысит 100 миллисекунд (в течение 10 секунд время обработки 25% запросов превысит 100 миллисекунд).
     1. Укажите еще один [автостоп](../../load-testing/concepts/auto-stop.md):
        * **Тип автостопа 2** — `INSTANCES`.
        * **Предел** — `90%`.
        * **Размер окна** — `60s`.

        Этот критерий остановит тест, если в течение 60 секунд будет занято 90% тестирующих потоков.

        При увеличении нагрузки ожидается, что в какой-то момент тестируемая система начнет деградировать. Дальнейшее повышение нагрузки приведет к увеличению времени ответа или росту количества ошибок. Чтобы избежать существенного увеличения времени тестирования, обязательно выставляйте в таких тестах критерий завершения — **Автостоп**.
     1. В блоке **{{ ui-key.yacloud.load-testing.meta-section }}** укажите имя, описание и номер тестируемой версии. Это поможет сделать отчет читаемым.

   - {{ ui-key.yacloud.load-testing.label_settings-type-config }}

     1. В поле для ввода конфигурации введите настройки тестирующих потоков в формате `yaml`:

        ```yaml
        pandora:
          enabled: true
          package: yandextank.plugins.Pandora
          config_content:
            pools:
              - id: HTTP
                gun:
                  type: http # Протокол.
                  target: 172.17.0.10:443 # IP-адрес цели тестирования.
                  ssl: true
                ammo:
                  type: uri
                  file: ammo_131b131b-131b-131b-131b-131b13
                result:
                  type: phout
                  destination: ./phout.log
                rps:
                  - duration: 120s # Время теста.
                    type: step # Тип нагрузки.
                    from: 1000
                    to: 5000
                    step: 1000
                startup:
                  type: once
                  times: 5000 # Количество тестирующих потоков.
            log:
              level: error
            monitoring:
              expvar:
                enabled: true
                port: 1234
        autostop: # Автостоп.
          enabled: true
          package: yandextank.plugins.Autostop
          autostop:
            - quantile(75,100ms,10s) # Завершение теста, если в течение 10 секунд 75 процентиль
                                     # превысит 100 миллисекунд (в течение 10 секунд время
                                     # обработки 25% запросов превысит 100 миллисекунд).
            - instances(90%,60s)  # Завершение теста, если в течение 60 секунд будет занято
                                  # 90% тестирующих потоков.
        core: {}
        uploader:
          enabled: true
          package: yandextank.plugins.DataUploader
          job_name: '[example][pandora][step]'
          job_dsc: 'example'
          ver: '0.5.5'
          api_address: loadtesting.{{ api-host }}:443
        ```

     При увеличении нагрузки ожидается, что в какой-то момент тестируемая система начнет деградировать. Дальнейшее повышение нагрузки приведет к увеличению времени ответа или росту количества ошибок. Чтобы избежать существенного увеличения времени тестирования, обязательно выставляйте в таких тестах критерий завершения — **Автостоп**.

     {% note tip %}

     Посмотрите [пример файла конфигурации](../../load-testing/concepts/testing-stream.md#config_example). Также пример файла конфигурации можно посмотреть в уже имеющихся тестах.

     {% endnote %}

    {% endlist %}

1. Нажмите **{{ ui-key.yacloud.common.create }}**.

После этого конфигурация пройдет проверки, и агент начнет нагружать тестируемый сервис.

Чтобы наблюдать за результатами выполнения тестирования, выберите созданный тест и перейдите на вкладку **{{ ui-key.yacloud.load-testing.label_test-report }}**.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, достаточно [удалить агент](../../compute/operations/vm-control/vm-delete.md).