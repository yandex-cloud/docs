Создайте [облачную сеть](../../../vpc/concepts/network.md#network) и [подсети](../../../vpc/concepts/network.md#subnet), необходимые для работы создаваемой облачной инфраструктуры:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете создавать инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. В правом верхнем углу нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_name }}** укажите имя сети `nextcloud-network`.
  1. Убедитесь, что опция **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** включена, и нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.

{% endlist %}