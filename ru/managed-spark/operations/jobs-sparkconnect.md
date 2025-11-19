---
title: Как управлять заданиями SparkConnect в {{ msp-full-name }}
description: Вы узнаете, как управлять заданиями SparkConnect в {{ msp-full-name }}.
---

# Управление заданиями SparkConnect

{% include notitle [preview](../../_includes/note-preview.md) %}

## Создать задание {#create}

{% note warning %}

Задание будет запущено автоматически после его создания.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.spark.jobs.create_action }}**.
    1. Укажите имя задания.
    1. В поле **{{ ui-key.yacloud.dataproc.jobs.field_job-type }}** выберите `SparkConnect`.
    1. (Опционально) Задайте продвинутые настройки:

        * Укажите пути к нужным файлам и архивам.
        * Укажите пути к JAR-файлам в формате:

          {% include [jar-file-path-requirements](../../_includes/managed-spark/jar-file-path-requirements.md) %}

        * В поле **{{ ui-key.yacloud.dataproc.jobs.field_properties }}** укажите свойства компонентов в виде пар `ключ-значение`.
        * Укажите координаты используемых и исключаемых Maven-пакетов, а также URL дополнительных репозиториев для поиска пакетов.

    1. Нажмите кнопку **{{ ui-key.yacloud.dataproc.jobs.button_create }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать задание SparkConnect:

    1. Посмотрите описание команды CLI для создания задания:

        ```bash
        yc managed-spark job create-spark-connect --help
        ```
    
    1. Создайте задание, выполнив команду:

        ```bash
        yc managed-spark job create-spark-connect \
          --cluster-id <идентификатор_кластера> \
          --name <имя_задания> \
          --jar-file-uris <список_путей_к_JAR-файлам> \
          --file-uris <список_путей_к_файлам> \
          --archive-uris <список_путей_к_архивам> \
          --packages <список_Maven-координат_пакетов> \
          --repositories <список_URL_репозиториев_для_поиска_пакетов>\
          --exclude-packages <список_Maven-координат_исключаемых_пакетов> \
          --properties <список_свойств> 
        ```

        Где:

        * `--cluster-id` — идентификатор кластера.

          Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        * `--name` (Опционально) — имя задания.
        * `--jar-file-uris` — список путей к используемым JAR-файлам в формате:
          
          {% include [jar-file-path-requirements](../../_includes/managed-spark/jar-file-path-requirements.md) %}
        
        * `--file-uris` — список путей к используемым файлам.
        * `--archive-uris` — список путей к используемым архивам.
        * `--packages` — список Maven-координат JAR-файлов в формате `groupId:artifactId:version`.
        * `--repositories` — список URL дополнительных репозиториев для поиска пакетов.
        * `--exclude-packages` — список Maven-координат пакетов, которые нужно исключить, в формате `groupId:artifactId`.
        * `--properties` — список свойств компонентов в формате `ключ=значение`.

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [JobService.Create](../api-ref/grpc/Job/create.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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
            "spark_connect_job": {
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
                <список_свойств>
              },
              "packages": [
                <список_Maven-координат_пакетов>
              ],
              "repositories": [
                <список_URL_репозиториев_для_поиска_пакетов>
              ],
              "exclude_packages": [
                <список_Maven-координат_исключаемых_пакетов>
              ]
            }
          }' \
          {{ api-host-spark }}:{{ port-https }} \
          yandex.cloud.spark.v1.JobService.Create
        ```

        Где:

        * `cluster_id` — идентификатор кластера.

            Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
        
        * `name` (Опционально) — имя задания.
        * `spark_connect_job` — параметры SparkConnect-задания:

            * `jar_file_uris` — список путей к используемым JAR-файлам в формате:
              
              {% include [jar-file-path-requirements](../../_includes/managed-spark/jar-file-path-requirements.md) %}

            * `file_uris` — список путей к используемым файлам.
            * `archive_uris` — список путей к используемым архивам.
            * `properties` — список свойств компонентов в формате `"ключ":"значение"`.
            * `packages` — список Maven-координат JAR-файлов в формате `groupId:artifactId:version`.
            * `repositories` — список URL дополнительных репозиториев для поиска пакетов.
            * `exclude_packages` — список Maven-координат пакетов, которые нужно исключить, в формате `groupId:artifactId`.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Job/create.md#yandex.cloud.operation.Operation).

{% endlist %}

Для запущенных заданий SparkConnect доступен эндпоинт, который можно использовать для [подключения через PySpark](connect.md). Эндпоинт можно получить с [информацией о задании](#get-info). Его значение указано в поле `connect_url` CLI и API или в поле **{{ ui-key.yacloud.spark.label_connect-url }}** в консоли управления.

> Например: `sc://connect-api-c9q9veov4uql********-c9q8ml85r1oh********.spark.yandexcloud.net:443`.

## Отменить задание {#cancel}

{% include [jobs-cancel](../../_includes/managed-spark/jobs-cancel.md) %}

## Получить список заданий {#list}

{% include [jobs-list](../../_includes/managed-spark/jobs-list.md) %}

## Получить общую информацию о задании {#get-info}

{% include [jobs-get-info](../../_includes/managed-spark/jobs-get-info.md) %}

## Получить логи выполнения задания {#get-logs}

{% include [jobs-get-logs](../../_includes/managed-spark/jobs-get-logs.md) %}
