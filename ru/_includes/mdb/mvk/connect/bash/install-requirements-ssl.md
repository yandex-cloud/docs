**Перед подключением установите зависимости:**

1. Подключите репозиторий, в котором находится утилита `redis-tools` с поддержкой TLS:

    ```bash
    sudo apt-add-repository ppa:redislabs/redis
    ```

    Пакеты в этом репозитории уже собраны с флагом `BUILD_TLS=yes`.

1. Установите утилиту:

    ```bash
    sudo apt update && sudo apt install -y redis-tools
    ```
