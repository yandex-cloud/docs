* {% include [Maintenance window](maintenance-window.md) %}

* Чтобы включить сервис {{ SPRK }} History Server, добавьте в описание конфигурации кластера блок `history_server`:

    ```hcl
    resource "yandex_spark_cluster" "<имя_кластера>" {
    ...
      config = {
      ...
        history_server = {
          enabled = true
        }
      }
    }
    ```

* Чтобы подключить к вашему кластеру [Metastore-сервер](../../../../metadata-hub/concepts/metastore.md), добавьте в описание конфигурации кластера блок `metastore`:

    ```hcl
    resource "yandex_spark_cluster" "<имя_кластера>" {
    ...
      config = {
      ...
        metastore = {
          cluster_id = "<идентификатор_кластера_metastore>"
        }
      }
    }
    ```

* Чтобы подключить дополнительные deb- и pip-пакеты для запуска заданий {{ SPRK }}, добавьте в описание конфигурации кластера блок `dependencies`:

    ```hcl
    resource "yandex_spark_cluster" "<имя_кластера>" {
    ...
      config = {
      ...
        dependencies = {
          deb_packages = ["<список_deb-пакетов>"]
          pip_packages = ["<список_pip-пакетов>"]
        }
      }
    }
    ```

    Где `deb_packages` и `pip_packages` — названия пакетов. Их формат определяет команда установки: `apt install` — для deb-пакетов, `pip install` — для pip-пакетов.