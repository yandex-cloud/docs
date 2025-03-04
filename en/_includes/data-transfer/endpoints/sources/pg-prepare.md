{% note info %}

When performing a transfer from {{ PG }} to a target of any type, objects of the [large object](https://www.postgresql.org/docs/current/largeobjects.html) type will not get transferred.

{% include [pg-types-limits](../../notes/pg-source-features.md) %}

Large objects in the [TOAST storage system](https://www.postgresql.org/docs/12/storage-toast.html) and those of the [bytea](https://www.postgresql.org/docs/12/datatype-binary.html) type get transferred without restrictions.

{% endnote %}

{% list tabs %}

- {{ mpg-name }}

    
    1. Configure the user the transfer will use to connect to the source:
        
        1. [Create a user](../../../../managed-postgresql/operations/cluster-users.md#adduser).
        
        1. For _{{ dt-type-repl }}_ and _{{ dt-type-copy-repl }}_ transfer types, [assign the `mdb_replication` role](../../../../managed-postgresql/operations/grant.md#grant-role) to this user.
        
        1. [Connect to the database](../../../../managed-postgresql/operations/connect.md) you want to migrate as the database owner and [configure privileges](../../../../managed-postgresql/operations/grant.md#grant-privilege):
            
            * `SELECT` for all the database tables to transfer.
            * `SELECT` for all the database sequences to transfer.
            * `USAGE` for the schemas of those tables and sequences.
            * `ALL PRIVILEGES` (`CREATE` and `USAGE`) for the service table (`__consumer_keeper` and `__data_transfer_mole_finder`) schema defined by the [endpoint parameter](../../../../data-transfer/operations/endpoint/source/postgresql.md#additional-settings) if the endpoint is going to be used for the _{{ dt-type-repl }}_ or _{{ dt-type-copy-repl }}_ transfer types.

    1. Configure the [number of user connections](../../../../data-transfer/concepts/work-with-endpoints.md#postgresql-connection-limit) to the database.

    1. If the replication source is a cluster, [enable](../../../../managed-postgresql/operations/extensions/cluster-extensions.md) the `pg_tm_aux` extension for it. This will allow replication to continue even after changing the master host. In some cases, a transfer may end in an error after you replace a master in your cluster. For more information, see [Troubleshooting](../../../../data-transfer/troubleshooting/index.md#master-change).
    
    1. {% include [Tables without primary keys](../../primary-keys-postgresql.md) %}
    
    1. Disable the transfer of external keys when creating a source endpoint. Recreate them once the transfer is completed.
    
    1. Find and terminate DDL queries that are running for too long. To do this, make a selection from the {{ PG }} `pg_stat_activity` system table:
    
        ```sql
        SELECT NOW() - query_start AS duration, query, state
        FROM pg_stat_activity
        WHERE state != 'idle' ORDER BY 1 DESC;
        ```
    
       This will return a list of queries running on the server. Pay attention to queries with a high `duration` value.
    
    1. Deactivate trigger transfer at the transfer initiation stage and reactivate it at the completion stage (for the _{{ dt-type-repl }}_ and the _{{ dt-type-copy-repl }}_ transfer types). For more information, see the [description of additional endpoint settings for the {{ PG }} source](../../../../data-transfer/operations/endpoint/source/postgresql.md#additional-settings).
    
    1. To enable parallel data reads from the table, set its primary key to [serial mode](https://www.postgresql.org/docs/current/datatype-numeric.html#DATATYPE-SERIAL).
    
       Then specify the number of workers and threads in the [transfer parameters](../../../../data-transfer/operations/transfer.md#create) under **Runtime environment**.
    
    1. Configure WAL monitoring. {#wal-setup-recommendation}

       _{{ dt-type-repl }}_ and _{{ dt-type-copy-repl }}_ transfers use [logical replication]({{ pg-docs }}/logicaldecoding.html). To perform the replication, the transfer creates a replication slot where `slot_name` matches the transfer ID, which you can get by selecting the transfer in the list of your transfers. Your WAL may grow due to different reasons: a long-running transaction or a transfer issue. Therefore, we recommend you to configure WAL monitoring on the source side.

        1. To monitor storage or disk space usage, [use monitoring tools to set up an alert](../../../../managed-postgresql/operations/monitoring.md#monitoring-hosts) (see the `disk.used_bytes` description).
        
        1. Set the maximum WAL size for replication in the `Max slot wal keep size` [setting](../../../../managed-postgresql/concepts/settings-list.md#setting-max-slot-wal-keep-size). The value of this setting can be edited as of {{ PG }} version 13. To urgently disable a transfer to perform data reads, [delete the replication slot](../../../../managed-postgresql/operations/replication-slots.md#delete).
        
           {% note warning %}
        
           If set to `-1` (unlimited size), you will not be able to delete WAL files due to open logical replication slots the information is not read from. As a result, the WAL files will take up the entire disk space and you will not be able to connect to the cluster.
        
           {% endnote %}
        
        1. [Set up an alert](../../../../managed-postgresql/operations/monitoring.md) with the {{ monitoring-full-name }} tools for the metric used for `Total size of WAL files`. Make sure the threshold values are less than those specified for the `disk.used_bytes` metric because, apart from the data, the disk stores temporary files, the WAL, and other types of data. You can monitor the current slot size by running this DB query with the correct `slot_name`, which matches the transfer ID:
        
            ```sql
            SELECT slot_name, pg_size_pretty(pg_current_wal_lsn() - restart_lsn), active_pid, catalog_xmin, restart_lsn, confirmed_flush_lsn
            FROM pg_replication_slots WHERE slot_name = '<transfer_ID>'
            ```

- {{ PG }}
    
    1. {% include notitle [White IP list](../../configure-white-ip.md) %}
    
    1. Create a user account the transfer will use to connect to the source:
        
        * For the _{{ dt-type-copy }}_ transfer type, create a user with the following command:
        
            ```sql
            CREATE ROLE <username> LOGIN ENCRYPTED PASSWORD '<password>';
            ```
        
        * For _{{ dt-type-repl }}_ and _{{ dt-type-copy-repl }}_ transfers, create a user with the `REPLICATION` privilege by running this command:
        
            ```sql
            CREATE ROLE <username> WITH REPLICATION LOGIN ENCRYPTED PASSWORD '<password>';
            ```
    
    1. Grant the new user the `SELECT` privilege for all the database tables involved in the transfer and the `USAGE` privilege for these tables' schemas:
    
        ```sql
        GRANT SELECT ON ALL TABLES IN SCHEMA <schema_name> TO <username>;
        GRANT USAGE ON SCHEMA <schema_name> TO <username>;
        ```
    
    1. Grant the new user the privileges for the service table (`__consumer_keeper` and `__data_transfer_mole_finder`) schema defined by the [endpoint parameter](../../../../data-transfer/operations/endpoint/source/postgresql.md#additional-settings) if the endpoint is going to be used for _{{ dt-type-repl }}_ or _{{ dt-type-copy-repl }}_ transfers:
    
        ```sql
        GRANT ALL PRIVILEGES ON SCHEMA <schema_name> TO <username>;
        ```

    1. Configure the [number of user connections](../../../../data-transfer/concepts/work-with-endpoints.md#postgresql-connection-limit) to the database.

    1. Install and enable the [wal2json](https://github.com/eulerto/wal2json) extension.
    
       **Installation**
        
        * Linux
            
            1. Add the [{{ PG }} official repository](https://www.postgresql.org/download/) for your distribution.
            1. Update the list of available packages and install `wal2json` for your {{ PG }} version.
        
        * Windows 10, 11
            
            1. If you do not have Microsoft Visual Studio installed yet, download and install it. To build the wal2json extension, the [Community Edition](https://visualstudio.microsoft.com/vs/community/) is sufficient. During installation, select the following components:
                
                * MSBuild
                * MSVC v141 x86/x64 build tools
                * C++\CLI support for v141 build tools
                * MSVC v141 - VS 2017 C++ x64\x86 build tools
                * MSVC v141 - VS 2017 C++ x64\x86 Spectre-mitigated libs
                * The latest version of the Windows SDK for the active OS version
                * Other dependencies that are installed automatically for selected components

               Take note of the version number of the installed Windows SDK. You will need it while setting the wal2json build parameters.
            
            1. Download the wal2json source code from the [project page](https://github.com/eulerto/wal2json/releases).
            1. Unpack the archive with the source code to the `C:\wal2json\` folder.
            1. Go to `C:\wal2json`.
            1. Within one PowerShell session, make changes to the `wal2json.vcxproj` file as follows:
                
                * Replace the `C:\postgres\pg103` lines with the path to the folder housing your installed {{ PG }} version, for example:
                
                    ```powershell
                    (Get-Content .\wal2json.vcxproj).replace('C:\postgres\pg103', 'C:\PostgreSQL\14') | `
                     Set-Content .\wal2json.vcxproj
                    ```
                
                * Replace the `/MP` build parameter with `/MT`, for example:
                
                    ```powershell
                    (Get-Content .\wal2json.vcxproj).replace('/MP', '/MT') | Set-Content .\wal2json.vcxproj
                    ```
                
                * Specify the version number of the installed Windows SDK in `<WindowsTargetPlatformVersion>`:
                
                    ```powershell
                    (Get-Content .\wal2json.vcxproj).replace('<WindowsTargetPlatformVersion>8.1', '<WindowsTargetPlatformVersion><installed_Windows_SDK_version>') | `
                     Set-Content .\wal2json.vcxproj
                    ```
                
                1. Enter the value of the extension variable required for building wal2json. For example, for Visual Studio Community Edition 2022:
                
                    ```powershell
                    $VCTargetsPath='C:\Program Files\Microsoft Visual Studio\2022\Comminuty\MSBuild\Microsoft\VC\v150'
                    ```
                
                1. Run the build:
                
                    ```powershell
                    & 'C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe' /p:Configuration=Release /p:Platform=x64
                    ```
                
                1. Copy the `wal2json.dll` file from the `build/release` folder to the `lib` folder of your {{ PG }} version.

       **Configuration**
        
        1. In the `postgresql.conf` file, set the value of the `wal_level` parameter to `logical`:
        
            ```conf
            wal_level = logical
            ```
        
        1. Restart PostgreSQL.
    
    1. If the replication source is a cluster, install and enable the [pg_tm_aux](https://github.com/x4m/pg_tm_aux) extension on its hosts. This will allow replication to continue even after changing the master host. In some cases, a transfer may end in an error after you replace a master in your cluster. For more information, see [Troubleshooting](../../../../data-transfer/troubleshooting/index.md#master-change).
    
    1. {% include [Tables without primary keys](../../primary-keys-postgresql.md) %}
    
    1. Disable the transfer of external keys when creating a source endpoint. Recreate them once the transfer is completed.
    
    1. Find and terminate DDL queries that are running for too long. To do this, make a selection from the {{ PG }} `pg_stat_activity` system table:
    
        ```sql
        SELECT NOW() - query_start AS duration, query, state
        FROM pg_stat_activity
        WHERE state != 'idle' ORDER BY 1 DESC;
        ```
    
       This will return a list of queries running on the server. Pay attention to queries with a high `duration` value.
    
    1. Deactivate trigger transfer at the transfer initiation stage and reactivate it at the completion stage (for the _{{ dt-type-repl }}_ and the _{{ dt-type-copy-repl }}_ transfer types). For more information, see the [description of additional endpoint settings for the {{ PG }} source](../../../../data-transfer/operations/endpoint/source/postgresql.md#additional-settings).
    
    1. To enable parallel data reads from the table, set its primary key to [serial mode](https://www.postgresql.org/docs/current/datatype-numeric.html#DATATYPE-SERIAL).
    
       Then specify the number of [workers](../../../../data-transfer/concepts/index.md#worker) and threads in the [transfer parameters](../../../../data-transfer/operations/transfer.md#create) under **Runtime environment**.
    
    1. If replication via [Patroni](https://github.com/zalando/patroni) is configured on the source, add an [ignore_slots](https://patroni.readthedocs.io/en/latest/SETTINGS.html?highlight=ignore_slots#dynamic-configuration-settings) section to the source configuration:
    
       ```yaml
       ignore_slots:
         - database: <database>
           name: <replication_slot>
           plugin: wal2json
           type: logical
       ```
    
       Where:
        
        * `database`: Name of the database the transfer is configured for.
        * `name`: Replication slot name.

       The database and the replication slot names must match the values specified in the [source endpoint settings](../../../../data-transfer/operations/endpoint/source/postgresql.md). By default, the `replication slot name` is the same as the `transfer ID`.

       Otherwise, the start of the replication phase will fail:
    
       ```
       Warn(Termination): unable to create new pg source: Replication slotID <replication_slot_name> does not exist.
       ```
    
    1. Configure WAL monitoring. _{{ dt-type-repl }}_ and _{{ dt-type-copy-repl }}_ transfers use [logical replication]({{ pg-docs }}/logicaldecoding.html). To perform the replication, the transfer creates a replication slot where `slot_name` matches the transfer ID, which you can get by selecting the transfer in the list of your transfers. Your WAL may grow due to different reasons: a long-running transaction or a transfer issue. Therefore, we recommend you to configure WAL monitoring on the source side.
        
        1. Set up alerts as described in the [disk usage recommendations]({{ pg-docs }}/diskusage.html).
        
        1. [Set the maximum WAL size]({{ pg-docs }}/runtime-config-replication.html#GUC-MAX-SLOT-WAL-KEEP-SIZE). This feature is available starting with {{ PG }} version 13.
        
        1. You can monitor the current slot size by running this DB query with the correct `slot_name`, which matches the transfer ID:
        
            ```sql
            SELECT slot_name, pg_size_pretty(pg_current_wal_lsn() - restart_lsn), active_pid, catalog_xmin, restart_lsn, confirmed_flush_lsn
            FROM pg_replication_slots WHERE slot_name = '<transfer_ID>'
            ```

{% endlist %}

{% note info %}

For things to note about data transfer from {{ PG }} to {{ CH }} using _{{ dt-type-repl }}_ and _{{ dt-type-copy-repl }}_ transfers, see [Asynchronously replicating data from {{ PG }} to {{ CH }}](../../../../data-transfer/tutorials/rdbms-to-clickhouse.md).

{% endnote %}