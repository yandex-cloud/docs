---
title: Миграция ресурсов {{ managed-k8s-full-name }} в другую зону доступности
description: Следуя данному руководству, вы сможете перенести ресурсы {{ managed-k8s-name }} в другую зону доступности.
---

# Миграция ресурсов {{ managed-k8s-name }} в другую зону доступности


В кластере {{ managed-k8s-name }} вы можете [перенести группу узлов и рабочую нагрузку в подах](#transfer-a-node-group) из одной зоны доступности в другую.

## Перед началом работы {#before-you-begin}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

Если CLI уже установлен, обновите его до последней версии:

```bash
yc components update
```


## Перенесите группу узлов и рабочую нагрузку в подах в другую зону доступности {#transfer-a-node-group}

[Подготовьте группу узлов](#prepare), после чего выполните миграцию одним из способов:

* Миграция непосредственно группы узлов в новую зону доступности. Зависит от вида рабочей нагрузки в подах:

   * [Stateless-нагрузка](#stateless) — работа приложений в подах во время миграции зависит от распределения нагрузки между узлами кластера. Если поды находятся в мигрирующей группе узлов и группах, для которых не меняется зона доступности, приложения продолжают работать. Если поды находятся только в мигрирующей группе, поды и приложения в них придется остановить на короткий срок.

      Примеры stateless-нагрузки: веб-сервер, [Ingress-контроллер](../../application-load-balancer/tools/k8s-ingress-controller/index.md) {{ alb-full-name }}, приложение REST API.

   * [Stateful-нагрузка](#stateful) — независимо от распределения нагрузки между узлами кластера поды и приложения придется остановить на короткий срок.

      Примеры stateful-нагрузки: базы данных, хранилища.

* [Постепенная миграция stateless- и stateful-нагрузки](#gradual-migration) в новую группу узлов. Заключается в создании новой группы узлов в новой зоне доступности и постепенном отключении старых узлов. Так вы можете контролировать перенос нагрузки.

### Подготовительные действия {#prepare}

1. Проверьте, используются ли стратегии `nodeSelector`, `affinity` или `topology spread constraints` для привязки подов к узлам группы. Подробнее о стратегиях см. в [документации {{ k8s }}](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/) и разделе [{#T}](../concepts/usage-recommendations.md#high-availability). Чтобы проверить привязку пода к узлам и убрать ее:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог с вашим кластером {{ managed-k8s-name }}.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
      1. Перейдите на страницу кластера, затем — в раздел **{{ ui-key.yacloud.k8s.cluster.switch_workloads }}**.
      1. На вкладке **{{ ui-key.yacloud.k8s.workloads.label_pods }}** откройте страницу пода.
      1. Перейдите на вкладку **{{ ui-key.yacloud.k8s.workloads.label_tab-yaml }}**.
      1. Проверьте, содержит ли манифест пода указанные параметры и {{ k8s }}-метки в них:

         * Параметры:

            * `spec.nodeSelector`
            * `spec.affinity`
            * `spec.topologySpreadConstraints`

         * {{ k8s }}-метки, заданные внутри параметров:

            * `failure-domain.beta.kubernetes.io/zone`: `<зона_доступности>`
            * `topology.kubernetes.io/zone`: `<зона_доступности>`

         Если в конфигурации есть хотя бы один из указанных параметров и он содержит хотя бы одну из перечисленных {{ k8s }}-меток, такая настройка будет препятствовать миграции группы узлов и рабочей нагрузки.

      1. Проверьте, есть ли в манифесте пода зависимости от сущностей:

         * зоны доступности, из которой вы переносите ресурсы;
         * конкретных узлов в группе.

      1. Если вы нашли указанные выше настройки, привязки и зависимости, удалите их из конфигурации пода:

         1. Скопируйте YAML-конфигурацию из консоли управления.
         1. Создайте локальный YAML-файл и вставьте в него конфигурацию.
         1. Удалите из нее привязки к зонам доступности. Например, если в параметре `spec.affinity` указана {{ k8s }}-метка `failure-domain.beta.kubernetes.io/zone`, удалите ее.
         1. Примените новую конфигурацию:

            ```bash
            kubectl apply -f <путь_до_YAML-файла>
            ```

         1. Убедитесь, что под перешел в статус `Running`:

            ```bash
            kubectl get pods
            ```

      1. Проверьте таким образом каждый под и поправьте его конфигурацию.

   {% endlist %}

1. Перенесите в новую зону доступности персистентные данные (например, базы данных, очереди сообщений, серверы мониторинга и логов).

### Миграция stateless-нагрузки {#stateless}

1. Создайте подсеть в новой зоне доступности и перенесите группу узлов:

   {% include [node-group-migration](../../_includes/managed-kubernetes/node-group-migration.md) %}

1. Убедитесь, что поды запущены в перенесенной группе узлов:

   ```bash
   kubectl get po --output wide
   ```

   Вывод команды показывает, в каких узлах запущены поды.

### Миграция stateful-нагрузки {#stateful}

Миграция основана на масштабировании контроллера `StatefulSet`. Чтобы перенести рабочую stateful-нагрузку:

1. Получите список контроллеров `StatefulSet`, чтобы узнать название нужного контроллера:

   ```bash
   kubectl get statefulsets
   ```

1. Узнайте количество подов контроллера:

   ```bash
   kubectl get statefulsets <название_контроллера> \
      -n default -o=jsonpath='{.status.replicas}'
   ```

   Сохраните полученное значение. Оно понадобится в конце миграции stateful-нагрузки для масштабирования контроллера StatefulSet.

1. Уменьшите количество подов до нуля:

   ```bash
   kubectl scale statefulset <название_контроллера> --replicas=0
   ```

   Так вы выключите поды, которые используют диски. При этом сохранится объект API {{ k8s }} [PersistentVolumeClaim](../concepts/volume.md#persistent-volume) (PVC).

1. Для объекта [PersistentVolume](../concepts/volume.md#persistent-volume) (PV), связанного с `PersistentVolumeClaim`, измените значение параметра `persistentVolumeReclaimPolicy` с `Delete` на `Retain`, чтобы предотвратить случайную потерю данных.

   1. Получите название объекта `PersistentVolume`:

      ```bash
      kubectl get pv
      ```

   1. Отредактируйте объект `PersistentVolume`:

      ```bash
      kubectl edit pv <название_PV>
      ```

1. Проверьте, содержит ли манифест объекта `PersistentVolume` параметр `spec.nodeAffinity`:

    ```bash
    kubectl get pv <название_PV> --output='yaml'
    ```

    Если манифест содержит параметр `spec.nodeAffinity` и в нем указана принадлежность к зоне доступности, сохраните этот параметр. Его понадобится указать в новом `PersistentVolume`.

1. Создайте [снапшот](../../glossary/snapshot.md) — копию диска `PersistentVolume` на определенный момент времени. Подробнее о механизме снапшотов см. в [документации Kubernetes](https://kubernetes.io/docs/concepts/storage/volume-snapshots/).

   1. Получите название объекта `PersistentVolumeClaim`:

      ```bash
      kubectl get pvc
      ```

   1. Создайте файл `snapshot.yaml` с манифестом снапшота и укажите в нем название `PersistentVolumeClaim`:

      ```yaml
      apiVersion: snapshot.storage.k8s.io/v1
      kind: VolumeSnapshot
      metadata:
         name: new-snapshot-test-<номер>
      spec:
         volumeSnapshotClassName: yc-csi-snapclass
         source:
            persistentVolumeClaimName: <название_PVC>
      ```

      Если вы создаете несколько снапшотов для разных `PersistentVolumeClaim`, укажите `<номер>` (номер по порядку), чтобы значение `metadata.name` было уникальным для каждого снапшота.

   1. Создайте снапшот:

      ```bash
      kubectl apply -f snapshot.yaml
      ```

   1. Убедитесь, что снапшот создан:

      ```bash
      kubectl get volumesnapshots.snapshot.storage.k8s.io
      ```

   1. Убедитесь, что создан объект API {{ k8s }} [VolumeSnapshotContent](https://kubernetes.io/docs/concepts/storage/volume-snapshots/#introduction):

      ```bash
      kubectl get volumesnapshotcontents.snapshot.storage.k8s.io
      ```

1. Получите идентификатор снапшота:

   ```bash
   yc compute snapshot list
   ```

1. Создайте [диск виртуальной машины](../../compute/concepts/disk.md) из снапшота:

   ```bash
   yc compute disk create \
      --source-snapshot-id <идентификатор_снапшота> \
      --zone <зона_доступности>
   ```

   В команде укажите зону доступности, в которую переносится группа узлов {{ managed-k8s-name }}.

   Сохраните следующие параметры из вывода команды:
   * идентификатор диска в поле `id`;
   * тип диска в поле `type_id`;
   * размер диска в поле `size`.

1. Создайте объект API {{ k8s }} `PersistentVolume` на основе нового диска:

   1. Создайте файл `persistent-volume.yaml` с манифестом `PersistentVolume`:

      ```yaml
      apiVersion: v1
      kind: PersistentVolume
      metadata:
         name: new-pv-test-<номер>
      spec:
         capacity:
            storage: <размер_PersistentVolume>
         accessModes:
            - ReadWriteOnce
         csi:
            driver: disk-csi-driver.mks.ycloud.io
            fsType: ext4
            volumeHandle: <идентификатор_диска>
         storageClassName: <тип_диска>
      ```

      В файле укажите параметры диска, созданного на основе снапшота:

      * `spec.capacity.storage` — размер диска.
      * `spec.csi.volumeHandle` — идентификатор диска.
      * `spec.storageClassName` — тип диска. Укажите его в соответствии с таблицей:

         | Тип диска на основе снапшота | Тип диска для YAML-файла |
         | ----------- | ----------- |
         | `network-ssd` | `yc-network-ssd` |
         | `network-ssd-nonreplicated` | `yc-network-ssd-nonreplicated` |
         | `network-nvme` | `yc-network-nvme` |
         | `network-hdd` | `yc-network-hdd` |

      Если вы создаете несколько объектов `PersistentVolume`, укажите `<номер>` (номер по порядку), чтобы значение `metadata.name` было уникальным.

      Если ранее вы сохранили параметр `spec.nodeAffinity`, добавьте его в манифест и укажите зону доступности, в которую переносится группа узлов {{ managed-k8s-name }}. Если параметр не указан, рабочая нагрузка может запуститься в другой зоне доступности, в которой недоступен `PersistentVolume`. Это приведет к ошибке запуска.

      Пример параметра `spec.nodeAffinity`:

      ```yaml
      spec:
         ...
         nodeAffinity:
            required:
               nodeSelectorTerms:
               - matchExpressions:
                  - key: failure-domain.beta.kubernetes.io/zone
                    operator: In
                    values:
                       - ru-central1-d
      ```

   1. Создайте объект `PersistentVolume`:

      ```bash
      kubectl apply -f persistent-volume.yaml
      ```

   1. Убедитесь, что `PersistentVolume` создан:

      ```bash
      kubectl get pv
      ```

      В выводе команды появится объект `new-pv-test-<номер>`.

   1. Если в манифесте вы указали параметр `spec.nodeAffinity`, убедитесь, что для `PersistentVolume` применен этот параметр:

       {% list tabs group=instructions %}

       - Консоль управления {#console}

          1. В [консоли управления]({{ link-console-main }}) выберите каталог с вашим кластером {{ managed-k8s-name }}.
          1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
          1. Перейдите на страницу кластера, затем — в раздел **{{ ui-key.yacloud.k8s.cluster.switch_storage }}**.
          1. На вкладке **{{ ui-key.yacloud.k8s.storage.label_pv }}** найдите объект `new-pv-test-<номер>` и посмотрите значение поля **{{ ui-key.yacloud.k8s.pv.overview.label_zone }}**. В нем должна отображаться зона доступности. Прочерк означает, что нет привязки к зоне доступности.

       {% endlist %}

   1. Если в манифесте вы не указали параметр `spec.nodeAffinity`, вы можете добавить его. Для этого отредактируйте объект `PersistentVolume`:

      ```bash
      kubectl edit pv new-pv-test-<номер>
      ```

1. Создайте объект `PersistentVolumeClaim` на основе нового объекта `PersistentVolume`:

   1. Создайте файл `persistent-volume-claim.yaml` с манифестом `PersistentVolumeClaim`:

      ```yaml
      apiVersion: v1
      kind: PersistentVolumeClaim
      metadata:
         name: <название_PVC>
      spec:
         accessModes:
            - ReadWriteOnce
         resources:
            requests:
               storage: <размер_PV>
         storageClassName: <тип_диска>
         volumeName: new-pv-test-<номер>
      ```

      В файле задайте параметры:

      * `metadata.name` — название объекта `PersistentVolumeClaim`, который вы использовали для создания снапшота. Название можно получить с помощью команды `kubectl get pvc`.
      * `spec.resources.requests.storage` — размер `PersistentVolume`, совпадает с размером созданного диска.
      * `spec.storageClassName` — тип диска `PersistentVolume`, совпадает с типом диска у нового объекта `PersistentVolume`.
      * `spec.volumeName` — название объекта `PersistentVolume`, на основе которого создается `PersistentVolumeClaim`. Название можно получить с помощью команды `kubectl get pv`.

   1. Удалите исходный объект `PersistentVolumeClaim`, чтобы затем заменить его:

      ```bash
      kubectl delete pvc <название_PVC>
      ```

   1. Создайте объект `PersistentVolumeClaim`:

      ```bash
      kubectl apply -f persistent-volume-claim.yaml
      ```

   1. Убедитесь, что `PersistentVolumeClaim` создан:

      ```bash
      kubectl get pvc
      ```

      В выводе команды для `PersistentVolumeClaim` будет указан размер, который вы задали в YAML-файле.

1. Создайте подсеть в новой зоне доступности и перенесите группу узлов:

   {% include [node-group-migration](../../_includes/managed-kubernetes/node-group-migration.md) %}

1. Верните прежнее количество подов контроллера `StatefulSet`:

   ```bash
   kubectl scale statefulset <название_контроллера> --replicas=<количество_подов>
   ```

   Поды запустятся в перенесенной группе узлов.

   В команде укажите параметры:

   * Название контроллера `StatefulSet`. Его можно получить с помощью команды `kubectl get statefulsets`.
   * Количество подов, которое было до масштабирования контроллера.

1. Убедитесь, что поды запущены в перенесенной группе узлов:

   ```bash
   kubectl get po --output wide
   ```

   Вывод команды показывает, в каких узлах запущены поды.

1. Удалите неиспользуемый объект `PersistentVolume` (в статусе `Released`).

   1. Получите название объекта `PersistentVolume`:

      ```bash
      kubectl get pv
      ```

   1. Удалите объект `PersistentVolume`:

      ```bash
      kubectl delete pv <название_PV>
      ```

### Постепенная миграция stateless- и stateful-нагрузки {#gradual-migration}

Ниже представлена инструкция по постепенной миграции нагрузки из старой группы узлов в новую. Инструкцию по миграции объектов `PersistentVolume` и `PersistentVolumeClaim` см. в подразделе [Миграция stateful-нагрузки](#stateful).

1. [Создайте новую группу узлов](../operations/node-group/node-group-create.md) {{ managed-k8s-name }} в новой зоне доступности.

1. Запретите запуск новых подов в старой группе узлов:

   ```bash
   kubectl cordon -l yandex.cloud/node-group-id=<идентификатор_старой_группы_узлов>
   ```

1. Для каждого узла из старой группы узлов выполните команду:

   ```bash
   kubectl drain <имя_узла> --ignore-daemonsets --delete-emptydir-data
   ```

   Поды постепенно переместятся в новую группу узлов.

1. Убедитесь, что поды запущены в новой группе узлов:

   ```bash
   kubectl get po --output wide
   ```

1. [Удалите старую группу узлов](../operations/node-group/node-group-delete.md).
