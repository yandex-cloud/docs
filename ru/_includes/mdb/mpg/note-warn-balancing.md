{% note warning %}

Балансировка не осуществляется на стороне {{ mpg-name }}, поэтому ее необходимо реализовать в бэкенде вашего приложения, например с помощью библиотеки `libpq`. Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/libpq-connect.html#LIBPQ-CONNECT-TARGET-SESSION-ATTRS).

Либо вы можете воспользоваться [особыми FQDN](../../../managed-postgresql/operations/connect.md#special-fqdns), которые указывают на доступный для операций чтения и записи хост-мастер и на наименее отстающую реплику.

{% endnote %}
