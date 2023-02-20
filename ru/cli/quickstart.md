# Начало работы с интерфейсом командной строки


_Интерфейс командной строки {{ yandex-cloud }} (CLI)_ — скачиваемое программное обеспечение для управления вашими облачными ресурсами через командную строку.


## Установка {#install}

{% include [install-cli](../_includes/cli/install-cli.md) %}

## Создание профиля {#initialize}

{% include notitle [Создание профиля CLI](../_includes/cli/create-profile.md) %}


## Примеры команд {#example}

Ниже описана последовательность действий для создания облачной сети, подсети и виртуальной машины, подключенной к этой подсети.

1. Посмотрите описание команд CLI для работы с облачными сетями:
   ```bash
   yc vpc network --help
   ```
1. Создайте облачную сеть в каталоге, указанном в вашем профиле CLI:
   ```bash
   yc vpc network create \
     --name my-yc-network \
     --labels my-label=my-value \
     --description "my first network via yc"
   ```
1. Создайте подсеть в облачной сети `my-yc-network`:
   ```bash
   yc vpc subnet create \
     --name my-yc-subnet-a \
     --zone {{ region-id }}-a \
     --range 10.1.2.0/24 \
     --network-name my-yc-network \
     --description "my first subnet via yc"
   ```
1. Получите список всех облачных сетей в каталоге, указанном в вашем профиле CLI:
   ```bash
   yc vpc network list

   +----------------------+------------------+-------------------------+
   |          ID          |       NAME       |       DESCRIPTION       |
   +----------------------+------------------+-------------------------+
   | skesdqhkc6449hbqqar1 | my-ui-network    | my first network via ui |
   | c6449hbqqar1skesdqhk | my-yc-network    | my first network via yc |
   +----------------------+------------------+-------------------------+
   ```
   Получите тот же список с большим количеством деталей в формате YAML:
   ```bash
   yc vpc network list --format yaml
   ```

   Результат:

   ```yaml
   - id: skesdqhkc6449hbqqar1
     folder_id: ijkl9012
     created_at: "2018-09-05T09:51:16Z"
     name: my-ui-network
     description: "my first network via ui"
     labels: {}
   - id: c6449hbqqar1skesdqhk
     folder_id: ijkl9012
     created_at: "2018-09-05T09:55:36Z"
     name: my-yc-network
     description: "my first network via yc"
     labels:
       my-label: my-value
   ```
1. Создайте виртуальную машину и подключите к подсети `my-yc-subnet-a`:
   1. [Подготовьте](../compute/operations/vm-connect/ssh.md#creating-ssh-keys) пару ключей (открытый и закрытый) для [SSH-доступа](../glossary/ssh-keygen.md) на виртуальную машину.
   1. Создайте виртуальную машину Linux:
      ```bash
      yc compute instance create \
        --name my-yc-instance \
        --network-interface subnet-name=my-yc-subnet-a,nat-ip-version=ipv4 \
        --zone {{ region-id }}-a \
        --ssh-key ~/.ssh/id_ed25519.pub
      ```
      Где `ssh-key` – путь к открытому ключу для SSH-доступа. В ОС виртуальной машины будет автоматически создан пользователь `yc-user` с указанным открытым ключом.
1. Подключитесь к виртуальной машине по SSH:
   1. Узнайте публичный IP-адрес виртуальной машины. Для этого посмотрите подробную информацию о вашей виртуальной машине:
      ```bash
      yc compute instance get my-yc-instance
      ```
      В выводе команды найдите адрес виртуальной машины в блоке `one_to_one_nat`:
      
            
      ```yaml
      one_to_one_nat:
          address: 130.193.32.90
          ip_version: IPV4
      ```
      
      
      
   1. Подключитесь к виртуальной машине по SSH от имени пользователя `yc-user`, используя закрытый ключ:
      
         

      ```bash
      ssh yc-user@130.193.32.90
      ```
      
   
   
1. Удалите виртуальную машину `my-yc-instance`, подсеть `my-yc-subnet-a` и сеть `my-yc-network`:
   ```bash
   yc compute instance delete my-yc-instance
   yc vpc subnet delete my-yc-subnet-a
   yc vpc network delete my-yc-network
   ```
