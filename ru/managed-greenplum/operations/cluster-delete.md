# Удаление кластера

## Перед удалением кластера {#before-you-delete}

[Отключите защиту от удаления](./update.md#change-additional-settings) для кластера, если она включена.

## Удалить кластер {#delete}

{% list tabs %}

- Консоль управления

  1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mgp-name }}**.
  1. Нажмите на значок ![image](../../_assets/options.svg) для нужного кластера и выберите пункт **Удалить кластер**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы удалить кластер, выполните команду:

    ```bash
    {{ yc-mdb-gp }} cluster delete <идентификатор или имя кластера>
    ```

    Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API

    Воспользуйтесь методом API [delete](../api-ref/Cluster/delete.md) и передайте идентификатор кластера в параметре `clusterId` запроса.

    Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
