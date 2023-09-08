---
title: "Как управлять заданиями MapReduce в {{ dataproc-full-name }}"
description: "Из статьи вы узнаете, как управлять заданиями MapReduce в {{ dataproc-full-name }}."
---

# Управление заданиями MapReduce

{% include [MapReduce](../../_includes/data-proc/mapreduce-intro.md) %}

## Создать задание {#create}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.dataproc.jobs.button_create }}**.
    1. (Опционально) Укажите имя задания.
    1. В поле **{{ ui-key.yacloud.dataproc.jobs.field_job-type }}** выберите `{{ ui-key.yacloud.dataproc.jobs.field_mapreduce-job-type }}`.
    1. Выберите один из типов драйвера и укажите, что использовать для запуска задания:
        * имя основного класса;
        * путь к основному JAR-файлу в формате:

           {% include [jar-file-path-requirements](../../_includes/data-proc/jar-file-path-requirements.md) %}

    1. Укажите аргументы задания.

       {% include [job-properties-requirements](../../_includes/data-proc/job-properties-requirements.md) %}

    1. (Опционально) Укажите пути к дополнительным JAR-файлам, если они используются.
    1. (Опционально) Задайте дополнительные настройки:

        * Укажите пути к необходимым файлам и архивам.
        * В поле **{{ ui-key.yacloud.dataproc.jobs.field_properties }}** укажите [свойства компонентов](../concepts/settings-list.md) в виде пары `ключ-значение`.

    1. Нажмите кнопку **{{ ui-key.yacloud.dataproc.jobs.button_create }}**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать задание:

    1. Посмотрите описание команды CLI для создания заданий типа `Mapreduce`:

        ```bash
        {{ yc-dp }} job create-mapreduce --help
        ```

    1. Создайте задание (в примере приведены не все доступные параметры):

        ```bash
        {{ yc-dp }} job create-mapreduce \
           --cluster-name=<имя кластера> \
           --name=<имя задания> \
           --main-class=<имя основного класса> \
           --file-uris=<путь к файлу> \
           --archive-uris=<пути к архивам> \
           --properties=<ключ-значение> \
           --args=<аргумент>
        ```

        Пути к необходимым для выполнения задания файлам передавайте в формате:

        {% include [jar-file-path-requirements](../../_includes/data-proc/jar-file-path-requirements.md) %}

    Идентификатор и имя кластера можно получить со [списком кластеров в каталоге](./cluster-list.md#list).

- API

    Воспользуйтесь методом API [create](../api-ref/Job/create) и передайте в запросе:

    * идентификатор кластера в параметре `clusterId`;
    * имя задания в параметре `name`;
    * свойства задания в параметре `mapreduceJob`.

    Идентификатор кластера можно получить со [списком кластеров в каталоге](./cluster-list.md#list).

{% endlist %}

## Отменить задание {#cancel}

{% include [jobs-cancel](../../_includes/data-proc/jobs-cancel.md) %}

## Получить список заданий {#list}

{% include [jobs-list](../../_includes/data-proc/jobs-list.md) %}

## Получить общую информацию о задании {#get-info}

{% include [jobs-get-info](../../_includes/data-proc/jobs-get-info.md) %}


## Получить логи выполнения задания {#get-logs}

{% include [jobs-get-logs](../../_includes/data-proc/jobs-get-logs.md) %}


{% note info %}

Для работы с MapReduce вы можете использовать библиотеки, которые находятся в директории `/usr/lib/hadoop-mapreduce/`.

{% endnote %}
