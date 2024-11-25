1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** на вкладке **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** выберите один из [GPU-ориентированных образов](/marketplace?search=gpu) и версию операционной системы.

    {% include [gpu-os](../gpu-os.md) %}

1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
1. (Опционально) В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** настройте загрузочный [диск](../../../compute/concepts/disk.md):

    * Выберите [тип диска](../../../compute/concepts/disk.md#disks_types).
    * Задайте нужный размер диска.
    * {% include [encryption-section-secondary](../encryption-section-secondary.md) %}

        Если вы создаете ВМ из существующего загрузочного диска, измените настройки этого диска на вкладке **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** в блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** вверху формы.

1. {% include [section-storages-secondary-disk](section-storages-secondary-disk.md) %}
1. {% include [section-storages-filesystem](section-storages-filesystem.md) %}
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:

    * Перейдите на вкладку **{{ ui-key.yacloud.component.compute.resources.label_tab-gpu }}**.
    * Выберите одну из [платформ](../../../compute/concepts/vm-platforms.md#gpu-platforms):

        * {{ v100-broadwell }}
        * {{ v100-cascade-lake }}
        * {{ a100-epyc }}
        * {{ t4-ice-lake }}
        * {{ t4i-ice-lake }}

    * Выберите одну из предлагаемых конфигураций с необходимым количеством GPU, vCPU и объемом RAM.

1. {% include [network-settings](section-network.md) %}
1. {% include [section-access](section-access.md) %}

1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ:

    {% include [name-format](../../name-format.md) %}

    {% include [name-fqdn](../../compute/name-fqdn.md) %}

1. {% include [section-additional](section-additional.md) %}
1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

Виртуальная машина появится в списке.