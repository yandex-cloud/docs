[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Kubernetes](../index.md) > [Концепции](index.md) > Квоты и лимиты

# Квоты и лимиты в Managed Service for Kubernetes

В сервисе Managed Service for Kubernetes действуют следующие ограничения:

* [_Квоты_](https://console.yandex.cloud/cloud?section=quotas) — организационные ограничения, которые можно изменить по запросу в техническую поддержку.
* _Лимиты_ — технические ограничения, обусловленные особенностями архитектуры Yandex Cloud. Изменить лимиты невозможно.

Сервис Managed Service for Kubernetes учитывает указанный максимальный размер группы узлов как фактический, независимо от текущего размера.

Если вам необходимо больше ресурсов, увеличьте квоты одним из способов:

* [Сформируйте запрос на увеличение](https://console.yandex.cloud/cloud?section=quotas).
* Обратитесь в [техническую поддержку](https://center.yandex.cloud/support) и расскажите, какие потребляемые квоты нужно увеличить и на сколько.

Чтобы ваш запрос был рассмотрен, у вас должна быть [роль](../../iam/roles-reference.md#quota-manager-requestoperator) `quota-manager.requestOperator` или выше (`editor` или `admin`).

Управлять квотами позволяет сервис [Cloud Quota Manager](../../quota-manager/quickstart.md).

#### Квоты {#managed-k8s-quotas}

#|
|| **Вид ограничения** | **Значение** ||
|| Суммарное количество vCPU для всех мастеров в одном облаке
`managed-kubernetes.masterCores.count` | 60 ||
|| Суммарный объем RAM для всех мастеров в одном облаке
`managed-kubernetes.masterMemory.size` | 240 ГБ ||
|| Суммарное количество vCPU для всех узлов в одном облаке
`managed-kubernetes.cores.count` | 240 ||
|| Суммарный объем RAM для всех узлов в одном облаке
`managed-kubernetes.memory.size` | 960 ГБ ||
|| Суммарный объем дисков для всех узлов в одном облаке
`managed-kubernetes.disk.size` | 30 000 ГБ ||
|| Максимальное количество кластеров Kubernetes в одном облаке
`managed-kubernetes.clusters.count` | 10 ||
|| Максимальное количество групп узлов в одном облаке
`managed-kubernetes.nodeGroups.count` | 160 ||
|| Максимальное количество узлов в одном облаке
`managed-kubernetes.nodes.count` | 160 ||
|| Максимальное количество групп узлов в одном кластере Kubernetes
`managed-kubernetes.clusterNodeGroups.count` | 32 ||
|| Максимальное количество узлов в одной группе узлов
`managed-kubernetes.groupNodes.count` | 200 ||
|| Максимальное количество узлов в одном кластере Kubernetes
`managed-kubernetes.clusterNodes.count` | 200 ||
|#

#### Лимиты {#managed-k8s-limits}

#|
|| **Вид ограничения** | **Значение** ||
|| Максимальное количество [томов](volume.md), подключенных к одному узлу | 56 ||
|#