# Connecting to an external file server

[{{ GP }} Parallel File Server]({{ gp.docs.broadcom }}/5/greenplum-database/utility_guide-admin_utilities-gpfdist.html) (`gpfdist`) is a utility used to read and write data from files located on remote servers. It is installed on each segment host of a {{ GP }} cluster and ensures parallel data loading by distributing it across segments either evenly or according to the set [distribution key](../../concepts/sharding.md#distribution-key). This improves performance when handling large amounts of external data.

`gpfdist` works with any delimited text files as well as compressed gzip and bzip2 files.

To read or write files on an external server:
1. [Install and run](#run-gpfdist) `gpfdist` as part of the {{ GP }} Loader or {{ GP }} Database package on the remote server hosting your target files.
1. [Create an external table](#create-gpfdist-table) in the {{ GP }} database to reference these files.

## Running gpfdist {#run-gpfdist}


{% note info %}

Downloading and using software from the VMware website is not part of the [{{ mgp-full-name }} Terms of Use]({{ link-cloud-terms-of-use }}) and is arranged between the client and VMware separately. Yandex is not responsible for any dealings between VMware and the client arising due to the client's use of VMware products or services.

{% endnote %}


1. Download and install the {{ GP }} Loader package from the [VMware website]({{ gp.docs.broadcom }}/5/greenplum-database/client_tool_guides-load-windows-win_load_install.html) or the {{ GP }} Database package from the {{ objstorage-full-name }} bucket by following [this guide](../greenplum-db.md).

1. Run `gpfdist`:

    ```bash
    gpfdist -d <data_file_directory> -p <connection_port> -l <log_file_path>
    ```

    Where:

    * `<data_file_directory>`: Local path to the directory with files for reading/writing data through an [external table](../../concepts/external-tables.md).
    * `<connection_port>`: Port the utility will use to operate. The default value is `8080`.
    * `<log_file_path>`: Optional path to the file `gpfdist` will write its logs to.

    To distribute the network's workload, you can run several `gpfdist` instances on the same server by specifying different directories and connection ports, e.g.:

    ```bash
    gpfdist -d /var/load_files1 -p 8081 -l /home/gpadmin/log1 & \
    gpfdist -d /var/load_files2 -p 8082 -l /home/gpadmin/log2 &
    ```

1. Make sure files from the specified directory are available on the set port from {{ yandex-cloud }}. To do this, run the following command from a VM in {{ yandex-cloud }}:

    ```bash
    wget http://hostname:port/filename
    ```

## Creating an external table using gpfdist {#create-gpfdist-table}

SQL query syntax for creating an external table:

```sql
CREATE [WRITABLE] EXTERNAL TABLE <table_name>
       (<column_name> <data_type> [, ...])
       LOCATION('gpfdist://<path_to_file_on_remote_server>' [, ...])
       FORMAT '[TEXT|CSV|CUSTOM]';
```

Where:

* `<table_name>`: Name of the external table that will be created in the {{ GP }} database.
* `<column_name>`: Table column name.
* `<data_type>`: Table column data type.
* `<path_to_file_on_remote_server>`: Address of the server `gpfdist` runs on, connection port, and file path. You can specify a particular file or a mask using the asterisk symbol (\*).

The `WRITABLE` option allows writing data to an external object. To read data from an external object, create an external table with the `READABLE` option.

## Examples of creating external tables {#gpfdist-examples}

* Creating an external table with data from `file.csv` on the `hostname` server:

    ```sql
    CREATE EXTERNAL TABLE tableName (id int)
           LOCATION('gpfdist://hostname:8080/file.csv')
           FORMAT 'CSV' (DELIMITER ',');
    ```

* Creating an external table consolidating data from all `txt` files, with `|` for a separator and space for `NULL`, on the `hostname1` and `hostname2` servers:

    ```sql
    CREATE EXTERNAL TABLE tableName (...)
           LOCATION('gpfdist://hostname1:8081/*.txt',
                    'gpfdist://hostname2:8081/*.txt')
           FORMAT 'TEXT' (DELIMITER '|' NULL ' ');
    ```

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
