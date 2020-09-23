# Подключение тома в блочном режиме

Чтобы подключить [том в режиме](../../concepts/volume.md#block) `volumeMode: Block`, выполните следующие действия.

## Создайте объект PersistentVolumeClaim {#create-pvc}

1. Для создания тома в блочном режиме укажите в поле `spec.volumeMode` значение `Block`.

   Сохраните следующую спецификацию для создания объекта [PersistentVolumeClaim](dynamic-create-pv.md) в YAML-файл с названием `pvc-block.yaml`.

   {% note info %}
 
    Если не указать параметр `storageClassName`, будет использован класс хранилищ по умолчанию: `yc-network-hdd`. Как изменить класс по умолчанию читайте в разделе [{#T}](manage-storage-class.md#sc-default).

    {% endnote %}

   Подробнее о спецификации для создания объекта `PersistentVolumeClaim` читайте в [документации {{ k8s }}](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.15/#persistentvolumeclaim-v1-core).

   ```yaml
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: pvc-block
   spec:
     accessModes:
       - ReadWriteOnce
     volumeMode: Block
     resources:
       requests:
         storage: 1Gi
   ```

1. Создайте объект `PersistentVolumeClaim`:
    
   ```bash
   kubectl create -f pvc-block.yaml
   ```

   Результат выполнения команды:

   ```bash
   persistentvolumeclaim/pvc-block created
   ```

## Создайте под с подключенным томом {#create-pod}

1. При создании пода с томом в блочном режиме укажите поле `spec.containers.volumeDevices`.

   Сохраните следующую спецификацию для создания пода в YAML-файл с названием `pod.yaml`.

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
       args: ["-xc", "/bin/dd if=/dev/block of=/dev/null bs=1K count=10; /bin/sleep 3600"]
       volumeDevices:
       - devicePath: /dev/block
         name: persistent-storage
     volumes:
     - name: persistent-storage
       persistentVolumeClaim:
         claimName:  pvc-block
   ```

1. Выполните команду: 

   ```bash
   kubectl create -f pod.yaml
   ```

   Результат выполнения команды:
   
   ```bash
   pod/pod created
   ```