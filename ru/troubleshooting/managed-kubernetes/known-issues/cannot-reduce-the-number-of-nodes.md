# Не уменьшается количество узлов в группе узлов {{ managed-k8s-name }}


## Описание проблемы {#issue-description}

В кластере {{ managed-k8s-full-name }} не уменьшается количество узлов в группе.

## Решение {#issue-resolution}

{{ managed-k8s-full-name }} использует Kubernetes cluster-autoscaler для автоматического масштабирования группы узлов. Это работает следующим образом: вы указываете минимальный и максимальный размер группы узлов, а кластер Kubernetes периодически проверяет состояние подов и узлов.

Если нагрузка на узлы недостаточная и все поды могут быть назначены с меньшим количеством узлов в группе, то число узлов в группе будет постепенно уменьшаться до указанного минимального размера.

Kubernetes cluster-autoscaler периодически проверяет нагрузку на нодах и, если поды могут быть перезапущены на других нодах, не перегружая их, очищает ноду и останавливает её.

Чтобы нода могла быть очищена, проверьте следующие параметры:
* нода нагружена менее чем на 50%. Для проверки уровня нагрузки вы можете воспользоваться командой `yc managed-kubernetes cluster list-nodes $CLUSTER_ID`, где `$CLUSTER_ID` - идентификатор кластера {{ managed-k8s-name }};
* поды на этой ноде не имеют локального хранилища;
* перемещению пода не мешает `affinity`/`antiaffinity`/`nodeselector`/`tolopogyspread`;
* поды управляются контроллером (деплоймент, стейтфулсет);
* [PodDisruptionBudget](https://kubernetes.io/docs/concepts/workloads/pods/disruptions/#pod-disruption-budgets) после удаления ноды не будет превышен;
* поды имеют аннотацию `"cluster-autoscaler.kubernetes.io/safe-to-evict": "false"`.

Вы можете вручную найти нужную ноду и проверить поды (в том числе поды из kube-system).
При необходимости удалите их вручную.

Также вы можете настроить удаление ненужных подов с помощью [descheduler](https://github.com/kubernetes-sigs/descheduler) 

Детали есть в нашей [документации](../../../managed-kubernetes/qa/cluster-autoscaler.md), а также в официальной [документации cluster-autoscaler](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#table-of-contents).

Также рекомендуем включить запись логов с мастера в вашу лог-группу:

```(text)

yc k8s cluster update <cluster_id> --master-logging enabled=true,log-group-id=<log_group_id>,cluster-autoscaler-enabled=true,kube-apiserver-enabled=true

```

В них вы сможете найти причину, по которой не отрабатывает даунскейл.

## Если проблема осталась {#if-issue-still-persists}

Если вышеописанные действия не помогли решить проблему, [создайте запрос в техническую поддержку]({{ link-console-support }}).
При создании запроса просим указать следующую информацию:

1. Идентификатор кластера {{ managed-k8s-name }}
2. Примерные дата и время ошибок в работе автоскейлера.
3. YAML-спецификация контроллера подов (деплоймента, стейтфулсета).
