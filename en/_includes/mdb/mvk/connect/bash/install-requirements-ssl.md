**Before connecting, install the required dependencies:**

Build `redis-tools` with TLS support using one of the two methods:

* **From a repository**

    1. Add a repository:

        ```bash
        sudo apt-add-repository ppa:redislabs/redis
        ```

        The repository’s packages come pre-built with `BUILD_TLS=yes`.

    1. Install the tool:

        ```bash
        sudo apt update && sudo apt install -y redis-tools
        ```

* **Manually**

    Go to the directory you want to download the distribution to. Download the stable tool version, then build and install it:

    ```bash
    wget https://download.redis.io/redis-stable.tar.gz && \
    tar -xzvf redis-stable.tar.gz && \
    cd redis-stable && \
    make BUILD_TLS=yes && \
    sudo make install && \
    sudo cp ./src/redis-cli /usr/bin/
    ```
