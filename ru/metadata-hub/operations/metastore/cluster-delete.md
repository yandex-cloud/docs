# Удаление кластера {{ metastore-full-name }}

Вы можете удалить кластер {{ metastore-name }} вместе со всеми хранимыми данными. Перед этим [отключите](cluster-update.md) защиту кластера от удаления, если она включена.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. На левой панели выберите страницу ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
    1. Нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) для нужного кластера и выберите пункт ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-delete }}**.
    1. Подтвердите удаление кластера.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы удалить кластер {{ metastore-name }}, выполните команду:

  ```bash
  {{ yc-metastore }} cluster delete <имя_или_идентификатор_кластера>
  ```
  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}


