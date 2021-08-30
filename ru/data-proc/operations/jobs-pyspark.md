# Управление заданиями PySpark

## Создать задание {#create}

{% list tabs %}

* Консоль управления

    1. Перейдите на страницу каталога и выберите сервис **{{ dataproc-name }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Задания**.
    1. Нажмите кнопку **Создать задание**.
    1. (Опционально) Укажите имя задания.
    1. В поле **Тип задания** выберите `PySpark`.
    1. В поле **Main python файл** укажите путь к основному PY-файлу приложения в формате:
       
       {% include [jar-file-path-requirements](../../_includes/data-proc/jar-file-path-requirements.md) %}
       
    1. Укажите пути к PY-файлам, если они используются.
    1. Укажите аргументы задания.
    
       {% include [job-properties-requirements](../../_includes/data-proc/job-properties-requirements.md) %}
       
    1. Укажите пути к JAR-файлам, если они используются.
    1. При необходимости задайте дополнительные настройки:
        * Укажите пути к необходимым файлам и архивам.
        * Укажите свойства задания.
    1. Нажмите кнопку **Создать задание**.

* CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать задание:

    1. Посмотрите описание команды CLI для создания заданий типа `PySpark`:

        ```bash
        yc dataproc job create-pyspark --help
        ```

    1. Создайте задание (в примере приведены не все доступные параметры):

        ```bash
        yc dataproc job create-pyspark \
           --cluster-name <имя кластера> \
           --name <имя задания> \
           --main-python-file-uri <путь к основному py-файлу приложения> \
           --python-file-uris <пути к дополнительным py-файлам> \
           --jar-file-uris <пути к jar-файлам> \
           --archive-uris <пути к архивам> \
           --properties <свойства задания> \
           --args <аргументы, передаваемые заданию>
        ```
       
        Пути к файлам, которые необходимы для выполнения задания, передавайте в формате:
                
        {% include [jar-file-path-requirements](../../_includes/data-proc/jar-file-path-requirements.md) %}

    Идентификатор и имя кластера можно получить со [списком кластеров в каталоге](./cluster-list.md#list).

* API

    Чтобы создать задание, воспользуйтесь методом API [create](../api-ref/Job/create) и передайте в запросе:

    * имя задания в параметре `name`;
    * свойства задания в параметре `pysparkJob`.

{% endlist %}

## Получить список заданий {#list}

{% list tabs %}

* Консоль управления

    1. Перейдите на страницу каталога и выберите сервис **{{ dataproc-name }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Задания**.

* CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список заданий, выполните команду:

    ```bash
    yc dataproc job list --cluster-name <имя кластера>
    ```

    Идентификатор и имя кластера можно получить со [списком кластеров в каталоге](./cluster-list.md#list).

* API

    Чтобы получить список заданий, воспользуйтесь методом API [list](../api-ref/Job/list).

{% endlist %}


## Получить общую информацию о задании {#get-info}

{% list tabs %}

* Консоль управления

    1. Перейдите на страницу каталога и выберите сервис **{{ dataproc-name }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Задания**.
    1. Нажмите на имя нужного задания.

* CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Для получения общей информации о задании выполните команду:

    ```bash
    yc dataproc job get \
       --cluster-name <имя кластера> \
       --name <имя задания>
    ```

    Идентификатор и имя кластера можно получить со [списком кластеров в каталоге](./cluster-list.md#list).

* API

    Чтобы получить общую информацию о задании, воспользуйтесь методом API [get](../api-ref/Job/list).

{% endlist %}


## Получить логи выполнения задания {#get-logs}

{% list tabs %}

* Консоль управления

    1. Перейдите на страницу каталога и выберите сервис **{{ dataproc-name }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Задания**.
    1. Нажмите на имя нужного задания.

* CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить логи выполнения задания, выполните команду:

    ```bash
    yc dataproc job log \
       --cluster-name <имя кластера> \
       --name <имя задания>
    ```

    Идентификатор и имя кластера можно получить со [списком кластеров в каталоге](./cluster-list.md#list).

* API

    Чтобы получить лог выполнения задания, воспользуйтесь методом API [listLog](../api-ref/Job/log).

{% endlist %}
