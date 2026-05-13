# Получение информации о пользователях

Yandex Managed Service for Valkey™ позволяет создавать пользователей Valkey™ и настраивать их разрешения на команды, ключи и каналы Pub/Sub кластера с помощью списков контроля доступа [Valkey™ ACL](https://valkey.io/topics/acl).

Valkey™ ACL решает две основные задачи:

* обеспечивает безопасность, разграничивая доступ к командам и ключам;
* защищает от случайных ошибок, вызванных действиями пользователя или программным сбоем.

Вместе с кластером создается пользователь по умолчанию `default`. Он имеет разрешения на все ключи и каналы Pub/Sub кластера, а также может выполнять все команды, кроме административных. Подробные разрешения пользователя можно получить с [информацией о пользователе](user-list.md#get).

## Получить список пользователей {#list}

{% list tabs group=instructions %}

- CLI {#cli}
  
  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список пользователей:

  1. Посмотрите описание команды CLI для получения списка пользователей:

      ```bash
      yc managed-redis user list --help
      ```
  
  1. Получите список пользователей, выполнив команду:

      ```bash
      yc managed-redis user list \
        --cluster-id=<идентификатор_кластера> 
      ```

      Где `--cluster-id` — идентификатор кластера.

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

- REST API {#api}
    
  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Воспользуйтесь методом [User.List](../api-ref/User/list.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://mdb.api.cloud.yandex.net/managed-redis/v1/clusters/<идентификатор_кластера>/users'
      ```

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/list.md#yandex.cloud.mdb.redis.v1.ListUsersResponse).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

  1. Воспользуйтесь вызовом [UserService.List](../api-ref/grpc/User/list.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/user_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
          "cluster_id": "<идентификатор_кластера>"
        }' \
        mdb.api.cloud.yandex.net:443 \
        yandex.cloud.mdb.redis.v1.UserService.List
        ```
    
      Где `cluster_id` — идентификатор кластера.
      
      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.  

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/list.md#yandex.cloud.mdb.redis.v1.ListUsersResponse).

{% endlist %}

## Получить информацию о пользователе {#get}

{% list tabs group=instructions %}

- CLI {#cli}
  
  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить информацию о конкретном пользователе:

  1. Посмотрите описание команды CLI для получения информации о пользователе:

      ```bash
      yc managed-redis user get --help
      ```
  
  1. Получите информацию о пользователе, выполнив команду:

      ```bash
      yc managed-redis user get <имя_пользователя> \
        --cluster-id=<идентификатор_кластера>
      ```

      Где `--cluster-id` — идентификатор кластера. Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      Имя пользователя можно получить со [списком пользователей](#list) в кластере.

- REST API {#api}
  
  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Воспользуйтесь методом [User.Get](../api-ref/User/get.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://mdb.api.cloud.yandex.net/managed-redis/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>'
      ```

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      Имя пользователя можно получить со [списком пользователей](#list) в кластере.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/get.md#yandex.cloud.mdb.redis.v1.User).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

  1. Воспользуйтесь вызовом [UserService.Get](../api-ref/grpc/User/get.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/user_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
          "cluster_id": "<идентификатор_кластера>",
          "user_name": "<имя_пользователя>"
        }' \
        mdb.api.cloud.yandex.net:443 \
        yandex.cloud.mdb.redis.v1.UserService.Get
        ```
      
      Где:

      * `cluster_id` — идентификатор кластера.
        
        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      * `user_name` — имя пользователя.
      
        Имя пользователя можно получить со [списком пользователей](#list) в кластере.  

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/get.md#yandex.cloud.mdb.redis.v1.User).

{% endlist %}