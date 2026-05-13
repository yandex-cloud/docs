# Агент для сбора метрик Prometheus

Чтобы передавать метрики из виртуальной машины в Yandex Managed Service for Prometheus®, надо установить агент для сбора метрик. Вы можете установить любой агент, который поддерживает передачу метрик, либо воспользоваться Unified Agent с возможностью передачи метрик Prometheus. 

В этом разделе описана установка агента при создании виртуальной машины. Другие способы установки см. в разделе [Установка и обновление Yandex Unified Agent](../../../concepts/data-collection/unified-agent/installation.md).

{% note info %}

Unified Agent с версии 25.03.80 может собирать и передавать метрики Prometheus.

{% endnote %}

## Список поддерживаемых операционных систем {#supported-os}

- Ubuntu 14.04 или выше.
- Debian 9 или выше.

## Подготовка к установке {#before-you-begin}

1. [Создайте сервисный аккаунт](../../../../iam/operations/sa/create.md) в каталоге, куда будут записываться метрики, и [назначьте ему роль](../../../../iam/operations/sa/assign-role-for-sa.md) `monitoring.editor`.

1. Настройте авторизацию агента в Yandex Monitoring API. Для этого [привяжите созданный сервисный аккаунт](../../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) к виртуальной машине. В этом случае агент будет автоматически получать IAM-токен сервисного аккаунта из сервиса метаданных.

## Установка и настройка {#setup}

Вы можете установить агент для сбора метрик при создании виртуальной машины в консоли управления, через CLI, API или Terraform.

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления](https://console.yandex.cloud) начните [создавать ВМ](../../../../compute/operations/vm-create/create-linux-vm.md).
  1. Раскройте блок **Дополнительно** ⟶ **Мониторинг**.
  1. Включите **Агент сбора метрик** и выберите **Yandex Managed Service for Prometheus®**.
  1. [Создайте](../index.md#access) или выберите уже существующий воркспейс.
  1. (Опционально) Укажите параметры поставки собственных метрик в формате JSON.

      Если параметры не указаны, агент будет поставлять только системные метрики Linux. Добавить или изменить поставку собственных метрик можно позднее в [пользовательских метаданных](../../../../compute/concepts/vm-metadata.md#how-to-send-metadata).
    
      Формат описания метрик:

      ```json
      {
        "jobs": [
          {
            "job_name": <имя>,
            "scrape_interval": "15s",
            "scrape_timeout": "5s",
            "metrics_path": "/metrics",
            "targets": [
              {
                "host": <FQDN_хоста>, //опционально
                "port": 42
              }
            ]
          }
        ]
      }
      ```

      Где:
      - `job_name` — произвольное имя для набора собираемых метрик.
      - `scrape_interval` — как часто агент будет собирать метрики.
      - `scrape_timeout` — время, отведенное агенту на сбор метрик.
      - `metrics_path` — путь, по которому находятся метрики сервиса.
      - `targets` — параметры хоста, с которого собираются метрики:
        - `host` — (опционально) полное доменное имя, например `my.example.com`.
        - `port` — порт для сбора метрик.

- CLI, API {#cli}
  
    Чтобы установить агент, укажите в [пользовательских метаданных](../../../../compute/concepts/vm-metadata.md#how-to-send-metadata) (`user-data`) строку:

    
      ```text
      #cloud-config\nruncmd:\n  - wget -O - https://monitoring.api.cloud.yandex.net/monitoring/v2/unifiedAgent/config/install.sh | bash
      ```



- Terraform {#tf}

  Для установки агента:
  
  1. В конфигурации создания ВМ укажите:

      ```hcl
      resource "yandex_compute_instance" "my-vm" {
        ...
        service_account_id = "ajehka*************"
        metadata    = {
          monitoring_workspaceid = "mon618clr**************"
          user-data = "${file("<путь_к_файлу_конфигурации>")}"
        }
        ...
      }

      ```

      Где:
      * `monitoring_workspaceid` — идентификатор воркспейса, в который будут записываться метрики.
      * `service_account_id` — идентификатор сервисного аккаунта с ролью `monitoring.editor`.

  1. В файле конфигурации (`user-data`) укажите строку:

      
      ```text
      #cloud-config\nruncmd:\n  - wget -O - https://monitoring.api.cloud.yandex.net/monitoring/v2/unifiedAgent/config/install.sh | bash
      ```



{% endlist %}

Для установки агента и отправки метрик у виртуальной машины должен быть доступ в интернет.

## Конфигурирование {#configuration}

У агента есть два файла конфигурации: `config.yml` и `prometheus.yml`.

Файл `config.yml` находится по пути `/etc/yc/unified_agent/config.yml`. Когда агент устанавливается в режиме сбора метрик Prometheus, файл не содержит параметров сбора метрик.

{% cut "Пример файла config.yml" %}

```yaml
status:
  port: "16241"

import:
  - /etc/yc/unified_agent/conf.d/*.yml
  - /etc/yc/unified_agent/generated_conf.d/*.yml
```

{% endcut %}

Файл `prometheus.yml` находится по пути `/etc/yc/unified_agent/generated_conf.d/prometheus.yml`. В нем настроен сбор метрик в формате Prometheus по умолчанию. Если при установке агента вы указали свои параметры сбора метрик, они будут добавлены в этот файл.

{% cut "Пример файла prometheus.yml" %}

```yaml
storages:
  - name: __prometheus_metrics_storage
    plugin: fs
    config:
      directory: /var/lib/yc/unified_agent/__prometheus_metrics_storage
      max_partition_size: 100mb
      max_segment_size: 10mb
channels:
  - name: __remote_write
    channel:
      pipe:
        - storage_ref:
            name: __prometheus_metrics_storage
      output:
        plugin: metrics
        config:
          url: "https://monitoring.api.cloud.yandex.net/prometheus/workspaces/workspace_id/api/v1/write"
          set_host_label: null
          iam:
            cloud_meta: { }
routes:
  - input:
      id: linux_metrics_input
      plugin: linux_metrics
      config:
        poll_period: 60s
        namespace: sys
        prometheus_config:
          job_name: linux_metrics
    channel:
      channel_ref:
        name: __remote_write
```

{% endcut %}


После разворачивания ВМ агент запустится автоматически и начнет отправлять метрики в Yandex Managed Service for Prometheus®.

Отправка метрик [тарифицируется](../../../pricing.md).


## Обзор метрик виртуальной машины {#view-metrics}

Чтобы посмотреть метрики, которые передаются через агента в Yandex Managed Service for Prometheus®:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится виртуальная машина.
  1. [Перейдите](../../../../console/operations/select-service.md#select-service) в сервис **Monitoring**.
  1. Перейдите в раздел **Prometheus**.
  1. Выберите воркспейс, в который записываются метрики виртуальной машины.
  1. Откройте вкладку **Метрики** и введите **Запрос на языке PromQL** для просмотра:
     
     * Системных метрик Linux — `{job="linux_metrics", instance="<имя_ВМ>", __name__="<имя_метрики>"}`.

        Пример: `{job="linux_metrics", instance="my_vm", __name__="sys_cpu_CpuCores"}`.

        Список метрик, которые передает агент Prometheus, см. в разделе [Метрики Yandex Unified Agent](../../../metrics-ref/unifiedagent-ref.md).
     
     * Пользовательских метрик, если их передача была настроена на агенте, — `{job="имя_набора_метрик", instance="<имя_ВМ>:<порт>", __name__="<имя_метрики>"}`.

        Где:
         * `job` — имя набора метрик, указанное при настройке агента;
         * `instance` — имя ВМ и порт, на котором работает ваше приложение;
         * `name` — имя метрики, которую передает ваше приложение.

         Пример: `{job="web_server", instance="my_server:9100", __name__="http_requests_total"}`.
  1. Нажмите кнопку **Выполнить**.

{% endlist %}