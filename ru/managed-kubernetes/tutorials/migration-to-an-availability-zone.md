---
title: Миграция ресурсов {{ managed-k8s-full-name }} в другую зону доступности
description: Следуя данному руководству, вы сможете перенести ресурсы {{ managed-k8s-name }} в другую зону доступности.
---

# Миграция ресурсов {{ managed-k8s-name }} в другую зону доступности


{% note info %}

{% include [zone-c-deprecation](../../_includes/vpc/zone-c-deprecation.md) %}

{% endnote %}

Чтобы перенести ресурсы {{ managed-k8s-name }} из одной зоны в другую:

1. [Перенесите мастер](#transfer-a-master).
1. [Перенесите группу узлов и рабочую нагрузку в подах](#transfer-a-node-group).

## Перед началом работы {#before-you-begin}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

Если CLI уже установлен, обновите его до последней версии:

```bash
yc components update
```

## Перенесите мастер в другую зону доступности {#transfer-a-master}

Миграция [мастера](../concepts/index.md#master) зависит от его типа: [зональный](#zonal) или [региональный](#regional).

### Миграция зонального мастера {#zonal}

Зональный мастер находится в одной зоне доступности. Вы можете перенести мастер только из зоны `{{ region-id }}-c` в `{{ region-id }}-d`. Во время миграции мастер перезапускается, а {{ k8s }} API кратковременно недоступен. После миграции публичный и внутренний IP-адреса мастера сохраняются, кластер и группа узлов не пересоздаются.

Зональный мастер переносится в новую подсеть с тем же внутренним IP-адресом, который был в старой подсети. Этот IP-адрес также остается зарезервирован в старой подсети, поэтому ее нельзя удалить. В дальнейшем вы сможете [перенести](../../vpc/operations/subnet-relocate.md) такую подсеть в новую зону доступности, либо она будет перенесена автоматически в зону `{{ region-id }}-d` после закрытия зоны `{{ region-id }}-c`.

Чтобы перенести зональный мастер в другую зону доступности:

{% list tabs group=instructions %}

- CLI {#cli}

   1. Создайте подсеть в зоне доступности `{{ region-id }}-d`:

      ```bash
      yc vpc subnet create \
         --folder-id <идентификатор_каталога> \
         --name <название_подсети> \
         --zone {{ region-id }}-d \
         --network-id <идентификатор_сети> \
         --range <CIDR_подсети>
      ```

      В команде укажите параметры подсети:

      * `--folder-id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
      * `--name` — название подсети.
      * `--zone` — зона доступности.
      * `--network-id` — идентификатор сети, в которую входит новая подсеть.
      * `--range` — список IPv4-адресов, откуда или куда будет поступать трафик. Например, `10.0.0.0/22` или `192.168.0.0/16`. Адреса должны быть уникальными внутри сети. Минимальный размер подсети — `/28`, а максимальный размер подсети — `/16`. Поддерживается только IPv4.

   1. Перенесите мастер в другую зону доступности:

      ```bash
      {{ yc-k8s }} cluster update \
         --folder-id <идентификатор_каталога> \
         --id <идентификатор_кластера> \
         --master-location subnet-id=<идентификатор_новой_подсети>,zone={{ region-id }}-d
      ```

      Где:

      * `--folder-id` — идентификатор каталога.
      * `--id` — [идентификатор кластера](../operations/kubernetes-cluster/kubernetes-cluster-list.md).
      * `--master-location` — параметры размещения мастера:
        * `subnet-id` — идентификатор новой подсети.
        * `zone` — зона доступности.

- {{ TF }} {#tf}

   {% include [master-tf-mifration-warning](../../_includes/managed-kubernetes/master-tf-mifration-warning.md) %}

   1. В файле с конфигурацией кластера обновите формат блока с параметрами расположения кластера (`zonal`) без изменения значений параметров:

      **Старый формат**:

      ```hcl
      resource "yandex_kubernetes_cluster" "<название_кластера>" {
         ...
         master {
            ...
            zonal {
               subnet_id = yandex_vpc_subnet.my-old-subnet.id
               zone      = "{{ region-id }}-c"
            }
         }
         ...
      }
      ```       

      **Новый формат**: 

      ```hcl
      resource "yandex_kubernetes_cluster" "<название_кластера>" {
         ...
         master {
            ...
            master_location {
               subnet_id = yandex_vpc_subnet.my-old-subnet.id
               zone      = "{{ region-id }}-c"
            }
         }
         ...
      }
      ```    

   1. Убедитесь, что изменений в параметрах ресурсов {{ TF }} не обнаружено:

      ```bash
      terraform plan
      ```

      Если {{ TF }} обнаружил изменения, проверьте значения всех параметров кластера — они должны соответствовать текущему состоянию.

   1. В файл с конфигурацией кластера добавьте манифест новой сети и измените местоположение кластера:

      ```hcl
      resource "yandex_vpc_subnet" "my-new-subnet" {
         name           = "<название_сети>"
         zone           = "{{ region-id }}-d"
         network_id     = yandex_vpc_network.k8s-network.id
         v4_cidr_blocks = ["<CIDR_подсети>"]
      }

      ...

      resource "yandex_kubernetes_cluster" "<название_кластера>" {
         ...
         master {
            ...
            master_location {
               subnet_id = yandex_vpc_subnet.my-new-subnet.id
               zone      = "{{ region-id }}-d"
            }
         }
         ...
      }
      ```

      Для кластера старая подсеть `my-old-subnet` заменяется на подсеть `my-new-subnet` с параметрами:

      * `name` — название подсети.
      * `zone` — зона доступности `{{ region-id }}-d`.
      * `network_id` — идентификатор сети, в которую входит новая подсеть.
      * `v4_cidr_blocks` — список IPv4-адресов, откуда или куда будет поступать трафик. Например, `10.0.0.0/22` или `192.168.0.0/16`. Адреса должны быть уникальными внутри сети. Минимальный размер подсети — `/28`, а максимальный размер подсети — `/16`. Поддерживается только IPv4.

   1. Проверьте корректность конфигурационного файла.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

{% endlist %}

### Миграция регионального мастера {#regional}

Региональный мастер создается распределенно в трех подсетях в разных зонах доступности. Для регионального мастера вы можете изменить [только одну зону доступности](../../overview/concepts/ru-central1-c-deprecation.md): с `{{ region-id }}-c` на `{{ region-id }}-d`. Для миграции указываются три подсети и зоны доступности. Во время миграции работа мастера не прерывается, кластер и группа узлов не пересоздаются.

Внутренний IP-адрес для регионального мастера назначается автоматически в одной из трех подсетей размещения. После миграции внутренний IP-адрес мастера сохраняется. Если этот IP-адрес был выделен в подсети зоны `{{ region-id }}-c`, то мастер переносится в зону `{{ region-id }}-d` с прежним IP-адресом, зарезервированным в старой подсети. Такую подсеть нельзя удалить, но в дальнейшем вы сможете [перенести](../../vpc/operations/subnet-relocate.md) ее в новую зону доступности, либо она будет перенесена автоматически в зону `{{ region-id }}-d` после закрытия зоны `{{ region-id }}-c`.

Чтобы перенести региональный мастер в другой набор зон доступности:

{% list tabs group=instructions %}

- CLI {#cli}

   1. Создайте подсеть в зоне доступности `{{ region-id }}-d`:

      ```bash
      yc vpc subnet create \
         --folder-id <идентификатор_каталога> \
         --name <название_подсети> \
         --zone {{ region-id }}-d \
         --network-id <идентификатор_сети> \
         --range <CIDR_подсети>
      ```

      В команде укажите параметры подсети:

      * `--folder-id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
      * `--name` — название подсети.
      * `--zone` — зона доступности.
      * `--network-id` — идентификатор сети, в которую входит новая подсеть.
      * `--range` — список IPv4-адресов, откуда или куда будет поступать трафик. Например, `10.0.0.0/22` или `192.168.0.0/16`. Адреса должны быть уникальными внутри сети. Минимальный размер подсети — `/28`, а максимальный размер подсети — `/16`. Поддерживается только IPv4.

   1. Переместите мастер в другой набор зон доступности:

      ```bash
      {{ yc-k8s }} cluster update \
         --folder-id <идентификатор_каталога> \
         --id <идентификатор_кластера> \
         --master-location subnet-id=<идентификатор_подсети>,zone={{ region-id }}-a \
         --master-location subnet-id=<идентификатор_подсети>,zone={{ region-id }}-b \
         --master-location subnet-id=<идентификатор_новой_подсети>,zone={{ region-id }}-d
      ```

      Где:

      * `--folder-id` — идентификатор каталога.
      * `--id` — [идентификатор кластера](../operations/kubernetes-cluster/kubernetes-cluster-list.md).
      * `--master-location` — параметры размещения мастера:
        * `subnet-id` — идентификатор подсети.
        * `zone` — зона доступности.

        Для каждой зоны доступности укажите соответствующую подсеть.

- {{ TF }} {#tf}

   {% include [master-tf-mifration-warning](../../_includes/managed-kubernetes/master-tf-mifration-warning.md) %}

   1. В файле с конфигурацией кластера обновите формат блока с параметрами расположения кластера (`regional`) без изменения значений параметров:

      **Старый формат**:

      ```hcl
      resource "yandex_kubernetes_cluster" "<название_кластера>" {
         ...
         master {
            ...
            regional {
               region = "{{ region-id }}"
               location {
                  subnet_id = yandex_vpc_subnet.my-subnet-a.id
                  zone      = yandex_vpc_subnet.my-subnet-a.zone
               }
               location {
                  subnet_id = yandex_vpc_subnet.my-subnet-b.id
                  zone      = yandex_vpc_subnet.my-subnet-b.zone
               }
               location {
                  subnet_id = yandex_vpc_subnet.my-subnet-c.id
                  zone      = yandex_vpc_subnet.my-subnet-c.zone
               }
            }
         }
         ...
      }
      ```       

      **Новый формат**: 

      ```hcl
      resource "yandex_kubernetes_cluster" "<название_кластера>" {
         ...
         master {
            ...
            master_location {
               subnet_id = yandex_vpc_subnet.my-subnet-a.id
               zone      = yandex_vpc_subnet.my-subnet-a.zone
            }
            master_location {
               subnet_id = yandex_vpc_subnet.my-subnet-b.id
               zone      = yandex_vpc_subnet.my-subnet-b.zone
            }
            master_location {
               subnet_id = yandex_vpc_subnet.my-subnet-c.id
               zone      = yandex_vpc_subnet.my-subnet-c.zone
            }
         }
         ...
      }
      ```

   1. Убедитесь, что изменений в параметрах ресурсов {{ TF }} не обнаружено:

      ```bash
      terraform plan
      ```

      Если {{ TF }} обнаружил изменения, проверьте значения всех параметров кластера — они должны соответствовать текущему состоянию.

   1. В файл с конфигурацией кластера добавьте манифест новой подсети и измените местоположение кластера:

      ```hcl
      resource "yandex_vpc_subnet" "my-subnet-d" {
         name           = "<название_сети>"
         zone           = "{{ region-id }}-d"
         network_id     = yandex_vpc_network.k8s-network.id
         v4_cidr_blocks = ["<CIDR_подсети>"]
      }

      ...

      resource "yandex_kubernetes_cluster" "k8s-cluster" {
         ...
         master {
            ...
            master_location {
               subnet_id = yandex_vpc_subnet.my-subnet-a.id
               zone      = yandex_vpc_subnet.my-subnet-a.zone
            }
            master_location {
               subnet_id = yandex_vpc_subnet.my-subnet-b.id
               zone      = yandex_vpc_subnet.my-subnet-b.zone
            }
            master_location {
               subnet_id = yandex_vpc_subnet.my-subnet-d.id
               zone      = yandex_vpc_subnet.my-subnet-d.zone
            }
            ...
         }
      ...
      }
      ```

      Для кластера подсеть `my-subnet-c` заменяется на подсеть `my-subnet-d` с параметрами:

      * `name` — название подсети.
      * `zone` — зона доступности.
      * `network_id` — идентификатор сети, в которую входит новая подсеть.
      * `v4_cidr_blocks` — список IPv4-адресов, откуда или куда будет поступать трафик. Например, `10.0.0.0/22` или `192.168.0.0/16`. Адреса должны быть уникальными внутри сети. Минимальный размер подсети — `/28`, а максимальный размер подсети — `/16`. Поддерживается только IPv4.

   1. Проверьте корректность конфигурационного файла.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

{% endlist %}

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
