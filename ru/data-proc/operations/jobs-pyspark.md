---
title: "Как управлять заданиями PySpark в {{ dataproc-full-name }}"
description: "Из статьи вы узнаете, как управлять заданиями PySpark в {{ dataproc-full-name }}."
---

# Управление заданиями PySpark

## Создать задание {#create}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ dataproc-name }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Задания**.
    1. Нажмите кнопку **Создать задание**.
    1. (опционально) Укажите имя задания.
    1. В поле **Тип задания** выберите `PySpark`.
    1. В поле **Main python файл** укажите путь к основному PY-файлу приложения в формате:

        {% include [jar-file-path-requirements](../../_includes/data-proc/jar-file-path-requirements.md) %}

    1. (опционально) Укажите пути к PY-файлам, если они используются.
    1. Укажите аргументы задания.

       {% include [job-properties-requirements](../../_includes/data-proc/job-properties-requirements.md) %}

    1. (опционально) Укажите пути к JAR-файлам, если они используются.
    1. (опционально) Задайте продвинутые настройки:
        * Пути к необходимым файлам и архивам.
        * **Настройки** в виде пары `ключ-значение`.
    1. Нажмите кнопку **Создать задание**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать задание:

    1. Посмотрите описание команды CLI для создания заданий типа `PySpark`:

        ```bash
        {{ yc-dp }} job create-pyspark --help
        ```

    1. Создайте задание (в примере приведены не все доступные параметры):

        ```bash
        {{ yc-dp }} job create-pyspark \
           --cluster-name=<имя кластера> \
           --name=<имя задания> \
           --main-python-file-uri=<путь к основному py-файлу приложения> \
           --python-file-uris=<пути к дополнительным py-файлам> \
           --jar-file-uris=<пути к jar-файлам> \
           --archive-uris=<пути к архивам> \
           --properties=<ключ-значение> \
           --args=<аргументы, передаваемые заданию> \
           --packages=<Maven координаты jar-файлов в формате groupId:artifactId:version> \
           --repositories=<дополнительные репозитории для поиска packages> \
           --exclude-packages=<пакеты в формате groupId:artifactId, которые надо исключить>
        ```

        Пути к необходимым для выполнения задания файлам передавайте в формате:

        {% include [jar-file-path-requirements](../../_includes/data-proc/jar-file-path-requirements.md) %}

    Идентификатор и имя кластера можно получить со [списком кластеров в каталоге](./cluster-list.md#list).

- API

    Воспользуйтесь методом API [create](../api-ref/Job/create) и передайте в запросе:

    * идентификатор кластера в параметре `clusterId`;
    * имя задания в параметре `name`;
    * свойства задания в параметре `pysparkJob`.

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

