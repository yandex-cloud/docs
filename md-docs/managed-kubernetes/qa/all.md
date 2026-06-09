# Вопросы и ответы про {{ managed-k8s-name }}

### Общие вопросы {#toc-general}

* [Какие сервисы доступны по умолчанию в кластерах {{ managed-k8s-name }}?](#defaults)

* [Какая версия {{ k8s }} CLI (kubectl) должна быть установлена для полноценной работы с кластером?](#kubectl-version)

* [Сможет ли {{ yandex-cloud }} восстановить работоспособность кластера, если я допущу ошибки при его настройке?](#tech-support-cases)

* [Кто будет заниматься мониторингом здоровья кластера?](#health-check)

* [Как быстро {{ yandex-cloud }} закрывает уязвимости, обнаруженные в системе безопасности? Что делать, если злоумышленник успеет воспользоваться уязвимостью, и мои данные пострадают?](#security-updates)

* [Я могу подключиться к узлу кластера через {{ oslogin }}, по аналогии с ВМ {{ yandex-cloud }}?](#connect-via-oslogin)

* [Какая операционная система используется на узлах кластера?](#cluster-node-os)

* [Поддерживает ли Yandex Virtual Private Cloud протокол IPv6?](#ipv6-support)

### Хранилище данных {#toc-volumes}

* [Какие существуют особенности работы с дисковым хранилищем при размещении БД ({{ MY }}, {{ PG }} и т. д.) в кластере {{ k8s }}?](#bd)

* [Как подключить под к управляемым базам данных {{ yandex-cloud }}?](#mdb)

* [Как правильно подключить постоянный том к контейнеру?](#persistent-volume)

* [Какие типы томов поддерживает {{ managed-k8s-name }}?](#supported-volumes)

### Автоматическое масштабирование {#toc-autosscaling}

* [Почему в моем кластере стало N узлов и он не уменьшается?](#not-scaling-down)

* [В группе с автоматическим масштабированием количество узлов не уменьшается до одного, даже при отсутствии нагрузки](#autoscaler-one-node)

* [Почему под удалился, а размер группы узлов не уменьшается?](#not-scaling-pod)

* [Почему автоматическое масштабирование не выполняется, хотя количество узлов меньше минимума / больше максимума?](#beyond-limits)

* [Почему в моем кластере остаются поды со статусом Terminated?](#terminated-pod)

* [Есть ли поддержка Horizontal Pod Autoscaler?](#horizontal-pod-autoscaler)

* [Как выбрать минимальный пресет мастера, чтобы снизить расходы?](#master-preset-cost)

* [Можно ли изменить пороги автоматического масштабирования мастера на стороне пользователя?](#master-autoscaler-thresholds)

* [Можно ли ограничить автоматическое масштабирование мастера сверху?](#master-autoscaler-max)

* [Как запретить автоматическое уменьшение ресурсов мастера при автоматическом масштабировании?](#master-autoscaler-no-scaledown)

### Настройка и обновление {#toc-settings}

* [Что делать, если часть моих данных потеряется при обновлении версии {{ k8s }}?](#backups-update)

* [Можно ли настроить резервное копирование для кластера {{ k8s }}?](#cluster-backups)

* [Будут ли ресурсы простаивать при обновлении версии {{ k8s }}?](#downtime-update)

* [Можно ли обновить кластер {{ managed-k8s-name }} в один этап?](#upgrade-in-one-step)

* [Обновляется ли плагин Container Network Interface вместе с кластером {{ managed-k8s-name }}?](#upgrade-cni)

* [Можно ли прислать вам YAML-файл с конфигурацией, чтобы вы применили его к моему кластеру?](#configs)

* [Можете ли вы установить Web UI Dashboard, Rook и другие инструменты?](#install-tools)

* [Что делать, если после обновления {{ k8s }} не подключаются тома?](#pvc)

### Ресурсы {#toc-resources}

* [Какие ресурсы требуются для обслуживания кластера {{ k8s }}, в который входит группа, например, из трех узлов?](#required-resources)

* [Можно ли изменять ресурсы для каждого узла в кластере {{ k8s }}?](#change-resources)

* [Кто будет следить за масштабированием кластера {{ k8s }}?](#scaling)

* [Нужен ли узлам кластера {{ k8s }} доступ в интернет?](#internet-access)

### Логи {#toc-logs}

* [Как я могу отслеживать состояние кластера {{ managed-k8s-name }}?](#monitoring)

* [Я могу получить логи моей работы в сервисах?](#logs)


* [Можно ли самостоятельно сохранять логи?](#auto-logging)


* [Можно ли использовать сервис {{ cloud-logging-full-name }} для просмотра логов?](#master-logging)

### Решение проблем {#toc-troubleshooting}

* [Ошибка при создании кластера в облачной сети другого каталога](#neighbour-catalog-permission-denied)

* [Пространство имен удалено, но все еще находится в статусе Terminating и не удаляется](#namespace-terminating)

* [Использую {{ network-load-balancer-full-name }} вместе с Ingress-контроллером, почему некоторые узлы моего кластера находятся в состоянии UNHEALTHY?](#nlb-ingress)

* [Почему созданный PersistentVolumeClaim остается в статусе Pending?](#pvc-pending)

* [Почему кластер {{ managed-k8s-name }} не запускается после изменения конфигурации его узлов?](#not-starting)

* [Ошибка при обновлении сертификата Ingress-контроллера](#ingress-certificate)

* [Почему в кластере не работает разрешение имен DNS?](#not-resolve-dns)

* [При создании группы узлов через CLI возникает конфликт параметров. Как его решить?](#conflicting-flags)

* [Ошибка при подключении к кластеру с помощью `kubectl`](#connect-to-cluster)

* [Ошибки при подключении к узлу по SSH](#node-connect)

* [Как выдать доступ в интернет узлам кластера {{ managed-k8s-name }}?](#internet)

* [Почему я не могу выбрать Docker в качестве среды запуска контейнеров?](#docker-runtime)

* [Ошибка при подключении репозитория {{ GL }} к Argo CD](#argo-cd)

* [При развертывании обновлений приложения в кластере с {{ alb-full-name }} наблюдается потеря трафика](#alb-traffic-lost)

* [Некорректно отображается системное время в консоли Linux, а также в журналах контейнеров и подов кластера {{ managed-k8s-name }}](#time)

* [Что делать, если я удалил сетевой балансировщик нагрузки или целевые группы {{ network-load-balancer-full-name }}, автоматически созданные для сервиса типа LoadBalancer?](#deleted-loadbalancer-service)

* [Ошибка при подключении виртуальной машины {{ compute-full-name }} в качестве внешнего узла {{ managed-k8s-name }}](#vm-as-external-node)

## Общие вопросы {#general}

#### Какие сервисы доступны по умолчанию в кластерах {{ managed-k8s-name }}? {#defaults}

По умолчанию доступны:
* [Сервер метрик (Metrics Server)](https://github.com/kubernetes-sigs/metrics-server) для агрегации данных об использовании ресурсов в [кластере {{ k8s }}](../concepts/index.md#kubernetes-cluster).
* [Плагин {{ k8s }} для CoreDNS](https://coredns.io/plugins/kubernetes/) для разрешения имен в кластере.
* [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) с поддержкой [CSI-плагинов](https://github.com/container-storage-interface/spec) для работы с [постоянными томами](../concepts/volume.md) (`PersistentVolume`).

#### Какая версия {{ k8s }} CLI (kubectl) должна быть установлена для полноценной работы с кластером? {#kubectl-version}

Мы рекомендуем использовать последнюю доступную официальную версию [kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl/), чтобы избежать проблем совместимости.

#### Сможет ли {{ yandex-cloud }} восстановить работоспособность кластера, если я допущу ошибки при его настройке? {#tech-support-cases}

[Мастер](../concepts/index.md#master) находится под управлением {{ yandex-cloud }}, поэтому вы не сможете его повредить. Если у вас возникли проблемы с компонентами кластера {{ k8s }}, обратитесь в [техническую поддержку]({{ link-console-support }}).

#### Кто будет заниматься мониторингом здоровья кластера? {#health-check}

{{ yandex-cloud }}. В кластере проводится мониторинг повреждений файловой системы (corrupted file system), неисправностей ядра (kernel deadlock), потери связи с интернетом и проблем с компонентами {{ k8s }}. Мы также разрабатываем механизм автоматического восстановления для неисправных компонентов.

#### Как быстро {{ yandex-cloud }} закрывает уязвимости, обнаруженные в системе безопасности? Что делать, если злоумышленник успеет воспользоваться уязвимостью, и мои данные пострадают? {#security-updates}

Сервисы {{ yandex-cloud }}, образы и конфигурация мастера изначально проходят [различные проверки на безопасность и соответствие стандартам](../../security/index.md). 

Пользователи могут выбрать [периодичность установки обновлений](../concepts/release-channels-and-updates.md#updates) в зависимости от решаемых задач и конфигурации кластера. Необходимо учитывать направления атаки и уязвимость приложений, развернутых в кластере {{ k8s }}. Факторами, влияющими на безопасность приложений, могут быть [политики сетевой безопасности](../concepts/network-policy.md) между приложениями, уязвимости внутри [Docker-контейнеров](https://yandex.cloud/ru/blog/posts/2022/03/docker-containers), а также некорректный режим запуска контейнеров в кластере.

#### Я могу подключиться к узлу кластера через {{ oslogin }}, по аналогии с ВМ {{ yandex-cloud }}? {#connect-via-oslogin}

Да, для этого [воспользуйтесь инструкцией](../operations/node-connect-oslogin.md).

#### Какая операционная система используется на узлах кластера? {#cluster-node-os}

В зависимости от [канала обновлений и версии](../concepts/release-channels-and-updates.md) {{ k8s }} на узлах кластера предустанавливается Ubuntu 20.04 или Ubuntu 22.04.

#### Поддерживает ли Yandex Virtual Private Cloud протокол IPv6? {#ipv6-support}

В {{ vpc-full-name }} [отсутствует поддержка протокола IPv6](../../vpc/concepts/network-overview.md#limits), но на уровне ОС на узлах кластера IPv6 включен по умолчанию.

## Хранилище данных {#volumes}

#### Какие существуют особенности работы с дисковым хранилищем при размещении БД ({{ MY }}, {{ PG }} и т. д.) в кластере {{ k8s }}? {#bd}

При размещении БД в кластере {{ k8s }} используйте контроллеры [StatefullSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/). Мы не рекомендуем запускать в {{ k8s }} statefull-сервисы в постоянными томами. Для работы с базами данных statefull-сервисов используйте [управляемые базы данных {{ yandex-cloud }}]({{ link-cloud-services }}#data-platform), например {{ mmy-name }} или {{ mpg-name }}.

#### Как подключить под к управляемым базам данных {{ yandex-cloud }}? {#mdb}

Чтобы подключиться к [управляемой базе данных {{ yandex-cloud }}]({{ link-cloud-services }}#data-platform), расположенной в той же [сети](../../vpc/concepts/network.md#network), укажите [имя ее хоста и FQDN](../../compute/concepts/network.md#hostname).

Для подключения сертификата базы данных к [поду](../concepts/index.md#pod) используйте объекты типа `secret` или `configmap`.

#### Как правильно подключить постоянный том к контейнеру? {#persistent-volume}

Вы можете выбрать режим для подключения [дисков](../../compute/concepts/disk.md) {{ compute-name }} в зависимости от ваших нужд:
* Чтобы {{ k8s }} автоматически подготовил объект `PersistentVolume` и настроил новый диск, создайте под с [динамически подготовленным](../operations/volumes/dynamic-create-pv.md) томом.
* Чтобы использовать уже существующие диски {{ compute-name }}, создайте под со [статически подготовленным](../operations/volumes/static-create-pv.md) томом.

Подробнее читайте в разделе [Работа с постоянными томами](../concepts/volume.md#persistent-volume).

#### Какие типы томов поддерживает {{ managed-k8s-name }}? {#supported-volumes}

{{ managed-k8s-name }} поддерживает работу с временными (`Volume`) и постоянными (`PersistentVolume`) томами. Подробнее читайте в разделе [{#T}](../concepts/volume.md).

## Автоматическое масштабирование {#autosscaling}

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
kubectl annotate pod <имя_пода> cluster-autoscaler.kubernetes.io/safe-to-evict=true
```

{% endnote %}

Другие возможные причины:
* [Группа узлов](../concepts/index.md#node-group) уже достигла минимального размера.
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

Установленные лимиты не будут нарушены при масштабировании, но {{ managed-k8s-name }} не следит за соблюдением границ намеренно. Масштабирование в сторону увеличения сработает только в случае появления подов в статусе `unschedulable`.

#### Почему в моем кластере остаются поды со статусом Terminated? {#terminated-pod}

Это происходит из-за того, что во время автоматического масштабирования контроллер [Pod garbage collector (PodGC)](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-garbage-collection) не успевает удалять поды. Подробнее в разделе [Удаление подов в статусе Terminated](../operations/autoscale.md#delete-terminated).

Ответы на другие вопросы об автоматическом масштабировании смотрите в [документации {{ k8s }}](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#table-of-contents).

#### Есть ли поддержка Horizontal Pod Autoscaler? {#horizontal-pod-autoscaler}

Да, {{ managed-k8s-name }} поддерживает механизм [горизонтального автомасштабирования подов](../concepts/autoscale.md#hpa) (Horizontal Pod Autoscaler).

#### Как выбрать минимальный пресет мастера, чтобы снизить расходы? {#master-preset-cost}

Выбирайте конфигурацию мастера, соответствующую реальной нагрузке на кластер. Ориентируйтесь на [рекомендуемые конфигурации](../concepts/master-configuration.md) — они зависят от числа узлов, максимального количества подов и используемого CNI.

#### Можно ли изменить пороги автоматического масштабирования мастера на стороне пользователя? {#master-autoscaler-thresholds}

Нет. Пороги срабатывания управляются на стороне сервиса {{ managed-k8s-name }}. Если вы хотите поделиться обратной связью о работе автоскейлера, обратитесь в [техническую поддержку]({{ link-console-support }}).

Косвенно влиять на поведение автоскейлера можно через выбор конфигурации мастера. {{ k8s-ma }} не уменьшает ресурсы ниже выбранной конфигурации.

#### Можно ли ограничить автоматическое масштабирование мастера сверху? {#master-autoscaler-max}

Нет, установить максимальные значения параметров масштабирования нельзя.

#### Как запретить уменьшение ресурсов мастера при автоматическом масштабировании? {#master-autoscaler-no-scaledown}

Выберите конфигурацию мастера, [соответствующую текущей нагрузке](../concepts/master-configuration.md). {{ k8s-ma }} не уменьшает ресурсы ниже выбранной конфигурации.

## Настройка и обновление {#settings}

#### Что делать, если часть моих данных потеряется при обновлении версии {{ k8s }}? {#backups-update}

Данные не потеряются: перед [обновлением версии {{ k8s }}](../concepts/release-channels-and-updates.md) {{ managed-k8s-name }} подготавливаем для них резервные копии. Вы можете самостоятельно настроить [резервное копирование кластера в {{ objstorage-full-name }}](../tutorials/kubernetes-backup.md). Также мы рекомендуем выполнять резервное копирование баз данных средствами самого приложения.

#### Можно ли настроить резервное копирование для кластера {{ k8s }}? {#cluster-backups}

Данные в [кластерах {{ managed-k8s-name }}](../concepts/index.md#kubernetes-cluster) надежно хранятся и реплицируются в инфраструктуре {{ yandex-cloud }}. Однако в любой момент вы можете сделать резервные копии данных из [групп узлов](../concepts/index.md#node-group) кластеров {{ managed-k8s-name }} и хранить их в [{{ objstorage-name }}](../../storage/index.md) или другом хранилище.

Подробнее читайте в разделе [{#T}](../tutorials/kubernetes-backup.md).

#### Будут ли ресурсы простаивать при обновлении версии {{ k8s }}? {#downtime-update}

При обновлении [мастера](../concepts/index.md#master) будут простаивать ресурсы Control Plane. Поэтому такие операции, как [создание](../operations/node-group/node-group-create.md) или [удаление](../operations/node-group/node-group-delete.md) [группы узлов {{ managed-k8s-name }}](../concepts/index.md#node-group), будут недоступны. Пользовательская нагрузка на приложение продолжит обрабатываться.

Если значение `max_expansion` больше нуля, при обновлении групп узлов {{ managed-k8s-name }} создаются новые узлы. На них переводится вся нагрузка, а старые группы узлов удаляются. Простой при этом будет равен времени рестарта [пода](../concepts/index.md#pod) при перемещении в новую группу узлов {{ managed-k8s-name }}.

#### Можно ли обновить кластер {{ managed-k8s-name }} в один этап? {#upgrade-in-one-step}

Зависит от того, с какой на какую версию вы хотите перевести кластер {{ managed-k8s-name }}. За один этап кластер {{ managed-k8s-name }} можно обновить только до следующей минорной версии относительно текущей. Обновление до более новых версий производится в несколько этапов, например: 1.19 → 1.20 → 1.21. Подробнее см. в разделе [{#T}](../operations/update-kubernetes.md#cluster-upgrade).

Если при обновлении вы хотите пропустить промежуточные версии, [создайте кластер {{ managed-k8s-name }}](../operations/kubernetes-cluster/kubernetes-cluster-create.md) с нужной версией и перенесите нагрузку на него со старого кластера.

#### Обновляется ли плагин Container Network Interface вместе с кластером {{ managed-k8s-name }}? {#upgrade-cni}

Да. Если вы используете контроллеры [Calico](../concepts/network-policy.md#calico) и [Cilium](../concepts/network-policy.md#cilium), они обновляются вместе с кластером {{ managed-k8s-name }}. Чтобы обновить кластер {{ managed-k8s-name }}, выполните одно из действий:
* [Создайте кластер {{ managed-k8s-name }}](../operations/kubernetes-cluster/kubernetes-cluster-create.md) с нужной версией и перенесите нагрузку на него со старого кластера.
* [Обновите кластер {{ managed-k8s-name }} вручную](../operations/update-kubernetes.md#cluster-manual-upgrade).

Чтобы вовремя получать обновления для текущей версии кластера {{ managed-k8s-name }}, [настройте автоматическое обновление](../operations/update-kubernetes.md#cluster-auto-upgrade).

#### Можно ли прислать вам YAML-файл с конфигурацией, чтобы вы применили его к моему кластеру? {#configs}

Нет. Вы можете использовать kubeconfig-файл, чтобы применить YAML-файл с конфигурацией кластера самостоятельно.

#### Можете ли вы установить Web UI Dashboard, Rook и другие инструменты? {#install-tools}

Нет. Вы можете установить все необходимые инструменты самостоятельно.

#### Что делать, если после обновления {{ k8s }} не подключаются тома? {#pvc}

Если после обновления {{ k8s }} вы получаете ошибку:

```text
AttachVolume.Attach failed for volume "pvc":
Attach timeout for volume yadp-k8s-volumes/pvc
```

Обновите [драйвер s3-CSI](https://github.com/ctrox/csi-s3) до актуальной версии.

## Ресурсы {#resources}

#### Какие ресурсы требуются для обслуживания кластера {{ k8s }}, в который входит группа, например, из трех узлов? {#required-resources}

Для каждого [узла](../concepts/index.md#node-group) необходимы ресурсы для запуска компонентов, которые отвечают за функционирование узла как части [кластера {{ k8s }}](../concepts/index.md#kubernetes-cluster). Подробнее читайте в разделе [{#T}](../concepts/node-group/allocatable-resources.md).

#### Можно ли изменять ресурсы для каждого узла в кластере {{ k8s }}? {#change-resources}

Вы можете изменять ресурсы только для группы узлов. В одном кластере {{ k8s }} можно создавать группы с разными конфигурациями и размещать их в разных [зонах доступности](../../overview/concepts/geo-scope.md). Подробнее читайте в разделе [{#T}](../operations/node-group/node-group-update.md).

#### Кто будет следить за масштабированием кластера {{ k8s }}? {#scaling}

В {{ managed-k8s-name }} можно включить [автоматическое масштабирование кластера](../concepts/autoscale.md#ca).

#### Нужен ли узлам кластера {{ k8s }} доступ в интернет? {#internet-access}

Для подключения к внешним ресурсам, например реестрам Docker-образов [{{ container-registry-name }}](../../container-registry/concepts/index.md), [{{ cloud-registry-name }}](../../cloud-registry/concepts/index.md) или [Docker Hub](https://hub.docker.com/), а также бакетам [{{ objstorage-name }}](../../storage/concepts/bucket.md), у узлов группы должен быть доступ в интернет.

Чтобы обеспечить доступ в интернет, [назначьте](../operations/node-group/node-group-update.md#node-internet-access) узлам публичный IP-адрес и [настройте](../operations/connect/security-groups.md#rules-internal-nodegroup) группу безопасности. Также в качестве альтернативы публичным IP-адресам можно создать и настроить в подсети узлов [NAT-шлюз](../../vpc/operations/create-nat-gateway.md) или [NAT-инстанс](../../vpc/tutorials/nat-instance/index.md).

Подробнее см. в подразделе [Доступ в интернет для рабочих узлов кластера](../concepts/network.md#nodes-internet).

## Логи {#logs}

#### Как я могу отслеживать состояние кластера {{ managed-k8s-name }}? {#monitoring}

[Получите статистику кластера](../operations/kubernetes-cluster/kubernetes-cluster-get-stats.md). Описание доступных метрик кластера приводится в [справочнике](../metrics.md).

#### Я могу получить логи моей работы в сервисах? {#logs}

Да, вы можете запросить информацию о работе с вашими ресурсами из логов сервисов {{ yandex-cloud }}. Для этого обратитесь в [техническую поддержку]({{ link-console-support }}).


#### Можно ли самостоятельно сохранять логи? {#auto-logging}

Для сбора и хранения логов используйте [Fluent Bit](../tutorials/fluent-bit-logging.md).


#### Можно ли использовать сервис {{ cloud-logging-full-name }} для просмотра логов? {#master-logging}

Да, для этого настройте отправку логов в [{{ cloud-logging-name }}](../../logging/index.md) при [создании](../operations/kubernetes-cluster/kubernetes-cluster-create.md) или [изменении](../operations/kubernetes-cluster/kubernetes-cluster-update.md) [кластера {{ managed-k8s-name }}](../concepts/index.md#kubernetes-cluster). Настройка доступна только в CLI, {{ TF }} и API.

## Решение проблем {#troubleshooting}

В этом разделе описаны типичные проблемы, которые могут возникать при работе {{ managed-k8s-name }}, и методы их решения.

#### Ошибка при создании кластера в облачной сети другого каталога {#neighbour-catalog-permission-denied}

Текст ошибки:

```text
Permission denied
```

Ошибка возникает из-за отсутствия у [сервисного аккаунта для ресурсов](../security/index.md#sa-annotation) необходимых [ролей](../../iam/concepts/access-control/roles.md) в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder), [облачная сеть](../../vpc/concepts/network.md#network) которого выбирается при создании.

Чтобы создать [кластер {{ managed-k8s-name }}](../concepts/index.md#kubernetes-cluster) в облачной сети другого каталога, [назначьте](../../iam/operations/sa/assign-role-for-sa.md) [сервисному аккаунту](../../iam/concepts/users/service-accounts.md) для ресурсов следующие роли в этом каталоге:
* [{{ roles-vpc-private-admin }}](../../vpc/security/index.md#vpc-private-admin)
* [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user)

Для использования [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses) дополнительно [назначьте](../../iam/operations/sa/assign-role-for-sa.md) роль [{{ roles-vpc-public-admin }}](../../vpc/security/index.md#vpc-public-admin).

#### Пространство имен удалено, но все еще находится в статусе Terminating и не удаляется {#namespace-terminating}

Такое случается, когда в [пространстве имен](../concepts/index.md#namespace) остаются зависшие ресурсы, которые контроллер пространства не может удалить.

Чтобы устранить проблему, вручную удалите зависшие ресурсы.

{% list tabs %}

- CLI

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. [Подключитесь к кластеру {{ managed-k8s-name }}](../operations/connect/index.md).
  1. Узнайте, какие ресурсы остались в пространстве имен:

     ```bash
     kubectl api-resources --verbs=list --namespaced --output=name \
       | xargs --max-args=1 kubectl get --show-kind \
       --ignore-not-found --namespace=<пространство_имен>
     ```

  1. Удалите найденные ресурсы:

     ```bash
     kubectl delete <тип_ресурса> <имя_ресурса> --namespace=<пространство_имен>
     ```

  Если после этого пространство имен все равно находится в статусе `Terminating` и не удаляется, удалите его принудительно, использовав `finalizer`:
  1. Включите проксирование API {{ k8s }} на ваш локальный компьютер:

     ```bash
     kubectl proxy
     ```

  1. Удалите пространство имен:

     ```bash
     kubectl get namespace <пространство_имен> --output=json \
       | jq '.spec = {"finalizers":[]}' > temp.json && \
     curl --insecure --header "Content-Type: application/json" \
       --request PUT --data-binary @temp.json \
       127.0.0.1:8001/api/v1/namespaces/<пространство_имен>/finalize
     ```

    Не рекомендуется сразу удалять пространство имен в статусе `Terminating` с помощью `finalizer`, так как при этом зависшие ресурсы могут остаться в кластере {{ managed-k8s-name }}.

{% endlist %}

#### Использую {{ network-load-balancer-full-name }} вместе с Ingress-контроллером, почему некоторые узлы моего кластера находятся в состоянии UNHEALTHY? {#nlb-ingress}

Это нормальное поведение [балансировщика нагрузки](../../network-load-balancer/concepts/index.md) при политике `External Traffic Policy: Local`. Статус `HEALTHY` получают только те [узлы {{ managed-k8s-name }}](../concepts/index.md#node-group), [поды](../concepts/index.md#pod) которых готовы принимать пользовательский трафик. Оставшиеся узлы помечаются как `UNHEALTHY`.

Чтобы узнать тип политики балансировщика, созданного с помощью сервиса типа `LoadBalancer`, выполните команду:

```bash
kubectl describe svc <имя_сервиса_типа_LoadBalancer> \
| grep 'External Traffic Policy'
```

Подробнее в разделе [Параметры сервиса типа LoadBalancer](../operations/create-load-balancer.md#advanced).

#### Почему созданный PersistentVolumeClaim остается в статусе Pending? {#pvc-pending}

Это нормальное поведение [PersistentVolumeClaim](../concepts/volume.md#persistent-volume). Созданный PVC находится в статусе **Pending**, пока не будет создан под, который должен его использовать.

Чтобы перевести PVC в статус **Running**:
1. Просмотрите информацию о PVC:

   ```bash
   kubectl describe pvc <имя_PVC> \
     --namespace=<пространство_имен>
   ```

   Где `--namespace` — пространство имен, в котором находится PVC.

   Сообщение `waiting for first consumer to be created before binding` означает, что PVC ожидает создания пода.
1. [Создайте под](../operations/volumes/dynamic-create-pv.md#create-pod) для этого PVC.

#### Почему кластер {{ managed-k8s-name }} не запускается после изменения конфигурации его узлов? {#not-starting}

Проверьте, что новая конфигурация узлов {{ managed-k8s-name }} не превышает [квоты](../concepts/limits.md):

{% list tabs %}

- CLI

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы провести диагностику узлов кластера {{ managed-k8s-name }}:
  1. [Подключитесь к кластеру {{ managed-k8s-name }}](../operations/connect/index.md).
  1. Проверьте состояние узлов {{ managed-k8s-name }}:

     ```bash
     yc managed-kubernetes cluster list-nodes <идентификатор_кластера>
     ```

     Сообщение о том, что ресурсы кластера {{ managed-k8s-name }} исчерпаны, отображается в первом столбце вывода команды. Пример:

     ```text
     +--------------------------------+-----------------+------------------+-------------+--------------+
     |         CLOUD INSTANCE         | KUBERNETES NODE |     RESOURCES    |     DISK    |    STATUS    |
     +--------------------------------+-----------------+------------------+-------------+--------------+
     | fhmil14sdienhr5uh89no          |                 | 2 100% core(s),  | 64.0 GB hdd | PROVISIONING |
     | CREATING_INSTANCE              |                 | 4.0 GB of memory |             |              |
     | [RESOURCE_EXHAUSTED] The limit |                 |                  |             |              |
     | on total size of network-hdd   |                 |                  |             |              |
     | disks has exceeded.,           |                 |                  |             |              |
     | [RESOURCE_EXHAUSTED] The limit |                 |                  |             |              |
     | on total size of network-hdd   |                 |                  |             |              |
     | disks has exceeded.            |                 |                  |             |              |
     +--------------------------------+-----------------+------------------+-------------+--------------+
     ```

{% endlist %}

Чтобы кластер {{ managed-k8s-name }} запустился, [увеличьте квоты](../concepts/limits.md).

#### После изменения маски подсети узлов в настройках кластера количество подов, размещаемых на узлах, не соответствует ожидаемому {#count-pods}

**Решение**: пересоздайте группу узлов.

#### Ошибка при обновлении сертификата Ingress-контроллера {#ingress-certificate}

Текст ошибки:

```text
ERROR controller-runtime.manager.controller.ingressgroup Reconciler error
{"name": "some-prod", "namespace": , "error": "rpc error: code = InvalidArgument
desc = Validation error:\nlistener_specs[1].tls.sni_handlers[2].handler.certificate_ids:
Number of elements must be less than or equal to 1"}
```

Ошибка возникает, если для одного обработчика Ingress-контроллера указаны разные сертификаты.

**Решение**: исправьте и примените спецификации Ingress-контроллера таким образом, чтобы в описании каждого обработчика был указан только один сертификат.

#### Почему в кластере не работает разрешение имен DNS? {#not-resolve-dns}

Кластер {{ managed-k8s-name }} может не выполнять разрешение имен внутренних и внешних DNS-запросов по нескольким причинам. Чтобы устранить проблему:
1. [Проверьте версию кластера {{ managed-k8s-name }} и групп узлов](#check-version).
1. [Убедитесь, что CoreDNS работает](#check-coredns).
1. [Убедитесь, что кластеру {{ managed-k8s-name }} достаточно ресурсов CPU](#check-cpu).
1. [Настройте автоматическое масштабирование](#dns-autoscaler).
1. [Настройте локальное кеширование DNS](#node-local-dns).

##### Проверьте версию кластера и групп узлов {#check-version}

1. Получите список актуальных версий {{ k8s }}:

   ```bash
   yc managed-kubernetes list-versions
   ```

1. Узнайте версию кластера {{ managed-k8s-name }}:

   ```bash
   yc managed-kubernetes cluster get <имя_или_идентификатор_кластера> | grep version:
   ```

   Идентификатор и имя кластера {{ managed-k8s-name }} можно получить со [списком кластеров в каталоге](../operations/kubernetes-cluster/kubernetes-cluster-list.md#list).
1. Узнайте версию группы узлов {{ managed-k8s-name }}:

   ```bash
   yc managed-kubernetes node-group get <имя_или_идентификатор_группы_узлов> | grep version:
   ```

   Идентификатор и имя группы узлов {{ managed-k8s-name }} можно получить со [списком групп узлов в кластере](../operations/node-group/node-group-list.md#list).
1. Если версии кластера {{ managed-k8s-name }} или групп узлов не входят в список актуальных версий {{ k8s }}, [обновите их](../operations/update-kubernetes.md).

##### Убедитесь, что CoreDNS работает {#check-coredns}

Получите список подов CoreDNS и их состояние:

```bash
kubectl get pods -n kube-system -l k8s-app=kube-dns -o wide
```

Все поды должны находится в состоянии `Running`.

##### Убедитесь, что кластеру достаточно ресурсов CPU {#check-cpu}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного кластера {{ managed-k8s-name }} и выберите вкладку **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.
1. Перейдите во вкладку **{{ ui-key.yacloud.k8s.nodes.label_nodes }}** и нажмите на имя любого узла {{ managed-k8s-name }}.
1. Перейдите во вкладку **{{ ui-key.yacloud.k8s.node.overview.label_monitoring }}**.
1. Убедитесь, что на графике **CPU, [cores]** значения используемой мощности CPU `used` не достигают значений доступной мощности CPU `total`. Проверьте это для всех узлов кластера {{ managed-k8s-name }}.

##### Настройте автоматическое масштабирование {#dns-autoscaler}

Настройте [автоматическое масштабирование DNS по размеру кластера {{ managed-k8s-name }}](../tutorials/dns-autoscaler.md).

##### Настройте локальное кеширование DNS {#node-local-dns}

[Настройте NodeLocal DNS Cache](../tutorials/node-local-dns.md). Чтобы применить оптимальные настройки, [установите NodeLocal DNS Cache из {{ marketplace-full-name }}](../operations/applications/node-local-dns.md#marketplace-install).

#### При создании группы узлов через CLI возникает конфликт параметров. Как его решить? {#conflicting-flags}

Проверьте, указаны ли параметры `--location`, `--network-interface` и `--public-ip` в одной команде. Если передать эти параметры вместе, возникают ошибки:
* Для пар `--location` и `--public-ip` или `--location` и `--network-interface`:

  ```text
  ERROR: rpc error: code = InvalidArgument desc = Validation error:
  allocation_policy.locations[0].subnet_id: can't use "allocation_policy.locations[0].subnet_id" together with "node_template.network_interface_specs"
  ```

* Для пары `--network-interface` и `--public-ip`:

  ```text
  ERROR: flag --public-ip cannot be used together with --network-interface. Use '--network-interface' option 'nat' to get public address
  ```

Передавайте в команде только один из трех параметров. Расположение группы узлов {{ managed-k8s-name }} достаточно указать в `--location` либо `--network-interface`.

Чтобы выдать доступ в интернет узлам кластера {{ managed-k8s-name }}, выполните одно из действий:
* Назначьте [публичные IP-адреса](../../vpc/concepts/address.md#public-addresses) узлам кластера, указав `--network-interface ipv4-address=nat` или `--network-interface ipv6-address=nat`.
* [Включите доступ к узлам {{ managed-k8s-name }} из интернета](../operations/node-group/node-group-update.md#node-internet-access) после того, как создадите группу узлов.

#### Ошибка при подключении к кластеру с помощью `kubectl` {#connect-to-cluster}

Текст ошибки:

```text
ERROR: cluster has empty endpoint
```

Ошибка возникает, если [подключаться к кластеру](../operations/connect/index.md#kubectl-connect) без публичного IP-адреса, а учетные данные для `kubectl` получить для публичного IP-адреса с помощью команды:

```bash
{{ yc-k8s }} cluster \
   get-credentials <имя_или_идентификатор_кластера> \
   --external
```

Для подключения к внутреннему IP-адресу кластера с ВМ, находящейся в той же сети, получите учетные данные для `kubectl` с помощью команды:

```bash
{{ yc-k8s }} cluster \
   get-credentials <имя_или_идентификатор_кластера> \
   --internal
```

Если вам нужно подключиться к кластеру из интернета, [пересоздайте кластер и предоставьте](../operations/kubernetes-cluster/kubernetes-cluster-create.md) ему публичный IP-адрес.

#### Ошибки при подключении к узлу по SSH {#node-connect}

Тексты ошибок:

```text
Permission denied (publickey,password)
```

```text
Too many authentication failures
```

Ошибки возникают [при подключении к узлу {{ managed-k8s-name }}](../operations/node-connect-ssh.md) в следующих ситуациях:
* Публичный [SSH-ключ](../../glossary/ssh-keygen.md) не добавлен в метаданные группы узлов {{ managed-k8s-name }}.

  **Решение**: [обновите ключи группы узлов {{ managed-k8s-name }}](../operations/node-connect-ssh.md#node-add-metadata).
* Публичный SSH-ключ добавлен в метаданные группы узлов {{ managed-k8s-name }}, но неправильно.

  **Решение**: [приведите файл с публичными ключами к необходимому формату](../operations/node-connect-ssh.md#key-format) и [обновите ключи группы узлов {{ managed-k8s-name }}](../operations/node-connect-ssh.md#node-add-metadata).
* Приватный SSH-ключ не добавлен в аутентификационный агент (ssh-agent).

  **Решение**: добавьте приватный ключ с помощью команды `ssh-add <путь_к_файлу_приватного_ключа>`.

#### Как выдать доступ в интернет узлам кластера {{ managed-k8s-name }}? {#internet}

Если узлам кластера {{ managed-k8s-name }} не выдан доступ в интернет, при попытке подключения к интернету возникнет ошибка:

```text
Failed to pull image "{{ registry }}/***": rpc error: code = Unknown desc = Error response from daemon: Gethttps://{{ registry }}/v2/: net/http: request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)
```

Есть несколько способов выдать доступ в интернет узлам кластера {{ managed-k8s-name }}:
* Создайте и настройте [NAT-шлюз](../../vpc/operations/create-nat-gateway.md) или [NAT-инстанс](../../vpc/tutorials/nat-instance/index.md). В результате с помощью [статической маршрутизации](../../vpc/concepts/routing.md) трафик будет направлен через шлюз или отдельную [виртуальную машину](../../compute/concepts/vm.md) с функциями NAT.
* [Назначьте публичные IP-адреса группе узлов {{ managed-k8s-name }}](../operations/node-group/node-group-update.md#node-internet-access).

{% note info %}

Если вы назначили публичные IP-адреса узлам кластера и затем настроили NAT-шлюз или NAT-инстанс, доступ в интернет через публичные адреса пропадет. Подробнее см. в [документации сервиса {{ vpc-full-name }}](../../vpc/concepts/routing.md#internet-routes).

{% endnote %}

#### Почему я не могу выбрать Docker в качестве среды запуска контейнеров? {#docker-runtime}

Среда запуска контейнеров Docker не поддерживается в кластерах с версией {{ k8s }} 1.24 и выше. Доступна только среда [containerd](https://containerd.io/).

#### Ошибка при подключении репозитория {{ GL }} к Argo CD {#argo-cd}

Текст ошибки:

```text
FATA[0000] rpc error: code = Unknown desc = error testing repository connectivity: authorization failed
```

Ошибка возникает, если доступ в {{ GL }} по протоколу HTTP(S) отключен.

**Решение**: включите доступ. Для этого:

  1. В {{ GL }} на панели слева выберите **Admin → Settings → General**.
  1. В блоке **Visibility and access controls** найдите настройку **Enabled Git access protocols**.
  1. Выберите в списке пункт, разрешающий доступ по протоколу HTTP(S).

  [Подробнее в документации {{ GL }}](https://docs.gitlab.com/administration/settings/visibility_and_access_controls/#configure-enabled-git-access-protocols).

#### При развертывании обновлений приложения в кластере с {{ alb-full-name }} наблюдается потеря трафика {#alb-traffic-lost}

Если трафик вашего приложения управляется балансировщиком {{ alb-name }} и для Ingress-контроллера балансировщика включена [политика управления трафиком](../nlb-ref/service.md#servicespec) `externalTrafficPolicy: Local`, то запросы обслуживаются приложением на том узле, куда запрос передал балансировщик. Передача трафика между узлами исключается.

[Проверка состояния по умолчанию](../../network-load-balancer/concepts/health-check.md) отслеживает состояние узла, а не приложения. Поэтому трафик с {{ alb-name }} может направляться на узел, где отсутствует работающее приложение. При развертывании новой версии приложения в кластере [Ingress-контроллер {{ alb-name }}](../../application-load-balancer/tools/k8s-ingress-controller/index.md) передает запрос балансировщику на изменение конфигурации группы бэкендов. Обработка запроса занимает не менее 30 секунд, и в течение этого времени приложение может не получать пользовательский трафик.

Чтобы исключить такую ситуацию, рекомендуется настраивать проверки состояния бэкендов на балансировщике {{ alb-name }}. Благодаря проверкам состояния балансировщик своевременно отслеживает недоступные бэкенды и направляет трафик на другие бэкенды. После обновления приложения трафик будет снова распределен на все бэкенды.

Подробнее см. в разделах [{#T}](../../application-load-balancer/concepts/best-practices.md) и [{#T}](../../application-load-balancer/k8s-ref/service-for-ingress.md#annotations).

#### Некорректно отображается системное время на узлах, а также в журналах контейнеров и подов кластера {{ managed-k8s-name }} {#time}

Время кластера {{ managed-k8s-name }} может расходиться со временем других ресурсов, например виртуальной машины, если они используют для синхронизации часов разные источники. Например, кластер {{ managed-k8s-name }} синхронизируется со служебным сервером времени (по умолчанию), а ВМ синхронизируется с собственным или публичным NTP-сервером.

**Решение**: настройте синхронизацию времени кластера {{ managed-k8s-name }} с собственным NTP-сервером. Для этого:

1. Укажите адреса NTP-серверов в [настройках DHCP](../../vpc/concepts/dhcp-options.md) подсетей мастера.

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
     1. Нажмите на имя нужного кластера {{ k8s }}.
     1. В блоке **{{ ui-key.yacloud.k8s.cluster.overview.section_master }}** нажмите на имя подсети.
     1. Нажмите кнопку ![subnets](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** в правом верхнем углу.
     1. В открывшемся окне раскройте блок **{{ ui-key.yacloud.vpc.subnetworks.create.section_dhcp-options }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.vpc.subnetworks.create.button_add-ntp-server }}** и укажите IP-адрес NTP-сервера.
     1. Нажмите **{{ ui-key.yacloud.vpc.subnetworks.update.button_update }}**.

   - CLI {#cli}

     Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

     По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

     1. Посмотрите описание команды CLI для обновления параметров подсети:

         ```bash
         yc vpc subnet update --help
         ```

     1. Выполните команду `subnet` с параметром `--ntp-server`, указав IP-адрес NTP-сервера: 

         ```bash
         yc vpc subnet update <идентификатор_подсети> --ntp-server <адрес_сервера>
         ```

     {% note tip %}
     
     Чтобы узнать идентификаторы подсетей, в которых находится кластер, [получите подробную информацию о кластере](../operations/kubernetes-cluster/kubernetes-cluster-list.md#get).
     
     {% endnote %}

   - {{ TF }} {#tf}

     1. В файле конфигурации {{ TF }} измените описание подсети кластера. Добавьте блок `dhcp_options` (если он отсутствует) с параметром `ntp_servers` и укажите IP-адрес NTP-сервера:

        ```hcl
        ...
        resource "yandex_vpc_subnet" "lab-subnet-a" {
          ...
          v4_cidr_blocks = ["<IPv4-адрес>"]
          network_id     = "<идентификатор_сети>"
          ...
          dhcp_options {
            ntp_servers = ["<IPv4-адрес>"]
            ...
          }
        }
        ...
        ```

        Подробную информацию о параметрах ресурса `yandex_vpc_subnet` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/vpc_subnet).

     1. Примените изменения:

        1. В терминале перейдите в директорию с конфигурационным файлом.
        1. Проверьте корректность конфигурации с помощью команды:
        
           ```bash
           terraform validate
           ```
        
           Если конфигурация является корректной, появится сообщение:
        
           ```bash
           Success! The configuration is valid.
           ```
        
        1. Выполните команду:
        
           ```bash
           terraform plan
           ```
        
           В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
        1. Примените изменения конфигурации:
        
           ```bash
           terraform apply
           ```
        
        1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.
        
        {{ TF }} изменит все требуемые ресурсы. Проверить изменение подсети можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

        ```bash
        yc vpc subnet get <имя_подсети>
        ```
     
   - API {#api}
   
     Воспользуйтесь методом [update](../../vpc/api-ref/Subnet/update.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) и передайте в запросе:

     * IP-адрес NTP-сервера в параметре `dhcpOptions.ntpServers`.
     * Обновляемый параметр `dhcpOptions.ntpServers` в параметре `updateMask`.
     
     {% note tip %}
     
     Чтобы узнать идентификаторы подсетей, в которых находится кластер, [получите подробную информацию о кластере](../operations/kubernetes-cluster/kubernetes-cluster-list.md#get).
     
     {% endnote %}

   {% endlist %}

   {% note warning %}

   Для высокодоступного мастера, который размещается в трех зонах доступности, изменения необходимо внести в каждую из трех подсетей.

   {% endnote %}

1. Разрешите подключение из кластера к NTP-серверам.
   
   [Создайте правило](../../vpc/operations/security-group-add-rule.md) для исходящего трафика в [группе безопасности кластера и групп узлов](../operations/connect/security-groups.md#rules-internal-cluster):

   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `123`. Если вместо порта `123` вы используете на NTP-сервере другой порт, укажите его.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_udp }}`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `<IP-адрес_NTP-сервера>/32`. Для мастера, который размещается в трех зонах доступности, укажите три блока: `<IP-адрес_NTP-сервера_в_подсети1>/32`, `<IP-адрес_NTP-сервера_в_подсети2>/32`, `<IP-адрес_NTP-сервера_в_подсети3>/32`.

1. Обновите сетевые параметры в группе узлов кластера одним из следующих способов:

   * Подключитесь к каждому узлу группы [по SSH](../operations/node-connect-ssh.md) или [через {{ oslogin }}](../operations/node-connect-oslogin.md) и выполните команду `sudo dhclient -v -r && sudo dhclient`.
   * Перезагрузите узлы группы в удобное для вас время.

   {% note warning %}

   Обновление сетевых параметров может привести к недоступности сервисов внутри кластера на несколько минут.

   {% endnote %}

#### Что делать, если я удалил сетевой балансировщик нагрузки или целевые группы {{ network-load-balancer-full-name }}, автоматически созданные для сервиса типа LoadBalancer? {#deleted-loadbalancer-service}

Восстановить сетевой балансировщик или целевые группы {{ network-load-balancer-name }} вручную нельзя. [Пересоздайте](../operations/create-load-balancer.md#lb-create) сервис типа `LoadBalancer` — балансировщик и целевые группы будут созданы автоматически.

#### Ошибка при подключении виртуальной машины {{ compute-full-name }} в качестве внешнего узла {{ managed-k8s-name }} {#vm-as-external-node}

Текст ошибки:

```text
Unable to create remote dir /home/kubernetes/bin/: ssh run `mkdir -p -m 0644 /home/kubernetes/bin/': Process exited with status 142
Please login as the user "NONE" rather than the user "root".
```

Чтобы устранить проблему, [пересоздайте](../../compute/operations/index.md#vm-create) виртуальную машину, указав в метаданных для ключа `user-data` параметр `disable_root: false`.

{% cut "Пример метаданных" %}

```yaml
#cloud-config
datasource:
 Ec2:
  strict_id: false
disable_root: false
users:
- name: <имя_пользователя>
  sudo: ALL=(ALL) NOPASSWD:ALL
  shell: /bin/bash
  ssh_authorized_keys:
  - ssh-rsa <публичный_ключ_доступа_к_ВМ>
```

{% endcut %}