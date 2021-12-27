# Начало работы с интерфейсом командной строки


_Интерфейс командной строки {{ yandex-cloud }} (CLI)_ — скачиваемое программное обеспечение для управления вашими облачными ресурсами через командную строку.

## Установка {#install}

{% include [install-cli](../_includes/cli/install-cli.md) %}

## Создание профиля {#initialize}


Если вы еще не подключены к консоли управления, войдите в [консоль]({{ link-console-main }}) и примите пользовательское соглашение (нажмите **Войти**).

{% list tabs %}

- От имени пользователя

  Чтобы аутентифицироваться от имени пользователя:
  1. Получите OAuth-токен в сервисе Яндекс.OAuth. Для этого перейдите по [ссылке]({{ link-cloud-oauth }}) и нажмите **Разрешить**.
  1. Запустите команду `yc init`, чтобы выполнить настройку вашего профиля CLI.
  1. По запросу команды введите свой OAuth токен.
     ```
     Please go to {{ link-cloud-oauth }}
      in order to obtain OAuth token.

     Please enter OAuth token: AaAaBbBbCcCcDdDdEeEeFfFfGgGg
     ```
  1. Выберите одно из предложенных облаков, в которых у вас есть права доступа:
     
     {% include [include](../_includes/cli/choose-cloud.md) %}

     Если вам доступно только одно облако, оно будет выбрано автоматически.
  1. Выберите каталог по умолчанию:

     {% include [include](../_includes/cli/choose-folder.md) %}

  1. Выберите зону доступности по умолчанию для сервиса {{ compute-full-name }}:

     {% include [include](../_includes/cli/choose-zone.md) %}
  1. Проверьте настройки вашего профиля CLI:
     ```
     yc config list
     ```

- От имени сервисного аккаунта

    Перед началом работы подготовьте сервисный аккаунт:
    1. [Аутентифицируйтесь в CLI как пользователь](operations/authentication/user.md).
    1. Если у вас еще нет сервисного аккаунта, [создайте его](../iam/operations/sa/create.md) и [настройте права доступа для него](../iam/operations/sa/assign-role-for-sa.md).

    {% include [auth-as-sa](../_includes/cli/auth-as-sa.md) %}

- От имени федеративного пользователя

    {% include [include](../_includes/cli/auth-federated-user.md) %}

{% endlist %}

## Примеры команд {#example}

Ниже описана последовательность действий для создания облачной сети, подсети и виртуальной машины, подключенной к этой подсети.

1. Посмотрите описание команд CLI для работы с облачными сетями:
   ```
   yc vpc network --help
   ```
1. Создайте облачную сеть в каталоге, указанном в вашем профиле CLI:
   ```
   yc vpc network create \
       --name my-yc-network \
       --labels my-label=my-value \
       --description "my first network via yc"
   ```
1. Создайте подсеть в облачной сети `my-yc-network`:
   ```
   yc vpc subnet create \
       --name my-yc-subnet-b \
       --zone ru-central1-b \
       --range 10.1.2.0/24 \
       --network-name my-yc-network \
       --description "my first subnet via yc"
   ```
1. Получите список всех облачных сетей в каталоге, указанном в вашем профиле CLI:
   ```
   yc vpc network list

   +----------------------+------------------+-------------------------+
   |          ID          |       NAME       |       DESCRIPTION       |
   +----------------------+------------------+-------------------------+
   | skesdqhkc6449hbqqar1 | my-ui-network    | my first network via ui |
   | c6449hbqqar1skesdqhk | my-yc-network    | my first network via yc |
   +----------------------+------------------+-------------------------+
   ```
   Получите тот же список c большим количеством деталей в формате YAML:
   ```
   yc vpc network list --format yaml

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
1. Создайте виртуальную машину и подключите к подсети `my-yc-subnet-b`:
   1. Подготовьте пару ключей (открытый и закрытый) для SSH-доступа на виртуальную машину.
   1. Создайте виртуальную машину Linux:
      ```
      yc compute instance create \
          --name my-yc-instance \
          --network-interface subnet-name=my-yc-subnet-b,nat-ip-version=ipv4 \
          --zone ru-central1-b \
          --ssh-key ~/.ssh/id_rsa.pub
      ```
      В параметре `ssh-key` передайте путь к открытому ключу для SSH-доступа. В ОС виртуальной машины будет автоматически создан пользователь `yc-user` с указанным открытым ключом.
1. Подключитесь к виртуальной машине по SSH:
   1. Узнайте публичный IP-адрес виртуальной машины. Для этого посмотрите подробную информацию о вашей виртуальной машине:
      ```
      yc compute instance get my-yc-instance
      ```
      В выводе команды найдите адрес виртуальной машины в блоке `one_to_one_nat`:
      ```
      one_to_one_nat:
          address: 130.193.32.90
          ip_version: IPV4
      ```
   1. Подключитесь к виртуальной машине по SSH от имени пользователя `yc-user`, используя закрытый ключ:
      ```
      ssh yc-user@130.193.32.90
      ```
1. Удалите виртуальную машину `my-yc-instance`, подсеть `my-yc-subnet-b` и сеть `my-yc-network`:
   ```
   yc compute instance delete my-yc-instance
   yc vpc subnet delete my-yc-subnet-b
   yc vpc network delete my-yc-network
   ```
