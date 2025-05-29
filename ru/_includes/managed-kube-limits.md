#### Квоты {#managed-k8s-quotas}

#|
|| Вид ограничения | Значение ||
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
|| Максимальное количество кластеров {{ k8s }} в одном облаке 
`managed-kubernetes.clusters.count` | 10 ||
|| Максимальное количество групп узлов в одном облаке 
`managed-kubernetes.nodeGroups.count` | 160 ||
|| Максимальное количество узлов в одном облаке 
`managed-kubernetes.nodes.count` | 160 ||
|| Максимальное количество групп узлов в одном кластере {{ k8s }} | 16 ||
|| Максимальное количество узлов в одном кластере {{ k8s }} | 32 ||
|#


#### Лимиты {#managed-k8s-limits}

Вид ограничения | Значение
--- | ---
Максимальное количество [томов](../managed-kubernetes/concepts/volume.md), подключенных к одному узлу | 56