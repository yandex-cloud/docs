{% note info %}

Some versions of Oracle use `V_$` instead of `V$` as the prefix for system objects. For example, `V_$DATABASE` instead of `V$DATABASE`.

If you get an error like "`can only select from fixed tables/views`" when granting permissions to system objects, try changing the prefixes.

{% endnote %}

{% list tabs %}

- Oracle

   * To prepare the source for the _{{ dt-type-copy }}_ transfer:

      1. Create a user account the transfer will use to connect to the source:

         ```sql
         CREATE USER <username> IDENTIFIED BY <password>;
         GRANT CREATE SESSION TO <username>;
         ```

      1. Grant privileges to the created user:

         ```sql
         GRANT SELECT ON V$DATABASE TO <username>;
         GRANT SELECT ON DBA_EXTENTS TO <username>;
         GRANT SELECT ON DBA_OBJECTS TO <username>;
         GRANT FLASHBACK ANY TABLE TO <username>;
         ```

         If required, you can only grant the `FLASHBACK` privileges to the tables you need to copy rather than to `ANY TABLE`.

      1. Grant the user the [privilege to read the tables](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/GRANT.html) to be copied.

   * To prepare the source for the _{{ dt-type-repl }}_ transfer:

      1. Create a user account the transfer will use to connect to the source:

         ```sql
         CREATE USER <username> IDENTIFIED BY <password>;
         ALTER USER <username> DEFAULT tablespace USERS TEMPORARY tablespace TEMP;
         ALTER USER <username> quote unlimited on USERS;

         GRANT
             CREATE SESSION,
             execute_catalog_role,
             SELECT ANY TRANSACTION,
             SELECT ANY DISCTIONARY,
             CREATE PROCEDURE,
             LOGMINING
         TO <username>;
         ```

      1. Grant privileges to the created user:

         ```sql
         GRANT SELECT ON V$DATABASE TO <username>;
         GRANT SELECT ON V$LOG TO <username>;
         GRANT SELECT ON V$LOGFILE TO <username>;
         GRANT SELECT ON V$ARCHIVED_LOG TO <username>;

         GRANT SELECT ON dba_objects TO <username>;
         GRANT SELECT ON dba_extents TO <username>;

         GRANT EXECUTE ON SYS.DBMS_LOGMNR TO <username>;
         GRANT SELECT ON SYSTEM.LOGMNR_COL$ TO <username>;
         GRANT SELECT ON SYSTEM.LOGMNR_OBJ$ TO <username>;
         GRANT SELECT ON SYSTEM.LOGMNR_USER$ TO <username>;
         GRANT SELECT ON SYSTEM.LOGMNR_UID$ TO <username>;
         ```

      1. Grant the user the [privilege to read the tables](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/GRANT.html) to be replicated.
      1. Enable [Minimal Supplemental Logging](https://docs.oracle.com/database/121/SUTIL/GUID-D2DDD67C-E1CC-45A6-A2A7-198E4C142FA3.htm#SUTIL1583) with primary keys as follows:

         ```sql
         ALTER DATABASE ADD SUPPLEMENTAL LOG DATA (PRIMARY KEY) COLUMNS;
         ```

   * If you are using the [CDB environment](https://docs.oracle.com/database/121/CNCPT/cdbovrvw.htm#CNCPT89234), configure the following settings:

      1. Create a [user](https://docs.oracle.com/en/database/oracle/oracle-database/19/multi/overview-of-managing-a-multitenant-environment.html#GUID-7D303718-2D59-495F-90FB-E51A377B1AD2) `Common User`:

         ```sql
         CREATE USER C##<username> IDENTIFIED BY <password> CONTAINER=all;
         ALTER USER C##<username> DEFAULT TABLESPACE USERS temporary tablespace TEMP CONTAINER=all;
         ALTER USER C##<username> quota unlimited on USERS CONTAINER=all;
         ALTER USER C##<username> SET container_data = (cdb$root, <your_PCB_name>) CONTAINER=current;

         GRANT
             CREATE SESSION,
             execute_catalog_role,
             SELECT ANY TRANSACTION,
             SELECT ANY DICTIONALY,
             CREATE PROCEDURE,
             LOGMINING,
             SET CONTAINER
         TO C##<username> CONTAINER=ALL;
         ```

         If required, you can only specify the `cdb$root` container and the container with the tables you need to transfer.

      1. To allow the user to switch to the `cdb$root` container, grant them the `ALTER SESSION` privileges:

         ```sql
         GRANT ALTER SESSION TO C##<username>;
         ```

      1. Grant privileges to the created user:

         ```sql
         GRANT SELECT ON V$DATABASE TO C##<username> CONTAINER=ALL;
         GRANT SELECT ON V$LOG TO C##<username> CONTAINER=ALL;
         GRANT SELECT ON V$LOGFILE TO C##<username> CONTAINER=ALL;
         GRANT SELECT ON V$ARCHIVED_LOG TO C##<username> CONTAINER=ALL;

         GRANT SELECT ON dba_objects TO C##<username> CONTAINER=ALL;
         GRANT SELECT ON dba_extents TO C##<username> CONTAINER=ALL;

         GRANT EXECUTE ON SYS.DBMS_LOGMNR TO C##<username> CONTAINER=ALL;
         GRANT SELECT ON SYSTEM.LOGMNR_COL$ TO C##<username> CONTAINER=ALL;
         GRANT SELECT ON SYSTEM.LOGMNR_OBJ$ TO C##<username> CONTAINER=ALL;
         GRANT SELECT ON SYSTEM.LOGMNR_USER$ TO C##<username> CONTAINER=ALL;
         GRANT SELECT ON SYSTEM.LOGMNR_UID$ TO C##<username> CONTAINER=ALL;
         ```

{% endlist %}