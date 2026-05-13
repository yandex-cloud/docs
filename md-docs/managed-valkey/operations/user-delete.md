# Удаление пользователя

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы удалить пользователя Valkey™:

  1. Посмотрите описание команды CLI для удаления пользователя:

      ```bash
      yc managed-redis user delete --help
      ```

  1. Удалите пользователя, выполнив команду:

      ```bash
      yc managed-redis user delete <имя_пользователя> \
        --cluster-id=<идентификатор_кластера>
      ```

      Где `--cluster-id` — идентификатор кластера. Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      Имя пользователя можно получить со [списком пользователей](user-list.md#list) в кластере.

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

  1. Удалите ресурс `yandex_mdb_redis_user` с описанием нужного пользователя.

  1. Проверьте корректность настроек.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Подтвердите изменение ресурсов.

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.

  1. Убедитесь, что пользователь удален, выполнив команду [CLI](../../cli/quickstart.md#install):

      ```bash
      yc managed-redis user list \
        --cluster-id=<идентификатор_кластера>
      ```

      [Подробнее о том, как получить список пользователей](user-list.md#list).

  {% note warning "Ограничения по времени" %}
  
  Провайдер Terraform ограничивает время на выполнение операций с кластером Yandex Managed Service for Valkey™:
  
  * создание, в т. ч. путем восстановления из резервной копии, — 15 минут;
  * изменение — 60 минут;
  * удаление — 15 минут.
  
  Операции, длящиеся дольше указанного времени, прерываются.
  
  {% cut "Как изменить эти ограничения?" %}
  
  Добавьте к описанию кластера блок `timeouts`, например:
  
  ```hcl
  resource "yandex_mdb_redis_cluster_v2" "<имя_кластера>" {
    ...
    timeouts = {
      create = "1h30m" # Полтора часа
      update = "2h"    # 2 часа
      delete = "30m"   # 30 минут
    }
  }
  ```
  
  {% endcut %}
  
  {% endnote %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

  1. Воспользуйтесь методом [User.Delete](../api-ref/User/delete.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

      ```bash
      curl \
        --request DELETE \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://mdb.api.cloud.yandex.net/managed-redis/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>'
      ```

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      Имя пользователя можно получить со [списком пользователей](user-list.md#list) в кластере.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/delete.md#yandex.cloud.operation.Operation).

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

  1. Воспользуйтесь вызовом [UserService.Delete](../api-ref/grpc/User/delete.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
        yandex.cloud.mdb.redis.v1.UserService.Delete
        ```

      Где:

      * `cluster_id` — идентификатор кластера.

        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

      * `user_name` — имя пользователя.

        Имя пользователя можно получить со [списком пользователей](user-list.md#list) в кластере.  

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/delete.md#yandex.cloud.operation.Operation).

{% endlist %}