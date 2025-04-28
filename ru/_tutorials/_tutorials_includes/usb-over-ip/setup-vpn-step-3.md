Включите IP Forwarding в настройках ядра Linux:

1. Откройте файл конфигурации `sysctl.conf`:

    ```bash
    sudo nano /etc/sysctl.conf
    ```
1. Добавьте в конец файла `sysctl.conf` строку:

    ```text
    net.ipv4.ip_forward = 1
    ```
1. Примените измененные настройки ядра:

    ```bash
    sudo sysctl -p
    ```