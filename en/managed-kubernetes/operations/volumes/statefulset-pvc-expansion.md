---
title: How to increase volume size for the StatefulSet controller in {{ managed-k8s-full-name }}
description: Follow this guide to increase volume size for the StatefulSet controller.
---

# Increasing volume size for the StatefulSet controller


To increase [volume](../../concepts/volume.md) size for the StatefulSet controller without shutting down the service:
1. [Create a StatefulSet controller](#create-sts).
1. [Update controller settings](#upgrade-sts).

{% include [Install kubectl to get started](../../../_includes/managed-kubernetes/kubectl-before-you-begin.md) %}

## Create a StatefulSet controller {#create-sts}

1. Create a file named `sts.yaml` with the controller configuration:

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

1. Create a controller:

   ```bash
   kubectl apply -f sts.yaml
   ```

   The command will create a StatefulSet controller named `ubuntu-test` comprising three [pods](../../concepts/index.md#pod). The size of PersistentVolumeClaim per pod is 1 GB.
1. Make sure the controller pods changed their status to `Running` and PersistentVolumeClaim, to `Bound`:

   ```bash
   kubectl get pods,pvc
   ```

   Result:

   
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



1. Make sure the [disks](../../../compute/concepts/disk.md) for objects with the `k8s-csi` prefix changed their status to `READY`:

   ```bash
   yc compute disk list
   ```

   Result:

   
   ```text
   +----------------------+--------------------------------------------------+------------+-------------------+--------+----------------------+-------------+
   |          ID          |                       NAME                       |    SIZE    |        ZONE       | STATUS |     INSTANCE IDS     | DESCRIPTION |
   +----------------------+--------------------------------------------------+------------+-------------------+--------+----------------------+-------------+
   | ef3b5ln111s3******** | k8s-csi-15319ac44278c2ff23f0df04ebdbe5a8******** | 1073741824 | {{ region-id }}-a     | READY  | ef3nrev9j72t******** |             |
   | ef3e617rmqri******** | k8s-csi-336f16a11f750525075d7c155ad26ae3******** | 1073741824 | {{ region-id }}-a     | READY  | ef3nrev9j72t******** |             |
   | ef3rfleqkit0******** | k8s-csi-ba784ddd49c7aabc63bcbfc45be3cc2e******** | 1073741824 | {{ region-id }}-a     | READY  | ef3nrev9j72t******** |             |
   +----------------------+--------------------------------------------------+------------+-------------------+--------+----------------------+-------------+
   ```


## Update controller settings {#upgrade-sts}

1. Save the current configuration of the `ubuntu-test` controller to a file named `ubuntu-test-sts.yaml`:

   ```bash
   kubectl get sts ubuntu-test --output yaml > ubuntu-test-sts.yaml
   ```

1. In `ubuntu-test-sts.yaml`, increase the `volumeClaimTemplates.spec.resources.requests.storage` value from `1Gi` to `2Gi`:

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

   You do not have to change the same `1Gi` value for the `kubectl.kubernetes.io/last-applied-configuration` parameter.

   {% endnote %}

1. Delete the current StatefulSet controller named `ubuntu-test`:

   ```bash
   kubectl delete statefulset ubuntu-test --cascade=orphan
   ```

1. Make sure the StatefulSet controller has been deleted:

   ```bash
   kubectl get sts
   ```

1. Delete the first pod named `ubuntu-test-0`:

   ```bash
   kubectl delete pod ubuntu-test-0
   ```

1. Update PersistentVolumeClaim of the `ubuntu-test-0` pod you deleted by increasing the storage size to 2 GB:

   ```bash
   kubectl patch pvc pvc-dynamic-ubuntu-test-0 --patch '{"spec": {"resources": {"requests": {"storage": "2Gi"}}}}'
   ```

1. Apply the changes to the `ubuntu-test` controller:

   ```bash
   kubectl apply -f ubuntu-test-sts.yaml
   ```

1. Reduce the number of the `ubuntu-test` controller pods to 1:

   ```bash
   kubectl scale statefulset ubuntu-test --replicas=1
   ```

1. Increase the storage size for the `ubuntu-test-1` and `ubuntu-test-2` pods to 2 GB:

   ```bash
   kubectl patch pvc pvc-dynamic-ubuntu-test-1 --patch '{"spec": {"resources": {"requests": {"storage": "2Gi"}}}}' && \
   kubectl patch pvc pvc-dynamic-ubuntu-test-2 --patch '{"spec": {"resources": {"requests": {"storage": "2Gi"}}}}'
   ```

1. Set the number of the `ubuntu-test` controller pods back to 3:

   ```bash
   kubectl scale statefulset ubuntu-test --replicas=3
   ```

1. Make sure PersistentVolume for the `ubuntu-test` controller has been increased to 2 GB for each volume:

   ```bash
   kubectl get pv
   ```

   Result:

   
   ```text
   NAME                                      CAPACITY  ACCESS MODES  RECLAIM POLICY  STATUS  CLAIM                              STORAGECLASS    REASON  AGE
   pvc-603ac129-fe56-400a-8481-feaa********  2Gi       RWO           Delete          Bound   default/pvc-dynamic-ubuntu-test-0  yc-network-hdd          11m
   pvc-a6fb0761-0771-483c-abfb-d4a8********  2Gi       RWO           Delete          Bound   default/pvc-dynamic-ubuntu-test-1  yc-network-hdd          11m
   pvc-f479c8aa-426a-4e43-9749-5e0f********  2Gi       RWO           Delete          Bound   default/pvc-dynamic-ubuntu-test-2  yc-network-hdd          11m
   ```
