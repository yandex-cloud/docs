1. [Создайте](../../compute/operations/vm-create/create-linux-vm.md) виртуальную машину `test-vm1` из публичного образа [Ubuntu 24.04](/marketplace/products/yc/ubuntu-2404-lts-oslogin) в зоне доступности `{{ region-id }}-a`.
   
1. [Подключитесь к ВМ по SSH](../../compute/operations/vm-connect/ssh.md).
   
    Если у вас установлен [интерфейс командной строки {{ yandex-cloud }}](../../cli/quickstart.md), вы можете подключиться к ВМ по [OS Login](../../compute/operations/vm-connect/os-login):

    ```bash
    yc compute ssh --name test-vm1
    ```
    

1. Запустите тестовый веб-сервер, который будет отвечать на запросы на порте `8080`:

    ```bash
    mkdir test-server; echo 'HELLO' > test-server/hello.txt; python3 -m http.server -d test-server 8080
    ```

1. Убедитесь, что веб-сервер возвращает список папок из каталога `test-server`. В терминале вашего компьютера выполните:

    ```bash
    curl -v <публичный_IP-адрес_ВМ>:8080
    ```