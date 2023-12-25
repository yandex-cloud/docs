{% note info %}

[Включите](../../../managed-postgresql/operations/extensions/cluster-extensions.md) расширение `pg_tm_aux` для кластера {{ PG }}. Это позволит продолжить репликацию при смене хоста-мастера. В некоторых случаях при смене мастера в кластере трансфер может завершиться ошибкой. Подробнее см. в разделе [Решение проблем](../../../data-transfer/troubleshooting/index.md#master-change).

{% endnote %}
