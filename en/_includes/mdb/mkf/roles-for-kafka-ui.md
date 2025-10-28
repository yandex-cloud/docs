To grant access to the {{ kafka-ui }} web interface, [assign](../../../iam/operations/roles/grant.md) the {{ yandex-cloud }} account the following roles for the folder where the {{ KF }} cluster was created:

* [managed-kafka.interfaceUser](../../../managed-kafka/security/index.md#managed-kafka-interface-user): To work with the {{ kafka-ui }} web interface.
* [managed-kafka.viewer](../../../managed-kafka/security/index.md#managed-kafka-viewer): To view the {{ KF }} cluster information.
* [resource-manager.viewer](../../../resource-manager/security/index.md#resource-manager-viewer): To view information about the cloud and folder in which the {{ KF }} cluster was created.