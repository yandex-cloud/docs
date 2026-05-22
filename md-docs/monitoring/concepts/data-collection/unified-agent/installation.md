# Установка и обновление Yandex Unified Agent

{% note info %}

Unified Agent с версии 25.03.80 может собирать и передавать метрики Prometheus.

{% endnote %}

Подробнее см. раздел [Агент для сбора метрик Prometheus](../../../operations/prometheus/ingestion/prometheus-agent.md).

## Список поддерживаемых операционных систем {#supported-os}

Работа Unified Agent поддерживается на следующих операционных системах:

- Ubuntu 16.04 или выше (возможна [установка любым из способов](#setup));
- Debian 9 или выше (Docker-образ, deb-пакет или бинарный файл);
- CentOS 7 или выше (Docker-образ);
- Fedora 32 или выше (Docker-образ);
- Fedora CoreOS (Docker-образ).


<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvmbl3hthmrm47cpx2?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

[Смотреть видео на YouTube](https://www.youtube.com/watch?v=EY6c_6YYF10).




## Подготовка к установке {#before-you-begin}

Перед установкой Yandex Unified Agent выполните следующие шаги:

1. Создайте виртуальную машину в Yandex Cloud или хост вне Yandex Cloud на одной из [поддерживаемых операционных систем](#supported-os), например, Ubuntu 16.04 или выше.

1. (Опционально) [Установите Docker](https://docs.docker.com/install/), если через него вы хотите запускать Unified Agent. Docker уже предустановлен в Fedora CoreOS.
   - Настройте публичный IPv4-адрес (рекомендуется).
   - [Настройте Docker для работы с IPv6](https://docs.docker.com/config/daemon/ipv6) и [включите сетевую трансляцию адресов](https://medium.com/@skleeschulte/how-to-enable-ipv6-for-docker-containers-on-ubuntu-18-04-c68394a219a2), если вы не можете использовать публичный IPv4-адрес.

1. [Создайте сервисный аккаунт](../../../../iam/operations/sa/create.md) в каталоге, куда будут записываться метрики, и [назначьте ему роль](../../../../iam/operations/sa/assign-role-for-sa.md) `monitoring.editor`.

1. Настройте авторизацию агента в Yandex Monitoring API:
   - Если агент установлен на виртуальную машину в Yandex Cloud, [привяжите созданный сервисный аккаунт](../../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) к виртуальной машине. В этом случае агент будет автоматически получать IAM-токен сервисного аккаунта из сервиса-метаданных.
   - Если агент установлен на хосте вне Yandex Cloud, [создайте авторизованный ключ](../../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) для сервисного аккаунта. Подробнее про поставку метрик с хостов вне Yandex Cloud читайте в разделе [Поставка метрик с хостов вне Yandex Cloud](../../../operations/unified-agent/non-yc.md).


## Установка {#setup}

Установите Unified Agent одним из способов:

{% list tabs group=unified_agent %}

- Docker-образ {#docker}

  Установите Docker Engine. Воспользуйтесь [инструкцией](https://docs.docker.com/engine/install/#supported-platforms) по установке и запуску Docker для вашей операционной системы.

  Unified Agent распространяется в виде Docker-образа. Образ опубликован в репозитории `cr.yandex/yc` с названием `unified_agent` и тегом `latest`. Образ содержит бинарный файл с агентом и конфигурационный файл, настраивающий агент для [поставки системных метрик Linux](../../../operations/unified-agent/linux_metrics.md) в Yandex Monitoring.

  Чтобы загрузить Docker-образ, выполните команду:

  ```bash
  sudo docker pull cr.yandex/yc/unified-agent:latest
  ```

- deb-пакет {#deb}

  Unified Agent распространяется в виде deb-пакета для операционных систем Ubuntu 16.04 и выше, Debian 9 и выше. Пакет содержит бинарный файл с агентом и конфигурационный файл, расположенный в `/etc/yandex/unified_agent/config.yml`.

  Чтобы установить Unified Agent:

  1. Скачайте последнюю версию deb-пакета:
  
      ```bash
      ubuntu_name="<версия_ОС>" \
      ua_version=$(curl --silent https://storage.yandexcloud.net/yc-unified-agent/latest-version) \
      bash -c 'curl --silent --remote-name https://storage.yandexcloud.net/yc-unified-agent/releases/${ua_version}/deb/${ubuntu_name}/yandex-unified-agent_${ua_version}_amd64.deb'
      ```
  
      Где `ubuntu_name` — версия операционной системы:
  
      * `ubuntu-16.04-xenial`
      * `ubuntu-18.04-bionic`
      * `ubuntu-20.04-focal`
      * `ubuntu-22.04-jammy` (начиная с версии `23.03.02`)
      * `ubuntu-24.04-noble`
  
      {% note info %}
  
      При установке Unified Agent на Debian 9 поддерживаются deb-пакеты только для `ubuntu-16.04-xenial` и ниже, на Debian 10 — для `ubuntu-18.04-bionic` и ниже.
  
      {% endnote %}
  
      Также вы можете скачать определенную версию Unified Agent. Для этого посмотрите список доступных версий и укажите нужную вместо значения `latest-version`:
  
      ```bash
      curl --silent https://storage.yandexcloud.net/yc-unified-agent/all-versions
      ```
  
  1. Посмотрите версию скачанного deb-пакета с помощью команды `ls`.
  
      Результат:
  
      ```bash
      yandex-unified-agent_<версия>_amd64.deb
      ```
  
      Где `<версия>` — версия скачанного deb-пакета, например `24.12.01`.
  
  1. Для установки скачанного deb-пакета выполните команду:
  
      ```bash
      sudo dpkg -i yandex-unified-agent_<версия>_amd64.deb
      ```
  
  1. Чтобы убедиться, что Unified Agent успешно установлен и запущен, выполните команду:
     
     ```bash
     systemctl status unified-agent
     ```
     
     Результат:
     
     ```bash
     ● unified-agent.service - Yandex Unified Agent service
          Loaded: loaded (/lib/systemd/system/unified-agent.service; enabled; vendor preset: enabled)
          Active: active (running) since Wed 2025-10-01 08:49:44 UTC; 27min ago
        Main PID: 1106 (unified_agent)
           Tasks: 8 (limit: 2308)
          Memory: 5.2M
             CPU: 136ms
          CGroup: /system.slice/unified-agent.service
                  └─1106 /usr/bin/unified_agent --config /etc/yandex/unified_agent/config.yml --log-priority NOTICE
     ```


  При установке Unified Agent выполняются действия:
  
  * Установка исполняемого файла `unified_agent`.
  
  * Установка базового файла конфигурации `/etc/yc/unified_agent/config.yml`. В конфигурации настроена отправка [базовых метрик виртуальной машины](inputs.md#linux_metrics_input) и [метрик здоровья агента](inputs.md#agent_metrics_input). Отправка метрик [тарифицируется](../../../pricing.md).
  
      Дополнительно можно [настроить](configuration.md) поставку собственных метрик или [логов в Cloud Logging](outputs.md#yc_logs_output).
  
  * Конфигурация системы инициализации, добавление нового сервиса `unified-agent`. Сервис запускается при старте системы.
  
  * Создание пользователя `unified_agent` с uid `1515` и одноименной группы с gid `1515`.
  
      Если данные uid или gid недоступны (заняты), пользователь и группа создаются без указания явного uid и gid.
  
  * Создание и настройка доступа к директории для пользовательской конфигурации `/etc/yandex/unified_agent/conf.d`.
  
  * Создание и настройка доступа к директории для пользовательского хранилища `/var/lib/yandex/unified_agent`.

- Бинарный файл {#binary}

  Unified Agent распространяется в виде бинарного файла, собранного под архитектуру x86-64 / amd64 для операционных систем Ubuntu 16.04 и выше.

  Чтобы скачать последнюю версию агента в виде бинарного файла, выполните команду:

  ```bash
  ua_version=$(curl --silent https://storage.yandexcloud.net/yc-unified-agent/latest-version) \
  bash -c 'curl --silent --remote-name https://storage.yandexcloud.net/yc-unified-agent/releases/$ua_version/unified_agent && chmod +x ./unified_agent'
  ```

- При создании ВМ {#vm}

  Вы можете установить Unified Agent при создании виртуальной машины в консоли управления, через CLI, API или Terraform.

  Чтобы установить агент из [консоли управления](https://console.yandex.cloud), в блоке **Мониторинг** включите опцию **Агент сбора метрик**.

  Чтобы установить агент через CLI, API или Terraform, укажите в [пользовательских метаданных](../../../../compute/concepts/metadata/sending-metadata.md) (`user-data`) строку:

  
  ```text
  #cloud-config\nruncmd:\n  - wget -O - https://monitoring.api.cloud.yandex.net/monitoring/v2/unifiedAgent/config/install.sh | bash
  ```




  Для установки агента и отправки метрик у виртуальной машины должен быть доступ в интернет.

  При установке Unified Agent выполняются действия:
  
  * Установка исполняемого файла `unified_agent`.
  
  * Установка базового файла конфигурации `/etc/yc/unified_agent/config.yml`. В конфигурации настроена отправка [базовых метрик виртуальной машины](inputs.md#linux_metrics_input) и [метрик здоровья агента](inputs.md#agent_metrics_input). Отправка метрик [тарифицируется](../../../pricing.md).
  
      Дополнительно можно [настроить](configuration.md) поставку собственных метрик или [логов в Cloud Logging](outputs.md#yc_logs_output).
  
  * Конфигурация системы инициализации, добавление нового сервиса `unified-agent`. Сервис запускается при старте системы.
  
  * Создание пользователя `unified_agent` с uid `1515` и одноименной группы с gid `1515`.
  
      Если данные uid или gid недоступны (заняты), пользователь и группа создаются без указания явного uid и gid.
  
  * Создание и настройка доступа к директории для пользовательской конфигурации `/etc/yandex/unified_agent/conf.d`.
  
  * Создание и настройка доступа к директории для пользовательского хранилища `/var/lib/yandex/unified_agent`.


  После разворачивания ВМ Unified Agent запустится автоматически и начнет передавать базовые метрики ВМ в сервис Yandex Monitoring.

  Обновление агента выполняйте вручную через бинарный файл.

{% endlist %}


## Обновление {#update}

Обновите Unified Agent одним из способов:

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

  1. [Запустите](run-and-stop.md#run) контейнер.

- deb-пакет {#deb}

  Заново скачайте и [установите](#setup) deb-пакет последней версии.

- Бинарный файл {#binary}

  1. Удалите существующий бинарный файл агента.
  1. Скачайте последнюю версию агента в виде бинарного файла:
  
      ```bash
      ua_version=$(curl --silent https://storage.yandexcloud.net/yc-unified-agent/latest-version) \
      bash -c 'curl --silent --remote-name https://storage.yandexcloud.net/yc-unified-agent/releases/$ua_version/unified_agent && chmod +x ./unified_agent'
      ```
  
  1. После скачивания исполняемого файла с агентом создайте конфигурационный файл, например, с настройками для [поставки системных метрик Linux](../../../operations/unified-agent/linux_metrics.md). Подробнее про конфигурацию агента см. в разделе [Конфигурирование](configuration.md).
  
  
  1. Переместите скачанный файл в папку `/bin/unified_agent`.
  1. [Перезапустите](run-and-stop.md#run) агент.
  
  Чтобы узнать все доступные версии агента, выполните команду:
  
  ```(bash)
  curl --silent https://storage.yandexcloud.net/yc-unified-agent/all-versions
  ```

- При создании ВМ {#vm}

  1. Удалите существующий бинарный файл агента.
  1. Скачайте последнюю версию агента в виде бинарного файла:
  
      ```bash
      ua_version=$(curl --silent https://storage.yandexcloud.net/yc-unified-agent/latest-version) \
      bash -c 'curl --silent --remote-name https://storage.yandexcloud.net/yc-unified-agent/releases/$ua_version/unified_agent && chmod +x ./unified_agent'
      ```
  
  1. После скачивания исполняемого файла с агентом создайте конфигурационный файл, например, с настройками для [поставки системных метрик Linux](../../../operations/unified-agent/linux_metrics.md). Подробнее про конфигурацию агента см. в разделе [Конфигурирование](configuration.md).
  
  
  1. Переместите скачанный файл в папку `/bin/unified_agent`.
  1. [Перезапустите](run-and-stop.md#run) агент.
  
  Чтобы узнать все доступные версии агента, выполните команду:
  
  ```(bash)
  curl --silent https://storage.yandexcloud.net/yc-unified-agent/all-versions
  ```

{% endlist %}


#### Что дальше {#what-is-next}

- [Узнайте, как запустить и остановить Unified Agent](run-and-stop.md)
- [Изучите концепции Unified Agent](index.md)
- [Узнайте подробнее о конфигурировании Unified Agent](configuration.md)
- [Ознакомьтесь с рекомендациями по эксплуатации Unified Agent](best-practices.md)