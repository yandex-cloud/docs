---
title: "Инструкция по управлению заданиями Spark в {{ dataproc-full-name }}"
description: "Из статьи вы узнаете, как управлять заданиями Spark в {{ dataproc-full-name }}."
---

# Управление заданиями Spark

## Создать задание {#create}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ dataproc-name }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Задания**.
    1. Нажмите кнопку **Создать задание**.
    1. (опционально) Укажите имя задания.
    1. В поле **Тип задания** выберите `Spark`.
    1. В поле **Основной JAR файл** укажите путь к основному JAR-файлу приложения в формате:

        {% include [jar-file-path-requirements](../../_includes/data-proc/jar-file-path-requirements.md) %}

    1. В поле **Основной класс** укажите имя основного класса приложения.
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

    1. Посмотрите описание команды CLI для создания заданий типа `spark`:

        ```bash
        {{ yc-dp }} job create-spark --help
        ```

    1. Создайте задание (в примере приведены не все доступные параметры):

        ```bash
        {{ yc-dp }} job create-spark \
           --cluster-name=<имя кластера> \
           --name=<имя задания> \
           --main-class=<имя основного класса приложения> \
           --main-jar-file-uri=<путь к основному jar-файлу> \
           --jar-file-uris=<путь к jar-файлу> \
           --file-uris=<путь к файлу> \
           --archive-uris=<путь к архиву> \
           --properties=<ключ-значение> \
           --args=<аргументы, передаваемые заданию> \
           --packages=<Maven координаты jar-файлов в формате groupId:artifactId:version> \
           --repositories=<дополнительные репозитории для поиска packages> \
           --exclude-packages=<пакеты в формате groupId:artifactId, которые надо исключить>
        ```

        Пути к необходимым для выполнения задания файлам передавайте в формате:

        {% include [job-properties-requirements](../../_includes/data-proc/jar-file-path-requirements.md) %}

    Идентификатор и имя кластера можно получить со [списком кластеров в каталоге](./cluster-list.md#list).

- API

    Воспользуйтесь методом API [create](../api-ref/Job/create) и передайте в запросе:

    * идентификатор кластера в параметре `clusterId`;
    * имя задания в параметре `name`;
    * свойства задания в параметре `sparkJob`.

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

