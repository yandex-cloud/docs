### Access from the management console is disabled in managed databases {#db-console-access}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | low | access.db-console-access ||
|#

#### Description

You may need access to the database from the management console to send [SQL queries](https://yandex.cloud/en/docs/managed-postgresql/operations/web-sql-query) to the database and visualize the data structure.

We recommend that you enable this type of access only if needed, because it raises information security risks. In normal mode, use a standard DB connection as a DB user.

#### Instructions and solutions

**Guides and solutions to use:**

1. In the [management console](https://console.yandex.cloud/), select the cloud or folder to disable access from the management console in. 2. In the list of services, select a service or services with managed databases. 3. In the object settings, go to the **Advanced settings** tab. 4. In the object parameters, disable **Access from console**.
