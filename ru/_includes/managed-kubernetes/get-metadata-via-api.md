Получите все существующие метаданные для группы узлов одним из способов:

* Воспользуйтесь методом REST API [get](../../managed-kubernetes/managed-kubernetes/api-ref/NodeGroup/get.md) для ресурса [NodeGroup](../../managed-kubernetes/managed-kubernetes/api-ref/NodeGroup/index.md).
* Используйте вызов gRPC API [NodeGroupService/Get](../../managed-kubernetes/managed-kubernetes/api-ref/grpc/NodeGroup/get.md).

Передайте в запросе идентификатор группы узлов в параметре `nodeGroupId`. Идентификатор можно запросить со [списком групп узлов в каталоге](../../managed-kubernetes/operations/node-group/node-group-list.md#list).

Метаданные будут перечислены в виде пар `ключ=значение` в поле `nodeTemplate.metadata` ответа.
