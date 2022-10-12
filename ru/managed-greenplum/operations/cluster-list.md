# Информация об имеющихся кластерах

Вы можете запросить детальную информацию о каждом созданном вами кластере {{ mgp-name }}.

## Получить список кластеров в каталоге {#list-clusters}

{% list tabs %}

- Консоль управления

    Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mgp-name }}**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы запросить список кластеров {{ GP }} в каталоге, выполните команду:

    ```bash
    {{ yc-mdb-gp }} cluster list
    ```

- API

    Воспользуйтесь методом API [list](../api-ref/Cluster/list.md).

{% endlist %}

## Получить детальную информацию о кластере {#get-cluster}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mgp-name }}**.
    1. Нажмите на имя нужного кластера.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить информацию о кластере {{ GP }}, выполните команду:

    ```bash
    {{ yc-mdb-gp }} cluster get <идентификатор или имя кластера>
    ```

    Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

- API

    Воспользуйтесь методом API [get](../api-ref/Cluster/get.md) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    Идентификатор кластера можно получить со [списком кластеров в каталоге](#list-clusters).

{% endlist %}

## Посмотреть список операций в кластере {#list-operations}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mgp-name }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![operations.svg](../../_assets/mdb/operations.svg) **Операции**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список операций, выполните команду:

    ```bash
    {{ yc-mdb-gp }} cluster list-operations <идентификатор или имя кластера>
    ```

    Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).

- API

    Воспользуйтесь методом API [listOperations](../api-ref/Cluster/listOperations.md) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    Идентификатор кластера можно получить со [списком кластеров в каталоге](#list-clusters).

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
