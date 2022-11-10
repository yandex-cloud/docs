# Вопросы и ответы про автоматическое масштабирование группы узлов в {{ managed-k8s-name }}

#### Почему в моем кластере стало N узлов и он не уменьшается? {#not-scaling-down}

[Автоматическое масштабирование](../concepts/autoscale.md) не останавливает узлы с [подами](../concepts/index.md#pod), которые не могут быть расселены. Масштабированию препятствуют:
* Поды, расселение которых ограничено с помощью [PodDisruptionBudget](../concepts/node-group/node-drain.md).
* Поды в [пространстве имен](../concepts/index.md#namespace) `kube-system`:
  * которые созданы не под управлением контроллера [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/);
  * для которых не установлен `PodDisruptionBudget` или расселение которых ограничено с помощью `PodDisruptionBudget`.
* Поды, которые не были созданы под управлением контроллера репликации ([ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/), [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) или [StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/)).
* Поды с `local-storage`.
* Поды, которые не могут быть расселены куда-либо из-за ограничений. Например, при недостатке ресурсов или отсутствии узлов, подходящих по селекторам [affinity или anti-affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity).
* Поды, на которых установлена аннотация, запрещающая расселение: `"cluster-autoscaler.kubernetes.io/safe-to-evict": "false"`.

{% note info %}

Поды `kube-system`, поды с `local-storage` и поды без контроллера репликации можно расселить. Для этого установите аннотацию `"safe-to-evict": "true"`:

```bash
kubectl annotate pod <имя пода> cluster-autoscaler.kubernetes.io/safe-to-evict=true
```

{% endnote %}

Другие возможные причины:
* [Группа узлов](../concepts/index.md#node-group) уже достигла минимального размера.
* Узел простаивает менее 10 минут.
* В течение последних 10 минут группа узлов была масштабирована в сторону увеличения.
* В течение последних 3 минут в группе узлов была неудачная попытка масштабирования в сторону уменьшения.
* Произошла неудачная попытка остановить определенный узел. В этом случае следующая попытка происходит по истечении 5 минут.
* На узле установлена аннотация, которая запрещает останавливать его при масштабировании: `"cluster-autoscaler.kubernetes.io/scale-down-disabled": "true"`. Аннотация можно добавить или снять с помощью `kubectl`.

  Проверьте наличие аннотации на узле:

  ```bash
  kubectl describe node <имя узла> | grep scale-down-disabled
  ```

  Результат:

  ```bash
  Annotations:        cluster-autoscaler.kubernetes.io/scale-down-disabled: true
  ```

  Установите аннотацию:

  ```bash
  kubectl annotate node <имя узла> cluster-autoscaler.kubernetes.io/scale-down-disabled=true
  ```

  Снять аннотацию можно, выполнив команду `kubectl` со знаком `-`:

  ```bash
  kubectl annotate node <имя узла> cluster-autoscaler.kubernetes.io/scale-down-disabled-
  ```

#### Почему под удалился, а размер группы узлов не уменьшается? {#not-scaling-pod}

Если узел недостаточно нагружен, он удаляется по истечении 10 минут.

#### Почему автоматическое масштабирование не выполняется, хотя количество узлов меньше минимума / больше максимума? {#beyond-limits}

Установленные лимиты не будут нарушены при масштабировании, но {{ managed-k8s-name }} не следит за соблюдением границ намеренно. Масштабирование в сторону увеличения сработает только в случае появления подов в статусе `unschedulable`.

Ответы на другие вопросы об автоматическом масштабировании смотрите в [документации {{ k8s }}](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#table-of-contents).