# Сбор метрик кластера «1С:Предприятие» на базе Linux

В этом руководстве вы настроите сбор метрик кластера «1С:Предприятие» на базе Linux в формате {{ prometheus-name }} и их визуализацию в сервисе [{{ monitoring-full-name }}](../../monitoring/concepts/visualization/metric-explorer.md). Помимо визуализации, {{ monitoring-name }} позволяет настраивать алерты, гибридные дашборды с метриками различных сервисов {{ yandex-cloud }} и обладает большими возможностями по масштабированию.

Метрики кластера будут собираться с помощью свободно распространяемой утилиты [{{ prometheus-name }} 1C Exporter](https://github.com/kirillmasanov/prometheus_1C_exporter), передаваться в [{{ unified-agent-full-name }}](../../monitoring/concepts/data-collection/unified-agent/index.md) и затем в {{ monitoring-name }}.

Руководство предполагает, что у вас уже развернут кластер «1С:Предприятие» на виртуальной машине в сервисе [{{ compute-full-name }}](../../compute/quickstart/index.md). Пример развертывания см. в руководстве [{#T}](../../tutorials/infrastructure-management/1c-postgresql-linux.md).

Чтобы начать работать с метриками в {{ monitoring-full-name }}:

1. [Установите и настройте {{ prometheus-name }} 1C Exporter](#configure-exporter)
1. [Установите и настройте {{ unified-agent-short-name }}](#configure-ua)
1. [Создайте сервисный аккаунт и привяжите его к ВМ](#sa-create)
1. [Проверьте, что метрики передаются в {{ monitoring-name }}](#check-metrics)
1. [Создайте дашборд для наблюдения за метриками](#dashboard-create)

Если созданные ресурсы больше не нужны, [удалите их](#clear-out).

## Необходимые платные ресурсы {#paid-resources}

Плата за передачу метрик в {{ monitoring-name }} (см. [тарифы {{ monitoring-name }}](../../monitoring/pricing.md)).

## Установите и настройте {{ prometheus-name }} 1C Exporter {#configure-exporter}

1. На виртуальной машине с «1С:Предприятие» скачайте {{ prometheus-name }} 1C Exporter:

   ```bash
   wget https://github.com/LazarenkoA/prometheus_1C_exporter/releases/download/v1.5.0/prometheus_1C_exporter-linux-amd64
   ```
1. Переименуйте экспортер и переместите его в системный каталог:

   ```bash
   mv prometheus_1C_exporter-linux-amd64 exporter_1C
   sudo mv exporter_1C /usr/local/bin/exporter_1C
   ```
1. Назначьте файл исполняемым:

   ```bash
   sudo chmod +x /usr/local/bin/exporter_1C
   ```
1. Создайте файл конфигурации для экспортера:
   
   ```bash
   sudo mkdir /etc/exporter_1C/
   sudo vi /etc/exporter_1C/settings.yaml
   ```

1. Скопируйте конфигурацию ниже в файл `settings.yaml`, при необходимости настройте свой набор метрик для сбора.

   {% cut "Конфигурация экспортера settings.yaml" %}

   ```yaml
   # Доступные значения метрик, которые можно собирать с помощью экспортера:
   # ClientLic — Клиентские лицензии
   # AvailablePerformance — Доступная производительность (через RAC)
   # SheduleJob — Проверка опции "Блокировка регламентных заданий"
   # Session — Сеансы
   # Connect — Соединения
   # SessionsData — Различные показатели из консоли 1C (через RAC)
   # ProcData — Данные процессов (собираются метрики ОС Linux)
   # CPU — Загрузка процессора
   # disk — Метрики диска (сейчас поддерживается только Linux и WeightedIO)
   # Property — Дополнительные параметры, у каждой метрики свой набор параметров
   # Processes — Дополнительный параметр ProcData, определяет список процессов, которые нужно отслеживать
   
   # Можно включить или отключить любой набор метрик для отслеживания
   Exporters:
   - Name: client_lic
   - Name: available_performance
   # - Name: processes
   # - Name: cpu
   # - Name: disk
   # - Name: shedule_job
   # - Name: session
   - Name: connect
   # - Name: sessions_data


   # HTTP-сервис, который возвращает JSON-массив с параметрами доступа к БД
   # Требуется для метрики SheduleJob
   # пример json:
   #[
   #  {
   #    "Name": "hrmcorp-n17", # Имя базы 1C
   #    "UserName": "",
   #    "UserPass": ""
   #  }
   #]
   #DBCredentials: # обязательный параметр для метрики shedule_job
   #  Адрес, по которому 1С возвращает список баз данных в JSON-формате
   #  URL: http://ca-fr-web-1/fresh/int/sm/hs/PTG_SysExchange/GetDatabase
   #  User: ""
   #  Password: ""
   #  TLSSkipVerify: true # true — при обращении к сервису игнорировать ошибки проверки сертификата

   RAC:
   Path: "/usr/local/bin/rac"
   Port: "1545"      # Необязательный параметр
   Host: "localhost" # Необязательный параметр
   Login: ""         # Необязательный параметр
   Pass: ""          # Необязательный параметр

   LogDir:        # Если каталог не указан, логи будут записываться в каталог с исполняемым файлом экспортера
   LogLevel:  5   # Уровень логирования: 2 (ошибка), 3 (предупреждение), 4 (информация), 5 (отладка)
   ```
   {% endcut %}

   В этой конфигурации настроена передача метрик:

   * `available_performance` — доступная производительность хоста (Histogram).
   * `client_lic` — клиентские лицензии 1С (Histogram).
   * `connect` — соединения 1С (Histogram).

   При необходимости можно добавить [другие метрики](https://github.com/kirillmasanov/prometheus_1C_exporter).

1. Создайте символическую ссылку для утилиты управления 1C RAC:

   ```bash
   sudo ln -s /opt/<путь_установки_1C>/rac /usr/local/bin/rac
   ```

1. Создайте unit-файл для systemd для управления экспортером:

   ```bash
   sudo vi /etc/systemd/system/exporter_1C.service
   ```

   {% cut "Содержимое файла exporter_1C.service" %}
   ```
   [Unit]
   Description=Prometheus 1C exporter
   After=local-fs.target network-online.target network.target
   Wants=local-fs.target network-online.target network.target

   [Service]
   Type=simple
   ExecStart=/usr/local/bin/exporter_1C -port=9095 --settings=/etc/exporter_1C/settings.yaml
   ExecReload=/bin/kill -s HUP $MAINPID

   [Install]
   WantedBy=multi-user.target
   ```

   Эта конфигурация запускает экспортер после загрузки ОС и сети. Экспортер начинает прослушивать порт `9095` по параметрам из файла `settings.yaml`.

   {% endcut %}

1. Запустите экспортер:

   ```bash
   sudo systemctl daemon-reload
   sudo systemctl start exporter_1C.service
   sudo systemctl enable exporter_1C.service
   ```

1. Проверьте состояние экспортера и убедитесь, что сервис находится в состоянии `active (running)`.

   ```bash
   sudo systemctl status exporter_1C.service
   ```

После запуска экспортера метрики доступны по адресу `curl http://localhost:9095/metrics`. Чтобы работать с метриками в {{ monitoring-full-name }}, надо установить {{ unified-agent-short-name }} и настроить его на прием метрик по этому адресу и передачу метрик в {{ monitoring-name }}.

## Создайте сервисный аккаунт и привяжите его к ВМ {#sa-create}

Сервисный аккаунт нужен для передачи метрик из ВМ в {{ monitoring-name }}.

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт `sa-1c-monitoring` в каталоге, куда будут записываться метрики.
1. [Назначьте](../../iam/operations/roles/grant.md) сервисному аккаунту [роль](../../monitoring/security/index.md#monitoring.editor) `monitoring.editor`.
1. [Подключите](../../compute/operations/vm-control/vm-connect-sa.md) сервисный аккаунт к ВМ, на которой установлено «1С:Предприятие».

## Установите и настройте {{ unified-agent-short-name }} {#configure-ua}

1. Скачайте последнюю версию deb-пакета:

   ```bash
   ubuntu_name="<версия_ОС>" ua_version=$(curl --silent https://storage.yandexcloud.net/yc-unified-agent/latest-version) bash -c 'curl --silent --remote-name https://storage.yandexcloud.net/yc-unified-agent/releases/${ua_version}/deb/${ubuntu_name}/yandex-unified-agent_${ua_version}_amd64.deb'
   ```

1. Посмотрите версию deb-пакета с помощью команды `ls`.
   
1. Установите {{ unified-agent-short-name }} из deb-пакета, указав его версию:

   ```bash
   sudo dpkg -i yandex-unified-agent_<версия_агента>_amd64.deb
   ```
   
   Другие способы установки описаны в разделе [{#T}](../../monitoring/concepts/data-collection/unified-agent/installation.md). 

1. Проверьте, что {{ unified-agent-short-name }} запущен:

   ```bash
   sudo systemctl status unified-agent.service
   ```

1. Откройте конфигурационный файл {{ unified-agent-short-name }}:
   
   ```bash
   sudo vi /etc/yandex/unified_agent/config.yml
   ```

1. Замените содержимое файла на конфигурацию ниже. Добавьте идентификатор каталога, в который будут передаваться метрики.

   {% cut "Конфигурация {{ unified-agent-short-name }} config.yml" %}
   ```yaml
   monitoring:
     port: 16300

   status:
   port: 16301

   channels:
   - name: yc_metrics_channel
      channel:
         output:
         plugin: yc_metrics
         config:
            folder_id: "<идентификатор_каталога>"
            iam:
               cloud_meta: {}
   - name: monitoring_1c
      channel:
         output:
         plugin: yc_metrics
         config:
            folder_id: "<идентификатор_каталога>"
            iam:
               cloud_meta: {}

   routes:
   - input:
         id: linux_metrics_input
         plugin: linux_metrics
         config:
         poll_period: 15s
      channel:
         channel_ref:
         name: yc_metrics_channel
   - input:
         plugin: metrics_pull
         config:
         url: http://localhost:9095/metrics
         format:
            prometheus: {}
         namespace: app1c
      channel:
         pipe:
         - filter:
               plugin: transform_metric_label
               config:
               label: cluster
               rename_to: cluster_1c
         - filter:
               plugin: transform_metric_labels
               config:
               labels:
                  - servicename: "-"
         - filter:
               plugin: transform_metric_labels
               config:
               labels:
                  - user: "-"
         - filter:
               plugin: transform_metric_labels
               config:
               labels:
                  - base: "-"
         - filter:
               plugin: transform_metric_labels
               config:
               labels:
                  - licSRV: "-"
         channel_ref:
         name: monitoring_1c

   import:
   - /etc/yandex/unified_agent/conf.d/*.yml
   ```
  
   В конфигурации для меток с эндпоинта `/metrics` задан префикс `app1c_`. Префикс может быть произвольным.

   В {{ monitoring-full-name }} есть ограничения на метки и их значения:

    * имя метки не может быть пустым;
    * имя метки и значение метрики могут содержать только латинские буквы;
    * нельзя использовать метку `cluster`.

   Для этих ограничений в файле конфигурации {{ unified-agent-short-name }} настроено:
    * переименование метки `cluster` на `cluster_1c`;
    * фильтрация (удаление) меток, которые содержат нелатинские символы: `servicename`, `user`, `base`, `licSRV`.

   Подробнее о настройке {{ unified-agent-short-name }} см. в разделе [{#T}](../../monitoring/concepts/data-collection/unified-agent/configuration.md).

   {% endcut %}

1. Проверьте, что файл конфигурации составлен верно (команда должна вывести содержимое файла):

   ```bash
   unified_agent check-config -c /etc/yandex/unified_agent/config.yml
   ```

1. Перезапустите {{ unified-agent-short-name }}, чтобы применить обновленную конфигурацию:

   ```bash
   sudo systemctl restart unified-agent.service
   ```

1. Посмотрите статус службы {{ unified-agent-short-name }}:

   ```bash
   sudo systemctl status unified-agent.service
   ```

## Проверьте, что метрики передаются в {{ monitoring-name }} {#check-metrics}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. На [главной странице]({{ link-monitoring }}) сервиса {{ monitoring-name }} на панели слева выберите **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
    1. В строке запроса выберите:
       * Каталог, в который собираются метрики.
       * Значение метки `service` — `custom`.
       * Значение метки `name`, начинающееся с префикса `app1c_`. Например, `app1c_available_performance`.
       * Значение метки `host` — имя ВМ кластера «1С:Предприятие».

    1. Нажмите кнопку **Выполнить запрос**.

{% endlist %}

## Создайте дашборд для наблюдения за метриками {#dashboard-create}

Ниже приведен пример дашборда, который позволяет следить за метриками, настроенными в конфигурации экспортера.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. На [главной странице]({{ link-monitoring }}) сервиса {{ monitoring-name }} нажмите **{{ ui-key.yacloud_monitoring.homepage.button_dashboards-action }}**.
    1. Справа вверху нажмите ![image](../../_assets/console-icons/plus.svg) и выберите ![image](../../_assets/console-icons/chart-column.svg) **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-graph }}**.
    1. Переключите строку запроса в [текстовый режим](../../monitoring/concepts/visualization/query-string.md#query-text). Для этого справа от строки нажмите ![raw](../../_assets/console-icons/code.svg). В текстовом режиме удобно добавлять уже готовые запросы.
    1. Укажите запрос для доступной производительности хоста:

         ```
         "app1c.available_performance"{folderId = "<идентификатор_каталога>", service = "custom", quantile = "0.99", type = "available", host = "<имя_ВМ_1C>"}
         ```
    1. Справа вверху нажмите ![image](../../_assets/console-icons/floppy-disk.svg) **{{ ui-key.yacloud_monitoring.actions.common.save }}**.
    1. Таким же образом добавьте на дашборд графики:
    
       * Использование клиентских лицензий:
         ```
         "app1c.client_lic"{folderId = "<your-folder-id>", service = "custom", quantile = "0.99", host = "<имя_ВМ_1C>"}
         ```

       * Соединения:
         ```
         "app1c.connect"{folderId = "<your-folder-id>", service = "custom", quantile = "0.99"}
         ```

{% endlist %}

Дополнительные настройки дашборда см. в разделе [{#T}](../../monitoring/operations/dashboard/add-widget.md).

## Удалите созданные ресурсы {#delete-resources}

Остановите чтение и запись метрик одним из способов:

* [Остановите {{ unified-agent-short-name }}](../../monitoring/concepts/data-collection/unified-agent/run-and-stop.md#stop).
* В [файле конфигурации](../../monitoring/concepts/data-collection/unified-agent/configuration.md) {{ unified-agent-short-name }} удалите настройки сбора и передачи метрик.
* [Удалите {{ unified-agent-short-name }}](../../monitoring/concepts/data-collection/unified-agent/delete.md).