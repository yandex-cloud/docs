* {% include [Field Database Name](../../fields/ydb/ui/database-name.md) %}

{% if audience == "external" %}

* {% include [Field Service Account](../../fields/ydb/ui/service-account.md) %}

{% else %}

* {% include [Field YDB Endpoint](../../fields/ydb/ui/ydb-endpoint.md) %}

* {% include [YQL](../../fields/ydb/ui/yql.md) %} 

{% endif %}

* {% include [Cleanup Policy](../../fields/common/ui/cleanup-policy-disabled-drop.md) %}