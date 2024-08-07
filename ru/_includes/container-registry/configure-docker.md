{% list tabs group=operating_system %}

- Linux {#linux}

    1. Установите Docker Engine. Воспользуйтесь [инструкцией](https://docs.docker.com/engine/install/#supported-platforms) по установке и запуску Docker для вашей операционной системы.

    1. После завершения установки добавьте текущего пользователя в группу `docker`:

        ```bash
        sudo groupadd docker
        sudo usermod -aG docker $USER
        newgrp docker
        ```

    Информацию о дополнительных настройках Docker в OS Linux см. в [документации разработчика](https://docs.docker.com/engine/install/linux-postinstall/).

    Если вы работаете на компьютере с графическим интерфейсом, вы также можете [установить](https://docs.docker.com/desktop/install/linux-install/) Docker Desktop для Linux.

- macOS {#macos}

  [Скачайте](https://docs.docker.com/get-docker/) и установите дистрибутив Docker Desktop для macOS. Подробную информацию см. в [документации разработчика](https://docs.docker.com/desktop/install/mac-install/).

- Windows {#windows}

    1. [Скачайте](https://docs.docker.com/get-docker/) и установите дистрибутив Docker Desktop для Windows.

    1. После завершения установки добавьте текущего пользователя в группу `docker-users`:

        1. От имени администратора откройте оснастку **Управление компьютером**:

            ```powershell
            compmgmt.msc
            ```
        
        1. Раскройте меню **Управление компьютером (локальным)** → **Служебные программы** → **Локальные пользователи и группы** → **Группы** и откройте группу `docker-users`.
        1. Нажмите кнопку **Добавить** и добавьте нужного пользователя в группу.
        1. Нажмите **ОК**.
    1. Запустите Docker Desktop и убедитесь, что статус приложения — `running`.

    Информацию о дополнительных настройках Docker в OS Windows см. в [документации разработчика](https://docs.docker.com/desktop/install/windows-install/).

{% endlist %}