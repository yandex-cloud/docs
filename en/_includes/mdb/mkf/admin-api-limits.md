* Topics can be managed by an admin user with the `ACCESS_ROLE_ADMIN` role effective for all the cluster topics. If there is no such user in the cluster, [create](../../../managed-kafka/operations/cluster-accounts.md) one.

* You need to configure user permissions for [producers and consumers](../../../managed-kafka/concepts/producers-consumers.md) using native {{ yandex-cloud }} interfaces rather than the {{ KF }} Admin API.
