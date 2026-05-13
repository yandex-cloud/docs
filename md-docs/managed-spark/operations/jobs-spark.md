# Управление заданиями Spark

## Создать задание {#create}

{% note warning %}

Задание будет запущено автоматически после его создания.

{% endnote %}

Чтобы создать задание:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога](https://console.yandex.cloud).
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for Apache Spark**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Задания**.
    1. Нажмите кнопку **Создать задание**.
    1. Укажите имя задания.
    1. В поле **Тип задания** выберите `Spark`.
    1. В поле **Основной JAR файл** укажите путь к основному JAR-файлу приложения в формате:

        | Размещение файла                                                | Формат пути                                          |
        |-----------------------------------------------------------------|------------------------------------------------------|
        | Файловая система инстанса                                       | `file:///<путь_к_файлу>`                             |
        | [Бакет Object Storage](../../storage/concepts/bucket.md) | `s3a://<имя_бакета>/<путь_к_файлу>`                  |
        | Интернет                                                        | `http://<путь_к_файлу>` или `https://<путь_к_файлу>` |
        
        Допускается использование архивов стандартных для Linux форматов: `zip`, `gz`, `xz`, `bz2` и т. д.
        
        Сервисному аккаунту кластера необходим доступ на чтение ко всем файлам в бакете. Пошаговые инструкции по настройке доступа к Object Storage приведены в разделе [Редактирование ACL бакета](../../storage/operations/buckets/edit-acl.md).

    1. В поле **Основной класс** укажите имя основного класса приложения.
    1. Укажите аргументы задания.

        Если аргумент, переменная или свойство состоит из нескольких частей, разделенных пробелом, указывайте каждую часть отдельно. При этом важно сохранить порядок объявления аргументов, переменных и свойств.
        
        Например, аргумент `-n 1000` должен быть преобразован в два аргумента `-n` и `1000`, стоящих последовательно.

    1. (Опционально) Укажите пути к JAR-файлам, если они используются.
    1. (Опционально) Задайте продвинутые настройки:

        * Укажите пути к необходимым файлам и архивам.
        * В поле **Настройки** укажите [свойства Apache Spark™](../concepts/spark-properties.md) в виде пар «ключ-значение».
        * Укажите координаты используемых и исключаемых Maven-пакетов, а также URL дополнительных репозиториев для поиска пакетов.

    1. Нажмите кнопку **Создать задание**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы создать задание Spark:

    1. Посмотрите описание команды CLI для создания задания:

        ```bash
        yc managed-spark job create-spark --help
        ```
    
    1. Создайте задание, выполнив команду:

        ```bash
        yc managed-spark job create-spark \
          --cluster-id <идентификатор_кластера> \
          --name <имя_задания> \
          --main-class <имя_основного_класса> \
          --main-jar-file-uri <путь_к_основному_JAR-файлу> \
          --jar-file-uris <список_путей_к_JAR-файлам> \
          --file-uris <список_путей_к_файлам> \
          --archive-uris <список_путей_к_архивам> \
          --packages <список_Maven-координат_пакетов> \
          --repositories <список_URL_репозиториев_для_поиска_пакетов> \
          --exclude-packages <список_Maven-координат_исключаемых_пакетов> \
          --properties <список_свойств_Apache_Spark™> \
          --args <список_аргументов> 
        ```

        Где:

        * `--cluster-id` — идентификатор кластера.

          Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        * (Опционально) `--name` — имя задания.
        * `--main-class` — имя основного класса приложения.
        * `--main-jar-file-uri` — путь к основному JAR-файлу приложения.
        * `--jar-file-uris` — список путей к используемым JAR-файлам.
        * `--file-uris` — список путей к используемым файлам.
        * `--archive-uris` — список путей к используемым архивам.
        * `--packages` — список Maven-координат пакетов в формате `groupId:artifactId:version`.
        * `--repositories` — список URL дополнительных репозиториев для поиска пакетов.
        * `--exclude-packages` — список Maven-координат пакетов, которые нужно исключить, в формате `groupId:artifactId`.
        * `--properties` — список [свойств Apache Spark™](../concepts/spark-properties.md) в формате `ключ=значение`.
        * `--args` — список аргументов приложения.

        Доступные форматы файлов:
          
          | Размещение файла                                                | Формат пути                                          |
          |-----------------------------------------------------------------|------------------------------------------------------|
          | Файловая система инстанса                                       | `file:///<путь_к_файлу>`                             |
          | [Бакет Object Storage](../../storage/concepts/bucket.md) | `s3a://<имя_бакета>/<путь_к_файлу>`                  |
          | Интернет                                                        | `http://<путь_к_файлу>` или `https://<путь_к_файлу>` |
          
          Допускается использование архивов стандартных для Linux форматов: `zip`, `gz`, `xz`, `bz2` и т. д.
          
          Сервисному аккаунту кластера необходим доступ на чтение ко всем файлам в бакете. Пошаговые инструкции по настройке доступа к Object Storage приведены в разделе [Редактирование ACL бакета](../../storage/operations/buckets/edit-acl.md).

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

    1. Воспользуйтесь вызовом [JobService.Create](../api-ref/grpc/Job/create.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/spark/v1/job_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                   "cluster_id": "<идентификатор_кластера>",
                   "name": "<имя_задания>",
                   "spark_job": {
                     "args": [
                       <список_аргументов>
                     ],
                     "jar_file_uris": [
                       <список_путей_к_JAR-файлам>
                     ],
                     "file_uris": [
                       <список_путей_к_файлам>
                     ],
                     "archive_uris": [
                       <список_путей_к_архивам>
                     ],
                     "properties": {
                       <список_свойств_Apache_Spark™>
                     },
                     "main_jar_file_uri": "<путь_к_основному_JAR-файлу>",
                     "main_class": "<имя_основного_класса>",
                     "packages": [
                       <список_Maven-координат_пакетов>
                     ],
                     "repositories": [
                       <URL_репозиториев_для_поиска_пакетов>
                     ],
                     "exclude_packages": [
                       <список_Maven-координат_исключаемых_пакетов>
                     ]
                   }
               }' \
            spark.api.cloud.yandex.net:443 \
            yandex.cloud.spark.v1.JobService.Create
        ```

        Где:

        * `name` — имя Spark-задания.
        * `spark_job` — параметры Spark-задания:

            * `args` — аргументы задания.
            * `jar_file_uris` — пути к используемым JAR-файлам.
            * `file_uris` — пути к используемым файлам.
            * `archive_uris` — пути к используемым архивам.
            * `properties` — [свойства Apache Spark™](../concepts/spark-properties.md) в виде пар `«ключ:значение»`.
            * `main_jar_file_uri` — путь к основному JAR-файлу приложения в формате:

                | Размещение файла                                                | Формат пути                                          |
                |-----------------------------------------------------------------|------------------------------------------------------|
                | Файловая система инстанса                                       | `file:///<путь_к_файлу>`                             |
                | [Бакет Object Storage](../../storage/concepts/bucket.md) | `s3a://<имя_бакета>/<путь_к_файлу>`                  |
                | Интернет                                                        | `http://<путь_к_файлу>` или `https://<путь_к_файлу>` |
                
                Допускается использование архивов стандартных для Linux форматов: `zip`, `gz`, `xz`, `bz2` и т. д.
                
                Сервисному аккаунту кластера необходим доступ на чтение ко всем файлам в бакете. Пошаговые инструкции по настройке доступа к Object Storage приведены в разделе [Редактирование ACL бакета](../../storage/operations/buckets/edit-acl.md).

            * `main_class` — имя основного класса приложения.
            * `packages` — Maven-координаты пакетов в формате `groupId:artifactId:version`.
            * `repositories` — URL дополнительных репозиториев для поиска пакетов.
            * `exclude_packages` — Maven-координаты пакетов, которые нужно исключить, в формате `groupId:artifactId`.

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Job/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Отменить задание {#cancel}

{% note info %}

Задания в статусах `ERROR`, `DONE` или `CANCELLED` отменить нельзя. Чтобы узнать статус задания, [получите список заданий](#list) в кластере.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога](https://console.yandex.cloud).
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for Apache Spark**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Задания**.
    1. Нажмите на имя нужного задания.
    1. В правом верхнем углу страницы нажмите кнопку **Отменить**.
    1. В открывшемся окне выберите **Отменить задание**.

- CLI {#cli}
    
    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).
    
    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
    
    Чтобы отменить задание:

    1. Посмотрите описание команды CLI для отмены задания:

        ```bash
        yc managed-spark job cancel --help
        ```
    
    1. Отмените задание, выполнив команду:

        ```bash
        yc managed-spark job cancel <имя_или_идентификатор_задания> \
          --cluster-id <идентификатор_кластера>
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        Имя и идентификатор задания можно получить со [списком заданий в кластере](#list).

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

    1. Воспользуйтесь вызовом [JobService.Cancel](../api-ref/grpc/Job/cancel.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/spark/v1/job_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                   "cluster_id": "<идентификатор_кластера>",
                   "job_id": "<идентификатор_задания>"
               }' \
            spark.api.cloud.yandex.net:443 \
            yandex.cloud.spark.v1.JobService.Cancel
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters), идентификатор задания — со [списком заданий в кластере](#list).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Job/cancel.md#yandex.cloud.operation.Operation).

{% endlist %}

## Получить список заданий {#list}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога](https://console.yandex.cloud).
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for Apache Spark**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Задания**.

- CLI {#cli}
    
    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).
    
    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
    
    Чтобы получить список заданий кластера:

    1. Посмотрите описание команды CLI для получения списка заданий:

        ```bash
        yc managed-spark job list --help
        ```
    
    1. Получите список заданий, выполнив команду:

        ```bash
        yc managed-spark job list \
          --cluster-id <идентификатор_кластера>
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

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

    1. Воспользуйтесь вызовом [JobService.List](../api-ref/grpc/Job/list.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/spark/v1/job_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                   "cluster_id": "<идентификатор_кластера>"
               }' \
            spark.api.cloud.yandex.net:443 \
            yandex.cloud.spark.v1.JobService.List
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Job/list.md#yandex.cloud.spark.v1.ListJobsResponse).

{% endlist %}

## Получить общую информацию о задании {#get-info}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога](https://console.yandex.cloud).
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for Apache Spark**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Задания**.
    1. Нажмите на имя нужного задания.

- CLI {#cli}
    
    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).
    
    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
    
    Чтобы получить информацию о задании:

    1. Посмотрите описание команды CLI для получения информации о задании:

        ```bash
        yc managed-spark job get --help
        ```
    
    1. Получите информацию о задании, выполнив команду:

        ```bash
        yc managed-spark job get <идентификатор_задания> \
          --cluster-id <идентификатор_кластера>
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        Идентификатор задания можно получить со [списком заданий в кластере](#list).

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

    1. Воспользуйтесь вызовом [JobService.Get](../api-ref/grpc/Job/get.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/spark/v1/job_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                   "cluster_id": "<идентификатор_кластера>",
                   "job_id": "<идентификатор_задания>"
               }' \
            spark.api.cloud.yandex.net:443 \
            yandex.cloud.spark.v1.JobService.Get
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters), идентификатор задания — со [списком заданий в кластере](#list).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Job/get.md#yandex.cloud.spark.v1.Job).

{% endlist %}

## Получить логи выполнения задания {#get-logs}

{% note warning %}

Чтобы получать логи выполнения заданий, включите запись логов в кластере при его [создании](cluster-create.md).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога](https://console.yandex.cloud).
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for Apache Spark**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Задания**.
    1. Нажмите на имя нужного задания.
    1. В поле **Логи выполнения задания** нажмите на ссылку.

- CLI {#cli}
    
    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).
    
    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
    
    Чтобы получить логи выполнения задания:

    1. Посмотрите описание команды CLI для получения логов задания:

        ```bash
        yc managed-spark job log --help
        ```
    
    1. Получите логи задания, выполнив команду:

        ```bash
        yc managed-spark job log <идентификатор_задания> \
          --cluster-id <идентификатор_кластера>
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        Идентификатор задания можно получить со [списком заданий в кластере](#list).

        Чтобы получить логи нескольких заданий, перечислите их идентификаторы через пробел, например:
        
        ```bash
        yc managed-spark job log c9q9veov4uql******** c9qu8uftedte******** \
          --cluster-id c9q8ml85r1oh********
        ```

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

    1. Воспользуйтесь вызовом [JobService.ListLog](../api-ref/grpc/Job/listLog.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/spark/v1/job_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                   "cluster_id": "<идентификатор_кластера>",
                   "job_id": "<идентификатор_задания>"
               }' \
            spark.api.cloud.yandex.net:443 \
            yandex.cloud.spark.v1.JobService.ListLog
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), идентификатор задания — со [списком заданий в кластере](#list).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Job/listLog.md#yandex.cloud.spark.v1.ListJobLogResponse).

{% endlist %}