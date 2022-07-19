# Нагрузочное тестирование gRPC-сервиса

{{ load-testing-full-name }} можно использовать для нагрузочного тестирования сервиса по протоколу [gRPC](https://grpc.io/docs/) с помощью генератора нагрузки [Pandora](../load-testing/concepts/load-generator.md#pandora).

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

{% include [before-you-begin](./_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

Если агент размещается на платформе {{ yandex-cloud }}, взимается плата за вычислительные ресурсы (см. [тарифы {{ compute-full-name }}](../compute/pricing.md)).

На стадии [Preview](../overview/concepts/launch-stages.md) использование сервиса {{ load-testing-name }} не тарифицируется.


## Подготовьте цель тестирования {#target-prepare}

В этом примере будет использоваться gRPC-сервис с внутренним IP-адресом `172.17.0.10` в той же подсети, где будет размещен агент.

Инструкции по интеграции фреймворка gRPC для разных языков программирования приведены в [документации](https://grpc.io/docs/languages/).

1. Настройте поддержку протокола gRPC Server Reflection. Инструкции по настройке протокола gRPC Server Reflection для разных языков программирования приведены в [документации](https://grpc.github.io/grpc/core/md_doc_server-reflection.html).

    С помощью gRPC Server Reflection, генератор нагрузки на старте опрашивает сервер, собирая информацию о сервисах и их методах, и использует эти данные для формирования корректных gRPC-запросов во время теста.
1. Установите порт для доступа к gRPC-сервису — `8080`.

{{ load-testing-name }} также можно использовать для нагрузочного тестирования сервиса, доступного публично или находящегося в другой подсети и группе безопасности относительно агента.

Для сервиса, доступного публично, разрешите входящий HTTPS-трафик на порт `8080`.

Для сервиса, находящегося в другой подсети и группе безопасности относительно агента, [создайте](#security-group-setup) правило для входящего HTTPS-трафика на порт `8080` в группе безопасности, где размещается цель тестирования.

## Подготовьте инфраструктуру {#infrastructure-prepare}

### Создайте сервисный аккаунт {#sa-create}

{% include [sa-create](../_includes/load-testing/sa-create.md) %}

### Настройте сеть {#network-setup}

[Включите](../vpc/operations/enable-nat.md) NAT в интернет в подсети, где размещается цель тестирования и будет размещен агент. Это обеспечит доступ агента к сервису {{ load-testing-name }}.

### Настройте группы безопасности {#security-group-setup}

1. Настройте группу безопасности агента тестирования:
    
    {% include [security-groups-agent](../_includes/load-testing/security-groups-agent.md) %}
1. Настройте группу безопасности цели тестирования:
    
    {% include [security-groups-target](../_includes/load-testing/security-groups-target.md) %}

## Создайте агент тестирования {#create-agent}

{% include [create-agent](../_includes/load-testing/create-agent.md) %}

## Проверьте работу протокола gRPC Server Reflection {#reflection-check}

1. [Подключитесь](../compute/operations/vm-connect/ssh.md#vm-connect) к агенту по протоколу SSH. 
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

1. Сформируйте тестовые данные в формате [HTTP_JSON](../load-testing/concepts/payloads/http-json.md):

    ```JSON
    {"tag": "/Add", "call": "api.Adder.Add", "payload": {"x": 21, "y": 12}}
    {"tag": "/Add", "call": "api.Adder.Add", "payload": {"x": 21, "y": 12}}
    {"tag": "/Add2", "call": "api.Adder.Add", "payload": {"x": 210, "y": 120}}
    ```

    Где:

    * `tag` — тег запроса для отображения в отчетах.
    * `call` — вызываемый метод.
    * `payload` — словарь с парметрами вызова, передаваемый цели тестирования.

    В этом примере две трети запросов будут помечены тегом `/Add`, а одна треть `/Add2`.

1. Сохраните тестовые данные в файл `data.json`.

## Запустите тест {#run-test}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ load-testing-name }}**.
  1. На панели слева выберите ![image](../_assets/load-testing/test.svg) **Тесты**. Нажмите **Создать тест**. 
  1. Задайте параметры теста:
      * **Способ настройки** — выберите **Конфиг**.
      * **Агент** — выберите агента `agent-008`, [созданного ранее](#create-agent).
  1. Загрузите файл `data.json` в поле **Файл с тестовыми данными**.
  1. В поле для ввода конфигурации введите настройки тестирующих потоков в формате `yaml`:

      ```yaml
      pandora:
        enabled: true
        pandora_cmd: /usr/local/bin/pandora
        package: yandextank.plugins.Pandora
        config_content:
          pools:
              - id: GRPC
              gun:
                type: grpc                # протокол
                target: 172.17.0.10:8080  # адрес цели тестирования
                tls: false
              ammo:
                type: grpc/json
                file: ammo_123
              result:
                type: phout
                destination: ./phout.log
              rps:
                 - duration: 180s         # время теста
                  type: line              # тип нагрузки
                  from: 1
                  to: 1500
              startup:
                 - type: once
                  times: 1500             # количество потоков
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
      cloudloader:
        enabled: false
        package: yandextank.plugins.CloudUploader
      ```

      {% note tip %}

      Посмотрите [пример файла конфигурации](../load-testing/concepts/testing-stream.md#config_example). Также пример файла конфигурации можно посмотреть в уже имеющихся тестах.

      {% endnote %}

  1. Нажмите **Создать**. После этого конфигурация пройдет проверки, и агент начнет нагружать тестируемый gRPC-сервис. 
  1. Чтобы наблюдать за результатами выполнения тестирования, выберите созданный тест и перейдите на вкладку **Отчет**.

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, достаточно [удалить агент](../compute/operations/vm-control/vm-delete.md).