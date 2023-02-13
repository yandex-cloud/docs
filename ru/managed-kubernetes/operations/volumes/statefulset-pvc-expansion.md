# Увеличение размера тома для контроллера StatefulSet

Чтобы увеличить размер [тома](../../concepts/volume.md) для контроллера StatefulSet:
1. [{#T}](#create-sts).
1. [{#T}](#upgrade-sts).
1. [{#T}](#create-upgraded-sts).

{% note warning %}

В процессе выполнения инструкции количество [подов](../../concepts/index.md#pod) контроллера будет уменьшено до нуля, что приведет к недоступности сервиса.

{% endnote %}

## Создайте контроллер StatefulSet {#create-sts}

1. Создайте файл `sts.yaml` с конфигурацией контроллера:

   {% cut "sts.yaml" %}

   {% if product == "yandex-cloud" %}

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

   {% endif %}

   {% if product == "cloud-il" %}

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
     volumeClaimTemplates:
     - metadata:
         name: pvc-dynamic
       spec:
         accessModes: [ "ReadWriteOnce" ]
         storageClassName: "yc-network-ssd"
         resources:
           requests:
             storage: 1Gi
   ```

   {% endif %}

   {% endcut %}

1. Создайте контроллер:

   ```bash
   kubectl apply -f sts.yaml
   ```

   В результате выполнения команды будет создан контроллер StatefulSet с именем `ubuntu-test`, состоящий из трех подов. Размер PersistentVolumeClaim для каждого пода — 1 Гбайт.

1. Убедитесь, что поды контроллера перешли в статус `Running`, а PersistentVolumeClaim — в статус `Bound`:

   ```bash
   kubectl get pods,pvc
   ```

   Результат:

   {% if product == "yandex-cloud" %}

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

   {% endif %}

   {% if product == "cloud-il" %}

   ```text
   NAME               READY  STATUS   RESTARTS  AGE
   pod/ubuntu-test-0  1/1    Running  0         90s
   pod/ubuntu-test-1  1/1    Running  0         80s
   pod/ubuntu-test-2  1/1    Running  0         72s
   NAME                                             STATUS  VOLUME                                    CAPACITY  ACCESS MODES  STORAGECLASS    AGE
   persistentvolumeclaim/pvc-dynamic-ubuntu-test-0  Bound   pvc-603ac129-fe56-400a-8481-feaad7fac9c0  1Gi       RWO           yc-network-ssd  91s
   persistentvolumeclaim/pvc-dynamic-ubuntu-test-1  Bound   pvc-a6fb0761-0771-483c-abfb-d4a89ec4719f  1Gi       RWO           yc-network-ssd  81s
   persistentvolumeclaim/pvc-dynamic-ubuntu-test-2  Bound   pvc-f479c8aa-426a-4e43-9749-5e0fcb5dc140  1Gi       RWO           yc-network-ssd  73s
   ```

   {% endif %}

1. Убедитесь, что диски для объектов с префиксами `k8s-csi` перешли в статус `READY`:

   ```bash
   yc compute disk list
   ```

   Результат:

   ```text
   +----------------------+--------------------------------------------------+------------+-------------------+--------+----------------------+-------------+
   |          ID          |                       NAME                       |    SIZE    |        ZONE       | STATUS |     INSTANCE IDS     | DESCRIPTION |
   +----------------------+--------------------------------------------------+------------+-------------------+--------+----------------------+-------------+
   | ef3b5ln111s36h0ugf7c | k8s-csi-15319ac44278c2ff23f0df04ebdbe5a8aa6f4a49 | 1073741824 | {{ region-id }}-a | READY  | ef3nrev9j72tpte4vtac |             |
   | ef3e617rmqrijnesob0n | k8s-csi-336f16a11f750525075d7c155ad26ae3513dca01 | 1073741824 | {{ region-id }}-a | READY  | ef3nrev9j72tpte4vtac |             |
   | ef3rfleqkit01i3d2j41 | k8s-csi-ba784ddd49c7aabc63bcbfc45be3cc2e279fd3b6 | 1073741824 | {{ region-id }}-a | READY  | ef3nrev9j72tpte4vtac |             |
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

1. Уменьшите количество подов контроллера `ubuntu-test` до нуля:

   ```bash
   kubectl scale statefulset ubuntu-test --replicas=0
   ```

1. Дождитесь завершения масштабирования контроллера. Чтобы наблюдать за состоянием удаления подов, используйте команду:

   ```bash
   kubectl get pods
   ```

   Масштабирование контроллера завершено, когда результат выполнения команды не показывает подов с префиксом `pod/ubuntu-test-`.

1. Убедитесь, что диски для объектов с префиксами `k8s-csi` имеют пустой `INSTANCE IDS`:

   ```bash
   yc compute disk list
   ```

   Результат:

   ```text
    +----------------------+--------------------------------------------------+------------+-------------------+--------+--------------+-------------+
    |          ID          |                       NAME                       |    SIZE    |        ZONE       | STATUS | INSTANCE IDS | DESCRIPTION |
    +----------------------+--------------------------------------------------+------------+-------------------+--------+--------------+-------------+
    | ef3b5ln111s36h0ugf7c | k8s-csi-15319ac44278c2ff23f0df04ebdbe5a8aa6f4a49 | 1073741824 | {{ region-id }}-a | READY  |              |             |
    | ef3e617rmqrijnesob0n | k8s-csi-336f16a11f750525075d7c155ad26ae3513dca01 | 1073741824 | {{ region-id }}-a | READY  |              |             |
    | ef3rfleqkit01i3d2j41 | k8s-csi-ba784ddd49c7aabc63bcbfc45be3cc2e279fd3b6 | 1073741824 | {{ region-id }}-a | READY  |              |             |
    +----------------------+--------------------------------------------------+------------+-------------------+--------+--------------+-------------+
    ```

1. Удалите текущий контроллер StatefulSet `ubuntu-test`:

   ```bash
   kubectl delete statefulset ubuntu-test --cascade=orphan
   ```

1. Убедитесь, что контроллер StatefulSet удален:

   ```bash
   kubectl get sts
   ```

## Создайте контроллер с новыми настройками PersistentVolumeClaim {#create-upgraded-sts}

1. Обновите настройки для каждого PersistentVolumeClaim контроллера:

   ```bash
   kubectl patch pvc pvc-dynamic-ubuntu-test-0 --patch '{"spec": {"resources": {"requests": {"storage": "2Gi"}}}}' && \
   kubectl patch pvc pvc-dynamic-ubuntu-test-1 --patch '{"spec": {"resources": {"requests": {"storage": "2Gi"}}}}' && \
   kubectl patch pvc pvc-dynamic-ubuntu-test-2 --patch '{"spec": {"resources": {"requests": {"storage": "2Gi"}}}}'
   ```

1. Создайте контроллер StatefulSet с увеличенным размером хранилища:

   ```bash
   kubectl apply -f ubuntu-test-sts.yaml
   ```

1. Убедитесь, что создан новый контроллер StatefulSet, содержащий три пода:

   ```bash
   kubectl get sts,pods
   ```

   Результат:

   ```text
   NAME                          READY  AGE
   statefulset.apps/ubuntu-test  3/3    15s

   NAME               READY  STATUS   RESTARTS  AGE
   pod/ubuntu-test-0  1/1    Running  0         16s
   pod/ubuntu-test-1  1/1    Running  0         13s
   pod/ubuntu-test-2  1/1    Running  0         10s
   ```

1. Убедитесь, что PersistentVolume для контроллера `ubuntu-test` увеличен до 2 Гбайт для каждого тома:

   ```bash
   kubectl get pv
   ```

   Результат:

   {% if product == "yandex-cloud" %}

   ```text
   NAME                                      CAPACITY  ACCESS MODES  RECLAIM POLICY  STATUS  CLAIM                              STORAGECLASS    REASON  AGE
   pvc-603ac129-fe56-400a-8481-feaad7fac9c0  2Gi       RWO           Delete          Bound   default/pvc-dynamic-ubuntu-test-0  yc-network-hdd          11m
   pvc-a6fb0761-0771-483c-abfb-d4a89ec4719f  2Gi       RWO           Delete          Bound   default/pvc-dynamic-ubuntu-test-1  yc-network-hdd          11m
   pvc-f479c8aa-426a-4e43-9749-5e0fcb5dc140  2Gi       RWO           Delete          Bound   default/pvc-dynamic-ubuntu-test-2  yc-network-hdd          11m
   ```

   {% endif %}

   {% if product == "cloud-il" %}

   ```text
   NAME                                      CAPACITY  ACCESS MODES  RECLAIM POLICY  STATUS  CLAIM                              STORAGECLASS    REASON  AGE
   pvc-603ac129-fe56-400a-8481-feaad7fac9c0  2Gi       RWO           Delete          Bound   default/pvc-dynamic-ubuntu-test-0  yc-network-hdd          11m
   pvc-a6fb0761-0771-483c-abfb-d4a89ec4719f  2Gi       RWO           Delete          Bound   default/pvc-dynamic-ubuntu-test-1  yc-network-hdd          11m
   pvc-f479c8aa-426a-4e43-9749-5e0fcb5dc140  2Gi       RWO           Delete          Bound   default/pvc-dynamic-ubuntu-test-2  yc-network-hdd          11m
   ```

   {% endif %}