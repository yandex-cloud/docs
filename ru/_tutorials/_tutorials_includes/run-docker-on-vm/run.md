1. [Подключитесь по SSH](../../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ.
1. Пройдите [аутентификацию](../../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm) от имени сервисного аккаунта, привязанного к этой машине:

    ```bash
    curl --header Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token | \
    cut -f1 -d',' | \
    cut -f2 -d':' | \
    tr -d '"' | \
    docker login --username iam --password-stdin {{ registry }}
    ```

    Результат:

    ```text
    Login Succeeded
    ```

1. Скачайте Docker-образ на ВМ:

    ```bash
    docker pull {{ registry }}/${REGISTRY_ID}/ubuntu:hello
    ```

    Результат:

    ```text
    hello: Pulling from crpc9qeoft23********/ubuntu
    6a5697faee43: Pulling fs layer
    ba13d3bc422b: Pulling fs layer
    ...
    Digest: sha256:42068479274f1d4c7ea095482430dcba24dcfe8c23ebdf6d32305928********
    Status: Downloaded newer image for {{ registry }}/crpc9qeoft23********/ubuntu:hello
    {{ registry }}/crpc9qeoft23********/ubuntu:hello
    ```