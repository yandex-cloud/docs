# Expanding a StatefulSet controller volume

To increase the size of a [volume](../../concepts/volume.md) for the StatefulSet controller:
1. [{#T}](#create-sts).
1. [{#T}](#upgrade-sts).
1. [{#T}](#create-upgraded-sts).

{% note warning %}

While the instruction is running, the number of the controller's [pods](../../concepts/index.md#pod) will drop to zero, which will make the service unavailable.

{% endnote %}

## Create a StatefulSet controller {#create-sts}

1. Create a file called `sts.yaml` with a controller configuration:

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

   The command will create a StatefulSet controller named `ubuntu-test` comprising three pods. The size of PersistentVolumeClaim for each pod is 1 GB.

1. Make sure that the controller's pods have transitioned to the `Running` state and PersistentVolumeClaim to `Bound`:

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
   persistentvolumeclaim/pvc-dynamic-ubuntu-test-0  Bound   pvc-603ac129-fe56-400a-8481-feaad7fac9c0  1Gi       RWO           yc-network-hdd  91s
   persistentvolumeclaim/pvc-dynamic-ubuntu-test-1  Bound   pvc-a6fb0761-0771-483c-abfb-d4a89ec4719f  1Gi       RWO           yc-network-hdd  81s
   persistentvolumeclaim/pvc-dynamic-ubuntu-test-2  Bound   pvc-f479c8aa-426a-4e43-9749-5e0fcb5dc140  1Gi       RWO           yc-network-hdd  73s
   ```



1. Make sure that for objects with the `k8s-csi` prefix, the disks have transitioned to `READY` status:

   ```bash
   yc compute disk list
   ```

   Command result:

   ```text
   +----------------------+--------------------------------------------------+-------------+-------------------+--------+----------------------+-------------+
   |          ID          |                       NAME                       |    SIZE     |       ZONE        | STATUS |     INSTANCE IDS     | DESCRIPTION |
   +----------------------+--------------------------------------------------+-------------+-------------------+--------+----------------------+-------------+
   | ef3b5ln111s36h0ugf7c | k8s-csi-15319ac44278c2ff23f0df04ebdbe5a8aa6f4a49 |  1073741824 | {{ region-id }}-a | READY  | ef3nrev9j72tpte4vtac |             |
   | ef3e617rmqrijnesob0n | k8s-csi-336f16a11f750525075d7c155ad26ae3513dca01 |  1073741824 | {{ region-id }}-a | READY  | ef3nrev9j72tpte4vtac |             |
   | ef3rfleqkit01i3d2j41 | k8s-csi-ba784ddd49c7aabc63bcbfc45be3cc2e279fd3b6 |  1073741824 | {{ region-id }}-a | READY  | ef3nrev9j72tpte4vtac |             |
   +----------------------+--------------------------------------------------+-------------+-------------------+--------+----------------------+-------------+
   ```

## Make changes to controller settings {#upgrade-sts}

1. Save the current `ubuntu-test` controller configuration to a file called `ubuntu-test-sts.yaml`:

   ```bash
   kubectl get sts ubuntu-test --output yaml > ubuntu-test-sts.yaml
   ```

1. In `ubuntu-test-sts.yaml`, increase the value for the `volumeClaimTemplates.spec.resources.requests.storage` parameter from `1Gi` to `2Gi`:

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

   There is no need to increase the corresponding value of `1Gi` for the `kubectl.kubernetes.io/last-applied-configuration` parameter.

   {% endnote %}

1. Reduce the number of `ubuntu-test` controller pods to zero:

   ```bash
   kubectl scale statefulset ubuntu-test --replicas=0
   ```

1. Wait for the controller to complete scaling. To monitor the status of pod deletion, use the command below:

   ```bash
   kubectl get pods
   ```

   The controller has finished scaling when there are no pods with the `pod/ubuntu-test-` prefix in the command result.

1. Make sure that for objects with the `k8s-csi` prefix, the disks have an empty `INSTANCE IDS`:

   ```bash
   yc compute disk list
   ```

   Result:

   ```text
    +----------------------+--------------------------------------------------+-------------+--------------------+--------+----------------------+-------------+
    |          ID          |                       NAME                       |    SIZE     |        ZONE        | STATUS |     INSTANCE IDS     | DESCRIPTION |
    +----------------------+--------------------------------------------------+-------------+--------------------+--------+----------------------+-------------+
    | ef3b5ln111s36h0ugf7c | k8s-csi-15319ac44278c2ff23f0df04ebdbe5a8aa6f4a49 |  1073741824 | {{ region-id }}-a  | READY  |                      |             |
    | ef3e617rmqrijnesob0n | k8s-csi-336f16a11f750525075d7c155ad26ae3513dca01 |  1073741824 | {{ region-id }}-a  | READY  |                      |             |
    | ef3rfleqkit01i3d2j41 | k8s-csi-ba784ddd49c7aabc63bcbfc45be3cc2e279fd3b6 |  1073741824 | {{ region-id }}-a  | READY  |                      |             |
    +----------------------+--------------------------------------------------+-------------+--------------------+--------+----------------------+-------------+
   ```

1. Delete the current `ubuntu-test` StatefulSet controller:

   ```bash
   kubectl delete statefulset ubuntu-test --cascade=orphan
   ```

1. Make sure that the StatefulSet controller is deleted:

   ```bash
   kubectl get sts
   ```

## Create a controller with new PersistentVolumeClaim settings {#create-upgraded-sts}

1. Update the settings for each PersistentVolumeClaim controller:

   ```bash
   kubectl patch pvc pvc-dynamic-ubuntu-test-0 --patch '{"spec": {"resources": {"requests": {"storage": "2Gi"}}}}' && \
   kubectl patch pvc pvc-dynamic-ubuntu-test-1 --patch '{"spec": {"resources": {"requests": {"storage": "2Gi"}}}}' && \
   kubectl patch pvc pvc-dynamic-ubuntu-test-2 --patch '{"spec": {"resources": {"requests": {"storage": "2Gi"}}}}'
   ```

1. Create a StatefulSet controller with more storage:

   ```bash
   kubectl apply -f ubuntu-test-sts.yaml
   ```

1. Make sure that a new StatefulSet controller comprising three pods has been created:

   ```bash
   kubectl get sts,pods
   ```

   Result:

   ```text
   NAME                           READY   AGE
   statefulset.apps/ubuntu-test   3/3     15s

   NAME                READY   STATUS    RESTARTS   AGE
   pod/ubuntu-test-0   1/1     Running   0          16s
   pod/ubuntu-test-1   1/1     Running   0          13s
   pod/ubuntu-test-2   1/1     Running   0          10s
   ```

1. Make sure that PersistentVolume for the `ubuntu-test` controller has increased to 2 GB for each volume:

   ```bash
   kubectl get pv
   ```

   Result:

   
   ```text
   NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                               STORAGECLASS     REASON   AGE
   pvc-603ac129-fe56-400a-8481-feaad7fac9c0   2Gi        RWO            Delete           Bound    default/pvc-dynamic-ubuntu-test-0   yc-network-hdd            11m
   pvc-a6fb0761-0771-483c-abfb-d4a89ec4719f   2Gi        RWO            Delete           Bound    default/pvc-dynamic-ubuntu-test-1   yc-network-hdd            11m
   pvc-f479c8aa-426a-4e43-9749-5e0fcb5dc140   2Gi        RWO            Delete           Bound    default/pvc-dynamic-ubuntu-test-2   yc-network-hdd            11m
   ```


