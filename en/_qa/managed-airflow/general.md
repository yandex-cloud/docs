#### How do I fix the IP address range overlap error when creating a cluster? {#ip-addresses}

When creating a {{ maf-name }} cluster you may get the following error:

```text
user subnet overlaps with service network range {{ airflow-service-address }}, see documentation for details
```

This error means that when creating the cluster, you selected a subnet whose IP address range overlaps with the `{{ airflow-service-address }}` address range of the service subnet. In it, {{ yandex-cloud }} manages the {{ maf-name }} cluster components.

To fix this error, select another subnet whose IP address range does not overlap with the range of the service subnet. To learn more about cluster subnet requirements, see [Network](../../managed-airflow/concepts/network.md#subnet-requirements).

#### How can I fix the no permission error when connecting a service account to the cluster? {#attach-service-account}

{% include notitle [attach-sa-create-update](../attach-sa-create-update.md) %}
