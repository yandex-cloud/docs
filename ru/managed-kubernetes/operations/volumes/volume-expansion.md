# Увеличение размера тома для подов

Чтобы увеличить размер [тома](../../concepts/volume.md) для [подов](../../concepts/index.md#pod), выполните следующие действия.

## Включите механизм увеличения размера тома {#enabling-expansion}

Чтобы включить механизм увеличения размера тома, в описании [класса хранилища](manage-storage-class.md) (`StorageClass`) должен быть указан параметр `allowVolumeExpansion: true`. В хранилищах сервиса {{ managed-k8s-name }} этот механизм включен по умолчанию:

{% if product == "yandex-cloud" %}

```yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: yc-network-hdd
provisioner: disk-csi-driver.mks.ycloud.io
volumeBindingMode: WaitForFirstConsumer
parameters:
  type: network-hdd
  csi.storage.k8s.io/fstype: ext4
allowVolumeExpansion: true
reclaimPolicy: Delete
```

{% endif %}

{% if product == "cloud-il" %}

```yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: yc-network-ssd
provisioner: disk-csi-driver.mks.ycloud.io
volumeBindingMode: WaitForFirstConsumer
parameters:
  type: network-hdd
  csi.storage.k8s.io/fstype: ext4
allowVolumeExpansion: true
reclaimPolicy: Delete
```

{% endif %}

## Создайте объект PersistentVolumeClaim {#create-pvc}

1. Сохраните следующую спецификацию для [создания объекта PersistentVolumeClaim](dynamic-create-pv.md) в YAML-файл с названием `pvc-expansion.yaml`.

   Подробнее о спецификации для создания объекта `PersistentVolumeClaim` читайте в [документации {{ k8s }}](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/).

   {% if product == "yandex-cloud" %}

   ```yaml
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: pvc-expansion
   spec:
     accessModes:
       - ReadWriteOnce
     storageClassName: yc-network-hdd
     resources:
       requests:
         storage: 1Gi
   ```

   {% endif %}

   {% if product == "cloud-il" %}
   
   ```yaml
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: pvc-expansion
   spec:
     accessModes:
       - ReadWriteOnce
     storageClassName: yc-network-ssd
     resources:
       requests:
         storage: 1Gi
   ```

   {% endif %}

1. Создайте объект `PersistentVolumeClaim`:

   ```bash
   kubectl create -f pvc-expansion.yaml
   ```

   Результат:

   ```bash
   persistentvolumeclaim/pvc-expansion created
   ```

## Создайте под с динамически подготовленным томом {#create-pod}

1. Сохраните следующую спецификацию для создания пода в YAML-файл с названием `pod.yaml`.

   Подробнее о спецификации для создания пода читайте в [документации {{ k8s }}](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.18/#pod-v1-core).

   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: pod
   spec:
     containers:
     - name: app
       image: ubuntu
       command: ["/bin/sh"]
       args: ["-c", "while true; do echo $(date -u) >> /data/out.txt; sleep 5; done"]
       volumeMounts:
       - name: persistent-storage
         mountPath: /data
     volumes:
     - name: persistent-storage
       persistentVolumeClaim:
         claimName: pvc-expansion
   ```

1. Создайте под:

   ```bash
   kubectl create -f pod.yaml
   ```

   Результат:

   ```bash
   pod/pod created
   ```

## Удалите под с томом {#restart-pod}

Чтобы запросить увеличение размера тома, необходимо удалить под.

1. Удалите под:

   ```bash
   kubectl delete pod pod
   ```

   Результат:

   ```bash
   pod "pod" deleted
   ```

## Запросите увеличение размера тома {#volume-expansion}

Внесите изменения в поле `spec.resources.requests.storage` объекта `PersistentVolumeClaim`.

1. Откройте YAML-файл с названием `pvc-expansion.yaml`:

   ```bash
   kubectl edit pvc pvc-expansion
   ```

   В текстовом редакторе измените значение размера диска и сохраните его:

   ```
   # Please edit the object below. Lines beginning with a '#' will be ignored,
   # and an empty file will abort the edit. If an error occurs while saving this file will be
   # reopened with the relevant failures.
   #
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
   ...
   spec:
     accessModes:
     - ReadWriteOnce
     resources:
       requests:
        storage: 1Gi # Измените на 2Gi.
   ...
   status:
     accessModes:
     - ReadWriteOnce
     capacity:
       storage: 1Gi
   phase: Bound
   ```

1. Дождитесь увеличения размера тома. Проверьте изменения:

   ```bash
   kubectl get pvc pvc-expansion -o yaml
   ```

   В поле `spec.resources.requests.storage` появился запрошенный объем тома:

   ```yaml
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
   ...
   spec:
     accessModes:
     - ReadWriteOnce
     resources:
       requests:
         storage: 2Gi
   ...
   status:
     accessModes:
     - ReadWriteOnce
     capacity:
       storage: 1Gi
   ...
   ```

## Создайте под с томом {#restart-pod}

1. Чтобы размер тома увеличился, необходимо создать под:

   ```bash
   kubectl create -f pod.yaml
   ```

   Результат:

   ```bash
   pod/pod created
   ```

1. Проверьте изменения:

   ```bash
   kubectl get pvc pvc-expansion -o yaml
   ```

   Размер тома увеличен. В поле `status.capacity.storage` появился увеличенный объем:

   ```yaml
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
   ...
   spec:
     accessModes:
     - ReadWriteOnce
     resources:
       requests:
         storage: 2Gi
   ...
   status:
     accessModes:
     - ReadWriteOnce
     capacity:
       storage: 2Gi
   ...
   ```