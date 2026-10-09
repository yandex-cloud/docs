#### Почему в моем кластере стало N узлов и он не уменьшается? {#not-scaling-down}

[Автоматическое масштабирование](../../managed-kubernetes/concepts/autoscale.md) не останавливает узлы с [подами](../../managed-kubernetes/concepts/index.md#pod), которые не могут быть расселены. Масштабированию препятствуют:
* Поды, расселение которых ограничено с помощью [PodDisruptionBudget](../../managed-kubernetes/concepts/node-group/node-drain.md).
* Поды в [пространстве имен](../../managed-kubernetes/concepts/index.md#namespace) `kube-system`:
  * которые созданы не под управлением контроллера [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/);
  * для которых не установлен `PodDisruptionBudget` или расселение которых ограничено с помощью `PodDisruptionBudget`.
* Поды, которые не были созданы под управлением контроллера репликации ([ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/), [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) или [StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/)).
* Поды с локальными томами, например `hostPath` или `emptyDir` без `medium: Memory`. Исключение — поды с аннотацией `cluster-autoscaler.kubernetes.io/safe-to-evict-local-volumes`, в значении которой перечислены все локальные тома пода, например `volume-1,volume-2`.
* Поды, которые не могут быть расселены куда-либо из-за ограничений. Например, при недостатке ресурсов или отсутствии узлов, подходящих по селекторам [affinity или anti-affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity).
* Поды, на которых установлена аннотация, запрещающая расселение: `"cluster-autoscaler.kubernetes.io/safe-to-evict": "false"`.

{% note info %}

Поды `kube-system`, поды с `local-storage` и поды без контроллера репликации можно расселить. Для этого установите аннотацию `"safe-to-evict": "true"`:

```bash
kubectl annotate pod <имя_пода> cluster-autoscaler.kubernetes.io/safe-to-evict=true
```

{% endnote %}

Другие возможные причины:
* [Группа узлов](../../managed-kubernetes/concepts/index.md#node-group) уже достигла минимального размера.
* Узел простаивает менее 10 минут.
* В течение последних 10 минут группа узлов была масштабирована в сторону увеличения.
* В течение последних 3 минут в группе узлов была неудачная попытка масштабирования в сторону уменьшения.
* Произошла неудачная попытка остановить определенный узел. В этом случае следующая попытка происходит по истечении 5 минут.
* На узле установлена аннотация, которая запрещает останавливать его при масштабировании: `"cluster-autoscaler.kubernetes.io/scale-down-disabled": "true"`. Аннотацию можно добавить или снять с помощью `kubectl`.

  Проверьте наличие аннотации на узле:

  ```bash
  kubectl describe node <имя_узла> | grep scale-down-disabled
  ```

  Результат:

  ```bash
  Annotations:        cluster-autoscaler.kubernetes.io/scale-down-disabled: true
  ```

  Установите аннотацию:

  ```bash
  kubectl annotate node <имя_узла> cluster-autoscaler.kubernetes.io/scale-down-disabled=true
  ```

  Снять аннотацию можно, выполнив команду `kubectl` со знаком `-`:

  ```bash
  kubectl annotate node <имя_узла> cluster-autoscaler.kubernetes.io/scale-down-disabled-
  ```
  
Перед обращением в техническую поддержку [включите запись логов мастера](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-update.md) в лог-группу {{ cloud-logging-name }}, в том числе логов Cluster Autoscaler. В них можно найти причину, по которой узел не удаляется.

Если причина остается неясной, [создайте запрос в техническую поддержку]({{ link-console-support }}). Укажите идентификатор кластера, примерные дату и время проблемы и приложите YAML-спецификации контроллеров затронутых подов.

Подробнее о диагностике масштабирования — в [документации Cluster Autoscaler](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#table-of-contents). Возможности Descheduler описаны отдельно в [его документации](https://github.com/kubernetes-sigs/descheduler).

#### В группе с автоматическим масштабированием количество узлов не уменьшается до одного, даже при отсутствии нагрузки {#autoscaler-one-node}

В кластере {{ managed-k8s-name }} приложение `kube-dns-autoscaler` регулирует количество реплик CoreDNS. Если в конфигурации `kube-dns-autoscaler` параметр `preventSinglePointFailure` имеет значение `true` и в группе больше одного узла, минимальное количество реплик CoreDNS равно двум. В этом случае Cluster Autoscaler не может уменьшить количество узлов в кластере так, чтобы оно стало меньше количества подов CoreDNS.

[Подробнее о масштабировании DNS по размеру кластера](../../tutorials/container-infrastructure/dns-autoscaler.md).

**Решение**:

1. Отключите защиту, при которой минимальное количество реплик CoreDNS равно двум. Для этого в [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/) `kube-dns-autoscaler` установите значение параметра `preventSinglePointFailure` равным `false`.
1. Разрешите вытеснение подов `kube-dns-autoscaler`, добавив аннотацию `save-to-evict` в [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/):

    ```bash
    kubectl patch deployment kube-dns-autoscaler -n kube-system \
      --type merge \
      -p '{"spec":{"template":{"metadata":{"annotations":{"cluster-autoscaler.kubernetes.io/safe-to-evict":"true"}}}}}'
    ```

#### Почему под удалился, а размер группы узлов не уменьшается? {#not-scaling-pod}

Если узел недостаточно нагружен, он удаляется по истечении 10 минут.

#### Почему автоматическое масштабирование не выполняется, хотя количество узлов меньше минимума / больше максимума? {#beyond-limits}

Установленные лимиты не будут нарушены при масштабировании, но {{ managed-k8s-name }} не следит за соблюдением границ намеренно. Масштабирование в сторону увеличения сработает только в случае появления подов, которые нельзя разместить на существующих узлах из-за нехватки запрошенных ресурсов (`unschedulable`).

Параметр **{{ ui-key.yacloud.k8s.node-groups.create.field_initial-size }}** определяет число узлов при создании группы. После создания размером группы управляет Cluster Autoscaler. Параметр **{{ ui-key.yacloud.k8s.node-groups.create.field_min-size }}** задает нижнюю границу при уменьшении группы. Изменение этих параметров не является командой немедленно создать новые узлы. Высокая загрузка уже работающих подов сама по себе также не запускает увеличение группы.

Если проблема сохраняется, [создайте запрос в техническую поддержку]({{ link-console-support }}). Укажите идентификатор кластера, время возникновения ошибки и результаты диагностики. Укажите ожидаемый размер группы и приложите описание подов, которые не удается разместить.

#### Почему в моем кластере остаются поды со статусом Terminated? {#terminated-pod}

Это происходит из-за того, что во время автоматического масштабирования контроллер [Pod garbage collector (PodGC)](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-garbage-collection) не успевает удалять поды. Подробнее в разделе [Удаление подов в статусе Terminated](../../managed-kubernetes/operations/autoscale.md#delete-terminated).

Ответы на другие вопросы об автоматическом масштабировании смотрите в [документации {{ k8s }}](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#table-of-contents).

#### Есть ли поддержка Horizontal Pod Autoscaler? {#horizontal-pod-autoscaler}

Да, {{ managed-k8s-name }} поддерживает механизм [горизонтального автомасштабирования подов](../../managed-kubernetes/concepts/autoscale.md#hpa) (Horizontal Pod Autoscaler).

#### Как выбрать минимальный пресет мастера, чтобы снизить расходы? {#master-preset-cost}

Выбирайте конфигурацию мастера, соответствующую реальной нагрузке на кластер. Ориентируйтесь на [рекомендуемые конфигурации](../../managed-kubernetes/concepts/master-configuration.md) — они зависят от числа узлов, максимального количества подов и используемого CNI.

#### Можно ли изменить пороги автоматического масштабирования мастера на стороне пользователя? {#master-autoscaler-thresholds}

Нет. Пороги срабатывания управляются на стороне сервиса {{ managed-k8s-name }}. Если вы хотите поделиться обратной связью о работе автоскейлера, обратитесь в [техническую поддержку]({{ link-console-support }}).

Косвенно влиять на поведение автоскейлера можно через выбор конфигурации мастера. {{ k8s-ma }} не уменьшает ресурсы ниже выбранной конфигурации.

#### Можно ли ограничить автоматическое масштабирование мастера сверху? {#master-autoscaler-max}

Нет, установить максимальные значения параметров масштабирования нельзя.

#### Как запретить уменьшение ресурсов мастера при автоматическом масштабировании? {#master-autoscaler-no-scaledown}

Выберите конфигурацию мастера, [соответствующую текущей нагрузке](../../managed-kubernetes/concepts/master-configuration.md). {{ k8s-ma }} не уменьшает ресурсы ниже выбранной конфигурации.
