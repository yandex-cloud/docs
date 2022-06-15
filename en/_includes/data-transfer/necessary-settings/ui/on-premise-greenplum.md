* **Custom installation:**
    * **{{ GP }} cluster coordinator**: Enter the data to connect to the master hosts:
        * **Primary**: The data of the primary master host:
            * {% include [Field IP FQDN](../../fields/common/ui/host.md) %}
            * {% include [Field Database port](../../fields/common/ui/database-port.md) %}
        * **Mirror**: The data of the backup master host (if there is only one master host, you may omit it).
    * **Cluster segments {{ GP }}**: specify the data to connect to the segment hosts (if needed). If you omit them, the addresses of the host segments will be retrieved automatically from the service table of the master host.
* **Authentication parameters**: Specify the authentication data:
    * {% include [Field CA certificate](../../fields/greenplum/ui/ca-certificate.md) %}
    * {% include [Field Password](../../fields/common/ui/password.md) %}
* {% include [Field Database Name](../../fields/common/ui/database-name.md) %}
* {% include [Field Username](../../fields/common/ui/username.md) %}
