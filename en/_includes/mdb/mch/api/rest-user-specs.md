* `name`: Username. It may contain Latin letters, numbers, hyphens, and underscores, and must start with a letter or underscore. The name may be up to 32 characters long.
* `password`: User password. The password must be from 8 to 128 characters long.

    
    You can also generate a password using {{ connection-manager-name }}. To do this, specify `"generatePassword": true` instead of `"password": "<user_password>"`.

    To view the password, select your cluster in the [management console]({{ link-console-main }}), navigate to the **{{ ui-key.yacloud.clickhouse.cluster.switch_users }}** tab, and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** for the relevant user. This will open the page of the {{ lockbox-name }} secret containing the password. To view passwords, you need the `lockbox.payloadViewer` role.


* `permissions`: List of databases the user should have access to.

    The list appears as an array of `databaseName` parameters. Each parameter contains the name of a separate database.
