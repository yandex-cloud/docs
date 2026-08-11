### Bash {#bash}

Before connecting:

1. {% include [cli-install](../cli-install.md) %}
1. Install the YTsaurus CLI according to the [instructions](https://ytsaurus.tech/docs/en/api/cli/install).
1. Install the dependencies:

    ```bash
    sudo apt update && sudo apt install -y python3 python3-pip && \
    pip3 install ytsaurus-client-yc-auth
    ```

{% list tabs group=connection %}

- Connecting from a user VM {#from-yandex-vm}

  1. Get the access configuration file using the following YC CLI command:

     ```bash
     {{ yc-ytsaurus }} cluster get-configuration <cluster_name_or_ID> --private
     ```

     {% cut "Configuration file example" %}
     
     ```bash
     {
       auth_class = {
         module_name = "yc_managed_ytsaurus_auth";
         class_name = "IamTokenAuth";
       };
       proxy = {
         url = "http://hp.<{{ ytsaurus-name }}_cluster_ID>.ytsaurus.mdb.yandexcloud.net:32100";
         network_name = "external";
         http_proxy_role = "default";
       }
     }
     ```

     {% endcut %}

     The configuration file will be saved to `~/.yt/config`.

     You can get the cluster ID with the [list of clusters in the folder](../../managed-ytsaurus/operations/cluster-list.md#list-clusters).

  1. Run a request for the root directory contents list:

      ```bash
      yt list /
      ```

- Connecting from the internet {#from-internet}

  1. Get the access configuration file using the following YC CLI command:

     ```bash
     {{ yc-ytsaurus }} cluster get-configuration <cluster_name_or_ID>
     ```

     {% cut "Configuration file example" %}
     
     ```bash
     {
       auth_class = {
         module_name = "yc_managed_ytsaurus_auth";
         class_name = "IamTokenAuth";
       };
       proxy = {
         url = "https://proxy.<{{ ytsaurus-name }}_cluster_ID>.ytsaurus.yandexcloud.net";
         enable_proxy_discovery = %false;
       }
     }
     ```
     
     {% endcut %}
     
     The configuration file will be saved to `~/.yt/config`.

     You can get the cluster ID with the [list of clusters in the folder](../../managed-ytsaurus/operations/cluster-list.md#list-clusters).

  1. Run a request for the root directory contents list:

      ```bash
      yt list /
      ```

{% endlist %}

### Python {#python}

Before connecting:

1. {% include [cli-install](../cli-install.md) %}
1. Install the YTsaurus CLI according to the [instructions](https://ytsaurus.tech/docs/en/api/cli/install).
1. Install the dependencies:

    ```bash
    sudo apt update && sudo apt install -y python3 python3-pip && \
    pip3 install ytsaurus-client-yc-auth
    ```

{% list tabs group=connection %}

- Connecting from a user VM {#from-yandex-vm}

  1. Code example:

      `connect.py`

      ```python
      import yt.wrapper as yt
      from yc_managed_ytsaurus_auth import with_iam_token_auth

      client = yt.YtClient(
          proxy="http://hp.<{{ ytsaurus-name }}_cluster_ID>.ytsaurus.mdb.yandexcloud.net:32100",
          config=with_iam_token_auth(
              config={"proxy": {"network_name": "external", "http_proxy_role": "default"}}
          ),
      )

      client.list("/")
      ```

  1. Connecting:

      ```bash
      python3 connect.py
      ```

- Connecting from the internet {#from-internet}

  1. Code example:

      `connect.py`

      ```python
      import yt.wrapper as yt
      from yc_managed_ytsaurus_auth import with_iam_token_auth

      client = yt.YtClient(
          proxy="https://proxy.<{{ ytsaurus-name }}_cluster_ID>.ytsaurus.yandexcloud.net",
          config=with_iam_token_auth(config={"proxy": {"enable_proxy_discovery": False}}),
      )

      client.list("/")
      ```

  1. Connecting:

      ```bash
      python3 connect.py
      ```

{% endlist %}
