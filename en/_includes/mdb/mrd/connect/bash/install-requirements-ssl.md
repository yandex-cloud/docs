**Before connecting, install the dependencies:**

Build the `redis-tools` utility with TLS support in one of two ways:

* **From a repository**

   1. Connect a repository:

      ```bash
      sudo apt-add-repository ppa:redislabs/redis
      ```

      Packages in this repository have already been built with the `BUILD_TLS=yes` flag.

   1. Install the utility:

      ```bash
      sudo apt update && sudo apt install -y redis-tools
      ```

* **Manually**

   Go to the directory you want to download the distribution to. Download the stable version of the utility, then build and install it:

   ```bash
   wget https://download.redis.io/redis-stable.tar.gz && \
   tar -xzvf redis-stable.tar.gz && \
   cd redis-stable && \
   make BUILD_TLS=yes && \
   sudo make install && \
   sudo cp ./src/redis-cli /usr/bin/
   ```
