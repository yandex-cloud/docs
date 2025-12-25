# Copying and populating a table from a local machine

Using the interactive [psql]({{ pg-docs }}/app-psql.html) terminal, you can both [copy](#copy) table data to a local file and import data from a file to [populate](#write) a table.

## Getting started {#before-you-begin}

1. [Get an SSL certificate](../../managed-postgresql/operations/connect.md#get-ssl-cert).
1. Install the dependencies:

    ```bash
    sudo apt update && sudo apt install --yes postgresql-client
    ```

## Copying data from a table {#copy}

To export table data to a file, run this command:

```bash
psql "host=c-<cluster_ID>.rw.{{ dns-zone }} \
    port={{ port-mgp }} \
    sslmode=verify-full \
    dbname=<DB_name> \
    user=<username> \
    target_session_attrs=read-write" \
    -c "\copy (SELECT * FROM <table_name>) to stdout (DELIMITER '<delimiter_character>')" \
    >> <local_file_name>
```

## Populating a table with data {#write}

{% note info %}

Make sure to create the target table beforehand. The local file’s column structure, i.e., number and data types, must match the {{ mpg-name }} table schema.

{% endnote %}

To import data from a local file into a table, run this command:

```bash
cat <local_file_name> | \
psql "host=c-<cluster_ID>.rw.{{ dns-zone }} \
    port={{ port-mgp }} \
    sslmode=verify-full \
    dbname=<DB_name> \
    user=<username> \
    target_session_attrs=read-write" \
    -c "COPY <table_name> FROM stdin (DELIMITER '<delimiter_character>')"
```
