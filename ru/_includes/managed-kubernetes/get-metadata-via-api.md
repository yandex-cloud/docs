Получите все существующие метаданные для группы узлов, воспользовавшись методом REST API [get](../../managed-kubernetes/api-ref/NodeGroup/get.md) для ресурса [NodeGroup](../../managed-kubernetes/api-ref/NodeGroup/index.md), и передайте в запросе идентификатор группы узлов в параметре `nodeGroupId`.

Имя группы узлов можно запросить со [списком групп узлов в каталоге](../../managed-kubernetes/operations/node-group/node-group-list.md#list).

Метаданные будут перечислены в виде пар `ключ=значение` в поле `nodeTemplate.metadata` ответа.
