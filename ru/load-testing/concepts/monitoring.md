# Мониторинг агентов тестирования

Мониторинг позволяет собирать данные о состоянии цели и агента тестирования (метрики), а также отображать эти данные на графиках. Сбор метрик выполняется с помощью плагина для агента сбора метрик [Telegraf](https://github.com/influxdata/telegraf) или плагина YCMonitoring. Графики мониторинга отображаются на вкладке **{{ ui-key.yacloud.load-testing.label_monitoring-report }}** для выбранного теста.

Включить мониторинг агента тестирования можно в настройках при [создании теста](../operations/create-test-bucket.md#create-test):

{% list tabs %}

- Форма

   Если вы настраиваете параметры теста с помощью формы в интерфейсе, включите опцию **Мониторинг агента**. В этом случае активируется стандартная конфигурация мониторинга агента, которая включает следующие метрики:
   
   * [cpu](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/cpu)
   * [diskio](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/diskio)
   * [mem](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/mem)
   * [net](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/net)
   * [nstat](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/nstat)
   * [system](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/system)

   Также вы можете настроить плагин YCMonitoring для сбора метрик из API сервиса {{ monitoring-full-name }} и отображения графиков метрик в секции **{{ ui-key.yacloud.load-testing.label_monitoring-report }}** нагрузочного теста.

   {% note warning %}

   Для работы плагина сервисному аккаунту должна быть выдана роль `monitoring.viewer` в соответствующем каталоге.
   Прежде чем использовать плагин, убедитесь, что агент тестирования имеет актуальную версию. При необходимости обновите агент.

   {% endnote %}
   
   {% note info %}

   Для разных облачных сервисов метрики {{ monitoring-full-name }} собираются с интервалами от 15 секунд до 1 минуты, поэтому для коротких тестов результат может быть неинформативным. Рекомендуется использовать плагин на длительных тестах (от 10 минут).

   {% endnote %}

   Чтобы настроить плагин YCMonitoring:

   1. В блоке **{{ ui-key.yacloud.load-testing.label_test-settings }}** в секции **Метрики YC Monitoring** нажмите ![image](../../_assets/plus-sign.svg) **График**.
   1. В поле **Название графика** укажите название графика.
   1. В поле **Запрос** введите запрос на [языке запросов в {{ monitoring-name }}](../../monitoring/concepts/querying.md).
   1. При желании, аналогичным образом добавьте другие графики.


- Telegraf

   Чтобы настроить сбор метрик с помощью плагина Telegraf, в конфигурационном файле опишите конфигурацию мониторинга агента в блоке `telegraf`. Вы можете настраивать каждую метрику с помощью всех опций, которые доступны для нее в Telegraf.

   Пример настройки блока `telegraf` в файле конфигурации тестирования:

   ```yaml
   telegraf:
      enabled: true
      package: yandextank.plugins.Telegraf
      config:
      metrics:
         cpu:
         percpu: true
         totalcpu: false
         fieldpass:
            - time_user
            - time_steal
            - usage_idle
   ```

   Также в конфигурации мониторинга агента вы можете описывать метрики, которых нет в Telegraf.

   Пример описания пользовательской метрики `custom`:
  
   ```yaml
   telegraf:
      enabled: true
      package: yandextank.plugins.Telegraf
      config:
      metrics:
         custom:
            diff: 1
            measure: call
            label: test
            cmd: curl -s 'http://localhost:6100/stat'  | python3 -c 'import sys, json; j = json.load(sys.stdin); print("\n".join(rerp(c["values"]["accept"]) for c in j["charts"] if c["name"] == "localqueue_wait_time"))'
   ```

- YCMonitoring

   Чтобы настроить сбор метрик с помощью плагина YCMonitoring, в конфигурационном файле опишите конфигурацию мониторинга агента в блоке `ycmonitoring`. Плагин позволяет собирать метрики мониторинга из API {{ monitoring-full-name }}.

   {% note warning %}

   Для работы плагина сервисному аккаунту должна быть выдана роль `monitoring.viewer` в соответствующем каталоге.
   Прежде чем использовать плагин, убедитесь, что агент тестирования имеет актуальную версию. При необходимости обновите агент.

   {% endnote %}

   {% note info %}

   Для разных облачных сервисов метрики {{ monitoring-full-name }} собираются с интервалами от 15 секунд до 1 минуты, поэтому для коротких тестов результат может быть неинформативным. Рекомендуется использовать плагин на длительных тестах (от 10 минут).

   {% endnote %}

   Формат минимальной конфигурации плагина:

   ```yaml
   ycmonitoring:
     enabled: true
     package: yandextank.plugins.YCMonitoring
     panels:
       <panel_name_1>:
         group_name: <group_name_1>
         queries:
           - <query1>
           - <query2>
       <panel2name>:
         group_name: <group_name_2>
         queries:
           - <query3>
   ```
   Где:
   * `panels` — словарь панелей для сбора метрик мониторинга.
   * `panel_name` — ключ словаря и название графика на панели мониторинга.
   * `group_name` — ключ группировки панелей. Значение по умолчанию - адрес API-хоста, с которого собирались метрики.
   * `query` — запрос на [языке запросов в {{ monitoring-name }}](../../monitoring/concepts/querying.md).

   Пример настройки блока `ycmonitoring` в файле конфигурации тестирования:

   ```yaml
   ycmonitoring:
     enabled: true
     package: yandextank.plugins.YCMonitoring
     panels:
       target_connections:
         queries:
           - '"network_connections.quota_utilization"{folderId="b1g7j67rou********ne", service="compute", resource_id="agent007"}'
       target_cpu:
         queries:
           - '"cpu_usage"{folderId="b1g7j67rou********ne", service="compute", resource_id="agent007"}'
       received_packets:
         queries:
           - '"network_received_packets"{folderId="b1g7j67rou********ne", service="compute", resource_id="agent007", resource_type="vm", interface_number="*"}'
   ```
   Где:
   * `resource_id` — имя агента тестирования.
   * `folderId` — идентификатор каталога, в котором находится агент тестирования. 

   Плагин также позволяет настроить дополнительные параметры:

   ```yaml
   panels:
     panel_name:
       ...
   api_host: {{ api-host-monitoring-1 }}:443
   token: LOADTESTING_YC_TOKEN
   timeout: 5s
   request_timeout: 10s
   poll_interval: 60s
   ignore_labels: ['service', 'resource_type', 'device', 'interface_number', 'source_metric', 'subcluster_name', 'shard', 'dc']
   priority_labels: ['cpu_name', 'label']
   ```

   Где:
   * `api_host` — адрес API сервиса {{ monitoring-name }}, из которого собираются данные. Значение по умолчанию — `{{ api-host-monitoring-1 }}:443`.
   * `token` — путь к файлу [IAM-токена](../../iam/concepts/authorization/iam-token.md). Значение по умолчанию берется из переменной окружения `LOADTESTING_YC_TOKEN`.
   * `timeout` — таймаут окончания работы плагина при завершении нагрузочного теста. Значение по умолчанию — 5 секунд.
   * `request_timeout` — таймаут запроса в API сервиса {{ monitoring-name }}. Значение по умолчанию — 10 секунд.
   * `poll_interval` — интервал между запросами в API сервиса {{ monitoring-name }}. Значение по умолчанию — 60 секунд.
   * `priority_labels` — список названий меток для построения названия метрики мониторинга.
   * `ignore_labels` — список названий меток, которые будут отброшены при построении названия метрики мониторинга.

   Последние два параметра используются для генерации названий метрик на графиках. Название каждой метрики формируется на основании ключей словаря соответствующего запроса и элементов списков `ignore_labels` и `priority_labels`. Все не алфавитно-цифровые символы в названиях заменяются на дефис.

{% endlist %}
