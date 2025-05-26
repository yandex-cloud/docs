---
title: Как управлять заданиями Spark в {{ msp-full-name }}
description: Из статьи вы узнаете, как управлять заданиями Spark в {{ msp-full-name }}.
---

# Управление заданиями Spark

{% include notitle [preview](../../_includes/note-preview.md) %}

## Создать задание {#create}

{% note warning %}

Задание будет запущено автоматически после его создания.

{% endnote %}

Чтобы создать задание:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.spark.jobs.create_action }}**.
    1. Укажите имя задания.
    1. В поле **{{ ui-key.yacloud.dataproc.jobs.field_job-type }}** выберите `{{ ui-key.yacloud.dataproc.jobs.field_spark-job-type }}`.
    1. В поле **{{ ui-key.yacloud.dataproc.jobs.field_main-jar }}** укажите путь к основному JAR-файлу приложения в формате:

        {% include [jar-file-path-requirements](../../_includes/managed-spark/jar-file-path-requirements.md) %}

    1. В поле **{{ ui-key.yacloud.dataproc.jobs.field_main-class }}** укажите имя основного класса приложения.
    1. Укажите аргументы задания.

        {% include [job-properties-requirements](../../_includes/managed-spark/job-properties-requirements.md) %}

    1. (Опционально) Укажите пути к JAR-файлам, если они используются.
    1. (Опционально) Задайте продвинутые настройки:

        * Укажите пути к необходимым файлам и архивам.
        * В поле **{{ ui-key.yacloud.dataproc.jobs.field_properties }}** укажите свойства компонентов в виде пар `ключ-значение`.
        * Укажите координаты используемых и исключаемых Maven-пакетов, а также URL дополнительных репозиториев для поиска пакетов.

    1. Нажмите кнопку **{{ ui-key.yacloud.dataproc.jobs.button_create }}**.

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [JobService.Create](../api-ref/grpc/Job/create.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
                       <список_свойств>
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
            {{ api-host-spark }}:{{ port-https }} \
            yandex.cloud.spark.v1.JobService.Create
        ```

        Где:

        * `name` — имя Spark-задания.
        * `spark_job` — параметры Spark-задания:

            * `args` — аргументы задания.
            * `jar_file_uris` — пути к используемым JAR-файлам.
            * `file_uris` — пути к используемым файлам.
            * `archive_uris` — пути к используемым архивам.
            * `properties` — свойства компонентов в виде пар `«ключ:значение»`.
            * `main_jar_file_uri` — путь к основному JAR-файлу приложения в формате:

                {% include [jar-file-path-requirements](../../_includes/data-processing/jar-file-path-requirements.md) %}

            * `main_class` — имя основного класса приложения.
            * `packages` — Maven-координаты JAR-файлов в формате `groupId:artifactId:version`.
            * `repositories` — URL дополнительных репозиториев для поиска пакетов.
            * `exclude_packages` — Maven-координаты пакетов, которые нужно исключить, в формате `groupId:artifactId`.

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Job/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Отменить задание {#cancel}

{% include [jobs-cancel](../../_includes/managed-spark/jobs-cancel.md) %}

## Получить список заданий {#list}

{% include [jobs-list](../../_includes/managed-spark/jobs-list.md) %}

## Получить общую информацию о задании {#get-info}

{% include [jobs-get-info](../../_includes/managed-spark/jobs-get-info.md) %}

## Получить логи выполнения задания {#get-logs}

{% include [jobs-get-logs](../../_includes/managed-spark/jobs-get-logs.md) %}
