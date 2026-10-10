# Миграция ресурсов {{ k8s }} в другую зону доступности


В кластере {{ managed-k8s-name }} вы можете [перенести высокодоступный мастер](#transfer-a-master), а также [группу узлов и рабочую нагрузку в подах](#transfer-a-node-group) из одной зоны доступности в другую.

## Перед началом работы {#before-you-begin}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

Если CLI уже установлен, обновите его до последней версии:

```bash
yc components update
```


## Необходимые платные ресурсы {#paid-resources}

* Мастер {{ managed-k8s-name }} ([тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md)).
* Узлы кластера {{ managed-k8s-name }}: использование вычислительных ресурсов и хранилища ([тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Публичные IP-адреса для мастера и узлов кластера {{ managed-k8s-name }}, если для них включен публичный доступ ([тарифы {{ vpc-full-name }}](../../vpc/pricing.md#prices-public-ip)).


## Перенесите мастер в другую зону доступности {#transfer-a-master}

В этом разделе описана миграция [высокодоступного мастера](../../managed-kubernetes/concepts/index.md#master) из зоны `ru-central1-b` в `ru-central1-e`. Размещение в зонах `ru-central1-a` и `ru-central1-d` сохраняется.

{% note warning %}

В кластерах с Cilium после переноса мастера могут стать недоступны вебхуки. Способ устранения проблемы описан в разделе [Восстановите доступность вебхуков Cilium](#cilium-webhooks).

{% endnote %}


### Миграция высокодоступного мастера {#regional}

Высокодоступный мастер размещается в трех подсетях в разных зонах доступности. Для миграции укажите полный набор из трех подсетей и зон: две текущие и одну новую. Новая подсеть должна находиться в той же облачной сети, что и кластер.

Чтобы перенести высокодоступный мастер в другой набор зон доступности:

{% list tabs group=instructions %}

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Посмотрите описание команды изменения кластера:

      ```bash
      {{ yc-k8s }} cluster update --help
      ```

   1. Создайте подсеть в зоне доступности `ru-central1-e`:

      ```bash
      yc vpc subnet create \
         --folder-id <идентификатор_каталога> \
         --name <название_подсети> \
         --zone ru-central1-e \
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
         --master-location subnet-id=<идентификатор_подсети_a>,zone=ru-central1-a \
         --master-location subnet-id=<идентификатор_подсети_d>,zone=ru-central1-d \
         --master-location subnet-id=<идентификатор_новой_подсети>,zone=ru-central1-e
      ```

      Где:

      * `--folder-id` — идентификатор каталога. Необязательный параметр, если каталог задан в профиле CLI.
      * `--id` — [идентификатор кластера](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-list.md). Обязательный параметр.
      * `--master-location` — параметры размещения мастера. Укажите три раза, по одному для каждой зоны:
        * `subnet-id` — идентификатор подсети.
        * `zone` — зона доступности.

        Для зон `ru-central1-a` и `ru-central1-d` укажите текущие подсети, для `ru-central1-e` — новую.

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   {% include [master-tf-mifration-warning](../../_includes/managed-kubernetes/master-tf-mifration-warning.md) %}

   1. Если в конфигурации кластера используется блок `regional`, замените его тремя блоками `master_location`, сохранив текущие значения зон и подсетей. Если блоки `master_location` уже используются, переходите к созданию новой подсети.

      Ниже показаны фрагменты конфигурации. Сохраните имя ресурса в конфигурации и остальные параметры ресурса `yandex_kubernetes_cluster` без изменений.

      **Старый формат**:

      ```hcl
      resource "yandex_kubernetes_cluster" "k8s-cluster" {
         ...
         master {
            ...
            regional {
               region = "ru-central1"
               location {
                  subnet_id = yandex_vpc_subnet.my-subnet-a.id
                  zone      = yandex_vpc_subnet.my-subnet-a.zone
               }
               location {
                  subnet_id = yandex_vpc_subnet.my-subnet-d.id
                  zone      = yandex_vpc_subnet.my-subnet-d.zone
               }
               location {
                  subnet_id = yandex_vpc_subnet.my-subnet-b.id
                  zone      = yandex_vpc_subnet.my-subnet-b.zone
               }
            }
         }
         ...
      }
      ```       

      **Новый формат**: 

      ```hcl
      resource "yandex_kubernetes_cluster" "k8s-cluster" {
         ...
         master {
            ...
            master_location {
               subnet_id = yandex_vpc_subnet.my-subnet-a.id
               zone      = yandex_vpc_subnet.my-subnet-a.zone
            }
            master_location {
               subnet_id = yandex_vpc_subnet.my-subnet-d.id
               zone      = yandex_vpc_subnet.my-subnet-d.zone
            }
            master_location {
               subnet_id = yandex_vpc_subnet.my-subnet-b.id
               zone      = yandex_vpc_subnet.my-subnet-b.zone
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
      resource "yandex_vpc_subnet" "my-subnet-e" {
         name           = "<название_подсети>"
         zone           = "ru-central1-e"
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
               subnet_id = yandex_vpc_subnet.my-subnet-d.id
               zone      = yandex_vpc_subnet.my-subnet-d.zone
            }
            master_location {
               subnet_id = yandex_vpc_subnet.my-subnet-e.id
               zone      = yandex_vpc_subnet.my-subnet-e.zone
            }
            ...
         }
      ...
      }
      ```

      Для кластера подсеть `my-subnet-b` заменяется на подсеть `my-subnet-e` с параметрами:

      * `name` — название подсети.
      * `zone` — зона доступности.
      * `network_id` — идентификатор сети, в которую входит новая подсеть.
      * `v4_cidr_blocks` — список IPv4-адресов, откуда или куда будет поступать трафик. Например, `10.0.0.0/22` или `192.168.0.0/16`. Адреса должны быть уникальными внутри сети. Минимальный размер подсети — `/28`, а максимальный размер подсети — `/16`. Поддерживается только IPv4.

   1. Проверьте корректность конфигурационного файла.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Подтвердите изменение ресурсов. Перед применением убедитесь, что план не содержит удаления или пересоздания кластера и его групп узлов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   Подробная информация о параметрах ресурса `yandex_kubernetes_cluster` приведена в [документации провайдера]({{ tf-provider-resources-link }}/kubernetes_cluster).

{% endlist %}

### Восстановите доступность вебхуков Cilium {#cilium-webhooks}

После миграции мастера в кластерах с Cilium могут стать недоступны мутирующие и валидирующие вебхуки (Mutating/Validating Webhook) со стороны перенесенного мастера.

Если вы столкнулись с этой проблемой:

1. [Подключитесь к кластеру](../../managed-kubernetes/operations/connect/index.md#kubectl-connect) с помощью {{ k8s }} CLI (kubectl).
1. Получите список объектов `CiliumNode`:

   ```bash
   kubectl get ciliumnodes
   ```

1. Найдите объект старого мастера из исходной зоны доступности. Например, при переносе из `ru-central1-b` его имя имеет вид `mk8s-master-<идентификатор>-b`.
1. Удалите только объект `CiliumNode`, который относится к старому мастеру:

   ```bash
   kubectl delete ciliumnode <имя_объекта_старого_мастера>
   ```

1. Проверьте, восстановилась ли доступность вебхуков. Если проблема сохраняется, обратитесь в [техническую поддержку]({{ link-console-support }}).

## Перенесите группу узлов и рабочую нагрузку в подах в другую зону доступности {#transfer-a-node-group}

[Подготовьте группу узлов](#prepare), после чего выполните миграцию одним из способов:

* Миграция непосредственно группы узлов в новую зону доступности. Зависит от вида рабочей нагрузки в подах:

   * [Stateless-нагрузка](#stateless) — работа приложений в подах во время миграции зависит от распределения нагрузки между узлами кластера. Если поды находятся в мигрирующей группе узлов и группах, для которых не меняется зона доступности, приложения продолжают работать. Если поды находятся только в мигрирующей группе, поды и приложения в них придется остановить на короткий срок.

      Примеры stateless-нагрузки: веб-сервер, [Ingress-контроллер](../../application-load-balancer/tools/k8s-ingress-controller/index.md) {{ alb-full-name }}, приложение REST API.

   * [Stateful-нагрузка](#stateful) — независимо от распределения нагрузки между узлами кластера поды и приложения придется остановить на короткий срок.

      Примеры stateful-нагрузки: базы данных, хранилища.

* [Постепенная миграция stateless- и stateful-нагрузки](#gradual-migration) в новую группу узлов. Заключается в создании новой группы узлов в новой зоне доступности и постепенном отключении старых узлов. Так вы можете контролировать перенос нагрузки.

### Подготовительные действия {#prepare}

1. Проверьте, используются ли стратегии `nodeSelector`, `affinity` или `topology spread constraints` для привязки подов к узлам группы. Подробнее о стратегиях смотрите в [документации {{ k8s }}](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/) и разделе [{#T}](../../managed-kubernetes/concepts/usage-recommendations.md#high-availability). Чтобы проверить привязку пода к узлам и убрать ее:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог с вашим кластером {{ managed-k8s-name }}.
      1. [Перейдите]({{ link-console-main }}/link/managed-kubernetes) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
      1. Выберите кластер {{ managed-k8s-name }}.
      1. Перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_workloads }}**, затем **{{ ui-key.yacloud.k8s.workloads.label_pods }}**.
      1. Выберите под и перейдите на вкладку **{{ ui-key.yacloud.k8s.workloads.label_tab-yaml }}**.
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

   Так вы выключите поды, которые используют диски. При этом сохранится объект API {{ k8s }} [PersistentVolumeClaim](../../managed-kubernetes/concepts/volume.md#persistent-volume) (PVC).

1. Для объекта [PersistentVolume](../../managed-kubernetes/concepts/volume.md#persistent-volume) (PV), связанного с `PersistentVolumeClaim`, измените значение параметра `persistentVolumeReclaimPolicy` с `Delete` на `Retain`, чтобы предотвратить случайную потерю данных.

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

1. Создайте [снапшот](../../glossary/snapshot.md) — копию диска `PersistentVolume` на определенный момент времени. Подробнее о механизме снапшотов смотрите в [документации Kubernetes](https://kubernetes.io/docs/concepts/storage/volume-snapshots/).

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
          1. [Перейдите]({{ link-console-main }}/link/managed-kubernetes) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
          1. Выберите кластер {{ managed-k8s-name }}.
          1. Перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_storage }}**, затем **{{ ui-key.yacloud.k8s.storage.label_pv }}**.
          1. Найдите объект `new-pv-test-<номер>`.

              У найденного объекта посмотрите значение поля **{{ ui-key.yacloud.k8s.pv.overview.label_zone }}**. В нем должна отображаться зона доступности. Прочерк означает, что нет привязки к зоне доступности.

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

Ниже представлена инструкция по постепенной миграции нагрузки из старой группы узлов в новую. Инструкцию по миграции объектов `PersistentVolume` и `PersistentVolumeClaim` смотрите в подразделе [Миграция stateful-нагрузки](#stateful).

1. [Создайте новую группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md) {{ managed-k8s-name }} в новой зоне доступности.

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

1. [Удалите старую группу узлов](../../managed-kubernetes/operations/node-group/node-group-delete.md).
