# Динамическая подготовка тома

Создайте [под](../../concepts/index.md#pod) с динамически подготовленным [томом](../../concepts/volume.md):
1. [Создайте объект PersistentVolumeClaim](#create-pvc).
1. [Создайте под](#create-pod).

{% note tip %}

Вы можете использовать [бакет](../../../storage/concepts/bucket.md) {{ objstorage-full-name }} в качестве хранилища для пода. Подробнее см. в разделе [{#T}](s3-csi-integration.md).

{% endnote %}

## Создайте объект PersistentVolumeClaim {#create-pvc}

1. Сохраните следующую спецификацию для создания объекта `PersistentVolumeClaim` в YAML-файл с названием `pvc-dynamic.yaml`.

   
   {% note info %}

   Если не указать параметр `storageClassName`, будет использован класс хранилищ по умолчанию: `yc-network-hdd`. Как изменить класс по умолчанию читайте в разделе [{#T}](manage-storage-class.md#sc-default).

   {% endnote %}



   Подробнее о спецификации для создания объекта `PersistentVolumeClaim` читайте в [документации {{ k8s }}](https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/).

   
   ```yaml
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: pvc-dynamic
   spec:
     accessModes:
       - ReadWriteOnce
     storageClassName: yc-network-hdd
     resources:
       requests:
         storage: 4Gi
   ```



   1. Выполните команду:

      ```bash
      kubectl create -f pvc-dynamic.yaml
      ```

      Результат:

      ```text
      persistentvolumeclaim/pvc-dynamic created
      ```

   1. Посмотрите информацию о созданном объекте `PersistentVolumeClaim`:

      ```bash
      kubectl describe persistentvolumeclaim pvc-dynamic
      ```

      Результат:

      
      ```text
      Name:          pvc-dynamic
      Namespace:     default
      StorageClass:  yc-network-hdd
      ...
      Type    Reason                Age               From                         Message
      ----    ------                ----              ----                         -------
      Normal  WaitForFirstConsumer  9s (x3 over 15s)  persistentvolume-controller  waiting for first consumer to be created before binding
      ```



## Создайте под с динамически подготовленным томом {#create-pod}

1. Сохраните следующую спецификацию для создания пода в YAML-файл с названием `pod.yaml`.

   Подробнее о спецификации для создания пода читайте в [документации {{ k8s }}](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/).

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
         claimName: pvc-dynamic
   ```

1. Выполните команду:

   ```bash
   kubectl create -f pod.yaml
   ```

   Результат:

   ```text
   pod/pod created
   ```

1. Посмотрите информацию о созданном поде:

   ```bash
   kubectl describe pod pod
   ```

   Результат:

   ```text
   Name:         pod
   Namespace:    default
   Priority:     0
   ...
     Normal  Pulled                  11s   kubelet, cl1gqrct5oier258n08t-ytas  Successfully pulled image "ubuntu"
     Normal  Created                 10s   kubelet, cl1gqrct5oier258n08t-ytas  Created container
     Normal  Started                 10s   kubelet, cl1gqrct5oier258n08t-ytas  Started container
   ```

   После создания пода:
   * В [консоли управления]({{ link-console-main }}) в **{{ compute-name }}** в разделе **Диски** появится новый [диск](../../../compute/concepts/disk.md) с префиксом `k8s-csi` в имени диска.
   * В событиях объекта `PersistentVolumeClaim` появится информация о выделении диска:

     ```bash
     kubectl describe persistentvolumeclaim pvc-dynamic
     ```

     Результат:

     
     ```text
     Name:          pvc-dynamic
     Namespace:     default
     StorageClass:  yc-network-hdd
     ...
       Normal  ExternalProvisioning   4m10s (x3 over 4m10s)  persistentvolume-controller                                                              waiting for a volume to be created, either by external provisioner "disk-csi-driver.mks.ycloud.io" or manually created by system administrator
       Normal  Provisioning           4m10s                  disk-csi-driver.mks.ycloud.io_cat1h5l0v862oq74cp8j_d0f0b837-a875-11e9-b6cb-d00df1cbdf81  External provisioner is provisioning volume for claim "default/pvc-dynamic"
       Normal  ProvisioningSucceeded  4m7s                   disk-csi-driver.mks.ycloud.io_cat1h5l0v862oq74cp8j_d0f0b837-a875-11e9-b6cb-d00df1cbdf81  Successfully provisioned volume pvc-c4794058-ad68-11e9-b71a-d00df1cbdf81
     ```



## Как удалить том {#delete-volume}

Чтобы удалить динамически подготовленный том, удалите объект `PersistentVolumeClaim`:

```bash
kubectl delete pvc <идентификатор объекта PersistentVolumeClaim>
```

Диск в {{ compute-name }} удалится автоматически.