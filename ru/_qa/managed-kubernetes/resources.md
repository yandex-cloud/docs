#### Какие ресурсы требуются для обслуживания кластера {{ k8s }}, в который входит группа, например, из трех узлов? {#required-resources}

Для каждого [узла](../../managed-kubernetes/concepts/index.md#node-group) необходимы ресурсы для запуска компонентов, которые отвечают за функционирование узла как части [кластера {{ k8s }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster). Подробнее читайте в разделе [{#T}](../../managed-kubernetes/concepts/node-group/allocatable-resources.md).

#### Можно ли изменять ресурсы для каждого узла в кластере {{ k8s }}? {#change-resources}

Вы можете изменять ресурсы только для группы узлов. В одном кластере {{ k8s }} можно создавать группы с разными конфигурациями и размещать их в разных [зонах доступности](../../overview/concepts/geo-scope.md). Подробнее читайте в разделе [{#T}](../../managed-kubernetes/operations/node-group/node-group-update.md).

#### Кто будет следить за масштабированием кластера {{ k8s }}? {#scaling}

В {{ managed-k8s-name }} можно включить [автоматическое масштабирование кластера](../../managed-kubernetes/concepts/autoscale.md#ca).

#### Нужен ли узлам кластера {{ k8s }} доступ в интернет? {#internet-access}

{% include [nodes-internet-access](../../_includes/managed-kubernetes/nodes-internet-access.md) %}

{% include [nodes-internet-access-additional](../../_includes/managed-kubernetes/nodes-internet-access-additional.md) %}

#### Как автоматически удаляются старые образы на узлах? {#image-garbage-collection}

Неиспользуемые образы автоматически удаляет kubelet. Очистка запускается при достижении верхнего порога использования диска и продолжается до достижения нижнего порога. Пороги задаются параметрами `imageGCHighThresholdPercent` и `imageGCLowThresholdPercent` конфигурации kubelet.

Не запускайте параллельно сторонние средства очистки образов: они могут нарушить работу kubelet. Подробнее о [сборке мусора в {{ k8s }}](https://kubernetes.io/docs/concepts/architecture/garbage-collection/#containers-images).

Если места по-прежнему недостаточно, проверьте, чем занят диск: образами, журналами или данными приложений. Если проблема сохраняется, [создайте запрос в техническую поддержку]({{ link-console-support }}). Укажите идентификатор кластера, время возникновения ошибки и результаты диагностики.

#### Как узнать размер эфемерного хранилища узлов? {#ephemeral-storage}

Выполните команду:

```bash
kubectl get nodes -o custom-columns="NAME:.metadata.name,CAPACITY_EPHEM:.status.capacity.ephemeral-storage,ALLOCATABLE_EPHEM:.status.allocatable.ephemeral-storage"
```

`CAPACITY_EPHEM` — общий объем ресурса `ephemeral-storage` узла, а `ALLOCATABLE_EPHEM` — объем, доступный для выделения подам с учетом резервирования. Это не объем свободного места на диске в текущий момент.

Подробнее о [резервировании ресурсов узла](../../managed-kubernetes/concepts/node-group/allocatable-resources.md) и [локальном эфемерном хранилище](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#local-ephemeral-storage).
