## CLI setup {#cli-setup}

To work with MDB, you need to use the external Yandex.Cloud CLI:

1. [Install the CLI](../../../cli/quickstart.md).

1. [Get an OAuth token](https://oauth.yandex-team.ru/authorize?response_type=token&client_id=8cdb2f6a0dca48398c6880312ee2f78d) to enable CLI access to the internal MDB.

   {% note warning %}

   Use this link to get the token: the CLI output contains a link to the external MDB application.

   {% endnote %}

1. Initialize the CLI profile using the OAuth token from the previous step:

   ```bash
   $ yc init --endpoint gw.db.yandex-team.ru:443
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

1. If you need to switch the CLI profile to a different folder, [find the folder ID](../../../mdb/access.md#find-id) and then run the command:

   ```bash
   yc config set folder-id <folder ID>
   ```

