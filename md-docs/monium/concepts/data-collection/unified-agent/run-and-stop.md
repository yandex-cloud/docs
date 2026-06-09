# Запуск и остановка Unified Agent

## Запуск {#run}

[Установите](installation.md#setup) Unified Agent и запустите его одним из способов:

{% list tabs group=unified_agent %}

- Docker-образ {#docker}

  Настройте конфигурационный файл агента, который расположен в `/etc/yandex/unified_agent/config.yml` и параметризован переменными окружения. Подробнее параметры запуска Docker-контейнера описаны в разделе [ниже](#configure-docker).

  Чтобы запустить контейнер с агентом, выполните команду:

  ```bash
  sudo docker run \
    -p 16241:16241 -it --detach --uts=host \
    --name=ua \
    -v /proc:/ua_proc \
    -e PROC_DIRECTORY=/ua_proc \
    -e FOLDER_ID=a1bs81qpemb4******** \
    cr.yandex/yc/unified-agent
  ```

  Где `FOLDER_ID` — идентификатор каталога, куда будут записываться метрики.

  Чтобы запустить контейнер с собственным файлом конфигурации, добавьте в команду запуска контейнера параметр `-v`, указав _полный путь_ до файла конфигурации. Перед запуском контейнера удалите из вашего конфигурационного файла строки:

  ```yaml
  import:
  - /etc/yandex/unified_agent/conf.d/*.yml
  ```

  Пример команды для запуска контейнера с пользовательским конфигурационным файлом:

  ```bash
  docker run \
    -p 16241:16241 -it --detach --uts=host \
    --name=ua \
    -v /proc:/ua_proc \
    -v `pwd`/config.yml:/etc/yandex/unified_agent/conf.d/config.yml \
    --entrypoint="" \
    -e PROC_DIRECTORY=/ua_proc \
    -e FOLDER_ID=a1bs81qpemb4******** \
    cr.yandex/yc/unified-agent
  ```

  По умолчанию в конфигурационном файле агента в секции [status](services.md#status) указан `host: null`. Учитывайте это, если используете собственный конфигурационный файл.

  {% note warning %}

  Для мониторинга дополнительных дисков, подключенных к хосту, передайте пути к их точкам монтирования при помощи параметра `-v` команды `docker run`. Подробнее читайте в разделе [Вход linux_metrics](inputs.md#linux_metrics_input).

  {% endnote %}

  Подробнее про конфигурацию агента читайте в разделе [Конфигурирование](configuration.md).

- deb-пакет {#deb}

  Отредактируйте файл конфигурации `/etc/yandex/unified_agent/config.yml`, например, настроив агент для [поставки системных метрик Linux](../../../operations/unified-agent/linux_metrics.md). Подробнее про конфигурацию агента читайте в разделе [Конфигурирование](configuration.md).


  Чтобы убедиться, что Unified Agent успешно установлен и запущен, выполните команду:
  
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

- Бинарный файл {#binary}

  Создайте файл конфигурации, например, с настройками для [поставки системных метрик Linux](../../../operations/unified-agent/linux_metrics.md). Подробнее про конфигурацию агента читайте в разделе [Конфигурирование](configuration.md).


  Чтобы запустить агент, выполните команду:

  ```bash
  ./unified_agent --config unified_agent.yml
  ```

- При создании ВМ {#vm}

  После разворачивания ВМ Unified Agent запустится автоматически и начнет передавать базовые метрики ВМ в сервис Monium Metrics.

  Обновление и поддержка агента выполняются самостоятельно.

  Агент устанавливается с файлом конфигурации по умолчанию, который находится в `/etc/yc/unified_agent/config.yml`. Вы можете [настроить](configuration.md) поставку собственных метрик или [логов в Monium Logs](outputs.md#yc_logs_output).

  В файле конфигурации настроена отправка [базовых метрик виртуальной машины](inputs.md#linux_metrics_input) и [метрик здоровья агента](inputs.md#agent_metrics_input). Отправка метрик [тарифицируется](../../../pricing.md).


  Чтобы запустить агент вручную, выполните команду:

  ```bash
  ./unified_agent --config unified_agent.yml
  ```

{% endlist %}


## Остановка {#stop}

Остановите Unified Agent одним из способов:

{% list tabs group=unified_agent %}

- Docker-образ {#docker}

  Чтобы остановить контейнер, выполните команду:

  ```bash
  sudo docker stop ua
  ```

- deb-пакет {#deb}

  Чтобы остановить агент, выполните команду:

  ```bash
  sudo systemctl stop unified-agent
  ```

  Чтобы перезапустить агент, выполните команду:

  ```bash
  sudo systemctl
  ```

- Бинарный файл {#binary}

  1. Узнайте идентификатор процесса `unified_agent`:
  
      ```bash
      ps aux | grep unified_agent
      ```
  
  1. Чтобы остановить процесс, выполните команду:
  
      ```bash
      sudo kill <идентификатор_процесса>
      ```

- При создании ВМ {#vm}

  1. Узнайте идентификатор процесса `unified_agent`:
  
      ```bash
      ps aux | grep unified_agent
      ```
  
  1. Чтобы остановить процесс, выполните команду:
  
      ```bash
      sudo kill <идентификатор_процесса>
      ```

{% endlist %}

Для завершения работы Unified Agent может потребоваться некоторое время на допоставку накопленных данных. Обычно это занимает до 2 секунд.


## Параметры запуска Docker-контейнера с Unified Agent {#configure-docker}

Если вы устанавливаете Unified Agent при помощи Docker, вы можете сконфигурировать агент с помощью переменных окружения. Так вам не потребуется редактировать файл конфигурации, расположенный в `/etc/yandex/unified_agent/config.yml`. Список переменных окружения перечислен в таблице ниже.

Переменная окружения | Значение по умолчанию | Описание
-------------------- | --------------------- | --------
`UA_STATUS_PORT` | `16241` | Порт, по которому будет доступен [статус работы агента](services.md#status).
`UA_LOG_PRIORITY` | `NOTICE` | Уровень [логирования работы агента](services.md#agent_log).
`FOLDER_ID` | Нет | Идентификатор каталога, куда будут записываться метрики (обязательный параметр).
`PROC_DIRECTORY` | `/proc` | Директория со смонтированным [procfs](https://ru.wikipedia.org/wiki/Procfs), откуда агент будет получать [системные Linux-метрики](inputs.md#linux_metrics_input).
`SYS_DIRECTORY` | `/sys` | Директория со смонтированным [sysfs](https://ru.wikipedia.org/wiki/Sysfs), откуда агент будет получать [системные Linux-метрики](inputs.md#linux_metrics_input).
`UA_LINUX_RESOURCE_CPU`<br/>`UA_LINUX_RESOURCE_MEMORY`<br/>`UA_LINUX_RESOURCE_NETWORK`</br>`UA_LINUX_RESOURCE_STORAGE`<br/>`UA_LINUX_RESOURCE_IO`<br/>`UA_LINUX_RESOURCE_KERNEL` | `basic` | Уровень детализации [системных метрик](inputs.md#linux_metrics_input): CPU, сети, дисков, системы ввода-вывода и Linux-ядра.


#### Что дальше {#what-is-next}

- [Изучите концепции Unified Agent](index.md)
- [Узнайте подробнее о конфигурировании Unified Agent](configuration.md)
- [Ознакомьтесь с рекомендациями по эксплуатации Unified Agent](best-practices.md)