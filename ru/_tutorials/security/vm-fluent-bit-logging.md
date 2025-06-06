# Передача логов с ВМ в {{ cloud-logging-full-name }}

Обработчик логов [Fluent Bit](https://fluentbit.io/) позволяет транслировать логи с [виртуальных машин](../../compute/concepts/vm.md) в сервис [{{ cloud-logging-full-name }}](../../logging/). Для передачи логов используется модуль [Fluent Bit plugin for {{ cloud-logging-full-name }}](https://github.com/yandex-cloud/fluent-bit-plugin-yandex).

Чтобы настроить передачу логов:

1. [Создайте сервис systemd, генерирующий логи](#systemd).
1. [Установите и настройте Fluent Bit](#install-fluent-bit).
1. [Подключите плагин](#connect-plugin).

## Перед началом работы {#before-you-begin}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролью `logging.writer` на каталог.
1. [Создайте ВМ](../../compute/operations/vm-create/create-linux-vm.md) из публичного образа [Ubuntu 24.04](/marketplace/products/yc/ubuntu-24-04-lts). В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите сервисный аккаунт, который создали на предыдущем шаге.
1. [Подключитесь к ВМ](../../compute/operations/vm-connect/ssh.md#vm-connect) по [SSH](../../glossary/ssh-keygen.md).
1. Установите на ВМ пакеты для разработки:

    ```bash
    sudo apt-get update
    sudo apt-get install -y python3-pip python3-venv python3-systemd git build-essential pkg-config libsystemd-dev golang-go
    ```

    Команда устанавливает:
      * **python3-pip** — менеджер пакетов Python (pip) для создания сервиса systemd, генерирующего логи.
      * **python3-venv** — модуль для создания виртуальных окружений Python.
      * **python3-systemd** — Python-библиотека для взаимодействия с systemd.
      * **git** — система контроля версий для загрузки с GitHub исходных кодов плагина Fluent Bit for {{ cloud-logging-full-name }}.
      * **build-essential** — компиляторы и инструменты для сборки ПО.
      * **pkg-config** — утилита для получения флагов компиляции и линковки библиотек.
      * **libsystemd-dev** — заголовочные файлы и библиотеки для разработки под systemd.
      * **golang-go** — компилятор и инструменты языка Go (Golang) для сборки плагина Fluent Bit.

1. Проверьте версии установленных пакетов:

    ```bash
    python3 --version
    pip3 --version
    go version
    ```

    Результат должен быть не ниже:

    ```
    Python 3.10
    pip 22.0.2 from /usr/lib/python3/dist-packages/pip (python 3.10)
    go version go1.17.6 linux/amd64
    ```

## Создайте сервис systemd, генерирующий логи {#systemd}

1. Создайте директорию:

    ```bash
    sudo mkdir -p /usr/local/bin/logtest
    sudo chown $USER /usr/local/bin/logtest
    cd /usr/local/bin/logtest
    ```

1. Создайте файл `logtest.py`:

    ```python
    import logging
    import random
    import sys
    import time
    from systemd import journal

    # Настройка логгера
    logger = logging.getLogger("logtest")
    journald_handler = journal.JournalHandler(SYSLOG_IDENTIFIER="logtest")
    logger.addHandler(journald_handler)
    logger.setLevel(logging.DEBUG)

    # Генерируем URL-подобные значения
    PATHS = [
        "/",
        "/admin",
        "/hello",
        "/docs",
    ]

    PARAMS = [
        "foo",
        "bar",
        "query",
        "search",
        None
    ]

    def fake_url():
        path = random.choice(PATHS)
        param = random.choice(PARAMS)
        if param:
            val = random.randint(0, 100)
            param += "={}".format(val)
        code = random.choices([200, 400, 404, 500], weights=[10, 2, 2, 1])[0]
        return "?".join(filter(None, [path, param])), code

    if __name__ == "__main__":
        while True:
            path, code = fake_url()
            if code == 200:
                logger.info(
                    "Path: {}".format(path),
                    extra={
                        "code": code
                    }
                )
            else:
                logger.error(
                    "Error: {}".format(path),
                    extra={
                        "code": code
                    }
                )
            time.sleep(1)
    ```

1. Создайте виртуальную среду и установите необходимые зависимости:

    ```bash
    python3 -m venv ~/venv
    source ~/venv/bin/activate
    pip install systemd-python
    ```

1. Сделайте файл исполняемым:

    ```bash
    sudo chmod +x /usr/local/bin/logtest/logtest.py
    ```

1. Создайте файл `/etc/systemd/system/logtest.service`:

    ```ini
    [Unit]
    Description=Log Test Service
    After=network.target

    [Service]
    ExecStart=/home/$USER/venv/bin/python3 /usr/local/bin/logtest/logtest.py
    Environment=PYTHONPATH=/home/$USER/venv/lib/python3.12/site-packages
    Restart=always
    User=$USER
    StandardOutput=journal
    StandardError=journal

    [Install]
    WantedBy=multi-user.target
    ```

1. Перезапустите `systemd`:

    ```bash
    sudo systemctl daemon-reload
    ```

1. Запустите и проверьте статус сервиса:

    ```bash
    sudo systemctl start logtest
    sudo systemctl status logtest
    ```

    Результат:

    ```
    ● logtest.service - Sample to show logging from a Python application to systemd
         Loaded: loaded (/etc/systemd/system/logtest.service; linked; vendor preset: enabled)
         Active: active (running) since Thu 2024-05-30 12:34:56 UTC; 5s ago
       Main PID: 12345 (logtest.sh)
          Tasks: 2 (limit: 2311)
         Memory: 18.5M
            CPU: 156ms
         CGroup: /system.slice/logtest.service
                 ├─12345 /bin/bash /usr/local/bin/logtest/logtest.sh
                 └─12346 python /usr/local/bin/logtest/logtest.py
    ```

## Установите и настройте Fluent Bit {#install-fluent-bit}

1. Добавьте GPG-ключ и репозиторий Fluent Bit:

    ```bash
    wget -qO - https://packages.fluentbit.io/fluentbit.key | sudo apt-key add -
    echo "deb https://packages.fluentbit.io/ubuntu/focal focal main" | sudo tee /etc/apt/sources.list.d/fluent-bit.list
    ```

1. Установите Fluent Bit:

    ```bash
    sudo apt-get update
    sudo apt-get install -y fluent-bit
    ```

## Подключите плагин {#connect-plugin}

1. Клонируйте репозиторий с плагином:

    ```bash
    git clone https://github.com/yandex-cloud/fluent-bit-plugin-yandex.git
    cd fluent-bit-plugin-yandex
    ```

1. Создайте и настройте файл с версиями:

    ```bash
    cat > versions.sh << 'EOL'
    #!/bin/bash
    export fluent_bit_version=3.0.3
    export golang_version=1.22.2
    export plugin_version=dev
    EOL

    chmod +x versions.sh
    source ./versions.sh
    ```

1. Соберите плагин:

    ```bash
    CGO_ENABLED=1 go build -v -buildmode=c-shared -o yc-logging.so yclogging.go
    ```

1. Установите плагин:

    ```bash
    sudo mkdir -p /usr/local/lib/fluent-bit/
    sudo cp yc-logging.so /usr/local/lib/fluent-bit/
    sudo chmod 644 /usr/local/lib/fluent-bit/yc-logging.so
    ```

1. Создайте файл `/etc/fluent-bit/plugins.conf`:

    ```ini
    [PLUGINS]
        Path /usr/local/lib/fluent-bit/yc-logging.so
    ```

1. Создайте файл `/etc/fluent-bit/fluent-bit.conf`:

    ```ini
    [SERVICE]
        Flush        1
        Daemon       Off
        Log_Level    info
        Parsers_File parsers.conf
        Plugins_File plugins.conf

    [INPUT]
        Name            systemd
        Tag             host.*
        Systemd_Filter  _SYSTEMD_UNIT=logtest.service

    [OUTPUT]
        Name            yc-logging
        Match           *
        resource_type   logtest
        folder_id       <идентификатор_каталога>
        message_key     MESSAGE
        level_key       SEVERITY
        default_level   WARN
        authorization   instance-service-account
    ```

    Где:
    - `folder_id` — идентификатор каталога Yandex Cloud, в лог-группу по умолчанию которого будут передаваться логи.
    - `authorization` — настройки авторизации. Значение `instance-service-account` используется для авторизации от имени сервисного аккаунта, указанного при создании ВМ.
    - `level_key` — поле, содержащее уровень логирования.
    - `message_key` — поле, содержащее текст сообщения.
    - `default_level` — уровень логирования по умолчанию, если не указан в сообщении.

1. Перезапустите Fluent Bit:

    ```bash
    sudo systemctl restart fluent-bit
    ```

## Посмотрите логи {#read-logs}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Проверьте статус сервисов:

    ```bash
    sudo systemctl status logtest
    sudo systemctl status fluent-bit
    ```

    Результат:

    ```
    ● fluent-bit.service - Fluent Bit
         Loaded: loaded (/lib/systemd/system/fluent-bit.service; disabled; vendor preset: enabled)
         Active: active (running) since Thu 2024-05-30 12:34:56 UTC; 5s ago
           Docs: https://docs.fluentbit.io/manual/
       Main PID: 12347 (fluent-bit)
          Tasks: 4 (limit: 2311)
         Memory: 18.8M
            CPU: 156ms
         CGroup: /system.slice/fluent-bit.service
                 └─12347 /opt/fluent-bit/bin/fluent-bit -c /etc/fluent-bit/fluent-bit.conf
    ```

    1. Просмотрите логи:

        ```bash
        # Логи тестового сервиса
        sudo journalctl -u logtest -n 10 | cat

        # Логи Fluent Bit
        sudo journalctl -u fluent-bit -n 20 | cat
        ```

        При корректной работе:

        1. Оба сервиса должны иметь статус "active (running)".
        1. В логах тестового сервиса должны появляться сообщения вида:
           - `Path: /admin?query=90` для успешных запросов.
           - `Error: /docs?bar=44` для ошибочных запросов.
        1. В логах Fluent Bit не должно быть ошибок.

    1. Проверьте логи в консоли управления:

       1. Откройте [консоль управления]({{ link-console-main }}).
       1. Перейдите в каталог, указанный в `folder_id`.
       1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
       1. Откройте лог-группу по умолчанию `default`.
       1. На вкладке **{{ ui-key.yacloud.common.logs }}** настройте фильтры:
          - `resource_type=logtest` для просмотра логов тестового сервиса.
          - `timestamp > now()-1h` для просмотра логов за последний час.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы посмотреть записи в лог-группе, выполните команду:

    ```bash
    yc logging read --folder-id=<идентификатор_каталога>
    ```

    Где `--folder-id` — идентификатор каталога, который указан в настройках сервиса `fluent-bit`.

- API {#api}

    Чтобы посмотреть записи в лог-группе, воспользуйтесь вызовом gRPC API [LogReadingService/Read](../../logging/api-ref/grpc/LogReading/read.md).

{% endlist %}

## Устранение возможных неполадок {#troubleshooting}

1. Ошибки доступа к файлам и системные проблемы:
   - Проверьте права доступа к критическим файлам:
  
     ```bash
     ls -l /usr/local/lib/fluent-bit/yc-logging.so
     ls -l /etc/fluent-bit/plugins.conf
     ls -l /etc/fluent-bit/fluent-bit.conf
     ```

     Корректный результат должен выглядеть так:

     ```
     -rwxr-xr-x 1 root root 8123456 May 30 12:34 /usr/local/lib/fluent-bit/yc-logging.so
     -rw-r--r-- 1 root root 123 May 30 12:34 /etc/fluent-bit/plugins.conf
     -rw-r--r-- 1 root root 456 May 30 12:34 /etc/fluent-bit/fluent-bit.conf
     ```

   - Проверьте системные логи на наличие ошибок:

     ```bash
     sudo tail -f /var/log/syslog
     ```

     Пример корректных логов:

     ```
     May 30 12:34:56 vm-name fluent-bit[12347]: [2024/05/30 12:34:56] [ info] [fluent bit] version=3.0.3
     May 30 12:34:56 vm-name fluent-bit[12347]: [2024/05/30 12:34:56] [ info] [storage] ver=1.4.0, type=memory
     May 30 12:34:56 vm-name fluent-bit[12347]: [2024/05/30 12:34:56] [ info] [cmetrics] version=0.6.3
     ```

     ```bash
     journalctl -xe
     ```

     Пример корректных логов:

     ```
     May 30 12:34:56 vm-name systemd[1]: Started Fluent Bit.
     May 30 12:34:56 vm-name fluent-bit[12347]: Fluent Bit v3.0.3
     May 30 12:34:56 vm-name logtest.sh[12345]: [INFO] 200 Path: /hello?query=42
     ```

1. Ошибка "Permission denied":
   - Проверьте права сервисного аккаунта:

     ```bash
     yc iam service-account list
     ```

     Результат должен показать ваш сервисный аккаунт:

     ```
     +----------------------+---------------+
     |          ID          |     NAME      |
     +----------------------+---------------+
     | aje5n27q235g8m3...   | service-acc-1 |
     +----------------------+---------------+
     ```

   - Проверьте роли сервисного аккаунта:

     ```bash
     yc iam service-account get service-acc-1
     ```

     В результате должна быть роль `logging.writer`:

     ```
     id: aje5n27q235g8m3...
     folder_id: b1g4c2a3v000000000000
     name: service-acc-1
     roles:
       - logging.writer
     ```

1. Логи не появляются в Cloud Logging:
   - Проверьте правильность `folder_id` в конфигурации:

     ```bash
     grep folder_id /etc/fluent-bit/fluent-bit.conf
     ```

     Результат должен показать ваш folder_id:

     ```
     folder_id b1g4c2a3v000000000000
     ```

   - Проверьте, что плагин yc-logging правильно загружен:

     ```bash
     sudo systemctl status fluent-bit | grep yc-logging
     ```

     Корректный результат:

     ```
     May 30 12:34:56 vm-name fluent-bit[12347]: [2024/05/30 12:34:56] [ info] [output:yc-logging:yc-logging.0] worker #0 started
     ```

1. Проблемы с форматом логов:
   - Проверьте настройки в конфигурации:

     ```bash
     grep -A 5 '\[OUTPUT\]' /etc/fluent-bit/fluent-bit.conf
     ```

     Корректный результат:

     ```
     [OUTPUT]
         Name            yc-logging
         Match           *
         resource_type   logtest
         message_key     MESSAGE
         level_key       SEVERITY
     ```

   - Проверьте формат логов в journald:

     ```bash
     journalctl -u logtest -n 5
     ```

     Корректный формат логов:

     ```
     May 30 12:34:56 vm-name logtest.sh[12345]: [INFO] 200 Path: /hello?query=42
     May 30 12:34:57 vm-name logtest.sh[12345]: [ERROR] 404 Error: /admin?foo=13
     ```

1. Ошибки доступа к файлам и системные проблемы:
   - Проверьте права доступа к критическим файлам:
  
     ```bash
     ls -l /usr/local/lib/fluent-bit/yc-logging.so
     ls -l /etc/fluent-bit/plugins.conf
     ls -l /etc/fluent-bit/fluent-bit.conf
     ```

   - Проверьте системные логи на наличие ошибок:

     ```bash
     sudo tail -f /var/log/syslog
     journalctl -xe
     ```

   - Убедитесь, что все файлы имеют корректные права доступа (644 для конфигурационных файлов, 755 для библиотек).

1. Ошибка "Permission denied":
   - Проверьте права сервисного аккаунта.
   - Убедитесь, что роль `logging.writer` назначена на нужный каталог.
   - Проверьте, что токен сервисного аккаунта действителен.

1. Логи не появляются в Cloud Logging:
   - Проверьте правильность `folder_id` в конфигурации.
   - Убедитесь, что формат логов соответствует ожидаемому.
   - Проверьте, что плагин yc-logging правильно загружен:
  
     ```bash
     sudo systemctl status fluent-bit | grep yc-logging
     ```

1. Проблемы с форматом логов:
   - Проверьте настройки `message_key` и `level_key`.
   - Убедитесь, что логи содержат необходимые поля.
   - Проверьте формат времени в логах.

## Полезные команды для диагностики {#diagnostic-commands}

1. Просмотр расширенных логов Fluent Bit:
   - Отслеживание логов в реальном времени:

     ```bash
     sudo journalctl -u fluent-bit -n 100 -f
     ```

     Пример вывода:

     ```
     May 30 12:34:56 vm-name fluent-bit[1234]: [info] [engine] started (pid=1234)
     May 30 12:34:56 vm-name fluent-bit[1234]: [info] [storage] version=1.1.6, initializing...
     May 30 12:34:57 vm-name fluent-bit[1234]: [info] [yc-logging] plugin initialized successfully
     ```

1. Проверка использования CPU и памяти:
   - Отслеживание процесса Fluent Bit:

     ```
     ps aux | grep fluent-bit
     top -p $(pgrep fluent-bit)
     ```
     
     Пример вывода ps:
     ```
     fluent  1234  0.5  1.2 256892 12644 ?  Ssl  12:34  0:02 /opt/fluent-bit/bin/fluent-bit -c /etc/fluent-bit/fluent-bit.conf
     ```

1. Мониторинг сетевых соединений:
   - Проверка открытых портов и соединений:

     ```bash
     sudo netstat -tupn | grep fluent-bit
     ```
     
     Пример вывода:
     ```
     tcp  0  0  0.0.0.0:24224  0.0.0.0:*  LISTEN  1234/fluent-bit
     tcp  0  0  10.0.0.2:52431  logging.api.cloud.yandex.net:443  ESTABLISHED  1234/fluent-bit
     ```

1. Проверка загрузки плагина:
   - Просмотр открытых файлов процесса:

     ```bash
     sudo lsof -p $(pgrep fluent-bit) | grep yc-logging
     ```
     
     Пример вывода:
     ```
     fluent-bit 1234 fluent-bit  mem REG 8,1 2890144 /usr/local/lib/fluent-bit/yc-logging.so
     ```

1. Проверка конфигурационных файлов:
   - Получение контрольных сумм:

     ```
     find /etc/fluent-bit/ -type f -exec md5sum {} \;
     ```
     
     Пример вывода:
     ```
     a1b2c3d4e5f6g7h8 /etc/fluent-bit/fluent-bit.conf
     b2c3d4e5f6g7h8i9 /etc/fluent-bit/plugins.conf
     c3d4e5f6g7h8i9j0 /etc/fluent-bit/parsers.conf
     ```

## Удалите созданные ресурсы {#delete-resources}

Если созданные ресурсы вам больше не нужны, удалите их:

1. [Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md).
1. [Удалите лог-группу](../../logging/operations/delete-group.md).