# Информация об имеющихся кластерах

Вы можете запросить детальную информацию о каждом созданном вами кластере {{ dataproc-name }}.

## Получить список кластеров в каталоге {#list}

{% list tabs %}

* Консоль управления

    Перейдите на страницу каталога и выберите сервис **{{ dataproc-name }}**.

* CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы запросить список кластеров {{ dataproc-name }} в каталоге по умолчанию, выполните команду:

    ```bash
    yc dataproc cluster list
    ```

* API

    Получить список кластеров можно с помощью метода [list](../api-ref/Cluster/list.md).

{% endlist %}

## Получить детальную информацию о кластере {#detail}

{% list tabs %}

* Консоль управления

    1. Перейдите на страницу каталога и выберите сервис **{{ dataproc-name }}**.
    1. Нажмите на имя нужного кластера.

* CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить детальную информацию о кластере {{ dataproc-name }}, выполните команду:

    ```bash
    yc dataproc cluster get <имя или идентификатор кластера>
    ```

    Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](#list).

* API

    Получить детальную информацию о кластере можно с помощью метода [get](../api-ref/Cluster/get.md).

{% endlist %}

## Посмотреть список операций в кластере {#operations}

{% list tabs %}

* Консоль управления

    1. Перейдите на страницу каталога и выберите сервис **{{ dataproc-name }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Операции**.

* CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список операций, выполните команду:

    ```bash
    yc dataproc cluster list-operations <имя или идентификатор кластера>
    ```

    Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](#list).

* API

    Получить список операций в кластере можно с помощью метода [listOperations](../api-ref/Cluster/listOperations.md).

{% endlist %}
