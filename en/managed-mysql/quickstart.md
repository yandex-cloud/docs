# Getting started with {{ mmy-short-name }}<sup>®</sup>

{% if audience == "internal" %}

For the internal MDB service, the [web interface](https://yc.yandex-team.ru) is deployed where you can manually create a database cluster. For more about quotas and the correlation between ABC services and clouds and folders, see [{#T}](../mdb/access.md).

## Access to DB clusters

[Request access](https://puncher.yandex-team.ru/) to the `_PGAASINTERNALNETS_` macro so you can connect to the created clusters. To connect to MySQL hosts, open port 3306.

## CLI setup

To work with MDB, you need to use the external Yandex.Cloud CLI:

1. [Install the CLI](../cli/index.md).
1. [Get an OAuth token](https://oauth.yandex-team.ru/authorize?response_type=token&client_id=8cdb2f6a0dca48398c6880312ee2f78d) for authorization.

  {% note important %}

  Use this link to get the token: the CLI output contains a link to the external MDB application.

  {% endnote %}

1. Initialize the CLI profile:

   ```bash
   $ yc init --endpoint gw.db.yandex-team.ru:443
   Welcome! This command will take you through the configuration process.
   Please go to https://oauth.yandex...
   
   Please enter the OAuth token: <OAuth token obtained>
   ```

1. Select a cloud from the [list of available clouds](../mdb/access.md):

   ```bash
    Please select cloud to use:
     [1] mdb-junk-cloud (id = foorkhlv2jt6khpv69ik)
     [2] ...
   
    Please enter your numeric choice: 1
    Your current cloud has been set to 'mdb-junk-cloud' (id = foorkhlv2jt6khpv69ik).
   ```

1. Select your folder (ABC service) from the list.

   If the folder you need isn't on the list, enter the ID of an existing folder to switch to the folder you need later.

    ```bash
    Please choose folder to use:
     [1] mdb-junk (id = b1go5vsme2m9353j40o5)
     [2] ...
    Please enter your numeric choice: 1
    Your current folder has been set to 'mdb-junk' (id = mdb-junk).
    ```

1. Disable the default zone selection:

    ```bash
    Do you want to configure a default Compute zone? [Y/n] n
    ```

1. If you need to switch the CLI profile to a different folder, [find the folder ID](../mdb/access.md#find-id) and then run the command:

```bash
yc config set folder-id <folder ID>
```

If you did everything correctly, the list clusters query should now work:

```bash
{{ yc-mdb-ch }} cluster list
```

{% else %}

To use the service, create a cluster and connect to a DBMS:

1. All you need to create a database cluster is a folder in Yandex.Cloud that you are allowed to access. If you already have a folder in Yandex.Cloud, open the page of that folder in the management console. If there is no folder yet, create one:

    {% include [create-folder](../_includes/create-folder.md) %}

1. You can connect to DB clusters from both inside and outside of the Cloud:
   1. To connect to a DB cluster from inside the Cloud, create a VM in the same network as the DB cluster (based on [Linux](../compute/quickstart/quick-create-linux.md) or [Windows](../compute/quickstart/quick-create-windows.md))
   1. To enable connection to a cluster over the internet, request external IP addresses for hosts when creating the cluster.

{% endif %}

Follow the instructions below to quickly create a cluster and test your connection to it.

1. In the management console, select the folder where you want to create a DB cluster.

1. Select **{{ mmy-name }}**.

1. Click **Create cluster** and select the necessary DBMS.

1. Set the cluster parameters and click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).

1. When the cluster is ready, its status on the {{ mmy-short-name }} dashboard will change to **RUNNING**.

1. To connect to the DB server, you need an SSL certificate. You can prepare all the necessary authentication data as follows:

    {% if audience != "internal" %}

    ```bash
    $ mkdir ~/.mysql
    $ wget "https://{{ s3-storage-host }}{{ pem-path }}" -O ~/.mysql/root.crt
    $ chmod 0600 ~/.mysql/root.crt
    ```

    {% else %}

    ```bash
    $ mkdir ~/.mysql
    $ wget "{{ pem-path }}" -O ~/.mysql/root.crt
    $ chmod 0600 ~/.mysql/root.crt
    ```

    {% endif %}

1. You can connect to the database using the command `mysql` (for more information, see [{#T}](operations/connect.md)):

    ```
    $ mysql --host=<host address>
            --port=3306
            --ssl-ca=~/.mysql/root.crt
            --ssl-mode=REQUIRED
            --user=<name of the database user>
            --password <DB name>
    ```

