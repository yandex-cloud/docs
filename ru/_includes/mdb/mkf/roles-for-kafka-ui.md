Чтобы предоставить доступ к веб-интерфейсу {{ kafka-ui }}, [назначьте](../../../iam/operations/roles/grant.md) аккаунту в {{ yandex-cloud }} роли на каталог, в котором создан кластер {{ KF }}:

* [managed-kafka.interfaceUser](../../../managed-kafka/security/index.md#managed-kafka-interface-user) — чтобы работать с веб-интерфейсом {{ kafka-ui }};
* [managed-kafka.viewer](../../../managed-kafka/security/index.md#managed-kafka-viewer) — чтобы просматривать информацию о кластере {{ KF }};
* [resource-manager.viewer](../../../resource-manager/security/index.md#resource-manager-viewer) — чтобы просматривать информацию об облаке и каталоге, в которых создан кластер {{ KF }}.