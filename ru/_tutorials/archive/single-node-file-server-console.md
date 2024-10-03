1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте группу безопасности](#create-security-group).
1. [Создайте виртуальную машину для файлового сервера](#create-vm).
1. [Настройте Samba и NFS](#setup-samba-nfs).
1. [Протестируйте работу файлового сервера](#test-file-server).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/single-node-file-server/paid-resources.md) %}

### Подготовьте сетевую инфраструктуру {#deploy-infrastructure}

1. Перейдите в [консоль управления]({{ link-console-main }}) {{ yandex-cloud }} и выберите каталог, в котором будете выполнять операции.
1. Убедитесь, что в выбранном каталоге есть сеть с подсетью, к которой можно подключить виртуальную машину. Для этого на странице каталога выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**. Если в списке есть сеть — нажмите на нее, чтобы увидеть доступные подсети. Если ни одной подсети или сети нет, [создайте их](../../vpc/quickstart.md).

## Создайте группу безопасности {#create-security-group}

Чтобы создать [группу безопасности](../../vpc/concepts/security-groups.md) для файлового сервера:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Откройте вкладку **{{ ui-key.yacloud.vpc.switch_security-groups }}**.
  1. Создайте группу безопасности:

     1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
     1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** укажите имя группы: `fileserver-sg`.
     1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** выберите сеть, в которой расположена ВМ `fileserver-tutorial`.
     1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** создайте следующие правила по инструкции под таблицей:

        | Направление<br/>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
        | --- | --- | --- | --- | --- | --- |
        | Исходящий | `any` | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
        | Входящий | `ssh` | `22` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
        | Входящий | `ext-http` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
        | Входящий | `ext-https` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
        | Входящий | `nfs` | `2049` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |

        1. Выберите вкладку **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** или **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}**.
        1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
        1. В открывшемся окне в поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** укажите один порт или диапазон портов, куда или откуда будет поступать трафик. Чтобы открыть все порты, нажмите **{{ ui-key.yacloud.vpc.network.security-groups.forms.button_select-all-port-range }}**.
        1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** укажите нужный протокол или оставьте **{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}**, чтобы разрешить передачу трафика по всем протоколам.
        1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** или **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** выберите `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` — правило будет применено к диапазону IP-адресов. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** укажите `0.0.0.0/0`.
        1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**. Таким образом создайте все правила из таблицы.

     1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Создайте виртуальную машину для файлового сервера {#create-vm}

Чтобы создать виртуальную машину:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.  
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите публичный образ [Ubuntu](/marketplace?tab=software&search=Ubuntu&categories=os).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. Добавьте дополнительный [диск](../../compute/concepts/disk.md) для хранения данных:

      * В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** нажмите кнопку **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.
      * В открывшемся окне выберите **{{ ui-key.yacloud.compute.instances.create-disk.value_source-disk }}**.
      * Выберите `Создать новый` и укажите параметры:

          * **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** — `{{ ui-key.yacloud.compute.instances.create-disk.value_source-none }}`.
          * **{{ ui-key.yacloud.compute.instances.create-disk.field_name }}** — `fileserver-tutorial-disk`.
          * **{{ ui-key.yacloud.compute.disk-form.field_type }}** — `{{ ui-key.yacloud.compute.value_disk-type-network-ssd }}`.
          * **{{ ui-key.yacloud.compute.disk-form.field_size }}** — `100 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

      * Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.label_add-disk }}**.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}**, выберите [платформу](../../compute/concepts/vm-platforms.md) и укажите рекомендуемые параметры для файлового сервера:

      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `8` или больше.
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `100%`.
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `56 {{ ui-key.yacloud.common.units.label_gigabyte }}` или больше.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** укажите идентификатор подсети в зоне доступности создаваемой ВМ или выберите [облачную сеть](../../vpc/concepts/network.md#network) из списка.

          * У каждой сети должна быть как минимум одна [подсеть](../../vpc/concepts/network.md#subnet). Если подсети нет, создайте ее, выбрав **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
          * Если сети нет, нажмите **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** и создайте ее:

              * В открывшемся окне укажите имя сети и выберите каталог, в котором она будет создана.
              * (Опционально) Выберите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**, чтобы автоматически создать подсети во всех зонах доступности.
              * Нажмите **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, чтобы назначить виртуальной машине случайный внешний IP-адрес из пула {{ yandex-cloud }}, или выберите статический адрес из списка, если вы зарезервировали его заранее.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** выберите созданную ранее группу безопасности `fileserver-sg`.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа к ВМ:

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя, который будет создан на виртуальной машине, например `ubuntu`.

        {% note alert %}

        Не используйте логин `root` или другие имена, зарезервированные операционной системой. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.

        {% endnote %}

      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `fileserver-tutorial`.
  1. Нажмите **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}

Создание ВМ может занять несколько минут. Когда ВМ перейдет в статус `RUNNING`, скопируйте публичный IP-адрес: он будет указан на странице ВМ в блоке **Сеть**. IP-адрес потребуются далее, чтобы [настроить NFS и Samba](#setup-samba-nfs).

## Настройте Samba и NFS {#setup-samba-nfs}

{% include [setup-samba-nfs](../_tutorials_includes/single-node-file-server/setup-samba-nfs.md) %}

## Протестируйте работу файлового сервера {#test-file-server}

{% include [single-node-file-server](../_tutorials_includes/single-node-file-server/test-file-server.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите ВМ](../../compute/operations/vm-control/vm-delete.md).
1. [Удалите статический публичный IP-адрес](../../vpc/operations/address-delete.md), если вы его зарезервировали.