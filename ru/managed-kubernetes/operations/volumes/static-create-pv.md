# Статическая подготовка тома


Создайте [под](../../concepts/index.md#pod) со статически подготовленным [томом](../../concepts/volume.md):
1. [Создайте объект PersistentVolume](#create-pv).
1. [Создайте объект PersistentVolumeClaim](#create-claim).
1. [Создайте под](#create-pod).

{% note tip %}

Вы можете использовать [бакет](../../../storage/concepts/bucket.md) {{ objstorage-full-name }} в качестве хранилища для пода. Подробнее см. в разделе [{#T}](s3-csi-integration.md).

{% endnote %}

## Перед началом {#before-you-begin}

Узнайте уникальный идентификатор [диска](../../../compute/concepts/disk.md), который будет использован для создания объекта `PersistentVolume`, или создайте новый диск:
1. Если у вас еще нет диска, [создайте его](../../../compute/operations/disk-create/empty.md).
1. Посмотрите уникальный идентификатор диска:

   ```bash
   yc compute disk list
   ```

   Результат:

   ```
   +----------------------+------+--------------+-------------------+--------+----------------------+-------------+
   |          ID          | NAME |     SIZE     |       ZONE        | STATUS |     INSTANCE IDS     | DESCRIPTION |
   +----------------------+------+--------------+-------------------+--------+----------------------+-------------+
   | ef3ouo4sgl86740ridn6 | k8s  |   4294967296 | {{ region-id }}-a | READY  |                      |             |
   | ef3qh55ckuu7md2kqhbt |      | 103079215104 | {{ region-id }}-a | READY  | ef3sin41eksav1kn4gct |             |
   | epd9vda1h0knttpcuhfu |      |  10737418240 | {{ region-id }}-a | READY  | epdegdecs9o14r13gbad |             |
   +----------------------+------+--------------+-------------------+--------+----------------------+-------------+
   ```

## Создайте объект PersistentVolume {#create-pv}

1. Сохраните спецификацию для создания объекта `PersistentVolume` в YAML-файл с названием `test-pv.yaml`.

   Подробнее о спецификации читайте в [документации {{ k8s }}](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-v1/).

   При указании параметра `capacity: storage` убедитесь, что задан точный объем диска. {{ CSI }} не обеспечивает проверку объема диска для статически подготовленных томов.

   Для создания объекта `PersistentVolume` на основе существующего облачного диска в параметре `volumeHandle` укажите уникальный идентификатор необходимого диска.

   ```
   apiVersion: v1
   kind: PersistentVolume
   metadata:
     name: test-pv
   spec:
     capacity:
       storage: 4Gi
     accessModes:
       - ReadWriteOnce
     storageClassName: "" 
     csi:
       driver: disk-csi-driver.mks.ycloud.io
       fsType: ext4
       volumeHandle: ef3ouo4sgl86740ridn6
   ```

1. Выполните команду:

   ```bash
   kubectl create -f test-pv.yaml
   ```

   Результат:

   ```
   persistentvolume/test-pv created
   ```

1. Посмотрите информацию о созданном объекте `PersistentVolume`:

   ```bash
   kubectl describe persistentvolume test-pv
   ```

   Результаты выполнения команды:

   
   ```
   Name:            test-pv
   Labels:          <none>
   Annotations:     <none>
   Finalizers:      [kubernetes.io/pv-protection]
   StorageClass:    yc-network-hdd
   Status:          Available
   ...
   ```



## Создайте объект PersistentVolumeClaim {#create-claim}

1. Сохраните спецификацию для создания объекта `PersistentVolumeClaim` YAML-файл с названием `test-claim.yaml`.

   Подробнее о спецификации читайте в [документации {{ k8s }}](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/).

   ```
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: test-claim
   spec:
     accessModes:
       - ReadWriteOnce
     resources:
       requests:
         storage: 4Gi
     volumeName: test-pv
   ```

   1. Выполните команду:

      ```bash
      kubectl create -f test-claim.yaml
      ```

      Результат:

      ```
      persistentvolumeclaim/test-claim created
      ```

   1. Посмотрите информацию о созданном `PersistentVolumeClaim`:

      ```bash
      kubectl describe persistentvolumeclaim test-claim
      ```

      Результат:

      
      ```
      Name:          test-claim
      Namespace:     default
      StorageClass:  yc-network-hdd
      Status:        Bound
      Volume:        test-pv
      ...
      ```



## Создайте под со статически подготовленным томом {#create-pod}

1. Сохраните следующий пример в YAML-файл с названием `test-pod.yaml`:

   ```
   apiVersion: v1
   kind: Pod
   metadata:
     name: test-pod
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
         claimName: test-claim
   ```

   Подробнее о спецификации читайте в [документации {{ k8s }}](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/).

1. Выполните команду:

   ```bash
   kubectl create -f test-pod.yaml
   ```

   Результат:

   ```
   pod/test-pod created
   ```

1. Посмотрите информацию о созданном поде:

   ```bash
   kubectl describe pod test-pod
   ```

   Результат:

   ```
   Name:         test-pod
   Namespace:    default
   Priority:     0
   Node:         cl1gqrct5oier258n08t-ypap/10.0.0.9
   Start Time:   Tue, 23 Jul 2019 18:34:57 +0300
   Labels:       <none>
   Annotations:  <none>
   Status:       Pending
   ...
   Events:
     Type    Reason     Age   From               Message
     ----    ------     ----  ----               -------
     Normal  Scheduled  3s    default-scheduler  Successfully assigned default/test-pod to cl1gqrct5oier258n08t-ypap
   ```

После этого рядом с используемым диском в консоли управления в **{{ compute-full-name }}** в разделе **Диски** появится надпись **Подключен**.