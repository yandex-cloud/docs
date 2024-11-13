1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте ВМ с платформой OpenCart](#create-vm).
1. [(опционально) Создайте кластер БД {{ MY }}](#create-mysql).
1. [Настройте OpenCart](#configure-opencart).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [opencart-paid-resources](../_tutorials_includes/opencart-paid-resources.md) %}

## Создайте ВМ с платформой OpenCart {#create-vm}

На загрузочном диске ВМ будет предустановлена платформа OpenCart и необходимые для ее работы компоненты, включая PHP и {{ MY }}.

Чтобы создать ВМ:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. В списке сервисов выберите **{{ compute-short-name }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **Виртуальные машины**.
  1. Нажмите кнопку **Создать виртуальную машину**.  
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** в поле **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** введите `OpenCart` и выберите публичный образ [OpenCart](/marketplace/products/yc/opencart-3).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** настройте загрузочный [диск](../../compute/concepts/disk.md):

      * Выберите [тип диска](../../compute/concepts/disk.md#disks_types) `{{ ui-key.yacloud.compute.value_disk-type-network-ssd }}`.
      * Задайте размер диска `13 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` и укажите необходимую [платформу](../../compute/concepts/vm-platforms.md), количество vCPU и объем RAM:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `20%`.
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `4 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** укажите идентификатор подсети в зоне доступности создаваемой ВМ или выберите [облачную сеть](../../vpc/concepts/network.md#network) из списка.

          * У каждой сети должна быть как минимум одна [подсеть](../../vpc/concepts/network.md#subnet). Если подсети нет, создайте ее, выбрав **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
          * Если сети нет, нажмите **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** и создайте ее:

              * В открывшемся окне укажите имя сети и выберите каталог, в котором она будет создана.
              * (Опционально) Выберите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**, чтобы автоматически создать подсети во всех зонах доступности.
              * Нажмите **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, чтобы назначить случайный IP-адрес из пула адресов {{ yandex-cloud }}, или выберите статический адрес из списка, если вы зарезервировали его заранее.

    1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа к ВМ:

        * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите предпочтительное имя пользователя, который будет создан на ВМ, например, `ubuntu`.
        * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** введите имя ВМ, например `opencart`. Требования к имени:

      {% include [name-format](../../_includes/name-format.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
  1. Получите [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses) ВМ — он потребуется далее, чтобы [настроить OpenCart](#configure-opencart). Публичный IP-адрес можно узнать в консоли управления в поле **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** блока **{{ ui-key.yacloud.compute.instance.overview.section_network }}** на странице ВМ.

{% endlist %}

Если вы рассчитываете на существенную нагрузку на БД, или хотели бы использовать сервис управляемых СУБД, то [создайте кластер БД](#create-mysql) с помощью сервиса {{ mmy-name }}. Если нет — [настройте OpenCart](#configure-opencart).

## Создайте кластер БД {{ MY }} {#create-mysql}

Сервис {{ mmy-name }} берет на себя поддержку и обслуживание СУБД, в том числе мониторинг ее состояния и текущей активности, автоматическое создание резервных копий и легко настраиваемую отказоустойчивость.

Если необходимости в кластере нет, пропустите этот шаг и [настройте OpenCart](#configure-opencart).

Чтобы создать кластер БД:

{% list tabs %}

- Консоль управления

  1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите пункт **Кластер {{ MY }}**.
  1. Укажите имя кластера, например, `opencart`.
  1. В блоке **Класс хоста** выберите `s2.micro`. Данных характеристик хватит для работы системы без особых нагрузок.
  1. В блоке **База данных** укажите:
     * **Имя БД** — оставьте значение по умолчанию, `db1`.
     * **Имя пользователя** для подключения к БД — оставьте значение по умолчанию, `user1`.
     * **Пароль**, который OpenCart будет использовать для доступа к БД {{ MY }}.
  1. В блоке **Хосты**, при необходимости поменяйте **Зону доступности**, в которой должна находиться БД. Для этого нажмите значок ![pencil](../../_assets/console-icons/pencil.svg) справа от текущей выбранной зоны доступности и выберите из выпадающего списка нужную.

     {% note tip %}

     Рекомендуется выбрать ту же зону доступности, которую вы выбрали при создании ВМ. Это позволит уменьшить задержку (latency) между ВМ и БД.

     {% endnote %}

  1. (опционально) Если вы хотите обеспечить отказоустойчивость БД, добавьте дополнительные хосты в кластер: для этого нажмите **Добавить хост** и укажите, в какой зоне доступности он должен быть размещен.
  1. Остальные поля оставьте без изменений.
  1. Нажмите кнопку **Создать кластер**.

{% endlist %}

Создание кластера БД может занять несколько минут. После создания [настройте OpenCart](#configure-opencart).

## Настройте OpenCart {#configure-opencart}

{% include [opencart-configure](../_tutorials_includes/opencart-configure.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../compute/operations/vm-control/vm-delete.md) ВМ `opencart`.
1. Если вы использовали БД {{ MY }}, то [удалите кластер {{ mmy-name }}](../../managed-mysql/operations/cluster-delete.md) (в примере кластер БД создается с именем `opencart`).

Если вы зарезервировали статический публичный IP-адрес специально для этой ВМ:
1. Выберите сервис **{{ vpc-short-name }}** в вашем каталоге.
1. Перейдите на вкладку **IP-адреса**.
1. Найдите нужный IP-адрес, нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите пункт **Удалить**.
