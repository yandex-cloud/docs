---
title: Увеличение размера тома для подов
description: Следуя данной инструкции, вы сможете увеличить размер тома для подов.
---

# Увеличение размера тома для подов


Чтобы увеличить размер [тома](../../concepts/volume.md):
1. [Включите механизм увеличения размера тома](#enabling-expansion).
1. [Создайте объект PersistentVolumeClaim](#create-pvc).
1. [Создайте под с динамически подготовленным томом](#create-pod).
1. [Запросите увеличение размера тома](#volume-expansion).
1. [Проверьте под с томом](#checking-pod).

{% include [Перед началом установите kubectl](../../../_includes/managed-kubernetes/kubectl-before-you-begin.md) %}

## Включите механизм увеличения размера тома {#enabling-expansion}

Чтобы включить механизм увеличения размера тома, в описании [класса хранилища](manage-storage-class.md) (`StorageClass`) должен быть указан параметр `allowVolumeExpansion: true`. В хранилищах сервиса {{ managed-k8s-name }} этот механизм включен по умолчанию:

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

## Создайте объект PersistentVolumeClaim {#create-pvc}

1. Сохраните следующую спецификацию для [создания объекта PersistentVolumeClaim](dynamic-create-pv.md) в YAML-файл с названием `pvc-expansion.yaml`.

   Подробнее о спецификации для создания объекта `PersistentVolumeClaim` читайте в [документации {{ k8s }}](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/).

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

1. Создайте объект `PersistentVolumeClaim`:

   ```bash
   kubectl create -f pvc-expansion.yaml
   ```

   Результат:

   ```bash
   persistentvolumeclaim/pvc-expansion created
   ```

## Создайте под с динамически подготовленным томом {#create-pod}

1. Сохраните следующую спецификацию для создания [пода](../../concepts/index.md#pod) в YAML-файл с названием `pod.yaml`.

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

## Запросите увеличение размера тома {#volume-expansion}

1. Внесите изменения в поле `spec.resources.requests.storage` объекта `PersistentVolumeClaim`.:

   ```bash
   kubectl patch pvc pvc-expansion -p '{"spec":{"resources":{"requests":{"storage":"2Gi"}}}}'
   ```

1. Подождите несколько минут пока увеличится размер тома. Проверьте изменения:

   ```bash
   kubectl get pvc pvc-expansion -o yaml
   ```

   В поле `status.capacity.storage` появился запрошенный объем тома:

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

## Проверьте под с томом {#checking-pod}

Проверьте статус пода:

   ```bash
   kubectl get pod pod -o yaml
   ```

Под работает. В секции `status` указано, что перезапусков контейнеров не было.
