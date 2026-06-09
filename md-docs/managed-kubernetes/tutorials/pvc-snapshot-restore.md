# Работа со снапшотами


В {{ managed-k8s-name }} доступны [снапшоты](../../glossary/snapshot.md) — копии дисков [PersistentVolume](../concepts/volume.md#provisioning-volumes) на определенный момент времени. Подробнее о механизме снапшотов см. в [документации Kubernetes](https://kubernetes.io/docs/concepts/storage/volume-snapshots/).

Чтобы создать снапшот, а потом восстановить его:

1. [Подготовьте тестовое окружение](#create-pvc-pod).
1. [Создайте снапшот](#create-snapshot).
1. [Восстановите объекты из снапшота](#restore-from-snapshot).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер {{ managed-k8s-name }}: использование мастера и исходящий трафик (см. [тарифы {{ managed-k8s-name }}](../pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища (см. [тарифы {{ compute-name }}](../../compute/pricing.md)).
* Плата за публичный IP-адрес, если он назначен узлам кластера (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md#prices-public-ip)).


## Перед началом работы {#before-you-begin}

1. Создайте ресурсы {{ k8s }}:

   {% list tabs group=instructions %}

   - Вручную {#manual}

     1. [Создайте группы безопасности](../operations/connect/security-groups.md) для кластера {{ managed-k8s-name }} и входящих в него групп узлов.

        {% note warning %}
        
        От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
        
        {% endnote %}

     1. [Создайте кластер {{ managed-k8s-name }}](../operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../operations/node-group/node-group-create.md) любой подходящей конфигурации. При создании укажите группы безопасности, подготовленные ранее.

   - {{ TF }} {#tf}

     1. Если у вас еще нет {{ TF }}, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
     1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
     1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
     1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

     1. Скачайте в ту же рабочую директорию файл конфигурации кластера [k8s-cluster.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cluster-infrastructure/blob/main/k8s-cluster.tf). В файле описаны:
        * Сеть.
        * Подсеть.
        * Кластер {{ managed-k8s-name }}.
        * Сервисный аккаунт, необходимый для создания кластера и группы узлов {{ managed-k8s-name }}.
        * [Группы безопасности](../../vpc/concepts/security-groups.md), которые содержат [необходимые правила](../operations/connect/security-groups.md) для кластера {{ managed-k8s-name }} и входящих в него групп узлов.

            {% note warning %}
            
            От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
            
            {% endnote %}

     1. Укажите в файле конфигурации [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
     1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Создайте необходимую инфраструктуру:

        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

        В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

   {% endlist %}

1. [Установите kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../operations/connect/index.md#kubectl-connect).

## Подготовьте тестовое окружение {#create-pvc-pod}

Для проверки работы со снапшотами будет создан [PersistentVolumeClaim](../concepts/volume.md#persistent-volume) и [под](../concepts/index.md#pod), имитирующий рабочую нагрузку.
1. Создайте файл `01-pvc.yaml` с манифестом `PersistentVolumeClaim`:

   ```yaml
   ---
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
         storage: 5Gi
   ```

1. Создайте `PersistentVolumeClaim`:

   ```bash
   kubectl apply -f 01-pvc.yaml
   ```

1. Убедитесь, что `PersistentVolumeClaim` создан и имеет состояние `Pending`:

   ```bash
   kubectl get pvc pvc-dynamic
   ```

1. Создайте файл `02-pod.yaml` с манифестом пода `pod-source`:

   ```yaml
   ---
   apiVersion: v1
   kind: Pod
   metadata:
     name: pod-source
   spec:
     containers:
       - name: app
         image: ubuntu
         command: ["/bin/sh"]
         args:
           ["-c", "while true; do echo $(date -u) >> /data/out.txt; sleep 5; done"]
         volumeMounts:
           - name: persistent-storage
             mountPath: /data
     volumes:
       - name: persistent-storage
         persistentVolumeClaim:
           claimName: pvc-dynamic
   ```

   Контейнер пода будет записывать текущие дату и время в файл `/data/out.txt`.

1. Создайте под `pod-source`:

   ```bash
   kubectl apply -f 02-pod.yaml
   ```

1. Убедитесь, что под перешел в состояние `Running`:

   ```bash
   kubectl get pod pod-source
   ```

1. Убедитесь, что в файл `/data/out.txt` попадают записи даты и времени. Для этого [выполните команду](https://kubernetes.io/docs/tasks/debug-application-cluster/get-shell-running-container/) на поде:

   ```bash
   kubectl exec pod-source -- tail /data/out.txt
   ```

   Результат:

   ```text
   Thu Feb 3 04:55:21 UTC 2022
   Thu Feb 3 04:55:26 UTC 2022
   ...
   ```

## Создайте снапшот {#create-snapshot}

1. Создайте файл `03-snapshot.yaml` с манифестом [снапшота](https://kubernetes.io/docs/concepts/storage/volume-snapshots/#volumesnapshots):

   ```yaml
   ---
   apiVersion: snapshot.storage.k8s.io/v1
   kind: VolumeSnapshot
   metadata:
     name: new-snapshot-test
   spec:
     volumeSnapshotClassName: yc-csi-snapclass
     source:
       persistentVolumeClaimName: pvc-dynamic
   ```

1. Создайте снапшот:

   ```bash
   kubectl apply -f 03-snapshot.yaml
   ```

1. Убедитесь, что снапшот создан:

   ```bash
   kubectl get volumesnapshots.snapshot.storage.k8s.io
   ```

1. Убедитесь, что создан [VolumeSnapshotContent](https://kubernetes.io/docs/concepts/storage/volume-snapshots/#introduction):

   ```bash
   kubectl get volumesnapshotcontents.snapshot.storage.k8s.io
   ```

## Восстановите объекты из снапшота {#restore-from-snapshot}

При [восстановлении из снапшота](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#volume-snapshot-and-restore-volume-from-snapshot-support) в кластере будут созданы:
* Объект `PersistentVolumeClaim` с именем `pvc-restore`.
* Под с именем `pod-restore`, содержащий записи в файле `/data/out.txt`.

Чтобы восстановить снапшот:
1. Создайте файл `04-restore-snapshot.yaml` с манифестом нового `PersistentVolumeClaim`:

   ```yaml
   ---
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: pvc-restore
   spec:
     storageClassName: yc-network-hdd
     dataSource:
       name: new-snapshot-test
       kind: VolumeSnapshot
       apiGroup: snapshot.storage.k8s.io
     accessModes:
       - ReadWriteOnce
     resources:
       requests:
         storage: 10Gi
   ```

   {% note tip %}

   Вы можете изменить размер создаваемого `PersistentVolumeClaim`. Для этого укажите нужный размер в значении настройки `spec.resources.requests.storage`.

   {% endnote %}

1. Создайте новый `PersistentVolumeClaim`:

   ```bash
   kubectl apply -f 04-restore-snapshot.yaml
   ```

1. Убедитесь, что `PersistentVolumeClaim` создан и имеет состояние `Pending`:

   ```bash
   kubectl get pvc pvc-restore
   ```

1. Создайте файл `05-pod-restore.yaml` с манифестом нового пода `pod-restore`:

   ```yaml
   ---
   apiVersion: v1
   kind: Pod
   metadata:
     name: pod-restore
   spec:
     containers:
       - name: app-restore
         image: ubuntu
         command: ["/bin/sh"]
         args: ["-c", "while true; do sleep 5; done"]
         volumeMounts:
           - name: persistent-storage-r
             mountPath: /data
     volumes:
       - name: persistent-storage-r
         persistentVolumeClaim:
           claimName: pvc-restore
   ```

   Контейнер нового пода не будет производить никаких действий с файлом `/data/out.txt`.

1. Создайте под `pod-restore`:

   ```bash
   kubectl apply -f 05-pod-restore.yaml
   ```

1. Убедитесь, что под перешел в состояние `Running`:

   ```bash
   kubectl get pod pod-restore
   ```

1. Убедитесь, что новый `PersistentVolumeClaim` перешел в состояние `Bound`:

   ```bash
   kubectl get pvc pvc-restore
   ```

1. Убедитесь, что файл `/data/out.txt` на новом поде содержит записи, которые контейнер пода `pod-source` [записал в файл](#create-pvc-pod) до создания снапшота:

   ```bash
   kubectl exec pod-restore -- tail /data/out.txt
   ```

   Результат:

   ```text
   Thu Feb 3 04:55:21 UTC 2022
   Thu Feb 3 04:55:26 UTC 2022
   ...
   ```

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

1. Удалите кластер {{ managed-k8s-name }}:

   {% list tabs group=instructions %}

   - Вручную {#manual}

     [Удалите кластер {{ managed-k8s-name }}](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).

   - {{ TF }} {#tf}

     1. В терминале перейдите в директорию с планом инфраструктуры.
     
         {% note warning %}
     
         Убедитесь, что в директории нет {{ TF }}-манифестов с ресурсами, которые вы хотите сохранить. {{ TF }} удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
     
         {% endnote %}
     
     1. Удалите ресурсы:
     
         1. Выполните команду:
     
             ```bash
             terraform destroy
             ```
     
         1. Подтвердите удаление ресурсов и дождитесь завершения операции.
     
         Все ресурсы, которые были описаны в {{ TF }}-манифестах, будут удалены.

   {% endlist %}

1. Если вы зарезервировали для кластера публичный статический IP-адрес, [удалите его](../../vpc/operations/address-delete.md).
1. [Удалите снимок диска](../../compute/operations/snapshot-control/delete.md).