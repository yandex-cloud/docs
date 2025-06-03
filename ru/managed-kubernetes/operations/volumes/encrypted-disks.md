---
title: Использование зашифрованных дисков для постоянных томов
description: Следуя данной инструкции, вы сможете использовать зашифрованные диски для постоянных томов.
---

# Использование зашифрованных дисков для постоянных томов

{% include [encrypted-disks-intro](../../../_includes/managed-kubernetes/encrypted-disks-intro.md) %}

Вы можете использовать зашифрованные диски как для [статической](#static-provisioning), так и для [динамической](#dynamic-provisioning) подготовки постоянных томов.

## Статическая подготовка тома {#static-provisioning}

1. [Создайте](../../../kms/operations/key.md) симметричный ключ в {{ kms-name }}.
1. [Создайте](../../../compute/operations/disk-create/empty.md) зашифрованный диск с использованием ключа, созданного ранее.

    Сохраните идентификатор диска, он понадобится в дальнейшем.
1. [Назначьте](../../../iam/operations/roles/grant.md) облачному сервисному аккаунту кластера {{ managed-k8s-name }} [роль](../../../kms/security/index.md#kms-keys-encrypterDecrypter) `kms.keys.encrypterDecrypter` на ключ или каталог.
1. [Подготовьте](static-create-pv.md) постоянный том. В манифесте объекта `PersistentVolume` укажите идентификатор созданного диска в параметре `spec:csi:volumeHandle`.

## Динамическая подготовка тома {#dynamic-provisioning}

1. [Создайте](../../../kms/operations/key.md) симметричный ключ в {{ kms-name }}.

    Сохраните идентификатор ключа, он понадобится в дальнейшем.
1. [Назначьте](../../../iam/operations/roles/grant.md) облачному сервисному аккаунту кластера {{ managed-k8s-name }} [роль](../../../kms/security/index.md#kms-keys-encrypterDecrypter) `kms.keys.encrypterDecrypter` на ключ или каталог.
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. В файле `encrypted-storage-class.yaml` сформируйте манифест для нового [класса хранилища](manage-storage-class.md):

    {% include [encrypted-storage-class-config](../../../_includes/managed-kubernetes/encrypted-storage-class-config.md) %}

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

    После создания пода в [консоли управления]({{ link-console-main }}) в сервисе **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** в разделе **{{ ui-key.yacloud.compute.switch_disks }}** появится новый зашифрованный диск с префиксом `k8s-csi` в имени.

### См. также {#see-also}

* [{#T}](../../concepts/volume.md)
* [{#T}](../../concepts/encryption.md) 
* [{#T}](../../../compute/concepts/encryption.md)
* [{#T}](./dynamic-create-pv.md)
* [{#T}](./static-create-pv.md)
* [{#T}](./manage-storage-class.md)