[Документация Yandex Cloud](../../../index.md) > [Все решения](../../index.md) > [Managed Service for Kubernetes](../index.md) > Не уменьшается количество нод в группе Managed Service for Kubernetes

# Не уменьшается количество узлов в группе Managed Service for Kubernetes


## Описание проблемы {#issue-description}

В кластере Managed Service for Kubernetes не уменьшается количество узлов в группе.

## Решение {#issue-resolution}

Managed Service for Kubernetes использует Cluster Autoscaler для автоматического масштабирования группы узлов. Это работает следующим образом: вы указываете минимальный и максимальный размер группы узлов, а кластер Kubernetes периодически проверяет состояние подов и узлов.

Если нагрузка на узлы недостаточная и все поды могут быть назначены с меньшим количеством узлов в группе, то число узлов в группе будет постепенно уменьшаться до указанного минимального размера.

Cluster Autoscaler периодически проверяет нагрузку на узлах и, если поды могут быть перезапущены на других узлах, не перегружая их, очищает узел и останавливает его.

Чтобы узел мог быть очищен, проверьте следующие параметры:

* Узел нагружен менее чем на 50%. Для проверки уровня нагрузки вы можете воспользоваться командой `yc managed-kubernetes cluster list-nodes $CLUSTER_ID`, где `$CLUSTER_ID` - идентификатор кластера Managed Service for Kubernetes;
* Поды на этом узле не имеют локального хранилища;
* Перемещению пода не мешают `affinity`, `antiaffinity`, `nodeselector` или `tolopogyspread`;
* Поды управляются контроллером: деплоймент, стейтфулсет;
* [PodDisruptionBudget](https://kubernetes.io/docs/concepts/workloads/pods/disruptions/#pod-disruption-budgets) после удаления узла не будет превышен.

Вы можете вручную найти нужный узел и проверить поды, в том числе поды из `kube-system`. При необходимости удалите их вручную.

Также вы можете настроить удаление ненужных подов с помощью [Descheduler](https://github.com/kubernetes-sigs/descheduler). Детали есть в нашей [документации](../../../managed-kubernetes/qa/cluster-autoscaler.md), а также в официальной [документации Cluster Autoscaler](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#table-of-contents).

Рекомендуем включить запись логов с мастера в вашу лог-группу:

```
yc k8s cluster update <cluster_id> --master-logging enabled=true,log-group-id=<log_group_id>,cluster-autoscaler-enabled=true,kube-apiserver-enabled=true
```

В логах вы сможете найти причину, по которой не отрабатывает даунскейл.

## Если проблема осталась {#if-issue-still-persists}

Если вышеописанные действия не помогли решить проблему, [создайте запрос в техническую поддержку](https://center.yandex.cloud/support). При создании запроса укажите следующую информацию:

1. Идентификатор кластера Managed Service for Kubernetes.
1. Примерные дату и время ошибок в работе Cluster Autoscaler.
1. YAML-спецификацию контроллера подов: деплоймента, стейтфулсета.