---
title: Как установить и обновить {{ unified-agent-full-name }}
description: Из статьи вы узнаете, как установить и обновить {{ unified-agent-full-name }}.
---

# Установка и обновление {{ unified-agent-full-name }}

## Список поддерживаемых операционных систем {#supported-os}

Работа {{ unified-agent-short-name }} поддерживается на следующих операционных системах:

- Ubuntu 14.04 или выше (возможна [установка любым из способов](#setup));
- Debian 9 или выше (Docker-образ, deb-пакет или бинарный файл);
- CentOS 7 или выше (Docker-образ);
- Fedora 32 или выше (Docker-образ);
- Fedora CoreOS (Docker-образ).


{% list tabs %}

- VK

  <iframe src="https://vk.com/video_ext.php?oid=-200452713&id=456239453&hash=1cd0d8eb71fb0296" width="640" height="360" frameborder="0" allowfullscreen="1" allow="autoplay; encrypted-media; fullscreen; picture-in-picture"></iframe>

- YouTube

  @[youtube](https://youtu.be/EY6c_6YYF10)

{% endlist %}




## Подготовка к установке {#before-you-begin}

Перед установкой {{ unified-agent-full-name }} выполните следующие шаги:

1. Создайте виртуальную машину в {{ yandex-cloud }} или хост вне {{ yandex-cloud }} на одной из [поддерживаемых операционных систем](#supported-os), например, Ubuntu 14.04 или выше.

1. (Опционально) [Установите Docker](https://docs.docker.com/install/), если через него вы хотите запускать {{ unified-agent-short-name }}. Docker уже предустановлен в Fedora CoreOS.
   - Настройте публичный IPv4-адрес (рекомендуется).
   - [Настройте Docker для работы с IPv6](https://docs.docker.com/config/daemon/ipv6) и [включите сетевую трансляцию адресов](https://medium.com/@skleeschulte/how-to-enable-ipv6-for-docker-containers-on-ubuntu-18-04-c68394a219a2), если вы не можете использовать публичный IPv4-адрес.

1. [Создайте сервисный аккаунт](../../../../iam/operations/sa/create.md) в каталоге, куда будут записываться метрики, и [назначьте ему роль](../../../../iam/operations/sa/assign-role-for-sa.md) `{{ roles-monitoring-editor }}`.

1. Настройте авторизацию агента в {{ monitoring-full-name }} API:
   - Если агент установлен на виртуальную машину в {{ yandex-cloud }}, [привяжите созданный сервисный аккаунт](../../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) к виртуальной машине. В этом случае агент будет автоматически получать IAM-токен сервисного аккаунта из сервиса-метаданных.
   - Если агент установлен на хосте вне {{ yandex-cloud }}, [создайте авторизованный ключ](../../../../iam/operations/authorized-key/create.md) для сервисного аккаунта. Подробнее про поставку метрик с хостов вне {{ yandex-cloud }} читайте в разделе [{#T}](../../../operations/unified-agent/non-yc.md).


## Установка {#setup}

Установите {{ unified-agent-short-name }} одним из способов:

{% list tabs group=unified_agent %}

- Docker-образ {#docker}

  {{ unified-agent-short-name }} распространяется в виде Docker-образа. Образ опубликован в репозитории `{{ registry }}/yc` с названием `unified_agent` и тегом `latest`. Образ содержит бинарный файл с агентом и конфигурационный файл, настраивающий агент для [поставки системных метрик Linux](../../../operations/unified-agent/linux_metrics.md) в {{ monitoring-full-name }}.

  Чтобы загрузить Docker-образ, выполните команду:

  ```bash
  sudo docker pull {{ registry }}/yc/unified-agent:latest
  ```

- deb-пакет {#deb}

  {{ unified-agent-short-name }} распространяется в виде deb-пакета для операционных систем Ubuntu 14.04 и выше. Пакет содержит бинарный файл с агентом и пустой конфигурационный файл, расположенный в `/etc/yandex/unified_agent/config.yml`.

  Чтобы установить {{ unified-agent-short-name }}:

  {% include [agent-setup-deb](../../../../_includes/monitoring/agent-setup-deb.md) %}


- Бинарный файл {#binary}

  {{ unified-agent-short-name }} распространяется в виде бинарного файла, собранного под архитектуру x86-64 / amd64 для операционных систем Ubuntu 14.04 и выше.

  Чтобы скачать последнюю версию агента в виде бинарного файла, выполните команду:

  ```bash
  ua_version=$(curl --silent https://{{ s3-storage-host }}/yc-unified-agent/latest-version) \
  bash -c 'curl --silent --remote-name https://{{ s3-storage-host }}/yc-unified-agent/releases/$ua_version/unified_agent && chmod +x ./unified_agent'
  ```

- При создании ВМ {#vm}

  Вы можете установить {{ unified-agent-short-name }} при создании виртуальной машины в консоли управления, через CLI, API или {{ TF }}.

  Чтобы установить агент из [консоли управления]({{ link-console-main }}), в блоке **{{ ui-key.yacloud.compute.instances.create.section_monitoring }}** включите опцию **{{ ui-key.yacloud.compute.instances.create.unified-agent }}**.

  Чтобы установить агент через CLI, API или {{ TF }}, укажите в [пользовательских метаданных](../../../../compute/concepts/vm-metadata.md#how-to-send-metadata) (`user-data`) строку:

  
  ```text
  #cloud-config\nruncmd:\n  - wget -O - https://monitoring.{{ api-host }}/monitoring/v2/unifiedAgent/config/install.sh | bash
  ```




  Для установки агента и отправки метрик у виртуальной машины должен быть доступ в интернет.

  Агент устанавливается с файлом конфигурации по умолчанию, который находится в `/etc/yc/unified_agent/config.yml`.

  В файле конфигурации настроена отправка [базовых метрик виртуальной машины](./inputs.md#linux_metrics_input) и [метрик здоровья агента](./inputs.md#agent_metrics_input). Отправка метрик [тарифицируется](../../../pricing.md).

  Дополнительно можно [настроить](./configuration.md) поставку собственных метрик или [логов в {{ cloud-logging-name }}](./outputs.md#yc_logs_output).


  После разворачивания ВМ {{ unified-agent-short-name }} запустится автоматически и начнет передавать базовые метрики ВМ в сервис {{ monitoring-full-name }}.

  Обновление агента выполняйте вручную через бинарный файл.

{% endlist %}


## Обновление {#update}

Обновите {{ unified-agent-short-name }} одним из способов:

{% list tabs group=unified_agent %}

- Docker-образ {#docker}

  1. Остановите контейнер `ua`:

      ```bash
      sudo docker stop ua
      ```

  1. Удалите контейнер:

      ```bash
      sudo docker rm ua
      ```

  1. [Запустите](./run-and-stop.md#run) контейнер.

- deb-пакет {#deb}

  Заново скачайте и установите deb-пакет:

  {% include [agent-setup-deb](../../../../_includes/monitoring/agent-setup-deb.md) %}

- Бинарный файл {#binary}

  {% include [agent-update-binary](../../../../_includes/monitoring/agent-update-binary.md) %}

- При создании ВМ {#vm}

  {% include [agent-update-binary](../../../../_includes/monitoring/agent-update-binary.md) %}

{% endlist %}


#### Что дальше {#what-is-next}

- [Узнайте, как запустить и остановить {{ unified-agent-short-name }}](./run-and-stop.md)
- [Изучите концепции {{ unified-agent-short-name }}](./index.md)
- [Узнайте подробнее о конфигурировании {{ unified-agent-short-name }}](./configuration.md)
- [Ознакомьтесь с рекомендациями по эксплуатации {{ unified-agent-short-name }}](./best-practices.md)
