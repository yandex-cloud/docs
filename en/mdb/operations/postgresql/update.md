# Changing cluster and database settings

After creating a cluster, you can change:

- The name of the user who is the DB owner.
- The list of database users (for more information about how to perform user management, see [[!TITLE]](cluster-users.md)).

    > [!NOTE]
    > 
    > [!KEYREF mdb-short-name] reserves 15 connections for service users of each [!KEYREF PG] database. This should be considered when planning the number of database users. For example, if `"max_connections": 100`, a maximum of 85 connections should be reserved for your users.
    
- [!KEYREF PG] extensions enabled for the database (for more information about extension management, see [[!TITLE]](cluster-extensions.md)).
- Any [!KEYREF PG] server settings described in the [DBMS documentation](https://www.postgresql.org/docs/10/static/runtime-config.html).
- Operation mode for the connection manager (PgBouncer).

---

**[!TAB Management console]**

To view or change cluster settings, go to the folder page and click on the tile **Yandex Managed Databases**. Then click on the name of the cluster you need.
You can:

- Perform user management on the **Users** tab. To remove an existing user or change a password, click ![](../../../_assets/vertical-ellipsis.svg) in the table row.
- Create new backups on the **Backup copies** tab.

---

