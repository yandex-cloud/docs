# Нагрузочное тестирование gRPC-сервиса

{{ load-testing-name }} можно использовать для нагрузочного тестирования сервиса по протоколу [gRPC](https://grpc.io/docs/) с помощью [генератора нагрузки](../../load-testing/concepts/load-generator.md) [Pandora](../../load-testing/concepts/load-generator.md#pandora).

Чтобы провести нагрузочное тестирование:
1. [Подготовьте облако к работе](#before-begin).
1. [Подготовьте цель тестирования](#target-prepare).
1. [Подготовьте инфраструктуру](#infrastructure-prepare).
1. [Создайте агент](#create-agent).
1. [Проверьте работу протокола gRPC Server Reflection](#reflection-check).
1. [Подготовьте файл с тестовыми данными](#test-file).
1. [Запустите тест](#run-test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

Если [агент](../../load-testing/concepts/agent.md) размещается на платформе {{ yandex-cloud }}, взимается плата за вычислительные ресурсы (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).

На стадии [Preview](../../overview/concepts/launch-stages.md) использование сервиса {{ load-testing-name }} не тарифицируется.


## Подготовьте цель тестирования {#target-prepare}

В этом примере будет использоваться gRPC-сервис с [внутренним IP-адресом](../../vpc/concepts/address.md#internal-addresses) `172.17.0.10` в той же [подсети](../../vpc/concepts/network.md#subnet), где будет размещен агент.

Инструкции по интеграции фреймворка gRPC для разных языков программирования приведены в [документации](https://grpc.io/docs/languages/).
1. Настройте поддержку протокола gRPC Server Reflection. Инструкции по настройке протокола gRPC Server Reflection для разных языков программирования приведены в [документации](https://grpc.github.io/grpc/core/md_doc_server-reflection.html).

   С помощью gRPC Server Reflection, генератор нагрузки на старте опрашивает сервер, собирая информацию о сервисах и их методах, и использует эти данные для формирования корректных gRPC-запросов во время теста.
1. Установите порт для доступа к gRPC-сервису — `8080`.

{{ load-testing-name }} также можно использовать для нагрузочного тестирования сервиса, доступного публично или находящегося в другой подсети и [группе безопасности](../../vpc/concepts/security-groups.md) относительно агента.

Для сервиса, доступного публично, разрешите входящий HTTPS-трафик на порт `8080`.

Для сервиса, находящегося в другой подсети и группе безопасности относительно агента, [создайте](#security-group-setup) правило для входящего HTTPS-трафика на порт `8080` в группе безопасности, где размещается цель тестирования.

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

## Проверьте работу протокола gRPC Server Reflection {#reflection-check}

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к агенту по протоколу [SSH](../../glossary/ssh-keygen.md).
1. Выполните команду для проверки работы протокола gRPC Server Reflection на gRPC-сервисе:

   {% list tabs %}

   - TLS-соединение

     ```bash
     grpcurl 172.17.0.10:8080 list
     ```

   - Стандартное соединение

     ```bash
     grpcurl --plaintext 172.17.0.10:8080 list
     ```

   {% endlist %}

   Результат:

   ```bash
   api.Adder
   grpc.reflection.v1alpha.ServerReflection
   ```

## Подготовьте файл с тестовыми данными {#test-file}

1. Сформируйте тестовые данные в формате [HTTP_JSON](../../load-testing/concepts/payloads/http-json.md):

   ```JSON
   {"tag": "/Add", "call": "api.Adder.Add", "payload": {"x": 21, "y": 12}}
   {"tag": "/Add", "call": "api.Adder.Add", "payload": {"x": 21, "y": 12}}
   {"tag": "/Add2", "call": "api.Adder.Add", "payload": {"x": 210, "y": 120}}
   ```

   Где:
   * `tag` — тег запроса для отображения в отчетах.
   * `call` — вызываемый метод.
   * `payload` — словарь с параметрами вызова, передаваемый цели тестирования.

   В этом примере две трети запросов будут помечены тегом `/Add`, а одна треть `/Add2`.
1. Сохраните тестовые данные в файл `data.json`.

## Запустите тест {#run-test}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
  1. На панели слева выберите ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}**.
  1. Нажмите **{{ ui-key.yacloud.load-testing.button_create-test }}**.
  1. На странице создания теста:
     1. В поле **{{ ui-key.yacloud.load-testing.label_agents-list }}** выберите агент `agent-008`, [созданный ранее](#create-agent).
     1. В блоке **{{ ui-key.yacloud.load-testing.test-data-section }}** выберите **{{ ui-key.yacloud.load-testing.label_local-source }}**, нажмите **Прикрепить файл** и выберите сохраненный ранее файл `data.json`.
     1. В блоке **{{ ui-key.yacloud.load-testing.label_test-settings }}**:
        * В поле **{{ ui-key.yacloud.load-testing.field_settings-type }}** выберите **{{ ui-key.yacloud.load-testing.label_settings-type-config }}**.
        * В поле для ввода конфигурации введите настройки тестирующих потоков в формате `yaml`:

          ```yaml
          pandora:
            enabled: true
            pandora_cmd: /usr/local/bin/pandora
            package: yandextank.plugins.Pandora
            config_content:
              pools:
                - id: GRPC
                  gun:
                    type: grpc # Протокол.
                    target: 172.17.0.10:8080 # Адрес цели тестирования.
                    tls: false
                  ammo:
                    type: grpc/json
                    file: ammo_ddfafc98-19a3-4dbb-b981-aa6787496a97
                  result:
                    type: phout
                    destination: ./phout.log
                  rps:
                    - duration: 180s # Время теста.
                      type: line # Тип нагрузки.
                      from: 1
                      to: 1500
                  startup:
                    type: once
                    times: 1500 # Количество потоков.
              log:
                level: debug
              monitoring:
                expvar:
                  enabled: true
                  port: 1234
          uploader:
            api_address: loadtesting.{{ api-host }}:443
            enabled: true
            job_dsc: grpc test
            job_name: '[pandora][config][grpc]'
            package: yandextank.plugins.DataUploader
            ver: '1.1'
          core: {}
          ```

          {% note tip %}

          Посмотрите [пример файла конфигурации](../../load-testing/concepts/testing-stream.md#config_example). Также пример файла конфигурации можно посмотреть в уже имеющихся тестах.

          {% endnote %}

     1. Нажмите **{{ ui-key.yacloud.common.create }}**.

    После этого конфигурация пройдет проверки, и агент начнет нагружать тестируемый gRPC-сервис.

    Чтобы наблюдать за результатами выполнения тестирования, выберите созданный тест и перейдите на вкладку **{{ ui-key.yacloud.load-testing.label_test-report }}**.

{% endlist %}

## Удалите созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, достаточно [удалить агент](../../compute/operations/vm-control/vm-delete.md).