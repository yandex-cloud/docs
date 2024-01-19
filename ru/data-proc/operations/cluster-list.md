# Информация об имеющихся кластерах {{ dataproc-name }}

Доступна детальная информация о каждом созданном кластере {{ dataproc-name }}.

## Получить список кластеров в каталоге {#list}

{% list tabs group=instructions %}

- Консоль управления {#console}

    Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы запросить список кластеров {{ dataproc-name }} в каталоге по умолчанию, выполните команду:

    ```bash
    {{ yc-dp }} cluster list
    ```

- API {#api}

    Воспользуйтесь методом API [list](../api-ref/Cluster/list.md).

{% endlist %}

## Получить детальную информацию о кластере {#detail}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Нажмите на имя нужного кластера.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить детальную информацию о кластере {{ dataproc-name }}, выполните команду:

    ```bash
    {{ yc-dp }} cluster get <имя_или_идентификатор_кластера>
    ```

    Идентификатор и имя кластера можно получить со [списком кластеров в каталоге](#list).

- API {#api}

    Воспользуйтесь методом API [get](../api-ref/Cluster/get.md) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    Идентификатор кластера можно получить со [списком кластеров в каталоге](#list).

{% endlist %}

## Посмотреть список операций в кластере {#operations}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.dataproc.switch_operations }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список операций, выполните команду:

    ```bash
    {{ yc-dp }} cluster list-operations <имя_или_идентификатор_кластера>
    ```

    Идентификатор и имя кластера можно получить со [списком кластеров в каталоге](#list).

- API {#api}

    Воспользуйтесь методом API [listOperations](../api-ref/Cluster/listOperations.md) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    Идентификатор кластера можно получить со [списком кластеров в каталоге](#list).

{% endlist %}
