* {% include [Maintenance window](maintenance-window.md) %}

* To enable {{ SPRK }} History Server, add a section named `history_server` to the cluster configuration description:

    ```hcl
    resource "yandex_spark_cluster" "<cluster_name>" {
    ...
      config = {
      ...
        history_server = {
          enabled = true
        }
      }
    }
    ```

* To connect an [{{ metastore-name }} server](../../../../metadata-hub/concepts/metastore.md) to your cluster, add the `metastore` section to the cluster configuration description:

    ```hcl
    resource "yandex_spark_cluster" "<cluster_name>" {
    ...
      config = {
      ...
        metastore = {
          cluster_id = "<metastore_cluster_ID>"
        }
      }
    }
    ```

* To connect additional deb and pip packages for running {{ SPRK }} jobs, add the `dependencies` section to the cluster configuration description:

    ```hcl
    resource "yandex_spark_cluster" "<cluster_name>" {
    ...
      config = {
      ...
        dependencies = {
          deb_packages = ["<list_of_deb_packages>"]
          pip_packages = ["<list_of_pip_packages>"]
        }
      }
    }
    ```

    Where `deb_packages` and `pip_packages` are package names. Their format depends on the installation command: `apt install` for deb packages and `pip install` for pip packages.