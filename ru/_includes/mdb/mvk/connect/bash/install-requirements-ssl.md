**Перед подключением установите зависимости:**

Соберите утилиту `redis-tools` с поддержкой TLS одним из двух способов::

* **Из репозитория**

    1. Подключите репозиторий:

        ```bash
        sudo apt-add-repository ppa:redislabs/redis
        ```

        Пакеты в этом репозитории уже собраны с флагом `BUILD_TLS=yes`.

    1. Установите утилиту:

        ```bash
        sudo apt update && sudo apt install -y redis-tools
        ```

* **Вручную**

    Перейдите в директорию, куда хотите скачать дистрибутив. Скачайте стабильную версию утилиты и выполните сборку и установку:

    ```bash
    wget https://download.redis.io/redis-stable.tar.gz && \
    tar -xzvf redis-stable.tar.gz && \
    cd redis-stable && \
    make BUILD_TLS=yes && \
    sudo make install && \
    sudo cp ./src/redis-cli /usr/bin/
    ```
