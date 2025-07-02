* `name`: Username. It may contain Latin letters, numbers, hyphens, and underscores, and must start with a letter or underscore. The name can be up to 32 characters long.
* `password`: User password. The password must be from 8 to 128 characters long.

    You can also generate a password using {{ connection-manager-name }}. To do this, specify `"generatePassword": true` instead of `"password": "<user_password>"`.

    To view the password, select the cluster you created in the [management console]({{ link-console-main }}), go to the **{{ ui-key.yacloud.clickhouse.cluster.switch_users }}** tab and click **{{ ui-key.yacloud.mdb.cluster.users.label_go-to-password }}** in the user's row. This will open the page of the {{ lockbox-name }} secret that stores the password. To view passwords, you need the `lockbox.payloadViewer` role.

* `permissions`: List of DBs the user must have access to.

    The list appears as an array of `databaseName` parameters. Each parameter contains the name of a separate database.
