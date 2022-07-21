# Начало работы с интерфейсом командной строки

{% if audience != "internal" %}

_Интерфейс командной строки {{ yandex-cloud }} (CLI)_ — скачиваемое программное обеспечение для управления вашими облачными ресурсами через командную строку.

{% else %}

Внутри Яндекса CLI (command-line interface) {{ yandex-cloud }} позволяет использовать:

* [{{mch-name}}](../managed-clickhouse/)
* [{{mes-name}}](../managed-elasticsearch/)
* [{{mkf-name}}](../managed-kafka/)
* [{{mmg-name}}](../managed-mongodb/)
* [{{mmy-name}}](../managed-mysql/)
* [{{mpg-name}}](../managed-postgresql/)
* [{{mrd-name}}](../managed-redis/)

{% endif %}

## Установка {#install}

{% include [install-cli](../_includes/cli/install-cli.md) %}

## Создание профиля {#initialize}

{% if audience == "internal" %}

{% note warning %}

Приведённая ниже инстукция будет работать в случае установки внутренней сборки CLI (из s3.mds.yandex.net), а не внешней (из storage.yandexcloud.net). В случае, если у вас используется внешняя сборка CLI, следуйте [этой инструкции](../mdb/cli.md).

Если у вас уже установлен CLI, вы можете понять, какая сборка у вас используется с помощью команды `yc version`. Если в версии присутствует `+yandex`, то сборка внутренняя. В противном случае сборка внешняя.

{% endnote %}

{% endif %}

Если вы еще не подключены к консоли управления, войдите в [консоль]({{ link-console-main }}) и примите пользовательское соглашение (нажмите **Войти**).

{% list tabs %}

- От имени пользователя

  {% if product == "yandex-cloud" %}
  
  Чтобы аутентифицироваться от имени пользователя:
  1. Получите OAuth-токен в сервисе Яндекс.OAuth. 
     1. Перейдите по [ссылке]({{ link-cloud-oauth }}). Если приложение запрашивает доступ к данным, пожалуйста, разрешите. Это необходимо для получения токена.
     1. Скопируйте в буфер обмена или сохраните полученный токен.
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

  {% if audience == "internal" %}
  1. Откажитесь от выбора зоны доступности по умолчанию для сервиса {{ compute-full-name }}:
     ```
     Do you want to configure a default {{ compute-full-name }} availability zone? [Y/n] N
     ```
  {% else %}
  1. Выберите зону доступности по умолчанию для сервиса {{ compute-full-name }}:

     {% include [include](../_includes/cli/choose-zone.md) %}

  {% endif %}
  1. Проверьте настройки вашего профиля CLI:
     ```
     yc config list
     ```
     
  {% endif %}

  {% if product == "cloud-il" %}

  1. Запустите интерактивное создание профиля:
 
     ```
     yc init \
       --endpoint {{ api-host }}:443 \
       --federation-endpoint {{ console-host }} \
       --federation-id google
     ```
  1. Выберите профиль, для которого вы хотите настроить аутентификацию, или создайте новый.
     ```
     Welcome! This command will take you through the configuration process.
     Pick desired action:
     [1] Re-initialize this profile 'default' with new settings
     [2] Create a new profile
     ```
  1. CLI выведет сообщение о продолжении аутентификации в браузере. Для продолжения нажмите клавишу **Enter**.
  
     ```
     You are going to be authenticated via federation-id 'google'.
     Your federation authentication web site will be opened.
     After your successful authentication, you will be redirected to '{{ link-console-main }}'.
  
     Press 'enter' to continue...
     ```
  
     {% include [include](../_includes/cli/success-auth-via-federation.md) %}
  
  1. Вернитесь в интерфейс командной строки, чтобы завершить создание профиля.
  
  1. Выберите одно из предложенных облаков, в которых у вас есть права доступа:
  
     {% include [include](../_includes/cli/choose-cloud.md) %}
  
     Если вам доступно только одно облако, оно будет выбрано автоматически.
  
  1. Выберите каталог по умолчанию:
  
     {% include [include](../_includes/cli/choose-folder.md) %}
  
  1. Выберите зону доступности по умолчанию для сервиса {{ compute-full-name }}:

     ```
     Do you want to configure a default {{ compute-full-name }} availability zone? [Y/n] Y
     Which zone do you want to use as a profile default?
     [1] {{ region-id }}-a
     [2] Don't set default zone
     Please enter your numeric choice: 1 
     ```
  
  1. Проверьте настройки вашего профиля CLI:
     ```
     yc config list
     federation-id: google
     endpoint: {{ api-host }}:443
     ...
     ```

  {% endif %}

{% if audience != "internal" %}

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
     --name my-yc-subnet-a \
     --zone {{ region-id }}-a \
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
1. Создайте виртуальную машину и подключите к подсети `my-yc-subnet-a`:
   1. Подготовьте пару ключей (открытый и закрытый) для SSH-доступа на виртуальную машину.
   1. Создайте виртуальную машину Linux:
      ```
      yc compute instance create \
        --name my-yc-instance \
        --network-interface subnet-name=my-yc-subnet-a,nat-ip-version=ipv4 \
        --zone {{ region-id }}-a \
        --ssh-key ~/.ssh/id_rsa.pub
      ```
      Где `ssh-key` – путь к открытому ключу для SSH-доступа. В ОС виртуальной машины будет автоматически создан пользователь `yc-user` с указанным открытым ключом.
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
1. Удалите виртуальную машину `my-yc-instance`, подсеть `my-yc-subnet-a` и сеть `my-yc-network`:
   ```
   yc compute instance delete my-yc-instance
   yc vpc subnet delete my-yc-subnet-a
   yc vpc network delete my-yc-network
   ```
{% endif %}
