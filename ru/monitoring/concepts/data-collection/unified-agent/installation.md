# Установка и запуск {{ unified-agent-full-name }}

## Список поддерживаемых операционных систем {#supported-os}

Работа {{unified-agent-short-name}} поддерживается на следующих операционных системах:

- Ubuntu 14.04 или старше;
- Debian 9 или старше;
- CentOS 7 или старше;
- Fedora 32 или старше;
- Fedora CoreOS.

## Подготовка к установке {#before-you-begin}

Перед установкой {{unified-agent-full-name}} выполните следующие шаги:

1. Создайте виртуальную машину в {{ yandex-cloud }} или хост вне {{ yandex-cloud }} на одной из [поддерживаемых операционных систем](#supported-os), например, Ubuntu 14.04 или старше.

1. (опционально) [Установите Docker](https://docs.docker.com/install/), если через него вы хотите запускать {{unified-agent-short-name}}.
   - Настройте публичный IPv4-адрес (рекомендуется).
   - [Настройте Docker для работы с IPv6](https://docs.docker.com/config/daemon/ipv6) и [включите сетевую трансляцию адресов](https://medium.com/@skleeschulte/how-to-enable-ipv6-for-docker-containers-on-ubuntu-18-04-c68394a219a2), если вы не можете использовать публичный IPv4-адрес.

1. [Создайте сервисный аккаунт](../../../../iam/operations/sa/create.md) в каталоге, куда будут записываться метрики, и [назначьте ему роль](../../../../iam/operations/sa/assign-role-for-sa.md) `{{ roles-monitoring-editor }}`.

1. Настройте авторизацию агента в {{monitoring-full-name}} API:
   - Если агент установлен на виртуальную машину в {{ yandex-cloud }}, [привяжите созданный сервисный аккаунт](../../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) к виртуальной машине. В этом случае агент будет автоматически получать IAM-токен сервисного аккаунта из сервиса-метаданных.
   - Если агент установлен на хосте вне {{ yandex-cloud }}, [создайте авторизованный ключ](../../../../iam/operations/authorized-key/create.md) для сервисного аккаунта. Подробнее про поставку метрик с хостов вне {{ yandex-cloud }} читайте в разделе [{#T}](../../../operations/unified-agent/non-yc.md).

## Установка {#setup}

Установите {{unified-agent-short-name}} одним из способов:

{% list tabs %}

- Docker-образ

  {{unified-agent-short-name}} распространяется в виде Docker-образа. Образ опубликован в репозитории `{{ registry }}/yc` с названием `unified_agent` и тегом `latest`. Образ содержит бинарный файл с агентом и конфигурационный файл, настраивающий агент для [поставки системных метрик Linux](../../../operations/unified-agent/linux_metrics.md) в {{monitoring-full-name}}.

  {% note warning %}

  Для мониторинга дополнительных дисков, подключенных к хосту, передайте пути к их точкам монтирования при помощи параметра `-v` команды `docker run`. Подробнее читайте в разделе [{#T}](./configuration.md#linux_metrics_input).

  {% endnote %}

  Конфигурационный файл агента расположен в `/etc/yandex/unified_agent/config.yml` и параметризован переменными окружения. Подробнее параметры запуска Docker-контейнера описаны в разделе [ниже](#configure-docker).

  Чтобы запустить контейнер с агентом, выполните следующую команду:

  ```bash
    docker run \
      -p 16241:16241 -it --detach --uts=host \
      --name=ua \
      -v /proc:/ua_proc \
      -e PROC_DIRECTORY=/ua_proc \
      -e FOLDER_ID=a1bs... \
      {{ registry }}/yc/unified-agent
  ```

  Где `FOLDER_ID` – идентификатор каталога, куда будут записываться метрики.

  Чтобы запустить контейнер с собственным файлом конфигурации, добавьте в команду запуска контейнера параметр `-v`, указав _полный путь_ до файла конфигурации. Например:

  ```bash
    docker run \
      -p 16241:16241 -it --detach --uts=host \
      --name=ua \
      -v /proc:/ua_proc \
      -v `pwd`/config.yml:/etc/yandex/unified_agent/config.yml \
      --entrypoint="" \
      -e PROC_DIRECTORY=/ua_proc \
      -e FOLDER_ID=a1bs... \
      {{ registry }}/yc/unified-agent
  ```

  Подробнее про конфигурацию агента читайте в разделе [{#T}](./configuration.md).

- deb-пакет

  {{unified-agent-short-name}} распространяется в виде deb-пакета для операционных систем Ubuntu 14.04 или старше. Пакет содержит бинарный файл с агентом и пустой конфигурационный файл, расположенный в `/etc/yandex/unified_agent/config.yml`.

  Чтобы скачать последнюю версию агента в виде deb-пакета выполните команду:

  ```bash
  ubuntu_name="ubuntu-14.04-trusty" ua_version=$(curl -s https://{{ s3-storage-host }}/yc-unified-agent/latest-version) bash -c 'curl -s -O https://{{ s3-storage-host }}/yc-unified-agent/releases/${ua_version}/deb/${ubuntu_name}/yandex-unified-agent_${ua_version}_amd64.deb'
  ```

  Поддерживаемые значения параметра `ubuntu_name`:
    - `ubuntu-14.04-trusty`;
    - `ubuntu-16.04-xenial`;
    - `ubuntu-18.04-bionic`;
    - `ubuntu-20.04-focal`.

  Чтобы узнать все доступные версии агента выполните команду:
  ```(bash)
  curl -s https://{{ s3-storage-host }}/yc-unified-agent/all-versions
  ```

  Чтобы установить deb-пакет, выполните команду:

  ```bash
  sudo dpkg -i yandex-unified-agent_21.02.03_amd64.deb
  ```

  Чтобы убедиться, что {{unified-agent-short-name}} успешно установлен и запущен, выполните команду `systemctl status unified-agent`. Пример работы команды:

  ```bash
  user@my-vm:~$ systemctl status unified-agent
  ● unified-agent.service - Yandex Unified Agent service
     Loaded: loaded (/lib/systemd/system/unified-agent.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2021-02-09 15:57:08 UTC; 2 weeks 2 days ago
   Main PID: 141403 (unified_agent)
      Tasks: 8 (limit: 507)
     Memory: 9.4M
     CGroup: /system.slice/unified-agent.service
             └─141403 /usr/bin/unified_agent --config /etc/yandex/unified_agent/config.yml --log-priority NOTICE
  ```

  После установки пакета отредактируйте файл конфигурации `/etc/yandex/unified_agent/config.yml`, например, настроив агент для [поставки системных метрик Linux](../../../operations/unified-agent/linux_metrics.md). Подробнее про конфигурацию агента читайте в разделе [{#T}](./configuration.md).

- Бинарный файл

  {{unified-agent-short-name}} распространяется в виде бинарного файла, собранного под архитектуру x86-64 / amd64 для операционных систем Ubuntu 14.04 или старше.

  Чтобы скачать последнюю версию агента в виде бинарного файла, выполните команду:

  ```bash
  ua_version=$(curl -s https://{{ s3-storage-host }}/yc-unified-agent/latest-version) bash -c 'curl -s -O https://{{ s3-storage-host }}/yc-unified-agent/releases/$ua_version/unified_agent && chmod +x ./unified_agent'
  ```

  Чтобы узнать все доступные версии агента выполните команду:
  ```(bash)
  curl -s https://{{ s3-storage-host }}/yc-unified-agent/all-versions
  ```

  После скачивания исполняемого файла с агентом создайте конфигурационный файл, например, с настройками для [поставки системных метрик Linux](../../../operations/unified-agent/linux_metrics.md). Подробнее про конфигурацию агента читайте в разделе [{#T}](./configuration.md).

  Чтобы запустить агент, выполните команду:

  ```bash
  ./unified_agent --config unified_agent.yml
  ```

  Где `--config` – путь до конфигурационного файла.


- При создании ВМ

  Вы можете установить агент при создании виртуальной машины в [консоли управления]({{ link-console-main }}). Для этого в блоке **Мониторинг** включите опцию **Агент сбора метрик**. Агент автоматически установится с файлом конфигурации по умолчанию, который будет отправлять [базовые метрики виртуальной машины](./configuration.md#linux_metrics_input), а также [метрики здоровья агента](./configuration.md#agent_metrics_input). Отправка метрик [тарифицируется](../../../pricing.md).

  Устанавливаемый агент является обычным [агентом Unified Agent](./index.md), который можно дополнительно [настроить](./configuration.md) для поставки собственных метрик или [логов в {{ cloud-logging-name }}](./configuration.md#yc_logs_output).

  Чтобы установить агент при создании виртуальной машины через CLI или API, укажите в [пользовательских метаданных](../../../../compute/concepts/vm-metadata.md#how-to-send-metadata) (`user-data`) строку:

  ```
  #cloud-config\nruncmd:\n  - wget -O - https://monitoring.{{ api-host }}/monitoring/v2/unifiedAgent/config/install.sh | bash"
  ```

  Для корректной установки агента и отправки метрик у созданной виртуальной машины должен быть доступ в интернет. 

  Обновление и поддержка агента выполняется самостоятельно.
  

{% endlist %}

## Параметры запуска Docker-контейнера с {{ unified-agent-short-name }} {#configure-docker}

Если вы устанавливаете {{unified-agent-short-name}} при помощи Docker, вы можете сконфигурировать агент с помощью переменных окружения. Так вам не потребуется редактировать файл конфигурации, расположенный в `/etc/yandex/unified_agent/config.yml`. Список переменных окружения перечислен в таблице ниже.

Переменная окружения | Значение по умолчанию | Описание
-------------------- | --------------------- | --------
`UA_STATUS_PORT` | `16241` | Порт, по которому будет доступен статус работы агента.<br/>Подробнее в разделе [{#T}](./configuration.md#status).
`UA_LOG_PRIORITY` | `NOTICE` | Уровень логирования работы агента.<br/>Подробнее в разделе [{#T}](./configuration.md#agent_log).
`FOLDER_ID` | Обязательный параметр,<br/>не имеющий значения<br/>по умолчанию | Идентификатор каталога, куда будут записываться метрики.<br/>Подробнее в разделе [{#T}](./configuration.md#yc_metrics_output).
`PROC_DIRECTORY` | `/proc` | Директория со смонтированным [procfs](https://ru.wikipedia.org/wiki/Procfs), откуда агент будет получать системные Linux-метрики.<br/>Подробнее в разделе [{#T}](./configuration.md#linux_metrics_input).
`SYS_DIRECTORY` | `/sys` | Директория со смонтированным [sysfs](https://ru.wikipedia.org/wiki/Sysfs), откуда агент будет получать системные Linux-метрики.<br/>Подробнее в разделе [{#T}](./configuration.md#linux_metrics_input).
`UA_LINUX_RESOURCE_CPU`<br/>`UA_LINUX_RESOURCE_MEMORY`<br/>`UA_LINUX_RESOURCE_NETWORK`</br>`UA_LINUX_RESOURCE_STORAGE`<br/>`UA_LINUX_RESOURCE_IO`<br/>`UA_LINUX_RESOURCE_KERNEL` | `basic` | Уровень детализации системных метрик CPU, сети, дисков, системы ввода-вывода и Linux-ядра.<br/>Подробнее в разделе [{#T}](./configuration.md#linux_metrics_input).

#### Что дальше {#what-is-next}

- [Изучите концепции {{ unified-agent-short-name }}](./index.md)
- [Узнайте подробнее о конфигурировании {{ unified-agent-short-name }}](./configuration.md)
- [Ознакомьтесь с рекомендациями по эксплуатации {{ unified-agent-short-name }}](./best-practices.md)
