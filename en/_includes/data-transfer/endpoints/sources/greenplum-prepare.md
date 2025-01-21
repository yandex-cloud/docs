{% note info %}

{% include [matview limits](../../../../_includes/data-transfer/pg-gp-matview.md) %}

{% endnote %}

{% list tabs %}


- {{ mgp-name }}

    
    1. Create a user account the transfer will use to connect to the source. To do this, run the following command:
    
        ```pgsql
        CREATE ROLE <username> LOGIN ENCRYPTED PASSWORD '<password>';
        ```

    1. Configure the source cluster to enable the user you created to connect to all the cluster [master hosts](../../../../managed-greenplum/concepts/index.md).
    
    1. If you are going to use [parallel copy](../../../../data-transfer/concepts/sharded.md), configure the source cluster to enable the user you created to connect to all the cluster's [segment hosts](../../../../managed-greenplum/concepts/index.md) in utility mode. To do this, make sure that the "Access from {{ data-transfer-name }}" setting is enabled for the cluster.
    
    1. Grant the user you created the `SELECT` privilege for the tables to transfer and the `USAGE` privilege for the schemas these tables are in.
    
       Privileges must be granted to entire tables. Access to certain table columns only is not supported.
    
       Tables without the required privileges are unavailable to {{ data-transfer-name }}. These tables are processed as if they did not exist.
    
       This example issues privileges to all the tables in the selected schema:
    
        ```pgsql
        GRANT SELECT ON ALL TABLES IN SCHEMA <schema_name> TO <username>;
        GRANT USAGE ON SCHEMA <schema_name> TO <username>;
        ```


- {{ GP }}
    
    1. {% include notitle [White IP list](../../../../_includes/data-transfer/configure-white-ip.md) %}
    
    1. Create a user account the transfer will use to connect to the source. To do this, run the following command:
    
        ```pgsql
        CREATE ROLE <username> LOGIN ENCRYPTED PASSWORD '<password>';
        ```

    1. Configure the source cluster to enable the user you created to connect to all the cluster [master hosts](../../../../managed-greenplum/concepts/index.md).
    
    1. If you are going to use [parallel copy](../../../../data-transfer/concepts/sharded.md), configure the source cluster to enable the user you created to connect to all the cluster [segment hosts](../../../../managed-greenplum/concepts/index.md) in utility mode.
    
    1. Grant the user you created the `SELECT` privilege for the tables to transfer and the `USAGE` privilege for the schemas these tables are in.
    
       Privileges must be granted to entire tables. Access to certain table columns only is not supported.
    
       Tables without the required privileges are unavailable to {{ data-transfer-name }}. These tables are processed as if they did not exist.
    
       This example grants privileges to all the database tables:
    
        ```pgsql
        GRANT SELECT ON ALL TABLES IN SCHEMA <schema_name> TO <username>;
        GRANT USAGE ON SCHEMA <schema_name> TO <username>;
        ```

{% endlist %}

{{ data-transfer-name }} works with {{ GP }} differently depending on the transfer configuration and the source cluster contents. Detailed information is available in the section on [{{ GP }} source endpoint settings](../../../../data-transfer/operations/endpoint/source/greenplum.md).