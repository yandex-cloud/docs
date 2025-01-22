Чтобы создать виртуальную машину из публичного образа [DSVM](/marketplace/products/f2e4v304qn35mhilnsbc):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** на вкладке **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** выберите образ [DSVM](/marketplace/products/yc/dsvm).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. (Опционально) В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** настройте загрузочный [диск](../concepts/disk.md):

      * Выберите [тип диска](../concepts/disk.md#disks_types).
      * Задайте нужный размер диска.

  1. {% include [section-storages-filesystem](../../_includes/compute/create/section-storages-filesystem.md) %}
  1. {% include [section-platform](../../_includes/compute/create/section-platform.md) %}
  1. {% include [network-settings](../../_includes/compute/create/section-network.md) %}
  1. {% include [section-access](../../_includes/compute/create/section-access.md) %}
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ:

      {% include [name-format](../../_includes/name-format.md) %}

      {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

  1. {% include [section-additional](../../_includes/compute/create/section-additional.md) %}
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  Виртуальная машина появится в списке. При создании виртуальной машине назначаются [IP-адрес](../../vpc/concepts/address) и [имя хоста](../../vpc/concepts/address.md#fqdn) (FQDN).

{% endlist %}
