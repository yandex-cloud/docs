# Использование зашифрованных дисков для постоянных томов

В Managed Service for Kubernetes для постоянных томов поддерживается использование дисков Compute Cloud, [зашифрованных](../../../compute/concepts/encryption.md) с помощью пользовательских [симметричных ключей](../../../kms/concepts/key.md) Yandex Key Management Service.

{% note info %}

Чтобы использовать зашифрованные диски, у [облачного сервисного аккаунта](../../concepts/index.md#service-accounts), назначенного кластеру Managed Service for Kubernetes, должна быть [роль](../../../kms/security/index.md#kms-keys-encrypterDecrypter) `kms.keys.encrypterDecrypter` на ключ или каталог.

{% endnote %}

Вы можете использовать зашифрованные диски как для [статической](#static-provisioning), так и для [динамической](#dynamic-provisioning) подготовки постоянных томов.

## Статическая подготовка тома {#static-provisioning}

1. [Создайте](../../../kms/operations/key.md) симметричный ключ в Key Management Service.
1. [Создайте](../../../compute/operations/disk-create/empty.md) зашифрованный диск с использованием ключа, созданного ранее.

    Сохраните идентификатор диска, он понадобится в дальнейшем.
1. [Назначьте](../../../iam/operations/roles/grant.md) облачному сервисному аккаунту кластера Managed Service for Kubernetes [роль](../../../kms/security/index.md#kms-keys-encrypterDecrypter) `kms.keys.encrypterDecrypter` на ключ или каталог.
1. [Подготовьте](static-create-pv.md) постоянный том. В манифесте объекта `PersistentVolume` укажите идентификатор созданного диска в параметре `spec:csi:volumeHandle`.

## Динамическая подготовка тома {#dynamic-provisioning}

1. [Создайте](../../../kms/operations/key.md) симметричный ключ в Key Management Service.

    Сохраните идентификатор ключа, он понадобится в дальнейшем.
1. [Назначьте](../../../iam/operations/roles/grant.md) облачному сервисному аккаунту кластера Managed Service for Kubernetes [роль](../../../kms/security/index.md#kms-keys-encrypterDecrypter) `kms.keys.encrypterDecrypter` на ключ или каталог.
1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).
1. В файле `encrypted-storage-class.yaml` сформируйте манифест для нового [класса хранилища](manage-storage-class.md):

    ```yaml
    kind: StorageClass
    apiVersion: storage.k8s.io/v1
    metadata:
      name: <название_класса_хранилища>
    provisioner: disk-csi-driver.mks.ycloud.io
    volumeBindingMode: WaitForFirstConsumer
    parameters:
      type: <тип_диска>
      csi.storage.k8s.io/fstype: ext4
      kmsKeyId: <идентификатора_симметричного_ключа>
    allowVolumeExpansion: true
    reclaimPolicy: Delete
    ```
    
    Где:
    * `metadata:name` — произвольное название класса хранилища.
    * `parameters:type` — [тип диска](../../concepts/volume.md#disks-types) в Compute Cloud. Возможные значения:
      * `network-ssd` — сетевой SSD-диск.
      * `network-hdd` — сетевой HDD-диск.
      * `network-ssd-nonreplicated` — нереплицируемый SSD-диск.
      * `network-ssd-io-m3` — сверхбыстрое сетевое хранилище с тремя репликами (SSD).
    * `parameters:kmsKeyId` — идентификатор симметричного ключа.

1. Создайте класс хранилища:

    ```bash
    kubectl apply -f encrypted-storage-class.yaml
    ```

1. В файле `encrypted-pvc.yaml` сформируйте манифест для нового объекта `PersistentVolumeClaim`:

    ```yaml
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: <название_PVC>
    spec:
      accessModes:
        - ReadWriteOnce
      storageClassName: <название_класса_хранилища>
      resources:
        requests:
          storage: 4Gi
    ```

    Где:
    * `metadata:name` — произвольное название для объекта `PersistentVolumeClaim`.
    * `spec:storageClassName` — название класса хранилища, созданного ранее.

1. Создайте объект `PersistentVolumeClaim`:

    ```bash
    kubectl apply -f encrypted-pvc.yaml
    ```

1. В файле `pod-with-encrypted-pvc.yaml` сформируйте манифест для пода с динамически подготовленным постоянным томом:

    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: <название_пода>
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
            claimName: <название_PVC>
    ```

    Где:
    * `metadata:name` — произвольное название для пода.
    * `spec:volumes:persistentVolumeClaim:claimName` — название объекта `PersistentVolumeClaim`, созданного ранее.

1. Создайте под:

    ```bash
    kubectl apply -f pod-with-encrypted-pvc.yaml
    ```

    После создания пода в [консоли управления](https://console.yandex.cloud) в сервисе **Compute Cloud** в разделе **Диски** появится новый зашифрованный диск с префиксом `k8s-csi` в имени.

### См. также {#see-also}

* [Том](../../concepts/volume.md)
* [Шифрование в Managed Service for Kubernetes](../../concepts/encryption.md) 
* [Шифрование в Compute Cloud](../../../compute/concepts/encryption.md)
* [Динамическая подготовка тома](dynamic-create-pv.md)
* [Статическая подготовка тома](static-create-pv.md)
* [Управление классами хранилищ](manage-storage-class.md)