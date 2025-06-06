1. Make changes to the source cluster configuration and authentication settings. To do this, edit the `postgresql.conf` and `pg_hba.conf` files (on Debian and Ubuntu, they reside in the `/etc/postgresql/<{{ PG }}_version>/main/` directory by default):

    1. Set the maximum number of user connections. To do this, edit the `max_connections` parameter in `postgresql.conf`:

        ```ini
        max_connections = <number_of_connections>
        ```
        
        Where `<number_of_connections>` is the maximum number of connections. For more information on how to configure this parameter, see [Specifics of working with endpoints](../../../../data-transfer/concepts/work-with-endpoints.md#postgresql-connection-limit).

        In the `pg_stat_activity` view, you can see the current number of connections:

        ```sql
        SELECT count(*) FROM pg_stat_activity;
        ```

    1. Set the logging level for [Write Ahead Log (WAL)](https://www.postgresql.org/docs/current/static/wal-intro.html). To do this, set the [wal_level](https://www.postgresql.org/docs/current/runtime-config-wal.html#RUNTIME-CONFIG-WAL-SETTINGS) value to `logical` in `postgresql.conf`:

        ```ini
        wal_level = logical
        ```

    1. Optionally, configure SSL to not only encrypt data but also compress it. To enable SSL, set the appropriate value in `postgresql.conf`:

        ```ini
        ssl = on
        ```
    
    1. Enable connections to the cluster. To do this, edit the `listen_addresses` [parameter](https://www.postgresql.org/docs/current/runtime-config-connection.html#GUC-LISTEN-ADDRESSES) in `postgresql.conf`. For example, you can enable the source cluster to accept connection requests from all IP addresses:

        ```ini
        listen_addresses = '*'
        ```

    1. Set up authentication in the `pg_hba.conf` file:

        {% list tabs %}

        - SSL

            ```txt
            hostssl         all            all             <connection_IP_address>      md5
            hostssl         replication    all             <connection_IP_address>      md5
            ```

        - Without SSL

            ```txt
            host         all            all             <connection_IP_address>      md5
            host         replication    all             <connection_IP_address>      md5
            ```

        {% endlist %}

        Where `<connection_IP_address>` can be either an exact IP address or a range of IP addresses. For example, to allow access from the {{ yandex-cloud }} network, you can specify [all public IP addresses](../../../../overview/concepts/public-ips.md) in {{ yandex-cloud }}.
1. If a firewall is enabled in the source cluster, allow incoming connections from the relevant addresses.

1. To apply the settings, restart {{ PG }}:

   ```bash
   sudo systemctl restart postgresql
   ```

1. Check the {{ PG }} status after restarting:

   ```bash
   sudo systemctl status postgresql
   ```