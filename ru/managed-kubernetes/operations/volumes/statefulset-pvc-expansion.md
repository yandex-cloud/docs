---
title: "Как увеличить размер тома для контроллера StatefulSet в {{ managed-k8s-full-name }}"
description: "Следуя данной инструкции, вы сможете увеличить размер тома для контроллера StatefulSet." 
---

# Увеличение размера тома для контроллера StatefulSet

Чтобы увеличить размер [тома](../../concepts/volume.md) для контроллера StatefulSet без остановки сервиса:
1. [{#T}](#create-sts).
1. [{#T}](#upgrade-sts).

{% include [Перед началом установите kubectl](../../../_includes/managed-kubernetes/kubectl-before-you-begin.md) %}

## Создайте контроллер StatefulSet {#create-sts}

1. Создайте файл `sts.yaml` с конфигурацией контроллера:

   {% cut "sts.yaml" %}

   
   ```yaml
   apiVersion: apps/v1
   kind: StatefulSet
   metadata:
     name: ubuntu-test
   spec:
     selector:
       matchLabels:
         app: ubuntu
     serviceName: "ubuntu"
     replicas: 3
     template:
       metadata:
         labels:
           app: ubuntu
       spec:
         terminationGracePeriodSeconds: 10
         containers:
         - name: ubuntu
           image: ubuntu
           command: ["/bin/sh"]
           args: ["-c", "while true; do echo $(date -u) >> /data/out.txt; sleep 5; done"]
           volumeMounts:
           - mountPath: /data
             name: pvc-dynamic
     volumeClaimTemplates:
     - metadata:
         name: pvc-dynamic
       spec:
         accessModes: [ "ReadWriteOnce" ]
         storageClassName: "yc-network-hdd"
         resources:
           requests:
             storage: 1Gi
   ```



   {% endcut %}

1. Создайте контроллер:

   ```bash
   kubectl apply -f sts.yaml
   ```

   В результате выполнения команды будет создан контроллер StatefulSet с именем `ubuntu-test`, состоящий из трех [подов](../../concepts/index.md#pod). Размер PersistentVolumeClaim для каждого пода — 1 ГБ.
1. Убедитесь, что поды контроллера перешли в статус `Running`, а PersistentVolumeClaim — в статус `Bound`:

   ```bash
   kubectl get pods,pvc
   ```

   Результат:

   
   ```text
   NAME               READY  STATUS   RESTARTS  AGE
   pod/ubuntu-test-0  1/1    Running  0         90s
   pod/ubuntu-test-1  1/1    Running  0         80s
   pod/ubuntu-test-2  1/1    Running  0         72s

   NAME                                             STATUS  VOLUME                                    CAPACITY  ACCESS MODES  STORAGECLASS    AGE
   persistentvolumeclaim/pvc-dynamic-ubuntu-test-0  Bound   pvc-603ac129-fe56-400a-8481-feaa********  1Gi       RWO           yc-network-hdd  91s
   persistentvolumeclaim/pvc-dynamic-ubuntu-test-1  Bound   pvc-a6fb0761-0771-483c-abfb-d4a8********  1Gi       RWO           yc-network-hdd  81s
   persistentvolumeclaim/pvc-dynamic-ubuntu-test-2  Bound   pvc-f479c8aa-426a-4e43-9749-5e0f********  1Gi       RWO           yc-network-hdd  73s
   ```



1. Убедитесь, что [диски](../../../compute/concepts/disk.md) для объектов с префиксами `k8s-csi` перешли в статус `READY`:

   ```bash
   yc compute disk list
   ```

   Результат:

   
   ```text
   +----------------------+--------------------------------------------------+------------+-------------------+--------+----------------------+-------------+
   |          ID          |                       NAME                       |    SIZE    |        ZONE       | STATUS |     INSTANCE IDS     | DESCRIPTION |
   +----------------------+--------------------------------------------------+------------+-------------------+--------+----------------------+-------------+
   | ef3b5ln111s3******** | k8s-csi-15319ac44278c2ff23f0df04ebdbe5a8******** | 1073741824 | {{ region-id }}-a     | READY  | ef3nrev9j72t******** |             |
   | ef3e617rmqri******** | k8s-csi-336f16a11f750525075d7c155ad26ae3******** | 1073741824 | {{ region-id }}-a     | READY  | ef3nrev9j72t******** |             |
   | ef3rfleqkit0******** | k8s-csi-ba784ddd49c7aabc63bcbfc45be3cc2e******** | 1073741824 | {{ region-id }}-a     | READY  | ef3nrev9j72t******** |             |
   +----------------------+--------------------------------------------------+------------+-------------------+--------+----------------------+-------------+
   ```


## Внесите изменения в настройки контроллера {#upgrade-sts}

1. Сохраните текущую конфигурацию контроллера `ubuntu-test` в файл `ubuntu-test-sts.yaml`:

   ```bash
   kubectl get sts ubuntu-test --output yaml > ubuntu-test-sts.yaml
   ```

1. В файле `ubuntu-test-sts.yaml` увеличьте значение параметра `volumeClaimTemplates.spec.resources.requests.storage` с `1Gi` до `2Gi`:

   ```yaml
   ...
   spec:
     accessModes:
     - ReadWriteOnce
     resources:
       requests:
         storage: 2Gi
   ```

   {% note info %}

   Аналогичное значение `1Gi` настройки `kubectl.kubernetes.io/last-applied-configuration` изменять не нужно.

   {% endnote %}

1. Удалите текущий контроллер StatefulSet `ubuntu-test`:

   ```bash
   kubectl delete statefulset ubuntu-test --cascade=orphan
   ```

1. Убедитесь, что контроллер StatefulSet удален:

   ```bash
   kubectl get sts
   ```

1. Удалите первый под `ubuntu-test-0`:

   ```bash
   kubectl delete pod ubuntu-test-0
   ```

1. Внесите изменения в PersistentVolumeClaim удаленного пода `ubuntu-test-0` — увеличьте размер хранилища до 2 ГБ:

   ```bash
   kubectl patch pvc pvc-dynamic-ubuntu-test-0 --patch '{"spec": {"resources": {"requests": {"storage": "2Gi"}}}}'
   ```

1. Примените изменения в контроллере `ubuntu-test`:

   ```bash
   kubectl apply -f ubuntu-test-sts.yaml
   ```

1. Уменьшите количество подов контроллера `ubuntu-test` до 1:

   ```bash
   kubectl scale statefulset ubuntu-test --replicas=1
   ```

1. Увеличьте размер хранилища до 2 ГБ для подов `ubuntu-test-1` и `ubuntu-test-2`:

   ```bash
   kubectl patch pvc pvc-dynamic-ubuntu-test-1 --patch '{"spec": {"resources": {"requests": {"storage": "2Gi"}}}}' && \
   kubectl patch pvc pvc-dynamic-ubuntu-test-2 --patch '{"spec": {"resources": {"requests": {"storage": "2Gi"}}}}'
   ```

1. Верните прежнее количество подов контроллера `ubuntu-test` обратно к 3:

   ```bash
   kubectl scale statefulset ubuntu-test --replicas=3
   ```

1. Убедитесь, что PersistentVolume для контроллера `ubuntu-test` увеличен до 2 Гбайт для каждого тома:

   ```bash
   kubectl get pv
   ```

   Результат:

   
   ```text
   NAME                                      CAPACITY  ACCESS MODES  RECLAIM POLICY  STATUS  CLAIM                              STORAGECLASS    REASON  AGE
   pvc-603ac129-fe56-400a-8481-feaa********  2Gi       RWO           Delete          Bound   default/pvc-dynamic-ubuntu-test-0  yc-network-hdd          11m
   pvc-a6fb0761-0771-483c-abfb-d4a8********  2Gi       RWO           Delete          Bound   default/pvc-dynamic-ubuntu-test-1  yc-network-hdd          11m
   pvc-f479c8aa-426a-4e43-9749-5e0f********  2Gi       RWO           Delete          Bound   default/pvc-dynamic-ubuntu-test-2  yc-network-hdd          11m
   ```
