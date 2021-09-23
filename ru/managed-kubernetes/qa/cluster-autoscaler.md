# Автоматическое масштабирование группы узлов

#### Почему в моём кластере стало N узлов, и он не уменьшается? {#not-scaling-down-1}

Автоматическое масштабирование не останавливает узлы с подами, которые не могут быть расселены. Масштабированию препятствуют:
* Поды, расселение которых ограничено посредством [PodDisruptionBudget](../concepts/node-group/node-drain.md).
* Поды в пространстве имен `kube-system`:
	* которые созданы не под управлением контроллера [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/);
	* для которых не установлен `PodDisruptionBudget` или расселение которых ограничено с помощью `PodDisruptionBudget`.
* Поды, которые не были созданы под управлением контроллера репликации ([ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/), [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) или [StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/)).
* Поды с `local storage`.
* Поды, которые не могут быть расселены куда-либо вследствие ограничений. Например, из-за недостатка ресурсов или отсутствия узлов, подходящих по селекторам `affinity` или `anti-affinity`.
* Поды, на которых установлена аннотация, запрещающая расселение:
	`"cluster-autoscaler.kubernetes.io/safe-to-evict": "false"`.

{% note info %}

Поды `kube-system`, поды с `local-storage` и поды без контроллера репликации можно расселить. Установите аннотацию `"safe-to-evict": "true"`:
```
kubectl annotate pod <имя пода> cluster-autoscaler.kubernetes.io/safe-to-evict=true
```

{% endnote %}

Другие возможные причины:

* Группа узлов уже достигла минимального размера.
* На узле установлена аннотация, запрещающая останавливать его при масштабировании: `"cluster-autoscaler.kubernetes.io/scale-down-disabled": "true"`. Аннотация может быть добавлена или снята с помощью `kubectl`.

	Чтобы проверить наличие аннотации на узле, выполните команду:
	```
	kubectl describe node <имя узла> | grep scale-down-disabled
	```
	Результат выполнения:
	```
	Annotations:        cluster-autoscaler.kubernetes.io/scale-down-disabled: true
	```
	Чтобы снять аннотацию, выполните команду kubectl со знаком «-»:
	```
	kubectl annotate node <имя узла> cluster-autoscaler.kubernetes.io/scale-down-disabled-
	```
	Данная аннотация устанавливается с помощью команды:
	```
	kubectl annotate node <имя узла> cluster-autoscaler.kubernetes.io/scale-down-disabled=true
	```
* Узел простаивает менее 10 минут.
* В течение последних 10 минут группа узлов была масштабирована в сторону увеличения.
* В течение последних 3 минут в группе узлов была неудачная попытка масштабирования в сторону уменьшения.
* Произошла неудачная попытка остановить определенный узел. В этом случае следующая попытка происходит по истечении 5 минут.

#### Почему под удалился, а размер группы узлов не уменьшается? {#not-scaling-down-2}

Если узел недостаточно нагружен, он удаляется по истечении 10 минут.

#### Почему автоматическое масштабирование не выполняется, хотя количество узлов меньше минимума / больше максимума? {#beyond-limits}

Установленные лимиты не будут нарушены при масштабировании, но функция не следит за соблюдением границ намеренно. Масштабирование в сторону увеличения сработает только в случае появления подов в статусе `unschedulable`.

Ответы на другие вопросы об автоматическом масштабировании смотрите в [документации](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#table-of-contents).

