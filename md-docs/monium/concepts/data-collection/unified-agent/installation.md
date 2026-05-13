# Установка и обновление Unified Agent

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

## Подготовка к установке {#before-you-begin}

Перед установкой Unified Agent выполните следующие шаги:

1. Создайте виртуальную машину в Yandex Cloud или хост вне Yandex Cloud на одной из [поддерживаемых операционных систем](#supported-os), например Ubuntu 16.04 или выше.

1. (Опционально) [Установите Docker](https://docs.docker.com/install/), если через него вы хотите запускать Unified Agent. Docker уже предустановлен в Fedora CoreOS.
   - Настройте публичный IPv4-адрес (рекомендуется).
   - [Настройте Docker для работы с IPv6](https://docs.docker.com/config/daemon/ipv6) и [включите сетевую трансляцию адресов](https://medium.com/@skleeschulte/how-to-enable-ipv6-for-docker-containers-on-ubuntu-18-04-c68394a219a2), если вы не можете использовать публичный IPv4-адрес.

1. [Создайте сервисный аккаунт](../../../../iam/operations/sa/create.md) в каталоге, куда будут записываться метрики, и [назначьте ему роль](../../../../iam/operations/sa/assign-role-for-sa.md) `monitoring.editor`.

1. Настройте авторизацию агента в Monium API:
   - Если агент установлен на виртуальную машину в Yandex Cloud, [привяжите созданный сервисный аккаунт](../../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) к виртуальной машине. В этом случае агент будет автоматически получать IAM-токен сервисного аккаунта из сервиса метаданных.
   - Если агент установлен на хосте вне Yandex Cloud, [создайте авторизованный ключ](../../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) для сервисного аккаунта. Подробнее про поставку метрик с хостов вне Yandex Cloud читайте в разделе [Поставка метрик с хостов вне Yandex Cloud](../../../operations/unified-agent/non-yc.md).

## Установка {#setup}

Установите Unified Agent одним из способов:

{% list tabs group=unified_agent %}

- Docker-образ {#docker}

  Установите Docker Engine. Воспользуйтесь [инструкцией](https://docs.docker.com/engine/install/#supported-platforms) по установке и запуску Docker для вашей операционной системы.

  Unified Agent распространяется в виде Docker-образа. Образ опубликован в репозитории `cr.yandex/yc` с названием `unified_agent` и тегом `latest`. Образ содержит бинарный файл с агентом и конфигурационный файл, настраивающий агент для [поставки системных метрик Linux](../../../operations/unified-agent/linux_metrics.md) в Monium.

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
  
  * Установка базового файла конфигурации `/etc/yc/unified_agent/config.yml`. В конфигурации настроена отправка [базовых метрик виртуальной машины](../../../../monitoring/concepts/data-collection/unified-agent/inputs.md#linux_metrics_input) и [метрик здоровья агента](../../../../monitoring/concepts/data-collection/unified-agent/inputs.md#agent_metrics_input). Отправка метрик [тарифицируется](../../../../monitoring/pricing.md).
  
      Дополнительно можно [настроить](../../../../monitoring/concepts/data-collection/unified-agent/configuration.md) поставку собственных метрик или [логов в Monium Logs](../../../../monitoring/concepts/data-collection/unified-agent/outputs.md#yc_logs_output).
  
  * Конфигурация системы инициализации, добавление нового сервиса `unified-agent`. Сервис запускается при старте системы.
  
  * Создание пользователя `unified_agent` с uid `1515` и одноименной группы с gid `1515`.
  
      Если данные uid или gid недоступны (заняты), пользователь и группа создаются без указания явного uid и gid.
  
  * Создание и настройка доступа к директории для пользовательской конфигурации `/etc/yandex/unified_agent/conf.d`.
  
  * Создание и настройка доступа к директории для пользовательского хранилища `/var/lib/yandex/unified_agent`.

- Бинарный файл {#binary}

  Unified Agent распространяется в виде бинарного файла, собранного под архитектуру x86-64/amd64 для операционных систем Ubuntu 16.04 и выше.

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
  
  * Установка базового файла конфигурации `/etc/yc/unified_agent/config.yml`. В конфигурации настроена отправка [базовых метрик виртуальной машины](../../../../monitoring/concepts/data-collection/unified-agent/inputs.md#linux_metrics_input) и [метрик здоровья агента](../../../../monitoring/concepts/data-collection/unified-agent/inputs.md#agent_metrics_input). Отправка метрик [тарифицируется](../../../../monitoring/pricing.md).
  
      Дополнительно можно [настроить](../../../../monitoring/concepts/data-collection/unified-agent/configuration.md) поставку собственных метрик или [логов в Monium Logs](../../../../monitoring/concepts/data-collection/unified-agent/outputs.md#yc_logs_output).
  
  * Конфигурация системы инициализации, добавление нового сервиса `unified-agent`. Сервис запускается при старте системы.
  
  * Создание пользователя `unified_agent` с uid `1515` и одноименной группы с gid `1515`.
  
      Если данные uid или gid недоступны (заняты), пользователь и группа создаются без указания явного uid и gid.
  
  * Создание и настройка доступа к директории для пользовательской конфигурации `/etc/yandex/unified_agent/conf.d`.
  
  * Создание и настройка доступа к директории для пользовательского хранилища `/var/lib/yandex/unified_agent`.


  После разворачивания ВМ Unified Agent запустится автоматически и начнет передавать базовые метрики ВМ в Monium.

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
  
  1. После скачивания исполняемого файла с агентом создайте конфигурационный файл, например, с настройками для [поставки системных метрик Linux](../../../../monitoring/operations/unified-agent/linux_metrics.md). Подробнее про конфигурацию агента см. в разделе [Конфигурирование](../../../../monitoring/concepts/data-collection/unified-agent/configuration.md).
  
  
  1. Переместите скачанный файл в папку `/bin/unified_agent`.
  1. [Перезапустите](../../../../monitoring/concepts/data-collection/unified-agent/run-and-stop.md#run) агент.
  
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
  
  1. После скачивания исполняемого файла с агентом создайте конфигурационный файл, например, с настройками для [поставки системных метрик Linux](../../../../monitoring/operations/unified-agent/linux_metrics.md). Подробнее про конфигурацию агента см. в разделе [Конфигурирование](../../../../monitoring/concepts/data-collection/unified-agent/configuration.md).
  
  
  1. Переместите скачанный файл в папку `/bin/unified_agent`.
  1. [Перезапустите](../../../../monitoring/concepts/data-collection/unified-agent/run-and-stop.md#run) агент.
  
  Чтобы узнать все доступные версии агента, выполните команду:
  
  ```(bash)
  curl --silent https://storage.yandexcloud.net/yc-unified-agent/all-versions
  ```

{% endlist %}

## Пример установки и настройки {#example}

В данном примере Unified Agent будет установлен из deb-пакета и настроен для сбора метрик.

Чтобы установить и настроить Unified Agent на виртуальной машине, выполните следующие шаги:

1. [Создайте сервисный аккаунт](../../../../iam/operations/sa/create.md) в каталоге, куда будут записываться метрики, и [назначьте ему роль](../../../../iam/operations/sa/assign-role-for-sa.md) `monitoring.editor`.

1. [Создайте](../../../../compute/operations/vm-create/create-linux-vm.md) виртуальную машину, в блоке **Дополнительно** выберите сервисный аккаунт, созданный на предыдущем шаге.

1. [Подключитесь к ВМ по SSH](../../../../compute/operations/vm-connect/ssh.md).

1. Установите Unified Agent:

   1. Получите права суперпользователя:

      ```bash
      sudo -i
      ```

   1. Скачайте deb-пакет с последней версией Unified Agent для вашей ОС (например, `ubuntu-22.04-jammy`):

      ```bash
      ubuntu_name="ubuntu-22.04-jammy"
      ua_version=$(curl -s https://storage.yandexcloud.net/yc-unified-agent/latest-version) bash -c 'curl -s -O https://storage.yandexcloud.net/yc-unified-agent/releases/${ua_version}/deb/${ubuntu_name}/yandex-unified-agent_${ua_version}_amd64.deb'
      ```

      Команда найдет последнюю версию Unified Agent и скачает deb-пакет на ВМ.

   1. Установите версию Unified Agent из скачанного пакета (например, `24.07.02`):

      ```bash
      dpkg -i yandex-unified-agent_24.07.02_amd64.deb
      ```

   1. Проверьте статус Unified Agent:

      ```bash
      systemctl status unified-agent.service
      ```

      {% cut "Результат" %}

      ```bash
      unified-agent.service - Yandex Unified Agent service
         Loaded: loaded (/usr/lib/systemd/system/unified-agent.service; enabled; preset: enabled)
         Active: active (running) since Mon 2024-08-19 17:32:24 UTC; 1min 49s ago
       Main PID: 7106 (unified_agent)
          Tasks: 7 (limit: 2275)
         Memory: 3.6M (peak: 3.9M)
            CPU: 19ms
         CGroup: /system.slice/unified-agent.service
                 └─7106 /usr/bin/unified_agent --config /etc/yandex/unified_agent/config.yml --log-priority NOTICE
                  CGroup: /system.slice/unified-agent.service
      
      Aug 19 17:32:24 ua-test-vm systemd[1]: Started unified-agent.service - Yandex Unified Agent service.
      Aug 19 17:32:24 ua-test-vm unified_agent[7106]: 2024-08-19T17:32:24.815279Z 7106 15778840110569512124 NOTICE agent starting, revision [14433827]
      Aug 19 17:32:24 ua-test-vm unified_agent[7106]: 2024-08-19T17:32:24.815307Z 7106  15778840110569512124 NOTICE agent monitoring service [:16300]
      Aug 19 17:32:24 ua-test-vm unified_agent[7106]: 2024-08-19T17:32:24.815632Z 7106 15778840110569512124 NOTICE agent status service [localhost:16301]
      Aug 19 17:32:24 ua-test-vm unified_agent[7106]: 2024-08-19T17:32:24.816002Z 7106  15778840110569512124 NOTICE agent started
      ```

      {% endcut %}

1. Настройте Unified Agent:

   1. Откройте конфигурационный файл Unified Agent:

      ```bash
      vim /etc/yandex/unified_agent/config.yml
      ```

   1. Добавьте в конфигурационный файл настройки для сбора метрик. Итоговый файл должен выглядеть следующим образом:

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
                folder_id: "a1bs81qpemb4********"
                iam:
                  cloud_meta: {}

      routes:
        - input:
            id: linux_metrics_input
            plugin: linux_metrics
            config:
              poll_period: 60s
          channel:
            channel_ref:
              name: yc_metrics_channel

      import:
        - /etc/yandex/unified_agent/conf.d/*.yml
      ```

   1. Перезапустите Unified Agent:

      ```bash
      systemctl restart unified-agent.service
      ```

   1. Проверьте статус Unified Agent:

      ```bash
      systemctl status unified-agent.service
      ```
      
Проверьте собираемые метрики:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в который собираются метрики.
  1. [Перейдите](../../../../console/operations/select-service.md#select-service) в сервис **Monium**.
  1. На панели слева выберите ![image](../../../../_assets/console-icons/rectangle-pulse.svg) **Метрики**.
  1. В редакторе запроса в строке ![image](../../../../_assets/monitoring/chart.svg) с именем нужного облака и каталога выберите:
     * `service` = `custom`;
     * `cluster` = `default`;
     * `name` = `memory.Active`;
     * `host` = `<имя_ВМ>`.
  1. Нажмите **Выполнить запрос**.
     На появившемся графике отобразятся метрики, которые собирает Unified Agent.

{% endlist %}

#### Что дальше {#what-is-next}

- [Узнайте, как запустить и остановить Unified Agent](run-and-stop.md)
- [Изучите концепции Unified Agent](index.md)
- [Узнайте подробнее о конфигурировании Unified Agent](configuration.md)
- [Ознакомьтесь с рекомендациями по эксплуатации Unified Agent](best-practices.md)