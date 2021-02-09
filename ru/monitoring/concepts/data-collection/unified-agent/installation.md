# Установка и запуск

## Подготовка к установке { #before-you-begin }

Перед установкой {{unified-agent-full-name}} убедитесь, что выполнены следующие условия:

- запущена виртуальная машина (или хост за пределами Яндекс.Облака), работающая на Linux-совместимой операционной системе (например, Ubuntu 20.04);

- (опционально) на виртуальной машине или хосте установлен [Docker](https://docs.docker.com/install/);
  - виртуальная машина или хост имеют белый IPv4-адрес (рекомендуется при использовании Docker);
  - при невозможности использовать белый IPv4-адрес, обратитесь с разделу [{#T}](#docker-with-ipv6);

- создан сервисный аккаунт с ролью `editor` в каталоге, куда будут записываться метрики;
  - подробнее необходимые для этого шаги описаны в разделах [{#T}](../../../../iam/operations/sa/create.md) и [{#T}](../../../../iam/operations/sa/assign-role-for-sa.md).

- сервисный аккаунт [привязан к виртуальной машине](../../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance), на которую установлен агент.

## Установка { #setup }

Установите {{unified-agent-short-name}} одним из способов:

{% list tabs %}

- Docker-образ

  Docker-образ опубликован в репозитории cr.yandex с названием `unified_agent` и тегом `latest`.

  Чтобы установить {{unified-agent-short-name}} в виде Docker-образа, выполните следующую команду, , заменив строку `<FOLDER_ID>` на идентификатор каталога, куда будут записываться метрики:

  {% include [ua-docker-install](../../../../_includes/monitoring/ua-docker-install.md) %}

- deb-пакет

  Чтобы скачать deb-пакет при помощи утилиты `wget`, выполните команду:

  ```bash
  wget --quiet https://storage.yandexcloud.net/yc-unified-agent/builds/binary/21.2.1/deb/ubuntu-20.04-focal/yandex-unified-agent.20.11.4/yandex-unified-agent_21.2.1_amd64.deb
  ```

  Чтобы установите пакет, выполните команду:

  ```bash
  sudo dpkg -i ./yandex-unified-agent_20.11.4_amd64.deb
  ```

- Бинарный файл

  Бинарный файл, собранный под архитектуру x86-64 / amd64 для Linux-совместимых операционных систем расположен по адресу `https://storage.yandexcloud.net/yc-unified-agent/builds/binary/21.2.1/unified_agent`.

  Чтобы запустить агент, выполните следующую команду, указав путь до конфигурационного файла в параметре `--config`:

  ```bash
  ./unified_agent --config unified_agent.yml
  ```

{% endlist %}

## Конфигурирование Docker-образа Unified Agent { #configure-docker }

Если вы устанавливаете {{unified-agent-short-name}} при помощи Docker-образа, вы можете сконфигурировать агент с помощью переменных окружения, чтобы не редактировать файл конфигурации по умолчанию `/etc/yandex/unified_agent/config.yml`. Список переменных окружения, которыми можно управлять, перечислен в таблице ниже.

Переменная окружения | Значение по умолчанию | Описание
-------------------- | --------------------- | --------
`UA_STATUS_PORT` | `16241` | Порт, по которому будет доступен статус работы агента.<br/>Подробнее в разделе [{#T}](./configuration.md#status).
`UA_LOG_PRIORITY` | `NOTICE` | Уровень логирования работы агента.<br/>Подробнее в разделе [{#T}](./configuration.md#agent_log)
`UA_CLOUD_MONITORING_URL` | `https://monitoring.api.cloud.yandex.net/monitoring/v2/data/write` | URL {{ monitoring-full-name }} API, по которому будут передаваться метрики.<br/>Подробнее в разделе [{#T}](./configuration.md#yc_metrics_output).
`FOLDER_ID` | N/A | Идентификатор каталога, куда будут записываться метрики.<br/>Подробнее в разделе [{#T}](./configuration.md#yc_metrics_output).
`PROC_DIRECTORY` | `/proc` | Директория со смонтированным [procfs](https://ru.wikipedia.org/wiki/Procfs), откуда агент будет получать системные Linux-метрики.<br/>Подробнее в разделе [{#T}](./configuration.md#linux_metrics_input).
`SYS_DIRECTORY` | `/sys` | Директория со смонтированным [sysfs](https://ru.wikipedia.org/wiki/Sysfs), откуда агент будет получать системные Linux-метрики.<br/>Подробнее в разделе [{#T}](./configuration.md#linux_metrics_input).
`UA_LINUX_RESOURCE_CPU`<br/>`UA_LINUX_RESOURCE_MEMORY`<br/>`UA_LINUX_RESOURCE_NETWORK`</br>`UA_LINUX_RESOURCE_STORAGE`<br/>`UA_LINUX_RESOURCE_IO`<br/>`UA_LINUX_RESOURCE_KERNEL` | `basic` | Уровень детализации системных метрик CPU, сети, дисков, системы ввода-вывода и Linux-ядра.<br/>Подробнее в разделе [{#T}](./configuration.md#linux_metrics_input).

## Использование Docker вместе с IPv6 { #docker-with-ipv6 }

Чтобы настроить работу Docker с IPv6, выполните следующие шаги:

1. Отредактируйте файл `sudo vim /etc/docker/daemon.json` и добавьте в него следующие строки:
```json
{
    "ipv6": true,
    "fixed-cidr-v6": "fd00::/80"
}
```

1. Включите трансляцию сетевых адресов:
```bash
sudo apt install iptables-persistent netfilter-persistent -y
sudo systemctl start netfilter-persistent
sudo systemctl enable netfilter-persistent
sudo iptables -P FORWARD ACCEPT
sudo ip6tables -t nat -A POSTROUTING -s fd00::/80 ! -o docker0 -j MASQUERADE
sudo netfilter-persistent save
```

1. Перезапустите Docker:
```bash
sudo systemctl reload docker
sudo systemctl restart docker
docker network inspect bridge
```

1. Если после этого агент, запущенный в Docker по-прежнему не передает метрики, попробуйте выполнить следующие команды:
```bash
sudo ip -6 route add 2001:db8:1::/64 dev docker0
sudo sysctl net.ipv6.conf.default.forwarding=1
sudo sysctl net.ipv6.conf.all.forwarding=1
```

Подробнее в [официальной документации Docker](https://docs.docker.com/config/daemon/ipv6/) и [следующем посте](https://medium.com/@skleeschulte/how-to-enable-ipv6-for-docker-containers-on-ubuntu-18-04-c68394a219a2).

## Что дальше {#next-steps}

- [Изучите концепции Unified Agent](index.md)
- [Узнайте подробнее о конфигурировании Unified Agent](configuration.md)
- [Ознакомьтесь с рекомендациями по эксплуатации Unified Agent](best-practices.md)
