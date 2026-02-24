### Настроено резервное копирование Kubernetes {#backup}

#|
|| **kind** | **severity** | **ID** ||
|| manual | high | k8s.backup ||
|#

#### Описание

{% note warning "**Ручная проверка**" %}

Данное правило требует ручной проверки настройки резервного копирования Kubernetes.

{% endnote %}

Для обеспечения непрерывности работы и защиты данных рекомендуется использовать резервное копирование в Managed Service for Kubernetes, поскольку оно позволяет быстро восстановить работу сервиса без потери данных и времени на восстановление после сбоя или аварии. Данные в [кластерах Kubernetes](https://yandex.cloud/ru/docs/managed-kubernetes/concepts/#kubernetes-cluster) надежно хранятся и реплицируются в инфраструктуре Yandex Cloud. Однако в любой момент вы можете сделать резервные копии данных из [групп узлов](https://yandex.cloud/ru/docs/managed-kubernetes/concepts/#node-group) кластеров Kubernetes и хранить их в [Yandex Object Storage](https://yandex.cloud/ru/docs/storage/) или другом хранилище.

#### Инструкции и решения по выполнению

* Вы можете создавать резервные копии данных из групп узлов кластера Kubernetes с помощью инструмента [Velero](https://velero.io/). Этот инструмент поддерживает работу с [дисками](https://yandex.cloud/ru/docs/compute/concepts/disk) Yandex Cloud с помощью CSI-драйвера Kubernetes, и позволяет создавать моментальные [снимки дисков томов](https://yandex.cloud/ru/docs/compute/concepts/snapshot).
* При работе с Velero, установленным вручную, вы можете использовать [nfs](https://kubernetes.io/docs/concepts/storage/volumes/#nfs), [emptyDir](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir), [локальный](https://kubernetes.io/docs/concepts/storage/volumes/#local) или любой другой тип тома, в котором нет встроенной поддержки моментальных снимков. Чтобы использовать такой тип тома, задействуйте плагин [restic](https://velero.io/docs/v1.8/restic/) при установке Velero. Velero, установленный из [Cloud Marketplace](https://yandex.cloud/ru/marketplace/products/yc/velero-yc-csi), плагин restic не включает.
* Инструкция по резервному копированию кластера Kubernetes в Object Storage: https://yandex.cloud/ru/docs/managed-kubernetes/tutorials/kubernetes-backup#backup