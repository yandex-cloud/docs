# Managing roles and users

{{ GP }} manages database access rights using two types of roles:

* User: Role that can log in to the database.
* Group: Role that includes other roles.

For more information, see [{#T}](../concepts/cluster-users.md).

The admin user is created with the {{ mgp-name }} cluster and is automatically given the `mdb_admin` admin role. [Connect to the database](connect.md) on its behalf to:

* [View a list of roles](#list).
* [Create a role](#create).
* [Configure group roles](#group-roles).
* [Change role attributes](#attributes).
* [Configure role privileges](#privileges).
* [Delete a role](#remove).

For more information about role interaction commands, see the [{{ GP }} documentation]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-sql_commands-sql_ref.html).

## View a list of roles {#list}

{% list tabs %}

* SQL

   Run this command:

   ```sql
   SELECT rolname FROM pg_roles;
   ```

   To see a list of roles with their privileges, run the command:

   ```sql
   SELECT
       rolname,
       rolsuper,
       rolcreatedb,
       rolcreaterole,
       rolinherit,
       rolcanlogin,
       rolconnlimit,
       rolcreaterextgpfd
   FROM pg_roles;
   ```

   Result:

   ```text
       rolname     | rolsuper | rolcreatedb | rolcreaterole | rolinherit | rolcanlogin | rolconnlimit | rolcreaterextgpfd
   ----------------+----------+-------------+---------------+------------+-------------+--------------+-------------------
    mdb_admin      | f        | f           | f             | t          | f           |           -1 | f
    gpadmin        | t        | t           | t             | t          | t           |           -1 | t
    monitor        | t        | f           | f             | t          | t           |           -1 | f
    user1          | f        | t           | t             | t          | t           |           -1 | t
   ```

   Where:

   * **t**: Privilege is available.
   * **f**: No privilege.

{% endlist %}

## Create a role {#create}

{% list tabs %}

* SQL

   Run this command:

   ```sql
   CREATE ROLE <role_name> <list_of_attributes>;
   ```

   For a list of available attributes, see [{#T}](../concepts/cluster-users.md#attributes).

{% endlist %}

## Configure group roles {#group-roles}

{% list tabs %}

* SQL

   To add a role to a group role, run the command:

   ```sql
   GRANT <group_role_name> TO <comma-separated_list_of_roles>;
   ```

   You can obtain role names with a [list of roles in the cluster](#list).

   The `LOGIN`, `SUPERUSER`, `CREATEDB`, `CREATEROLE`, `CREATEEXTTABLE`, and `RESOURCE QUEUE` attributes are not inherited. To use all attributes of the group role, run the following command on behalf of the role:

   ```sql
   SET ROLE <group_role_name>;
   ```

   To remove a role from a group role, run the command:

   ```sql
   REVOKE <group_role_name> FROM <comma-separated_list_of_roles>;
   ```

{% endlist %}

## Change role attributes {#attributes}

{% list tabs %}

* SQL

   Run this command:

   ```sql
   ALTER ROLE <role_name> <list_of_attributes>;
   ```

   For a list of available attributes, see [{#T}](../concepts/cluster-users.md#attributes).

{% endlist %}

## Configure role privileges {#privileges}

{% list tabs %}

* SQL

   To grant privileges to a role, run the command:

   ```sql
   GRANT <comma-separated_list_of_privileges> ON <object_name> TO <role_name>;
   ```

   For a list of available privileges, see [{#T}](../concepts/cluster-users.md#privileges).

   To revoke privileges from a role, run the command:

   ```sql
   REVOKE <comma-separated_list_of_privileges> ON <object_name> FROM <role_name>;
   ```

   Instead of listing all object privileges, use `ALL PRIVILEGES`.

   To revoke all privileges of all role objects, run the command:

   ```sql
   DROP OWNED BY <role_name>;
   ```

{% endlist %}

## Delete a role {#remove}

Before deleting a role, delete all objects it owns or reassign their ownership rights and revoke all privileges for other objects.

{% list tabs %}

* SQL

   Run this command:

   ```sql
   DROP ROLE <role_name>;
   ```

{% endlist %}

## Examples

### Creating a role

Create a role with these test characteristics:

* Name: `greenplum_user`.
* Attributes: `CREATEDB` and `CREATEROLE`.
* Option of logging in to the system using a secure password: `password123`.

Run this command:

```sql
CREATE ROLE greenplum_user CREATEDB CREATEROLE LOGIN ENCRYPTED PASSWORD 'password123';
```

Check that the new role with the specified attributes appeared in the list:

```sql
SELECT
    rolname,
    rolsuper,
    rolcreatedb,
    rolcreaterole,
    rolinherit,
    rolcanlogin,
    rolconnlimit,
    rolcreaterextgpfd
FROM pg_roles;
```

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
