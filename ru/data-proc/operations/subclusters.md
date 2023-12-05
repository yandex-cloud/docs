# Управление подкластерами {{ dataproc-name }}

Помимо [изменения настроек](subcluster-update.md) отдельного подкластера вы можете создавать новые и удалять имеющиеся подкластеры.

{% note warning %}

В каждом кластере может быть не больше одного подкластера с хостом-мастером, поэтому создавать и удалять подкластеры с этой ролью невозможно. Также невозможно удалять подкластеры для хранения данных.

{% endnote %}

## Получить список подкластеров в кластере {#list-subclusters}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_subclusters }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы запросить список подкластеров в кластере {{ dataproc-name }}, выполните команду:

  ```bash
  {{ yc-dp }} subcluster list --cluster-name=<имя кластера>
  ```

  Имя кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list).

{% endlist %}

## Добавить подкластер {#add-subcluster}

Количество хостов в кластерах {{ dataproc-name }} ограничено [квотами]({{ link-console-quotas }}) на количество vCPU и объем памяти, которые могут использовать виртуальные машины в вашем облаке. Чтобы увидеть доступные ресурсы, откройте раздел [{{ ui-key.yacloud.iam.cloud.switch_quotas }}]({{ link-console-quotas }}) и найдите блок **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}** и выберите нужный кластер.
  1. Перейдите в раздел **{{ ui-key.yacloud.mdb.cluster.switch_subclusters }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.subclusters.button_create }}**.
  1. Укажите параметры подкластера:
     1. **{{ ui-key.yacloud.mdb.forms.base_field_hosts-count }}** — выберите количество хостов.
     1. **{{ ui-key.yacloud.mdb.forms.base_field_roles }}** — выберите роли подкластера в зависимости от того, какие сервисы должны быть развернуты на хостах:

         * `COMPUTENODE` — роль для обработки данных. В подкластерах с такой ролью могут быть развернуты YARN NodeManager и библиотеки Spark.
         * `DATANODE` — роль для хранения данных. В подкластерах с такой ролью могут быть развернуты YARN NodeManager и библиотеки Spark, а также HBase RegionServer и HDFS Datanode.

     1. В блоке [**{{ ui-key.yacloud.mdb.forms.section_resource }}**](../concepts/instance-types.md) — выберите платформу и вычислительные ресурсы, доступные хосту.
     1. В блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}** — укажите тип и размер хранилища.
     1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}**:

         * Выберите **{{ ui-key.yacloud.mdb.forms.network_field_form-type }}**.
         * Укажите **{{ ui-key.yacloud.mdb.forms.network_field_subnetwork }}** — подсеть сети, в которой расположен кластер.
         * (Опционально) Включите опцию **{{ ui-key.yacloud.mdb.forms.field_assign-public-ip }}** для доступа к хостам подкластера из интернета.

             Эту настройку невозможно изменить после создания подкластера.

             {% note tip %}

             Подкластеры для обработки данных можно удалить и создать заново с нужным значением этой настройки.

             {% endnote %}

     1. (Опционально) Включите опцию **{{ ui-key.yacloud.mdb.forms.label_autoscaling-activated }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create-subcluster }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать подкластер:
  1. Посмотрите описание команды CLI для создания подкластера:

     ```bash
     {{ yc-dp }} subcluster create --help
     ```

  1. Укажите параметры подкластера в команде создания (в примере приведены не все доступные параметры):

     ```bash
     {{ yc-dp }} subcluster create <имя подкластера> \
       --cluster-name=<имя кластера> \
       --role=<роль подкластера> \
       --resource-preset=<класс хоста> \
       --disk-type=<тип хранилища: network-ssd, network-hdd или network-ssd-nonreplicated> \
       --disk-size=<размер хранилища в гигабайтах> \
       --subnet-name=<имя подсети> \
       --hosts-count=<количество хостов>
     ```

     Где:
     * `--cluster-name` — имя кластера. Имя кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list).
     * `--role` — роль подкластера: `datanode` или `computenode`.
     * `--resource-preset` — [класс хостов](../concepts/instance-types.md).
     * `--disk-type` — [тип хранилища](../concepts/storage.md).
     * `--disk-size` — размер хранилища в гигабайтах.
     * `--subnet-name` — [имя подсети](../../vpc/concepts/network.md#subnet).
     * `--hosts-count` — количество хостов подкластера. Минимальное значение — `1`, максимальное — `32`.

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).
  1. Добавьте в описании кластера {{ dataproc-name }} блок `subcluster_spec` с параметрами нового подкластера:

     ```hcl
     resource "yandex_dataproc_cluster" "<имя кластера>" {
       ...
       cluster_config {
         ...
         subcluster_spec {
           name = "<имя подкластера>"
           role = "<роль подкластера: COMPUTENODE или DATANODE>"
           resources {
             resource_preset_id = "<класс хоста>"
             disk_type_id       = "<тип хранилища>"
             disk_size          = <объем хранилища, ГБ>
           }
           subnet_id   = "<идентификатор подсети в {{ TF }}>"
           hosts_count = <число хостов в подкластере>
           ...
         }
       }
     }
     ```

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/dataproc_cluster).

{% endlist %}

## Удалить подкластер {#remove-host}

{% note warning %}

Удалить подкластеры для хранения данных невозможно.

{% endnote %}

{% list tabs %}

- Консоль управления

  Чтобы удалить подкластер:
  1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}** и выберите нужный кластер.
  1. Перейдите в раздел **{{ ui-key.yacloud.mdb.cluster.switch_subclusters }}**.
  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) для нужного подкластера и выберите пункт **{{ ui-key.yacloud.mdb.cluster.subclusters.button_action-delete }}**.
  1. (Опционально) Укажите таймаут [декомиссии](../concepts/decommission.md).
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-remove-subcluster_button }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить подкластер в кластере {{ dataproc-name }}, выполните команду:

  ```bash
  {{ yc-dp }} subcluster delete <идентификатор или имя подкластера> \
    --cluster-name=<имя кластера>
  ```

  Идентификатор и имя подкластера можно получить со [списком подкластеров в кластере](#list-subclusters), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list).

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).
  1. Удалите из описания кластера {{ dataproc-name }} блок `subcluster_spec` нужного подкластера.
  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Введите слово `yes` и нажмите **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/dataproc_cluster).

{% endlist %}