Обработчик логов [Fluent Bit](https://fluentbit.io/) позволяет транслировать логи с [виртуальных машин](../../compute/concepts/vm.md) в сервис [{{ cloud-logging-full-name }}](../../logging/). Для передачи логов используется модуль [Fluent Bit plugin for {{ cloud-logging-full-name }}](https://github.com/yandex-cloud/fluent-bit-plugin-yandex).

Чтобы настроить передачу логов:

1. [Создайте сервис systemd, генерирующий логи](#systemd).
1. [Установите и настройте Fluent Bit](#install-fluent-bit).
1. [Подключите плагин](#connect-plugin).

## Перед началом работы {#before-you-begin}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролью `logging.writer` на каталог.
1. [Создайте ВМ](../../compute/operations/vm-create/create-linux-vm.md) из публичного образа [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts). В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите сервисный аккаунт, который создали на предыдущем шаге.
1. [Подключитесь к ВМ](../../compute/operations/vm-connect/ssh.md#vm-connect) по [SSH](../../glossary/ssh-keygen.md).
1. Установите на ВМ:
    * [Go не ниже версии 1.17](https://go.dev/doc/install):

        ```bash
        wget https://go.dev/dl/go1.17.6.linux-amd64.tar.gz
        tar -xzf go1.17.6.linux-amd64.tar.gz
        export PATH=$PWD/go/bin:$PATH
        ```

    * Git:

        ```bash
        sudo apt install git
        ```

## Создайте сервис systemd, генерирующий логи {#systemd}

1. Создайте директорию:

    ```bash
    sudo mkdir /usr/local/bin/logtest
    sudo chown $USER /usr/local/bin/logtest
    cd /usr/local/bin/logtest
    ```

1. Создайте файл `logtest.py`:

    ```py
    import logging
    import random
    import sys
    import time

    from systemdlogging.toolbox import check_for_systemd
    from systemdlogging.toolbox import SystemdFormatter
    from systemdlogging.toolbox import SystemdHandler

    # Следующие несколько строк можно заменить на вызов `systemdlogging.toolbox.init_systemd_logging`
    # Код приводится в целях демонстрации

    # Проверяем, доступен ли systemd
    systemd_ok = check_for_systemd()

    if systemd_ok:
        handler = SystemdHandler()
        # syslog_id: значение, которое будет использовано в поле SYSLOG_IDENTIFIER
        handler.syslog_id = ''
        handler.setFormatter(SystemdFormatter())

        # Получаем экземпляр объекта логгера
        logger = logging.getLogger()
        logger.addHandler(handler)

    else:
        logger = logging.getLogger(__name__)
        # Логи выводятся в STDOUT
        handler = logging.StreamHandler(stream=sys.stdout)
        handler.setFormatter(logging.Formatter(
            '[%(levelname)s] %(code)d %(message)s'
        ))
        logger.addHandler(handler)

    # Настраиваем уровень логирования по умолчанию, опционально
    logger.setLevel(logging.DEBUG)

    # Генерируем URL-подобные значения
    PATHS = [
        '/',
        '/admin',
        '/hello',
        '/docs',
    ]

    PARAMS = [
        'foo',
        'bar',
        'query',
        'search',
        None
    ]


    def fake_url():
        path = random.choice(PATHS)
        param = random.choice(PARAMS)
        if param:
            val = random.randint(0, 100)
            param += '=%s' % val
        code = random.choices([200, 400, 404, 500], weights=[10, 2, 2, 1])[0]
        return '?'.join(filter(None, [path, param])), code


    if __name__ == '__main__':
        while True:
            # Создаем пару — код и значение URL
            path, code = fake_url()
            # Если код 200, пишем в  лог с уровнем Info
            # Cloud Logging смотрит на текстовое написание уровня логирования, поэтому в `context` передаем
            # дополнительное значение `SEVERITY`
            # Оно попадет в journald и сможет быть прочитано в плагине yc-logging
            if code == 200:
                logger.info(
                    'Path: %s',
                    path,
                    extra={"code": code, "context": {"SEVERITY": "info"}},
                )
            # Иначе с уровнем Error
            else:
                logger.error(
                    'Error: %s',
                    path,
                    extra={"code": code, "context": {"SEVERITY": "error"}},
                )

            # Ждем 1 секунду, чтобы не засорять журнал
            time.sleep(1)
    ```

1. Обновите версии установленных пакетов:

    ```bash
    sudo apt-get update
    ```

1. Создайте виртуальную среду и установите необходимые зависимости:

    ```bash
    sudo apt install python3-pip python3.8-venv
    python3 -m venv venv
    source venv/bin/activate
    pip3 install systemd-logging
    ```

1. Создайте файл `logtest.sh`:

    ```sh
    #!/bin/bash

    SCRIPT_PATH=$(dirname "$(realpath "$0")")
    . "$SCRIPT_PATH/venv/bin/activate"
    python "$SCRIPT_PATH/logtest.py"
    ```

1. `systemd` будет вызывать `logtest.sh` для запуска сервиса, поэтому сделайте файл исполняемым:

    ```bash
    chmod +x logtest.sh
    ```

1. Создайте файл `logtest.service`:

    ```
    [Unit]
    Description=Sample to show logging from a Python application to systemd
    After=network.target

    [Service]
    Type=simple
    ExecStart=/usr/local/bin/logtest/logtest.sh
    Restart=on-abort

    [Install]
    WantedBy=multi-user.target
    ```

1. Создайте символическую ссылку для `logtest.service`:

    ```bash
    sudo ln -s "$(pwd)/logtest.service" /etc/systemd/system/logtest.service
    ```

1. Перезапустите `systemd`:

    ```bash
    sudo systemctl daemon-reload
    ```

1. Посмотрите статус сервиса `logtest.service`:

    ```bash
    systemctl status logtest.service
    ```

    Результат:

    ```bash
    ● logtest.service - Sample to show logging from a Python application to systemd
     Loaded: loaded (/etc/systemd/system/logtest.service; linked; vendor preset: enabled)
     Active: inactive (dead)
    ```

1. Запустите сервис `logtest.service`:

    ```bash
    sudo systemctl start logtest.service
    ```

1. Снова посмотрите статус сервиса `logtest.service`, теперь он должен быть активен:

    ```bash
    systemctl status logtest.service
    ```

    Результат:

    ```bash
    ● logtest.service - Sample to show logging from a Python application to systemd
         Loaded: loaded (/etc/systemd/system/logtest.service; linked; vendor preset: enabled)
         Active: active (running) since Wed 2022-02-02 18:49:03 UTC; 13h ago
       Main PID: 6550 (logtest.sh)
          Tasks: 2 (limit: 2311)
         Memory: 8.5M
         CGroup: /system.slice/logtest.service
                 ├─6550 /bin/bash /usr/local/bin/logtest/logtest.sh
                 └─6568 python /usr/local/bin/logtest/logtest.py
    ```

## Установите и настройте Fluent Bit {#install-fluent-bit}

1. Добавьте GPG-ключ, которым подписаны пакеты в репозитории Fluent Bit:

    ```bash
    wget -qO - https://packages.fluentbit.io/fluentbit.key | sudo apt-key add -
    ```

1. Добавьте в файл `/etc/apt/sources.list` следующую строку:

    ```bash
    deb https://packages.fluentbit.io/ubuntu/focal focal main
    ```

1. Обновите версии установленных пакетов:

    ```bash
    sudo apt-get update
    ```

1. Установите пакет `fluent-bit`:

    ```bash
    sudo apt-get install fluent-bit
    ```

1. Запустите сервис `fluent-bit`:

    ```bash
    sudo systemctl start fluent-bit
    ```

1. Проверьте статус сервиса `fluent-bit`, он должен быть активен:

    ```bash
    systemctl status fluent-bit
    ```

    Результат:

    ```bash
    ● fluent-bit.service - Fluent Bit
         Loaded: loaded (/lib/systemd/system/fluent-bit.service; disabled; vendor preset: enabled)
         Active: active (running) since Tue 2024-04-30 09:00:58 UTC; 3h 35min ago
           Docs: https://docs.fluentbit.io/manual/
       Main PID: 589764 (fluent-bit)
          Tasks: 9 (limit: 2219)
         Memory: 18.8M
            CPU: 2.543s
         CGroup: /system.slice/fluent-bit.service
                 └─589764 /opt/fluent-bit/bin/fluent-bit -c //etc/fluent-bit/fluent-bit.conf
   ```

## Подключите плагин {#connect-plugin}

1. Клонируйте репозиторий с кодом плагина:

    ```bash
    git clone https://github.com/yandex-cloud/fluent-bit-plugin-yandex.git
    ```

1. Скомпилируйте библиотеку `yc-logging.so`:

    ```bash
    cd fluent-bit-plugin-yandex/
    export fluent_bit_version=3.0.3
    export golang_version=1.22.2
    export plugin_version=dev
    CGO_ENABLED=1 go build -buildmode=c-shared \
        -o ./yc-logging.so \
        -ldflags "-X main.PluginVersion=${plugin_version}" \
        -ldflags "-X main.FluentBitVersion=${fluent_bit_version}"
   ```

   Где:
   * `fluent_bit_version` — версия пакета `fluent-bit`. Для проверки версии воспользуйтесь командой `/opt/fluent-bit/bin/fluent-bit --version`.
   * `golang_version` — версия компилятора Go. Для проверки версии воспользуйтесь командой `go version`.

1. Скопируйте библиотеку `yc-logging.so` в директорию библиотек `fluent-bit`:

    ```bash
    sudo cp yc-logging.so /usr/lib/fluent-bit/plugins/yc-logging.so
    ```

1. Добавьте в файл с настройками плагинов `/etc/fluent-bit/plugins.conf` путь до библиотеки `yc-logging.so`:

    ```
    [PLUGINS]
        Path /usr/lib/fluent-bit/plugins/yc-logging.so
    ```

1. Добавьте в файл `/etc/fluent-bit/fluent-bit.conf` настройки сервиса `fluent-bit`:


    ```
    [INPUT]
        Name  systemd
        Tag   host.*
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
    * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в [лог-группу по умолчанию](../../logging/concepts/log-group.md) которого будут передаваться логи.
    * `authorization` — настройки авторизации. Укажите `instance-service-account`, чтобы авторизоваться от имени сервисного аккаунта, который указали в блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** при [создании ВМ](#before-you-begin).

1. Перезапустите сервис `fluent-bit`:

    ```bash
    sudo systemctl restart fluent-bit
    ```

## Посмотрите логи {#read-logs}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1.  В [консоли  управления]({{ link-console-main }}) перейдите в каталог, который указали в настройках сервиса `fluent-bit`.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
    1. Нажмите на строку c лог-группой по умолчанию `default`.
    1. Перейдите на вкладку **{{ ui-key.yacloud.common.logs }}**.
    1. На открывшейся странице отобразятся записи.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы посмотреть записи в лог-группе, выполните команду:
    ```
    yc logging read --folder-id=<идентификатор_каталога>
    ```

    Где `--folder-id` — идентификатор каталога, который указан в настройках сервиса `fluent-bit`.

- API {#api}

    Чтобы посмотреть записи в лог-группе, воспользуйтесь вызовом gRPC API [LogReadingService/Read](../../logging/api-ref/grpc/log_reading_service.md#Read).

{% endlist %}

## Удалите созданные ресурсы {#delete-resources}

Если созданные ресурсы вам больше не нужны, удалите их:

1. [Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md).
1. [Удалите лог-группу](../../logging/operations/delete-group.md).
