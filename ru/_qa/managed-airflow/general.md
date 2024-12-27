#### Как исправить ошибку про пересечение диапазонов IP-адресов при создании кластера? {#ip-addresses}

Во время создания кластера {{ maf-name }} вы можете получить ошибку:

```text
user subnet overlaps with service network range {{ airflow-service-address }}, see documentation for details
```

Ошибка означает, что при создании кластера вы выбрали подсеть, диапазон IP-адресов которой пересекается с диапазоном адресов `{{ airflow-service-address }}` служебной подсети. В ней {{ yandex-cloud }} управляет компонентами кластера {{ maf-name }}.

Чтобы исправить ошибку, выберите другую подсеть, диапазон IP-адресов которой не пересекается с диапазоном служебной подсети. Подробнее о требованиях к подсетям кластера см. в разделе [Сеть](../../managed-airflow/concepts/network.md#subnet-requirements).

#### Как исправить ошибку отсутствия прав при подключении сервисного аккаунта к кластеру? {#attach-service-account}

{% include notitle [attach-sa-create-update](../attach-sa-create-update.md) %}
