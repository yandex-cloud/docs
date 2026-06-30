1. Make changes to the source cluster configuration and authentication settings. To do this, edit the `postgresql.conf` and `pg_hba.conf` files. On Debian and Ubuntu distributions, these files reside in the `/etc/postgresql/<{{ PG }}_version>/main/` directory by default:

    1. Set the maximum number of user connections. To do this, update the `max_connections` setting in `postgresql.conf`:

        ```ini
        max_connections = <number_of_connections>
        ```
        
        Where `<number_of_connections>` is the maximum number of connections. For more information on how to configure this setting, see [Specifics of working with endpoints](../../../../data-transfer/concepts/work-with-endpoints.md#postgresql-connection-limit).

        You can check the current number of connections using the `pg_stat_activity` system table:

        ```sql
        SELECT count(*) FROM pg_stat_activity;
        ```

    1. Configure the [Write Ahead Log (WAL)](https://www.postgresql.org/docs/current/static/wal-intro.html) log level by setting [wal_level](https://www.postgresql.org/docs/current/runtime-config-wal.html#RUNTIME-CONFIG-WAL-SETTINGS) to `logical` in `postgresql.conf`:

        ```ini
        wal_level = logical
        ```

    1. Optionally, configure SSL to enable data encryption and compression. To turn SSL on, specify the following in `postgresql.conf`:

        ```ini
        ssl = on
        ```
    
    1. Enable cluster access by updating the `listen_addresses` [setting](https://www.postgresql.org/docs/current/runtime-config-connection.html#GUC-LISTEN-ADDRESSES) in `postgresql.conf`. For example, to make the source cluster accept connection requests from all IP addresses, specify the following:

        ```ini
        listen_addresses = '*'
        ```

    1. Configure authentication in the `pg_hba.conf` file:

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

1. Restart {{ PG }} for the settings to apply:

   ```bash
   sudo systemctl restart postgresql
   ```

1. Check the {{ PG }} status after restart:

   ```bash
   sudo systemctl status postgresql
   ```