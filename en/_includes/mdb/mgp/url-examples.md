* `jdbc:mysql://mysqlhost:{{ port-mmy }}/testdb`: For a local {{ MY }} DB.
* `jdbc:postgresql://c-<cluster_ID>.rw.{{ dns-zone }}:{{ port-mpg }}/db1`: For a {{ mpg-full-name }} cluster. The address contains a [special FQDN](../../../managed-postgresql/operations/connect.md#special-fqdns) of the master host in the cluster.
* `jdbc:oracle:thin:@host.example:1521:orcl`: For an Oracle DB.
