---
title: Как управлять заданиями Spark в {{ dataproc-full-name }}
description: Из статьи вы узнаете, как управлять заданиями Spark в {{ dataproc-full-name }}.
---

# Управление заданиями Spark

## Создать задание {#create}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.dataproc.jobs.button_create }}**.
    1. (Опционально) Укажите имя задания.
    1. В поле **{{ ui-key.yacloud.dataproc.jobs.field_job-type }}** выберите `{{ ui-key.yacloud.dataproc.jobs.field_spark-job-type }}`.
    1. В поле **{{ ui-key.yacloud.dataproc.jobs.field_main-jar }}** укажите путь к основному JAR-файлу приложения в формате:

        {% include [jar-file-path-requirements](../../_includes/data-processing/jar-file-path-requirements.md) %}

    1. В поле **{{ ui-key.yacloud.dataproc.jobs.field_main-class }}** укажите имя основного класса приложения.
    1. Укажите аргументы задания.

        {% include [job-properties-requirements](../../_includes/data-processing/job-properties-requirements.md) %}

    1. (Опционально) Укажите пути к JAR-файлам, если они используются.
    1. (Опционально) Задайте продвинутые настройки:

        * Укажите пути к необходимым файлам и архивам.
        * В поле **{{ ui-key.yacloud.dataproc.jobs.field_properties }}** укажите [свойства компонентов](../concepts/settings-list.md) в виде пары `ключ-значение`.

    1. Нажмите кнопку **{{ ui-key.yacloud.dataproc.jobs.button_create }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать задание:

    1. Посмотрите описание команды CLI для создания заданий типа `spark`:

        ```bash
        {{ yc-dp }} job create-spark --help
        ```

    1. Создайте задание (в примере приведены не все доступные параметры):

        ```bash
        {{ yc-dp }} job create-spark \
           --cluster-name=<имя_кластера> \
           --name=<имя_задания> \
           --main-class=<имя_основного_класса_приложения> \
           --main-jar-file-uri=<путь_к_основному_jar-файлу> \
           --jar-file-uris=<путь_к_jar-файлу> \
           --file-uris=<путь_к_файлу> \
           --archive-uris=<путь_к_архиву> \
           --properties=<свойства_компонентов> \
           --args=<аргументы> \
           --packages=<Maven_координаты_jar-файлов> \
           --repositories=<дополнительные_репозитории> \
           --exclude-packages=<пакеты_для_исключения>
        ```

        Где: 
        
        * `--properties` — свойства компонентов в виде пары `ключ-значение`.
        * `--args` — аргументы, передаваемые заданию.
        * `--packages` — Maven координаты jar-файлов в формате `groupId:artifactId:version`.
        * `--repositories` — дополнительные репозитории для поиска `packages`.
        * `--exclude-packages` — пакеты в формате `groupId:artifactId`, которые надо исключить.

        Пути к необходимым для выполнения задания файлам передавайте в формате:

        {% include [job-properties-requirements](../../_includes/data-processing/jar-file-path-requirements.md) %}

    Идентификатор и имя кластера можно получить со [списком кластеров в каталоге](./cluster-list.md#list).

- API {#api}

    Воспользуйтесь методом API [create](../api-ref/Job/create) и передайте в запросе:

    * идентификатор кластера в параметре `clusterId`;
    * имя задания в параметре `name`;
    * свойства задания в параметре `sparkJob`.

    Идентификатор кластера можно получить со [списком кластеров в каталоге](./cluster-list.md#list).

{% endlist %}

## Отменить задание {#cancel}

{% include [jobs-cancel](../../_includes/data-processing/jobs-cancel.md) %}

## Получить список заданий {#list}

{% include [jobs-list](../../_includes/data-processing/jobs-list.md) %}

## Получить общую информацию о задании {#get-info}

{% include [jobs-get-info](../../_includes/data-processing/jobs-get-info.md) %}


## Получить логи выполнения задания {#get-logs}

{% include [jobs-get-logs](../../_includes/data-processing/jobs-get-logs.md) %}

