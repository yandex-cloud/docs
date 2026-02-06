* Topics are managed by:
   * Admin user with the `ACCESS_ROLE_ADMIN` role for all cluster topics. If there is no such user in the cluster, [create](../../../managed-kafka/operations/cluster-accounts.md) one.
   * User with the `ACCESS_ROLE_TOPIC_ADMIN` role for specific topics.

   Learn more about the permissions you get with each role [here](../../../managed-kafka/concepts/account-roles.md).

* You need to configure user access permissions for [producers and consumers](../../../managed-kafka/concepts/producers-consumers.md) using native {{ yandex-cloud }} interfaces rather than the {{ KF }} Admin API.
