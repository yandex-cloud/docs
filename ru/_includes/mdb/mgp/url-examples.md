* `jdbc:mysql://mysqlhost:{{ port-mmy }}/testdb` — для локальной БД {{ MY }}.
* `jdbc:postgresql://c-<идентификатор_кластера>.rw.{{ dns-zone }}:{{ port-mpg }}/db1` — для кластера {{ mpg-full-name }}. Адрес содержит [особый FQDN](../../../managed-postgresql/operations/connect.md#special-fqdns) мастера в кластере.
* `jdbc:oracle:thin:@host.example:1521:orcl` — для БД Oracle.
