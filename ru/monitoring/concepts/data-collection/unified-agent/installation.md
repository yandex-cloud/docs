# Установка и запуск Yandex Unified Agent

## Подготовка к установке { #before-you-begin }

Перед установкой {{unified-agent-full-name}} выполните следующие шаги:

1. Создайте виртуальную машину в {{ yandex-cloud }} или хост вне {{ yandex-cloud }} на операционной системе Ubuntu 14.04 или страше;

1. Для варианта запуска {{unified-agent-short-name}} через Docker:
  - [установите Docker](https://docs.docker.com/install/);
  - настройте публичный IPv4-адрес (рекомендуется);
  - при невозможности использовать публичный IPv4-адрес, [настройте Docker для работы с IPv6](https://docs.docker.com/config/daemon/ipv6) и [включите сетевую трансляцию адресов](https://medium.com/@skleeschulte/how-to-enable-ipv6-for-docker-containers-on-ubuntu-18-04-c68394a219a2).

1. [Создайте сервисный аккаунт](../../../../iam/operations/sa/create.md) в каталоге, куда будут записываться метрики, и [назначьте ему роль](../../../../iam/operations/sa/assign-role-for-sa.md) `editor`.

1. [Привяжите сервисный аккаунт](../../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) к виртуальной машине, на которую установлен агент.

## Установка { #setup }

Установите {{unified-agent-short-name}} одним из способов:

{% list tabs %}

- Docker-образ

  {{unified-agent-short-name}} распространяется в виде Docker-образа. Образ опубликован в репозитории `cr.yandex` с названием `unified_agent` и тегом `latest`. Образ содержит бинарный файл с агентом и конфигурационный файл, настраивающий агент для [поставки системных метрик Linux](../../../operations/unified-agent/linux_metrics.md).

  Конфигурационный файл расположен в `/etc/yandex/unified_agent/config.yml` и параметризован переменными окружения. Подробнее параметры запуска Docker-контейнера описаны в разделе [ниже](#configure-docker).

  Чтобы запустить контейнер с агентом, выполните следующую команду, указав в параметре `FOLDER_ID` идентификатор каталога, куда будут записываться метрики:

  {% include [ua-docker-install](../../../../_includes/monitoring/ua-docker-install.md) %}

  Чтобы запустить контейнер с собственным файлом конфигурации, добавьте в команду запуска контейнера параметр `-v`, указав путь до файла конфигурации. Например:

  ```bash
    docker run \
      -p 16241:16241 -it --detach --uts=host \
      --name=ua \
      -v \/proc:/ua_proc \
      -v config.yml:/etc/yandex/unified_agent/conf.d/config.yml
      -e PROC_DIRECTORY=/ua_proc \
      -e FOLDER_ID=a1bs... \
      cr.yandex/yc/unified-agent
  ```

- deb-пакет

  {{unified-agent-short-name}} распространяется в виде deb-пакета для операционных систем Ubuntu 14.04 или старше. Пакет содержит бинарный файл с агентом и пустой конфигурационный файл, расположенный в `/etc/yandex/unified_agent/config.yml`.

  Чтобы скачать deb-пакет при помощи утилиты `wget`, выполните команду:

  ```bash
  wget --quiet https://storage.yandexcloud.net/yc-unified-agent/builds/binary/21.2.1/deb/ubuntu-20.04-focal/yandex-unified-agent.20.11.4/yandex-unified-agent_21.2.1_amd64.deb
  ```

  Чтобы установить deb-пакет, выполните команду:

  ```bash
  sudo dpkg -i ./yandex-unified-agent_20.11.4_amd64.deb
  ```

  Чтобы убедиться, что {{unified-agent-short-name}} успешно установлен и запущен выполните команду `service unified-agent status`. Пример работы команды:

  ```bash
  user@my-vm:~$ service unified-agent status
  unified-agent.service - Yandex Unified Agent service
     Loaded: loaded (/lib/systemd/system/unified-agent.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2021-02-09 15:57:08 UTC; 6 days ago
   Main PID: 141403 (unified_agent)
      Tasks: 8 (limit: 507)
     Memory: 10.5M
     CGroup: /system.slice/unified-agent.service
             └─141403 /usr/bin/unified_agent --config /etc/yandex/unified_agent/config.yml --log-priority NOTICE
  ```

  После установки пакета, отредактируйте файл конфигурации `/etc/yandex/unified_agent/config.yml`, например, настроив агент для [поставки системных метрик Linux](../../../operations/unified-agent/linux_metrics.md). Подробнее про конфигурацию агента читайте в разделе [{#T}](./configuration.md).

- Бинарный файл

  {{unified-agent-short-name}} распространяется в виде бинарного файла, собранного под архитектуру x86-64 / amd64 для операционных систем Ubuntu 14.04 или старше.

  Чтобы скачать бинарный файл при помощи утилиты `wget`, выполните команду:

  ```bash
  wget --quiet https://storage.yandexcloud.net/yc-unified-agent/builds/binary/21.2.1/unified_agent
  ```

  После скачивания файла с агентом, создайте конфигурационный файл, например, с настройками для [поставки системных метрик Linux](../../../operations/unified-agent/linux_metrics.md). Подробнее про конфигурацию агента читайте в разделе [{#T}](./configuration.md).

  Чтобы запустить агент, выполните команду, указав путь до конфигурационного файла в параметре `--config`:

  ```bash
  ./unified_agent --config unified_agent.yml
  ```

{% endlist %}

## Параметры запуска Docker-контейнера с Unified Agent { #configure-docker }

Если вы устанавливаете {{unified-agent-short-name}} при помощи Docker, вы можете сконфигурировать агент с помощью переменных окружения, чтобы не редактировать файл конфигурации по умолчанию расположенный в `/etc/yandex/unified_agent/config.yml`. Список переменных окружения перечислен в таблице ниже.

Переменная окружения | Значение по умолчанию | Описание
-------------------- | --------------------- | --------
`UA_STATUS_PORT` | `16241` | Порт, по которому будет доступен статус работы агента.<br/>Подробнее в разделе [{#T}](./configuration.md#status).
`UA_LOG_PRIORITY` | `NOTICE` | Уровень логирования работы агента.<br/>Подробнее в разделе [{#T}](./configuration.md#agent_log).
`FOLDER_ID` | Обязательный параметр,<br/>не имеющий значения<br/>по умолчанию | Идентификатор каталога, куда будут записываться метрики.<br/>Подробнее в разделе [{#T}](./configuration.md#yc_metrics_output).
`PROC_DIRECTORY` | `/proc` | Директория со смонтированным [procfs](https://ru.wikipedia.org/wiki/Procfs), откуда агент будет получать системные Linux-метрики.<br/>Подробнее в разделе [{#T}](./configuration.md#linux_metrics_input).
`SYS_DIRECTORY` | `/sys` | Директория со смонтированным [sysfs](https://ru.wikipedia.org/wiki/Sysfs), откуда агент будет получать системные Linux-метрики.<br/>Подробнее в разделе [{#T}](./configuration.md#linux_metrics_input).
`UA_LINUX_RESOURCE_CPU`<br/>`UA_LINUX_RESOURCE_MEMORY`<br/>`UA_LINUX_RESOURCE_NETWORK`</br>`UA_LINUX_RESOURCE_STORAGE`<br/>`UA_LINUX_RESOURCE_IO`<br/>`UA_LINUX_RESOURCE_KERNEL` | `basic` | Уровень детализации системных метрик CPU, сети, дисков, системы ввода-вывода и Linux-ядра.<br/>Подробнее в разделе [{#T}](./configuration.md#linux_metrics_input).

## Что дальше {#next-steps}

- [Изучите концепции Unified Agent](index.md)
- [Узнайте подробнее о конфигурировании Unified Agent](configuration.md)
- [Ознакомьтесь с рекомендациями по эксплуатации Unified Agent](best-practices.md)
