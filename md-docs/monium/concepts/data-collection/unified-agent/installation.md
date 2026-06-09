# Установка и обновление {{ unified-agent-full-name }}

{% note info %}

{{ unified-agent-short-name }} с версии 25.03.80 может собирать и передавать метрики {{ prometheus-name }}.

{% endnote %}

Подробнее см. раздел [{#T}](../../../operations/prometheus/ingestion/prometheus-agent.md).

## Список поддерживаемых операционных систем {#supported-os}

Работа {{ unified-agent-short-name }} поддерживается на следующих операционных системах:

- Ubuntu 16.04 или выше (возможна [установка любым из способов](#setup));
- Debian 9 или выше (Docker-образ, deb-пакет или бинарный файл);
- CentOS 7 или выше (Docker-образ);
- Fedora 32 или выше (Docker-образ);
- Fedora CoreOS (Docker-образ).

## Подготовка к установке {#before-you-begin}

Перед установкой {{ unified-agent-full-name }} выполните следующие шаги:

1. Создайте виртуальную машину в {{ yandex-cloud }} или хост вне {{ yandex-cloud }} на одной из [поддерживаемых операционных систем](#supported-os), например Ubuntu 16.04 или выше.

1. (Опционально) [Установите Docker](https://docs.docker.com/install/), если через него вы хотите запускать {{ unified-agent-short-name }}. Docker уже предустановлен в Fedora CoreOS.
   - Настройте публичный IPv4-адрес (рекомендуется).
   - [Настройте Docker для работы с IPv6](https://docs.docker.com/config/daemon/ipv6) и [включите сетевую трансляцию адресов](https://medium.com/@skleeschulte/how-to-enable-ipv6-for-docker-containers-on-ubuntu-18-04-c68394a219a2), если вы не можете использовать публичный IPv4-адрес.

1. [Создайте сервисный аккаунт](../../../../iam/operations/sa/create.md) в каталоге, куда будут записываться метрики, и [назначьте ему роль](../../../../iam/operations/sa/assign-role-for-sa.md) `{{ roles-monitoring-editor }}`.

1. Настройте авторизацию агента в {{ monium-name }} API:
   - Если агент установлен на виртуальную машину в {{ yandex-cloud }}, [привяжите созданный сервисный аккаунт](../../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) к виртуальной машине. В этом случае агент будет автоматически получать IAM-токен сервисного аккаунта из сервиса метаданных.
   - Если агент установлен на хосте вне {{ yandex-cloud }}, [создайте авторизованный ключ](../../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) для сервисного аккаунта. Подробнее про поставку метрик с хостов вне {{ yandex-cloud }} читайте в разделе [{#T}](../../../operations/unified-agent/non-yc.md).

## Установка {#setup}

Установите {{ unified-agent-short-name }} одним из способов:

{% list tabs group=unified_agent %}

- Docker-образ {#docker}

  Установите Docker Engine. Воспользуйтесь [инструкцией](https://docs.docker.com/engine/install/#supported-platforms) по установке и запуску Docker для вашей операционной системы.

  {{ unified-agent-short-name }} распространяется в виде Docker-образа. Образ опубликован в репозитории `{{ registry }}/yc` с названием `unified_agent` и тегом `latest`. Образ содержит бинарный файл с агентом и конфигурационный файл, настраивающий агент для [поставки системных метрик Linux](../../../operations/unified-agent/linux_metrics.md) в {{ monium-name }}.

  Чтобы загрузить Docker-образ, выполните команду:

  ```bash
  sudo docker pull {{ registry }}/yc/unified-agent:latest
  ```

- deb-пакет {#deb}

  {{ unified-agent-short-name }} распространяется в виде deb-пакета для операционных систем Ubuntu 16.04 и выше, Debian 9 и выше. Пакет содержит бинарный файл с агентом и конфигурационный файл, расположенный в `/etc/yandex/unified_agent/config.yml`.

  Чтобы установить {{ unified-agent-short-name }}:

  1. Скачайте последнюю версию deb-пакета:
  
      ```bash
      ubuntu_name="<полное_название_версии_ОС>" \
      ua_version=$(curl --silent https://{{ s3-storage-host }}/yc-unified-agent/latest-version) \
      bash -c 'curl --silent --remote-name https://{{ s3-storage-host }}/yc-unified-agent/releases/${ua_version}/deb/${ubuntu_name}/yandex-unified-agent_${ua_version}_amd64.deb'
      ```
  
      Где `ubuntu_name` — идентификатор версии операционной системы в формате `ubuntu-<номер_версии>-<кодовое_имя>`. Указывайте значение точно так, как оно используется в имени каталога пакета:
  
      * `ubuntu-16.04-xenial`
      * `ubuntu-18.04-bionic`
      * `ubuntu-20.04-focal`
      * `ubuntu-22.04-jammy` (начиная с версии `23.03.02`)
      * `ubuntu-24.04-noble`
  
      {% note info %}
  
      При установке {{ unified-agent-short-name }} на Debian 9 поддерживаются deb-пакеты только для `ubuntu-16.04-xenial` и ниже, на Debian 10 — для `ubuntu-18.04-bionic` и ниже.
  
      {% endnote %}
  
      Если вы не знаете точное значение `ubuntu_name`, выведите список доступных вариантов для последней версии {{ unified-agent-short-name }}:
  
      ```bash
      ua_version=$(curl --silent https://{{ s3-storage-host }}/yc-unified-agent/latest-version)
      aws s3 ls s3://yc-unified-agent/releases/${ua_version}/deb/ \
        --endpoint-url https://{{ s3-storage-host }} \
        --no-sign-request | awk '{print $2}' | tr -d '/'
      ```
  
      Также вы можете скачать определенную версию {{ unified-agent-short-name }}. Для этого посмотрите список доступных версий и укажите нужную вместо значения `latest-version`:
  
      ```bash
      curl --silent https://{{ s3-storage-host }}/yc-unified-agent/all-versions
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
  
  1. Чтобы убедиться, что {{ unified-agent-short-name }} успешно установлен и запущен, выполните команду:
     
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


  При установке {{ unified-agent-short-name }} выполняются действия:
  
  * Установка исполняемого файла `unified_agent`.
  
  * Установка базового файла конфигурации `/etc/yc/unified_agent/config.yml`. В конфигурации настроена отправка [базовых метрик виртуальной машины](../../../../monitoring/concepts/data-collection/unified-agent/inputs.md#linux_metrics_input) и [метрик здоровья агента](../../../../monitoring/concepts/data-collection/unified-agent/inputs.md#agent_metrics_input). Отправка метрик [тарифицируется](../../../../monitoring/pricing.md).
  
      Дополнительно можно [настроить](../../../../monitoring/concepts/data-collection/unified-agent/configuration.md) поставку собственных метрик или [логов в {{ cloud-logging-name }}](../../../../monitoring/concepts/data-collection/unified-agent/outputs.md#yc_logs_output).
  
  * Конфигурация системы инициализации, добавление нового сервиса `unified-agent`. Сервис запускается при старте системы.
  
  * Создание пользователя `unified_agent` с uid `1515` и одноименной группы с gid `1515`.
  
      Если данные uid или gid недоступны (заняты), пользователь и группа создаются без указания явного uid и gid.
  
  * Создание и настройка доступа к директории для пользовательской конфигурации `/etc/yandex/unified_agent/conf.d`.
  
  * Создание и настройка доступа к директории для пользовательского хранилища `/var/lib/yandex/unified_agent`.

- Бинарный файл {#binary}

  {{ unified-agent-short-name }} распространяется в виде бинарного файла, собранного под архитектуру x86-64/amd64 для операционных систем Ubuntu 16.04 и выше.

  Чтобы скачать последнюю версию агента в виде бинарного файла, выполните команду:

  ```bash
  ua_version=$(curl --silent https://{{ s3-storage-host }}/yc-unified-agent/latest-version) \
  bash -c 'curl --silent --remote-name https://{{ s3-storage-host }}/yc-unified-agent/releases/$ua_version/unified_agent && chmod +x ./unified_agent'
  ```

- При создании ВМ {#vm}

  Вы можете установить {{ unified-agent-short-name }} при создании виртуальной машины в консоли управления, через CLI, API или {{ TF }}.

  Чтобы установить агент из [консоли управления]({{ link-console-main }}), в блоке **{{ ui-key.yacloud.compute.instances.create.section_monitoring }}** включите опцию **{{ ui-key.yacloud.compute.instances.create.unified-agent }}**.

  Чтобы установить агент через CLI, API или {{ TF }}, укажите в [пользовательских метаданных](../../../../compute/concepts/metadata/sending-metadata.md) (`user-data`) строку:

  
  ```text
  #cloud-config\nruncmd:\n  - wget -O - https://monitoring.{{ api-host }}/monitoring/v2/unifiedAgent/config/install.sh | bash
  ```




  Для установки агента и отправки метрик у виртуальной машины должен быть доступ в интернет.

  При установке {{ unified-agent-short-name }} выполняются действия:
  
  * Установка исполняемого файла `unified_agent`.
  
  * Установка базового файла конфигурации `/etc/yc/unified_agent/config.yml`. В конфигурации настроена отправка [базовых метрик виртуальной машины](../../../../monitoring/concepts/data-collection/unified-agent/inputs.md#linux_metrics_input) и [метрик здоровья агента](../../../../monitoring/concepts/data-collection/unified-agent/inputs.md#agent_metrics_input). Отправка метрик [тарифицируется](../../../../monitoring/pricing.md).
  
      Дополнительно можно [настроить](../../../../monitoring/concepts/data-collection/unified-agent/configuration.md) поставку собственных метрик или [логов в {{ cloud-logging-name }}](../../../../monitoring/concepts/data-collection/unified-agent/outputs.md#yc_logs_output).
  
  * Конфигурация системы инициализации, добавление нового сервиса `unified-agent`. Сервис запускается при старте системы.
  
  * Создание пользователя `unified_agent` с uid `1515` и одноименной группы с gid `1515`.
  
      Если данные uid или gid недоступны (заняты), пользователь и группа создаются без указания явного uid и gid.
  
  * Создание и настройка доступа к директории для пользовательской конфигурации `/etc/yandex/unified_agent/conf.d`.
  
  * Создание и настройка доступа к директории для пользовательского хранилища `/var/lib/yandex/unified_agent`.


  После разворачивания ВМ {{ unified-agent-short-name }} запустится автоматически и начнет передавать базовые метрики ВМ в {{ monium-name }}.

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

  1. [Запустите](run-and-stop.md#run) контейнер.

- deb-пакет {#deb}

  Заново скачайте и [установите](#setup) deb-пакет последней версии.

- Бинарный файл {#binary}

  1. Удалите существующий бинарный файл агента.
  1. Скачайте последнюю версию агента в виде бинарного файла:
  
      ```bash
      ua_version=$(curl --silent https://{{ s3-storage-host }}/yc-unified-agent/latest-version) \
      bash -c 'curl --silent --remote-name https://{{ s3-storage-host }}/yc-unified-agent/releases/$ua_version/unified_agent && chmod +x ./unified_agent'
      ```
  
  1. После скачивания исполняемого файла с агентом создайте конфигурационный файл, например, с настройками для [поставки системных метрик Linux](../../../../monitoring/operations/unified-agent/linux_metrics.md). Подробнее про конфигурацию агента см. в разделе [{#T}](../../../../monitoring/concepts/data-collection/unified-agent/configuration.md).
  
  
  1. Переместите скачанный файл в папку `/bin/unified_agent`.
  1. [Перезапустите](../../../../monitoring/concepts/data-collection/unified-agent/run-and-stop.md#run) агент.
  
  Чтобы узнать все доступные версии агента, выполните команду:
  
  ```(bash)
  curl --silent https://{{ s3-storage-host }}/yc-unified-agent/all-versions
  ```

- При создании ВМ {#vm}

  1. Удалите существующий бинарный файл агента.
  1. Скачайте последнюю версию агента в виде бинарного файла:
  
      ```bash
      ua_version=$(curl --silent https://{{ s3-storage-host }}/yc-unified-agent/latest-version) \
      bash -c 'curl --silent --remote-name https://{{ s3-storage-host }}/yc-unified-agent/releases/$ua_version/unified_agent && chmod +x ./unified_agent'
      ```
  
  1. После скачивания исполняемого файла с агентом создайте конфигурационный файл, например, с настройками для [поставки системных метрик Linux](../../../../monitoring/operations/unified-agent/linux_metrics.md). Подробнее про конфигурацию агента см. в разделе [{#T}](../../../../monitoring/concepts/data-collection/unified-agent/configuration.md).
  
  
  1. Переместите скачанный файл в папку `/bin/unified_agent`.
  1. [Перезапустите](../../../../monitoring/concepts/data-collection/unified-agent/run-and-stop.md#run) агент.
  
  Чтобы узнать все доступные версии агента, выполните команду:
  
  ```(bash)
  curl --silent https://{{ s3-storage-host }}/yc-unified-agent/all-versions
  ```

{% endlist %}

## Пример установки и настройки {#example}

В данном примере {{ unified-agent-short-name }} будет установлен из deb-пакета и настроен для сбора метрик.

Чтобы установить и настроить {{ unified-agent-short-name }} на виртуальной машине, выполните следующие шаги:

1. [Создайте сервисный аккаунт](../../../../iam/operations/sa/create.md) в каталоге, куда будут записываться метрики, и [назначьте ему роль](../../../../iam/operations/sa/assign-role-for-sa.md) `{{ roles-monitoring-editor }}`.

1. [Создайте](../../../../compute/operations/vm-create/create-linux-vm.md) виртуальную машину, в блоке **{{ ui-key.yacloud.compute.instances.create.section_additional }}** выберите сервисный аккаунт, созданный на предыдущем шаге.

1. [Подключитесь к ВМ по SSH](../../../../compute/operations/vm-connect/ssh.md).

1. Установите {{ unified-agent-short-name }}:

   1. Получите права суперпользователя:

      ```bash
      sudo -i
      ```

   1. Скачайте deb-пакет с последней версией {{ unified-agent-short-name }} для вашей ОС (например, `ubuntu-22.04-jammy`):

      ```bash
      ubuntu_name="ubuntu-22.04-jammy"
      ua_version=$(curl -s https://{{ s3-storage-host }}/yc-unified-agent/latest-version) bash -c 'curl -s -O https://{{ s3-storage-host }}/yc-unified-agent/releases/${ua_version}/deb/${ubuntu_name}/yandex-unified-agent_${ua_version}_amd64.deb'
      ```

      Команда найдет последнюю версию {{ unified-agent-short-name }} и скачает deb-пакет на ВМ.

   1. Установите версию {{ unified-agent-short-name }} из скачанного пакета (например, `24.07.02`):

      ```bash
      dpkg -i yandex-unified-agent_24.07.02_amd64.deb
      ```

   1. Проверьте статус {{ unified-agent-short-name }}:

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

1. Настройте {{ unified-agent-short-name }}:

   1. Откройте конфигурационный файл {{ unified-agent-short-name }}:

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

   1. Перезапустите {{ unified-agent-short-name }}:

      ```bash
      systemctl restart unified-agent.service
      ```

   1. Проверьте статус {{ unified-agent-short-name }}:

      ```bash
      systemctl status unified-agent.service
      ```
      
Проверьте собираемые метрики:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в который собираются метрики.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_monium }}**.
  1. На панели слева выберите ![image](../../../../_assets/console-icons/rectangle-pulse.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
  1. В редакторе запроса в строке ![image](../../../../_assets/monitoring/chart.svg) с именем нужного облака и каталога выберите:
     * `service` = `custom`;
     * `cluster` = `default`;
     * `name` = `memory.Active`;
     * `host` = `<имя_ВМ>`.
  1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**.
     На появившемся графике отобразятся метрики, которые собирает {{ unified-agent-short-name }}.

{% endlist %}

#### Что дальше {#what-is-next}

- [Узнайте, как запустить и остановить {{ unified-agent-short-name }}](run-and-stop.md)
- [Изучите концепции {{ unified-agent-short-name }}](index.md)
- [Узнайте подробнее о конфигурировании {{ unified-agent-short-name }}](configuration.md)
- [Ознакомьтесь с рекомендациями по эксплуатации {{ unified-agent-short-name }}](best-practices.md)