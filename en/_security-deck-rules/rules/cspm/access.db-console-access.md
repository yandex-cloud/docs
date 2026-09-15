### Access from the management console is disabled in managed databases {#db-console-access}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | low | access.db-console-access ||
|#

#### Description

**How this rule works:** The rule automatically checks whether the "Access from console" option is enabled on managed database clusters. It flags all clusters where this option is active, regardless of whether the access has been used. The rule does not verify whether the access is actively monitored or whether it is needed for a legitimate purpose.

You may need access to the database from the management console to send [SQL queries](https://yandex.cloud/en/docs/managed-postgresql/operations/web-sql-query) to the database and visualize the data structure.

We recommend that you enable this type of access only if needed, because it raises information security risks. In normal mode, use a standard DB connection as a DB user.

**Risks if the rule is not followed:** Console access to managed databases allows any user with the appropriate IAM role to run arbitrary operations, bypassing application-level access controls and audit logging. This increases the risk of accidental data exposure, unauthorized data modification, and makes it harder to attribute database changes to specific application actions.

#### Instructions and solutions

1. In the [management console](https://console.yandex.cloud/), select the cloud or folder to disable access from the management console in.
2. In the list of services, select a service or services with managed databases.
3. In the object settings, go to the **Advanced settings** tab.
4. In the object parameters, disable **Access from console**.
