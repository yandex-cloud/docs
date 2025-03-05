1. Убедитесь, что версия ядра Linux расходится с версией заголовков ядра:

    * Чтобы узнать версию ядра Linux, в терминале выполните команду:

        ```bash
        uname -r
        ```

        Результат:

        ```text
        6.1.0-31-amd64
        ```
    * Чтобы узнать версию заголовков ядра Linux, выполните команду:

        ```bash
        sudo apt list --installed | grep header
        ```

        Результат:

        ```bash
        linux-headers-6.1.0-27-amd64/stable,now 6.1.115-1 amd64 [installed]
        linux-headers-6.1.0-27-common/stable,now 6.1.115-1 all [installed,automatic]
        ```
    Как видно из вывода команд, значения версий различаются: версия ядра Linux — `6.1.0-31`, версия заголовков ядра Linux — `6.1.0-27`.
1. Установите пакет `linux-headers` для нового ядра Linux:

    ```bash
    sudo apt install linux-headers-$(uname -r)
    ```
1. Убедитесь, что новые заголовки ядра были добавлены:

    ```bash
    sudo apt list --installed | grep header
    ```

    Результат:

    ```bash
    linux-headers-6.1.0-27-amd64/stable,now 6.1.115-1 amd64 [installed]
    linux-headers-6.1.0-27-common/stable,now 6.1.115-1 all [installed,automatic]
    linux-headers-6.1.0-31-amd64/stable-security,now 6.1.128-1 amd64 [installed]
    linux-headers-6.1.0-31-common/stable-security,now 6.1.128-1 all [installed,automatic]
    ```
1. Перезапустите операционную систему:

    ```bash
    sudo reboot
    ```

    В процессе перезагрузки фреймворк DKMS пересоберет модуль SnapAPI под нужную версию ядра Linux и агент {{ backup-name }} заработает.