# Мониторинг агентов тестирования

Мониторинг позволяет собирать данные о состоянии агента тестирования (метрики) и отображать их на графиках. Сбор метрик выполняется с помощью [Telegraf](https://github.com/influxdata/telegraf). Графики мониторинга отображаются на вкладке **{{ ui-key.yacloud.load-testing.label_monitoring-report }}** для выбранного теста.

Включить мониторинг агента можно в настройках при [создании теста](../operations/create-test-bucket.md#create-test):

{% list tabs %}

- Форма

  Если вы настраиваете параметры теста с помощью формы в интерфейсе, включите опцию `Мониторинг агента`. В этом случае активируется стандартная конфигурация мониторинга агента, которая включает следующие метрики:
   
  * [cpu](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/cpu)
  * [diskio](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/diskio)
  * [mem](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/mem)
  * [net](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/net)
  * [nstat](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/nstat)
  * [system](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/system)

- Конфигурационный файл

  Если вы настраиваете параметры теста в конфигурационном файле, опишите конфигурацию мониторинга агента в блоке `telegraf`. Вы можете настраивать каждую метрику с помощью всех опций, которые доступны для нее в Telegraf.

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

{% endlist %}
