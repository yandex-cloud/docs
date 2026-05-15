# Автоматическое масштабирование

Автоматическое масштабирование — это изменение размера [группы узлов](index.md#node-group), количества подов или количества выделяемых каждому поду ресурсов на основе запросов ресурсов для [подов](index.md#pod), запущенных на узлах этой группы. Автоматическое масштабирование доступно в Kubernetes с версии 1.15.

В кластере Managed Service for Kubernetes доступны три вида автоматического масштабирования:
* _Автоматическое масштабирование кластера_ (Cluster Autoscaler). Managed Service for Kubernetes отслеживает нагрузку на узлы и при необходимости изменяет их количество в указанных пределах.
* _Горизонтальное масштабирование подов_ (Horizontal Pod Autoscaler). Kubernetes динамически изменяет количество подов, запущенных на каждом узле группы.
* _Вертикальное масштабирование подов_ (Vertical Pod Autoscaler). При повышении нагрузки Kubernetes выделяет каждому поду дополнительные ресурсы в установленных пределах.

Вы можете использовать несколько видов автоматического масштабирования в одном кластере. При этом не рекомендуется использовать Horizontal Pod Autoscaler и Vertical Pod Autoscaler одновременно.

## Автоматическое масштабирование кластера {#ca}

Cluster Autoscaler автоматически изменяет количество узлов в группе в зависимости от нагрузки.

{% note warning %}

Размещение узлов автомасштабируемой группы возможно только в одной [зоне доступности](../../overview/concepts/geo-scope.md).

{% endnote %}

При [создании группы узлов](../operations/node-group/node-group-create.md) выберите автоматический тип масштабирования и задайте минимальное, максимальное и начальное количество узлов в группе. Kubernetes будет периодически проверять состояние подов и нагрузку на узлы, при необходимости изменяя размер группы:
* Если поды не могут быть назначены из-за нехватки vCPU или RAM на существующих узлах, число узлов в группе будет постепенно увеличиваться до указанного максимального размера.
* Если нагрузка на узлы недостаточная и все поды могут быть назначены с меньшим количеством узлов в группе, число узлов в группе будет постепенно уменьшаться до указанного минимального размера. Если поды узла не могут быть расселены за установленное время (5 минут), узел принудительно останавливается. Время ожидания нельзя изменить.

{% note info %}

При подсчете текущих лимитов и [квот](https://console.yandex.cloud/cloud?section=quotas) сервис Managed Service for Kubernetes учитывает указанный максимальный размер группы узлов как фактический, независимо от текущего размера группы.

{% endnote %}

Включение Cluster Autoscaler доступно только при создании группы узлов. Управление Cluster Autoscaler выполняется на стороне сервиса Managed Service for Kubernetes.

Подробнее см. в документации Kubernetes:

* [описание Cluster Autoscaler](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler);
* [параметры, используемые по умолчанию](https://github.com/kubernetes/autoscaler/blob/c6b754c359a8563050933a590f9a5dece823c836/cluster-autoscaler/FAQ.md#what-are-the-parameters-to-ca);

См. также раздел [Вопросы и ответы про автоматическое масштабирование группы узлов в Managed Service for Kubernetes](../qa/cluster-autoscaler.md).

## Горизонтальное автомасштабирование подов {#hpa}

При использовании горизонтального масштабирования подов Kubernetes изменяет их количество в зависимости от степени нагрузки на vCPU.

При [создании Horizontal Pod Autoscaler](../operations/autoscale.md#hpa) укажите в параметрах:
* Желаемую среднюю нагрузку на vCPU для каждого пода в процентах.
* Минимальное и максимальное количество реплик подов.

Горизонтальное автомасштабирование подов доступно для контроллеров:
* [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/).
* [StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/).
* [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/).

Подробнее о Horizontal Pod Autoscaler см. в [документации Kubernetes](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/).

## Вертикальное автомасштабирование подов {#vpa}

Kubernetes ограничивает выделение ресурсов для каждого приложения с помощью параметров `limits`. Для пода, превысившего лимит vCPU, включается режим пропуска тактов процессора. Под, превысивший лимит RAM, будет остановлен.

Vertical Pod Autoscaler при необходимости выделяет дополнительные ресурсы vCPU и RAM для подов.

При [создании Vertical Pod Autoscaler](../operations/autoscale.md#vpa) укажите в спецификации режим автоматического масштабирования:
* `updateMode: "Off"`, чтобы Vertical Pod Autoscaler [предоставлял рекомендации](https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler#quick-start) по управлению ресурсами подов, но не изменял их.
* `updateMode: "Initial"`, чтобы Vertical Pod Autoscaler применял рекомендации только при создании подов.
* `updateMode: "Recreate"`, чтобы Vertical Pod Autoscaler пересоздавал поды с обновленными значениями ресурсов при значительном расхождении между текущими запросами и рекомендациями.
* `updateMode: "InPlaceOrRecreate"`, чтобы Vertical Pod Autoscaler сперва пытался обновить запросы и лимиты ресурсов без перезапуска пода. Если такое обновление недоступно, под будет пересоздан аналогично режиму `Recreate`. Подробнее см. на странице [Resize CPU and Memory Resources assigned to Containers](https://kubernetes.io/docs/tasks/configure-pod-container/resize-container-resources/).

Подробнее о Vertical Pod Autoscaler см. в [документации Kubernetes](https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler).

## Примеры использования {#examples}

* [Горизонтальное масштабирование приложения в кластере](../tutorials/autoscaling.md)
* [Вертикальное масштабирование приложения в кластере](../tutorials/vpa-autoscaling.md)
* [Развертывание и нагрузочное тестирование gRPC-сервиса с масштабированием](../tutorials/load-testing-grpc-autoscaling.md)