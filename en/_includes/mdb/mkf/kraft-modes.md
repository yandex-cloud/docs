* **{{ ui-key.yacloud.kafka.FormSections.value_coordination-service-type-kraft-combined-mode_c1zke }}**: One {{ KF }} host accommodates a [broker](../../../managed-kafka/concepts/brokers.md) and a {{ kraft-short-name }} metadata controller at the same time. In the cluster, only three {{ KF }} hosts get created in one of these configurations:
  * Three hosts in the same [availability zone](../../../overview/concepts/geo-scope.md).
  * Each host in a separate availability zone.
  
  You cannot set the number of broker hosts manually.

* **{{ ui-key.yacloud.kafka.FormSections.value_coordination-service-type-kraft-split-mode_sbrDd }}**: A broker and a {{ kraft-short-name }} metadata controller are on separate hosts. When you create a multiple-host cluster, three dedicated {{ kraft-short-name }} hosts are added to it.

  The number of broker hosts is set manually.

You cannot delete {{ kraft-short-name }} hosts. The number of {{ kraft-short-name }} hosts is fixed.