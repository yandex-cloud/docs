# Статическая подготовка тома

Создайте [под](../../concepts/index.md#pod) со статически подготовленным [томом](../../concepts/volume.md):
1. [Создайте объект PersistentVolume](#create-pv).
1. [Создайте объект PersistentVolumeClaim](#create-claim).
1. [Создайте под](#create-pod).

{% note tip %}

Вы можете использовать [бакет](../../../storage/concepts/bucket.md) {{ objstorage-full-name }} в качестве хранилища для пода. Подробнее см. в разделе [{#T}](s3-csi-integration.md).

{% endnote %}

## Перед началом работы {#before-you-begin}

1. [Установите kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) и [настройте](../connect/create-static-conf.md) его на работу с вашим [кластером {{ k8s }}](../../concepts/index.md#kubernetes-cluster).
1. Узнайте уникальный идентификатор [диска](../../../compute/concepts/disk.md), который будет использован для создания объекта `PersistentVolume`:
   1. Если у вас еще нет диска, [создайте его](../../../compute/operations/disk-create/empty.md).

      {% note warning %}

      Диск должен быть размещен в той же [зоне доступности](../../../overview/concepts/geo-scope.md), что и [узлы группы](../../concepts/index.md#node-group), на которой будут работать поды.

      {% endnote %}

   1. Получите идентификатор диска (колонка `ID`):

      ```bash
      yc compute disk list
      ```

      Результат выполнения команды:

      ```text
      +----------------------+------+------------+-------------------+--------+--------------+-------------+
      |          ID          | NAME |    SIZE    |       ZONE        | STATUS | INSTANCE IDS | DESCRIPTION |
      +----------------------+------+------------+-------------------+--------+--------------+-------------+
      | ef3ouo4sgl86740ridn6 | k8s  | 4294967296 | {{ region-id }}-a | READY  |              |             |
      +----------------------+------+------------+-------------------+--------+--------------+-------------+
      ```

1. Посмотрите доступные [классы хранилищ](manage-storage-class.md) и выберите подходящий:

   ```bash
   kubectl get storageclass
   ```

   Результат выполнения команды:

   {% if product == "yandex-cloud" %}

   ```text
   NAME                          PROVISIONER                    RECLAIMPOLICY  VOLUMEBINDINGMODE     ALLOWVOLUMEEXPANSION  AGE
   yc-network-hdd (default)      disk-csi-driver.mks.ycloud.io  Delete         WaitForFirstConsumer  true                  12d
   yc-network-nvme               disk-csi-driver.mks.ycloud.io  Delete         WaitForFirstConsumer  true                  12d
   yc-network-ssd                disk-csi-driver.mks.ycloud.io  Delete         WaitForFirstConsumer  true                  12d
   yc-network-ssd-nonreplicated  disk-csi-driver.mks.ycloud.io  Delete         WaitForFirstConsumer  true                  12d
   ```

   {% endif %}

   {% if product == "cloud-il" %}

   ```text
   NAME                          PROVISIONER                    RECLAIMPOLICY  VOLUMEBINDINGMODE     ALLOWVOLUMEEXPANSION  AGE
   yc-network-ssd (default)      disk-csi-driver.mks.ycloud.io  Delete         WaitForFirstConsumer  true                  12d
   ```

   {% endif %}

   {% note info %}

   Не путайте [классы хранилищ {{ k8s }}](manage-storage-class.md) и [типы дисков {{ compute-full-name }}](../../../compute/concepts/disk.md#disks_types).

   {% endnote %}

## Создайте объект PersistentVolume {#create-pv}

1. Сохраните спецификацию для создания объекта `PersistentVolume` в YAML-файл с названием `test-pv.yaml`.

   Подробнее о спецификации читайте в [документации {{ k8s }}](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-v1/).

   При указании параметра `spec.capacity.storage` убедитесь, что задан точный объем диска. {{ CSI }} не обеспечивает проверку объема диска для статически подготовленных томов.

   Для создания объекта `PersistentVolume` на основе существующего облачного диска в параметре `volumeHandle` укажите уникальный идентификатор необходимого диска.

   ```yaml
   apiVersion: v1
   kind: PersistentVolume
   metadata:
     name: <имя PersistentVolume>
   spec:
     capacity:
       storage: <размер PersistentVolume>
     accessModes:
       - ReadWriteOnce
     csi:
       driver: disk-csi-driver.mks.ycloud.io
       fsType: ext4
       volumeHandle: <идентификатор диска>
     storageClassName: <имя класса хранилища>
   ```

1. Выполните команду:

   ```bash
   kubectl create -f test-pv.yaml
   ```

   Результат выполнения команды:

   ```text
   persistentvolume/<имя PersistentVolume> created
   ```

1. Посмотрите информацию о созданном объекте `PersistentVolume`:

   ```bash
   kubectl describe persistentvolume <имя PersistentVolume>
   ```

   Результаты выполнения команды:

   ```text
   Name:            <имя PersistentVolume>
   Labels:          <none>
   Annotations:     <none>
   Finalizers:      [kubernetes.io/pv-protection]
   StorageClass:    <имя класса хранилища>
   Status:          Available
   ...
   ```

## Создайте объект PersistentVolumeClaim {#create-claim}

1. Сохраните спецификацию для создания объекта `PersistentVolumeClaim` YAML-файл с названием `test-claim.yaml`.

   Подробнее о спецификации читайте в [документации {{ k8s }}](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/).

   ```yaml
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: <имя PersistentVolumeClaim>
   spec:
     accessModes:
       - ReadWriteOnce
     resources:
       requests:
         storage: <размер PersistentVolumeClaim>
     storageClassName: <имя класса хранилища>
     volumeName: <имя PersistentVolume>
   ```

   {% note info %}

   Размер `PersistentVolumeClaim` должен быть меньше или равен размеру `PersistentVolume`.

   {% endnote %}

   1. Выполните команду:

      ```bash
      kubectl create -f test-claim.yaml
      ```

      Результат выполнения команды:

      ```text
      persistentvolumeclaim/<имя PersistentVolumeClaim> created
      ```

   1. Посмотрите информацию о созданном `PersistentVolumeClaim`:

      ```bash
      kubectl describe persistentvolumeclaim <имя PersistentVolumeClaim>
      ```

      Результат выполнения команды:

      ```text
      Name:          <имя PersistentVolumeClaim>
      Namespace:     default
      StorageClass:  <имя класса хранилища>
      Status:        Bound
      Volume:        <имя PersistentVolume>
      ...
      ```

## Создайте под со статически подготовленным томом {#create-pod}

1. Создайте файл `test-pod.yaml` с манифестом пода, использующего `PersistentVolumeClaim`:

   ```yaml
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
         claimName: <имя PersistentVolumeClaim>
   ```

   Подробнее о спецификации читайте в [документации {{ k8s }}](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/).

1. Выполните команду:

   ```bash
   kubectl create -f test-pod.yaml
   ```

   Результат выполнения команды:

   ```text
   pod/test-pod created
   ```

1. Посмотрите информацию о созданном поде:

   ```bash
   kubectl describe pod test-pod
   ```

   Результат выполнения команды:

   ```text
   Name:         test-pod
   Namespace:    default
   Priority:     0
   ...
     ----    ------                  ----  ----                     -------
     Normal  Scheduled               20m   default-scheduler        Successfully assigned default/test-pod to cl1jtehftl7q1umj18ll-icut
     Normal  SuccessfulAttachVolume  20m   attachdetach-controller  AttachVolume.Attach succeeded for volume "<имя PersistentVolume>"
   ```

После этого рядом с используемым диском в консоли управления в **{{ compute-name }}** в разделе **Диски** появится надпись **Подключен**.