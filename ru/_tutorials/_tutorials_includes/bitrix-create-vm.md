{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите пункт **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
     * В поле **{{ ui-key.yacloud.common.name }}** введите имя ВМ, например, `bitrixwebsite`.
     * В поле **{{ ui-key.yacloud.compute.instances.create.field_zone }}** выберите `{{ region-id }}-a`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** и нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**. Выберите образ операционной системы [Ubuntu 22.04 lts](/marketplace/products/yc/ubuntu-22-04-lts).
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** выберите жесткий диск `{{ ui-key.yacloud.compute.value_disk-type-network-ssd }}` и укажите размер `24 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** и укажите конфигурацию:
     * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
     * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
     * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `20%`.
     * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `4 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
     * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите созданную ранее подсеть `subnet-a`.
     * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** оставьте значение `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, чтобы назначить ВМ случайный публичный IP-адрес из пула {{ yandex-cloud }}, или выберите статический адрес из списка, если вы зарезервировали его заранее.
     * В поле **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** выберите группу безопасности `bitrix-sg-vm`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа к ВМ:
     * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя, который будет создан на ВМ, например `ubuntu`.
     * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** скопируйте ваш открытый [SSH-ключ](../../glossary/ssh-keygen.md). Пару ключей для подключения по SSH необходимо создать [самостоятельно](../../compute/operations/vm-connect/ssh.md).
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  В процессе работы вам может потребоваться сохранять [снимки диска](../../compute/operations/disk-control/create-snapshot.md) ВМ. Они содержат копию файловой системы ВМ на момент создания снимка.

  Вы можете использовать снимки для различных целей, например:
  * Перенос данных с одного диска на другой — например, на диск в другой зоне доступности.
  * Создание [резервной копии](../../compute/concepts/backups.md) диска перед операциями, которые могут повлечь повреждение данных.
  * Версионирование диска путем [регулярного создания снимков диска](../../compute/operations/disk-control/configure-schedule.md).

{% endlist %}