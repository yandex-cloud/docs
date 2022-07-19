## External CLI setup {#cli-setup}

{% note warning %}

The instructions below describe how to set up an external CLI build (from {{ s3-storage-host }}) to access an internal MDB. This might be helpful if you use the CLI to access both an internal MDB and external {{ yandex-cloud }}. If you are happy with the internal CLI build (from s3.mds.yandex.net), follow [these instructions](../../../cli/quickstart.md).

If you already have a CLI installed, you can figure out which build you have using the `yc version` command. If the version contains `+yandex`, the build is internal. Otherwise, the build is external.

{% endnote %}

To access an internal MDB using an external CLI:

1. [Install the CLI](https://cloud.yandex.com/docs/cli/quickstart#install).

1. Make sure that you have [YandexInternalRootCA.crt](https://crls.yandex.net/YandexInternalRootCA.crt) installed. For Windows and Mac OS, a certificate must be pre-installed when issuing the hardware. For Linux, you can use the following [instructions](https://wiki.yandex-team.ru/security/ssl/sslclientfix/#vcli-utilitax).

1. [Get an OAuth token](https://oauth.yandex-team.ru/authorize?response_type=token&client_id=8cdb2f6a0dca48398c6880312ee2f78d) to enable CLI access to the internal MDB.

   {% note warning %}

   Be sure to use this link to get the token: the output of the external CLI build includes a link to an external OAuth rather than internal one.

   {% endnote %}

1. Initialize the CLI profile using the OAuth token from the previous step:

   ```bash
   yc init --endpoint gw.db.yandex-team.ru:443
   Welcome! This command will take you through the configuration process.
   Please go to https://oauth.yandex...
   
   Please enter the OAuth token: <OAuth token obtained>
   ```

1. Select a cloud from the [list of available clouds](../../../mdb/access.md):

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

1. If you need to switch the CLI profile to a different folder, [find out the folder ID](../../../mdb/access.md#find-id) and then run the command:

   ```bash
   yc config set folder-id <folder ID>
   ```

