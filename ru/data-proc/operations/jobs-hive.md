# Управление заданиями Hive

В кластере {{ dataproc-name }} можно управлять [заданиями (jobs)](../concepts/jobs.md), а также получать логи их выполнения. Примеры заданий см. в разделе [{#T}](../tutorials/job-overview.md).

## Создать задание {#create}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ dataproc-name }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Задания**.
    1. Нажмите кнопку **Создать задание**.
    1. (опционально) Укажите имя задания.
    1. В поле **Тип задания** выберите `Hive`.
    1. Укажите **Настройки** в виде пары `ключ-значение`.

       {% include [job-properties-requirements](../../_includes/data-proc/job-properties-requirements.md) %}

    1. (опционально) Включите настройку **Продолжать при ошибке**.
    1. Укажите **Переменные скрипта** в виде пары `ключ-значение`.
    1. (опционально) Укажите пути к JAR-файлам, если они используются:

        {% include [jar-file-path-requirements](../../_includes/data-proc/jar-file-path-requirements.md) %}

    1. Выберите один из типов драйвера и укажите, что использовать для запуска задания:
        * список запросов, которые необходимо выполнить;
        * путь к файлу с запросами, которые нужно выполнить.
    1. Нажмите кнопку **Создать задание**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать задание:

    1. Посмотрите описание команды CLI для создания заданий типа `Hive`:

        ```bash
        {{ yc-dp }} job create-hive --help
        ```

    1. Создайте задание (в примере приведены не все доступные параметры):

        ```bash
        {{ yc-dp }} job create-hive \
           --cluster-name=<имя кластера> \
           --name=<имя задания> \
           --query-file-uri=<URI файла запроса> \
           --script-variables=<список значений переменных, разделенных запятыми>
        ```

        Пути к необходимым для выполнения задания файлам передавайте в формате:

        {% include [jar-file-path-requirements](../../_includes/data-proc/jar-file-path-requirements.md) %}

    Идентификатор и имя кластера можно получить со [списком кластеров в каталоге](./cluster-list.md#list).

- API

    Воспользуйтесь методом API [create](../api-ref/Job/create) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Его можно получить со [списком кластеров в каталоге](./cluster-list.md#list).
    * Имя задания в параметре `name`.
    * Свойства задания в параметре `hiveJob`.

{% endlist %}

## Отменить задание {#cancel}

{% include [jobs-cancel](../../_includes/data-proc/jobs-cancel.md) %}

## Получить список заданий {#list}

{% include [jobs-list](../../_includes/data-proc/jobs-list.md) %}

## Получить общую информацию о задании {#get-info}

{% include [jobs-get-info](../../_includes/data-proc/jobs-get-info.md) %}

{% if product == "yandex-cloud" %}

## Получить логи выполнения задания {#get-logs}

{% include [jobs-get-logs](../../_includes/data-proc/jobs-get-logs.md) %}

{% endif %}
