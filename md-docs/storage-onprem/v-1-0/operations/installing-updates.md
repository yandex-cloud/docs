# Установка обновлений

Поставка обновления включает:

* Архив `yc-storage-<версия>.tar.gz` — ПО Object Storage, где `<версия>` — поставляемая версия.
* Два значения: новые версии `yc-storage-operator` и версия On-premises Yandex Object Storage.

Чтобы обновить продукт:

1. [Загрузите образы из архива в локальный OCI Registry](#upload-images).
1. [Обновите yc-storage-operator](#update-operator).
1. [Обновите Object Storage](#update-objstorage).

{% note info %}

Вы можете обновлять продукт в процессе использования.

Загрузка образов и обновление `yc-storage-operator` никак не влияют на функциональность и производительность кластера.

При обновлении Object Storage возможна временная деградация производительности или недоступность S3 API строго по одному из адресов.

Доступность S3 API в целом не нарушается.

{% endnote %}


## Загрузите образы из архива в локальный OCI Registry {#upload-images}

1. Загрузите архив `yc-storage-<версия>.tar.gz` на master-хост OCI Registry согласно параметрам, указанным при установке.
1. На том же хосте выполните команду, указав путь к архиву `yc-storage-<версия>.tar.gz`:

    ```bash
    /opt/kubernetes/extract-images.sh <путь_к_архиву>
    ```


## Обновите yc-storage-operator {#update-operator}

Выполняйте этот шаг на любом master-хосте Kubernetes. В большинстве случаев хост из первого шага также является master-хостом Kubernetes.

1. Обновите целевую версию `yc-storage-operator` в соответствующем ArgoCD Application, выполнив команду:

    ```bash
    kubectl patch application yc-storage-operator -n argocd \
      --type merge -p '{"spec": {"source": {"targetRevision": "<версия>"}}}'
    ```

    Где `<версия>` — новая версия `yc-storage-operator`.

1. Обновите оператора, выполнив команды:

    ```bash
    RANDOM_NAME="yc-storage-operator-$(cat /dev/urandom | tr -dc 'a-z' | head -c 8)"

    kubectl apply -f - <<EOF
    apiVersion: storage.yandex.cloud/v1alpha1
    kind: UpdateRequest
    metadata:
      name: ${RANDOM_NAME}
    spec:  
      adHoc:
        steps:
          - apps:
              - app: yc-storage-operator
    EOF

    kubectl wait updaterequest ${RANDOM_NAME} --for=condition=Done --timeout=300s
    ```


## Обновите Object Storage {#update-objstorage}

Выполняйте этот шаг на любом master-хосте Kubernetes. В большинстве случаев хост из первого шага также является master-хостом Kubernetes.

1. Обновите версию у `Instance`, выполнив команду:

    ```bash
    kubectl patch instance main \
      --type merge -p '{"spec": {"version": "<версия>"}}'
    ```

    Где `<версия>` — новая версия `yc-storage-operator`.

1. Выполните команду:

    ```bash
    kubectl wait instance main \
      --for=condition=Ready \
      --timeout=600s
    ```

    Дождитесь завершения обновления.