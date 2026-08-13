**Before connecting, install the dependencies:

1. Connect to the repository containing `redis-tools` with TLS support:

    ```bash
    sudo apt-add-repository ppa:redislabs/redis
    ```

    The repository’s packages come pre-built with `BUILD_TLS=yes`.

1. Install the tool:

    ```bash
    sudo apt update && sudo apt install -y redis-tools
    ```
