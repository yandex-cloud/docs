# HTTP-тест с нагрузкой по сценарию с помощью Pandora

{{ load-testing-name }} можно использовать для тестирования сервиса с нагрузкой по сценарию по протоколу HTTP с помощью [генератора нагрузки](../../load-testing/concepts/load-generator.md) [Pandora](../../load-testing/concepts/load-generator.md#pandora).

Чтобы провести нагрузочное тестирование:
1. [Подготовьте облако к работе](#before-begin).
1. [Подготовьте цель тестирования](#target-prepare).
1. [Подготовьте инфраструктуру](#infrastructure-prepare).
1. [Создайте агент](#create-agent).
1. [Подготовьте файл с тестовыми данными](#test-file).
1. [Подготовьте файл сценария](#test-scenario).
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

1. Настройте группу безопасности агента тестирования:

   {% include [security-groups-agent](../../_includes/load-testing/security-groups-agent.md) %}

1. Настройте группу безопасности цели тестирования:

   {% include [security-groups-target](../../_includes/load-testing/security-groups-target.md) %}

## Создайте агент тестирования {#create-agent}

{% include [create-agent](../../_includes/load-testing/create-agent.md) %}

## Подготовьте файл с тестовыми данными {#test-file}

1. Сформируйте тестовые данные в файле `users.csv`:

   ```csv
   user_id,name,pass
   1,John,123
   2,Jack,456
   3,Jim,789
   4,Joe,0asdf
   5,Jane,12dasdf
   6,Jill,asdf
   7,Joy,zxcv
   8,Joy,zxcv
   9,Joy,zxcv
   10,Joy,zxcv
   ```

## Подготовьте файл сценария {#test-scenario}

В сценарии необходимо описать последовательность HTTP-запросов, которые будут выполнены в процессе тестирования. Один файл может содержать несколько сценариев. Сценарий может быть представлен в одном из следующих форматов:
* hcl;
* yaml;
* json.

1. Подготовьте сценарий в файле `payload.hcl`:

   ```hcl
   variable_source "variables" "variables" {
      variables = {
         auth_path = /auth
         order_path = /order
      }
   }


   variable_source "users" "file/csv" {
      file              = "users.csv"
      fields            = ["user_id", "name", "pass"]
      ignore_first_line = true
      delimiter         = ","
   }

   request "auth_req" {
      method  = "POST"
      uri     = "{{.source.variables.auth_path}}"
      headers = {
         Content-Type = "application/json"
         Useragent    = "Yandex"
      }
      body = <<EOF
   {"user_id":  {{.request.auth_req.preprocessor.user_id}}}
   EOF
      tag  = "auth"

      preprocessor {
         mapping = {
            user_id = "source.users[next].user_id"
         }
      }
   }

   request "order_req" {
      method  = "POST"
      uri     = "{{.source.variables.order_path}}?sleep=100"
      headers = {
         Useragent     = "Yandex"
      }
      body = <<EOF
   {"item_id": test_item_id}
   EOF
      tag  = "order"
   }

   scenario "test_scenario" {
      min_waiting_time = 1000
      requests = [
         "auth_req",
         "sleep(100)",
         "order_req(3, 100)"
      ]
   }
   ```

   В данном сценарии `test_scenario` описаны запросы `auth_req` и `order_req`. Запросу можно передавать аргументы: количество повторений и задержка между ними. В данном примере `order_req(3, 100)` означает, что запрос `order_req` будет выполнен трижды с интервалом в 100 миллисекунд между повторениями.

   Параметр `min_waiting_time` определяет минимальное время выполнения сценария в миллисекундах. Если сценарий завершится быстрее указанного значения, будет добавлена соответствующая задержка в конце сценария.

   В сценарии создан источник переменных `variables`, содержащий переменные `auth_path` и `order_path`. Значения этих переменных используются для указания `uri` в запросах.

   Также в сценарии создан источник переменных `users`, использующий данные из внешнего файла `users.csv`. Для работы с массивом пользователей используется препроцессор, в котором доступны следующие модификаторы:
   * `next` для получения следующего элемента массива;
   * `last` для получения последнего элемента массива;
   * `rand` для получения случайного элемента массива.

## Запустите тест {#run-test}

1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
1. На панели слева выберите ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}**. Нажмите **{{ ui-key.yacloud.load-testing.button_create-test }}**.
1. В параметре **{{ ui-key.yacloud.load-testing.label_agents-list }}** выберите агент `agent-008`.
1. В блоке **Прикрепленные файлы** нажмите **Выбрать файлы** и выберите сохраненные ранее файлы `users.csv` и `payload.hcl`.
1. В блоке **{{ ui-key.yacloud.load-testing.label_test-settings }}** выберите способ настройки: **{{ ui-key.yacloud.load-testing.label_settings-type-config }}**.

1. В поле для ввода конфигурации введите настройки тестирующих потоков в формате `yaml`:

   ```yaml
      uploader:
         enabled: true
         package: yandextank.plugins.DataUploader
         api_address: loadtesting.{{ api-host }}:443
      pandora:
         enabled: true
         package: yandextank.plugins.Pandora
         config_content:
            pools:
               - id: Pool name
                  gun:
                     type: http/scenario
                     target: 172.17.0.10:80
                  ammo:
                     type: http/scenario
                     file: payload.hcl
                  result:
                     type: phout
                     destination: ./phout.log
                  rps:
                     - duration: 10s
                        type: line
                        from: 1
                        to: 5
                  startup:
                     type: once
                     times: 5
            log:
               level: debug
      autostop:
         enabled: true
         package: yandextank.plugins.Autostop
         autostop:
            - limit (5m)
      core: {}
   ```

1. Нажмите **{{ ui-key.yacloud.common.create }}**.

После этого конфигурация пройдет проверки, и агент начнет нагружать тестируемый сервис.

Чтобы наблюдать за результатами выполнения тестирования, выберите созданный тест и перейдите на вкладку **{{ ui-key.yacloud.load-testing.label_test-report }}**.

## Как удалить созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите агент](../../compute/operations/vm-control/vm-delete.md).
1. [Удалите таблицу маршрутизации](../../vpc/operations/delete-route-table.md).
1. [Удалите NAT-шлюз](../../vpc/operations/delete-nat-gateway.md).
