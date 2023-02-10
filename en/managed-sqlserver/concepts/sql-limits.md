# SQL command limits

{{ mms-short-name }} has some limits on DB owner actions using SQL commands:

* You can't change {{ MS }} settings, including management of server-level objects:
   * `Linked Server`
   * `Login`
   * `Credential`
   * `SQL Server Agent Job`
   * `Maintenance Plan`
   * `Audit`
   * `Polybase`
   * `Replication`
   * `Backup devices`
   * `Server Triggers`
   * `Extended events`

* You can't manage users and assign roles to them. However, you can [assign privileges to users](./../operations/grant.md).
* You can't create a database. However, a DB owner can run the `ALTER DATABASE` command for a previously created DB, except for changing the [recovery model]({{ ms.docs }}/sql/relational-databases/backup-restore/recovery-models-sql-server).
* No actions related to server administration are allowed.

See our [step-by-step instructions](../operations/index.md) on how to perform these actions using the {{ yandex-cloud }} tools.
