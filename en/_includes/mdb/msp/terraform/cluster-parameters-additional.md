* {% include [Maintenance window](maintenance-window.md) %}

* To enable {{ SPRK }} History Server, add a section named `history_server` to the description of your cluster configuration:

    ```hcl
    resource "yandex_spark_cluster" "<cluster_name>" {
    ...
      config = {
      ...
        history_server = {
          enabled = <use_history_server:_true_or_false>
        }
      }
    }
    ```

* To connect a {{ metastore-name }} server to your cluster, add a section named `metastore` to the description of your cluster configuration:

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

* To connect additional deb and pip packages for running {{ SPRK }} jobs, add the `dependencies` section to the description of your cluster configuration:

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

    Where `deb_packages` and `pip_packages` are package names. Their format depends on the installation command: use `apt install` for deb packages and `pip install` for pip packages.