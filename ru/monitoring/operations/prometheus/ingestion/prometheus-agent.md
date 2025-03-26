---
title: Как установить агент для сбора метрик {{ prometheus-name }}
description: Из статьи вы узнаете, как установить агент для сбора метрик {{ prometheus-name }} при создании виртуальной машины и посмотреть собранные метрики.
---

# Агент для сбора метрик {{ prometheus-name }}

Чтобы передавать метрики из виртуальной машины в {{ managed-prometheus-name }}, надо установить агент для сбора метрик. Вы можете установить любой агент, который поддерживает передачу метрик, либо воспользоваться {{ unified-agent-short-name }} с возможностью передачи метрик {{ prometheus-name }}. 

В этом разделе описана установка агента при создании виртуальной машины. Другие способы установки см. в разделе [{#T}](../../../concepts/data-collection/unified-agent/installation.md).

## Список поддерживаемых операционных систем {#supported-os}

- Ubuntu 14.04 или выше.
- Debian 9 или выше.

## Подготовка к установке {#before-you-begin}

1. [Создайте сервисный аккаунт](../../../../iam/operations/sa/create.md) в каталоге, куда будут записываться метрики, и [назначьте ему роль](../../../../iam/operations/sa/assign-role-for-sa.md) `{{ roles-monitoring-editor }}`.

1. Настройте авторизацию агента в {{ monitoring-full-name }} API. Для этого [привяжите созданный сервисный аккаунт](../../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) к виртуальной машине. В этом случае агент будет автоматически получать IAM-токен сервисного аккаунта из сервиса метаданных.

## Установка и настройка {#setup}

Вы можете установить агент для сбора метрик при создании виртуальной машины в консоли управления, через CLI, API или {{ TF }}.

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) начните [создавать ВМ](../../../../compute/operations/vm-create/create-linux-vm.md).
  1. Раскройте блок **{{ ui-key.yacloud.compute.instances.create.section_additional }}** > **{{ ui-key.yacloud.compute.instances.create.section_monitoring }}**.
  1. Включите **{{ ui-key.yacloud.compute.instances.create.unified-agent }}** и выберите **{{ managed-prometheus-name }}**.
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
      #cloud-config\nruncmd:\n  - wget -O - https://monitoring.{{ api-host }}/monitoring/v2/unifiedAgent/config/install.sh | bash
      ```



- {{ TF }} {#tf}

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
      #cloud-config\nruncmd:\n  - wget -O - https://monitoring.{{ api-host }}/monitoring/v2/unifiedAgent/config/install.sh | bash
      ```



{% endlist %}

Для установки агента и отправки метрик у виртуальной машины должен быть доступ в интернет.

Агент устанавливается с файлом конфигурации по умолчанию, который находится по пути `/etc/yc/unified_agent/config.yml`.

В файле конфигурации настроена отправка системных метрик Linux и метрик здоровья агента. Отправка метрик [тарифицируется](../../../pricing.md). Дополнительно можно настроить поставку метрик из ваших приложений в формате {{ prometheus-name }}.


После разворачивания ВМ агент запустится автоматически и начнет отправлять метрики в {{ managed-prometheus-name }}.


## Обзор метрик виртуальной машины {#view-metrics}

Чтобы посмотреть метрики, которые передаются через агента в {{ managed-prometheus-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится виртуальная машина.
  1. В списке сервисов выберите **{{ monitoring-short-name }}**.
  1. Перейдите в раздел **{{ prometheus-name }}**.
  1. Выберите ворксейс, в который записываются метрики виртуальной машины.
  1. Откройте вкладку **{{ ui-key.yacloud_monitoring.prometheus.approved.tab.explore }}** и введите **{{ ui-key.yacloud_monitoring.prometheus.query.label }}** для просмотра:
     
     * Системных метрик Linux — `{job="linux_metrics", instance="<имя_ВМ>", __name__="<имя_метрики>"}`.

        Пример: `{job="linux_metrics", instance="my_vm", __name__="sys_cpu_CpuCores"}`.

        Список метрик, которые передает агент {{ prometheus-name }}, см. в разделе [{#T}](../../../metrics-ref/unifiedagent-ref.md).
     
     * Пользовательских метрик, если их передача была настроена на агенте, — `{job="имя_набора_метрик", instance="<имя_ВМ>:<порт>", __name__="<имя_метрики>"}`.

        Где:
         * `job` — имя набора метрик, указанное при настройке агента;
         * `instance` — имя ВМ и порт, на котором работает ваше приложение;
         * `name` — имя метрики, которую передает ваше приложение.

         Пример: `{job="web_server", instance="my_server:9100", __name__="http_requests_total"}`.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.prometheus.query.action_execute }}**.

{% endlist %}