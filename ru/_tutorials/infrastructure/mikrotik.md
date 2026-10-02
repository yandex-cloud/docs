# Установка виртуального роутера Mikrotik CHR

В {{ yandex-cloud }} можно развернуть виртуальный роутер Mikrotik Cloud Hosted Router из готового образа ВМ. Чтобы установить Mikrotik Cloud Hosted Router и проверить его работу:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте группу безопасности](#create-security-group).
1. [Создайте ВМ с Mikrotik Cloud Hosted Router](#create-router).
1. [Зайдите на ВМ и смените пароль](#change-password).
1. [Создайте тестовую ВМ](#create-test-vm).
1. [Проверьте связь роутера и тестовой ВМ](#test-connection).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% note alert %}

Пропускная способность роутера при использовании образа Mikrotik Cloud Hosted Router без лицензии ограничена 1 Мбит/с. Чтобы снять ограничение, [установите лицензию](https://help.mikrotik.com/docs/spaces/ROS/pages/18350234/Cloud+Hosted+Router+CHR#CloudHostedRouter,CHR-CHRLicensing).

{% endnote %}

В стоимость использования виртуального роутера и тестовой ВМ входят:

* плата за диски и постоянно запущенные виртуальные машины ([тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование публичного IP-адреса ([тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

## Создайте группу безопасности {#create-security-group}

Чтобы в дальнейшем открыть веб-интерфейс Mikrotik Cloud Hosted Router из браузера, создайте [группу безопасности](../../vpc/concepts/security-groups.md) и разрешите входящие подключения по HTTP на порт `80`. Для безопасности разрешите подключение только с вашего текущего публичного IP-адреса. Также разрешите весь исходящий трафик, чтобы роутер мог обращаться к внешним ресурсам, в том числе к серверу лицензирования:

1. [Узнайте](https://2ip.io) публичный IP-адрес компьютера или сети, с которой будете подключаться к роутеру.
1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется создать группу безопасности.
1. [Перейдите]({{ link-console-main }}/link/vpc) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
1. На панели слева выберите ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
1. Введите имя группы безопасности: `mikrotik-router-group`.
1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** выберите сеть, которой будет назначена группа безопасности. Если нужной [сети](../../vpc/concepts/network.md#network) еще нет, [создайте ее](../../vpc/operations/network-create.md).
1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}** и в открывшемся окне укажите параметры нового правила:

   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-direction }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-direction-ingress }}`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `80`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `TCP`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `<ваш_публичный_IP-адрес>/32`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}** — `Mikrotik Router`.

1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
1. Повторно нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}** и укажите параметры исходящего правила:

   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-direction }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-direction-egress }}`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.button_select-all-port-range }}`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}** — `Mikrotik Router Egress`.

1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

## Создайте ВМ с Mikrotik Cloud Hosted Router {#create-router}

1. На странице [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления]({{ link-console-main }}) нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** в поле **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** введите `Cloud Hosted Router` и выберите публичный образ [Cloud Hosted Router](/marketplace/products/yc/cloud-hosted-router).
1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет создана ВМ. Если вы не знаете, какая зона доступности вам нужна, оставьте выбранную по умолчанию.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` и укажите необходимую [платформу](../../compute/concepts/vm-platforms.md), количество vCPU и объем RAM:

    * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
    * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
    * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `100%`.
    * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `2 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

    * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите сеть, которой была назначена созданная ранее группа безопасности `mikrotik-router-group`, и подсеть. Если нужной [подсети](../../vpc/concepts/network.md#subnet) еще нет, [создайте ее](../../vpc/operations/subnet-create.md).
    * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** оставьте значение `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, чтобы назначить ВМ случайный внешний IP-адрес из пула {{ yandex-cloud }}, или выберите статический адрес из списка, если вы зарезервировали его заранее.
    * В поле **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** выберите группу `mikrotik-router-group`.

1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа на ВМ:

    * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя. Не используйте имя `root` или другие имена, зарезервированные ОС.
    * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

    Обратите внимание, что эти данные нужны только для создания ВМ, их нельзя использовать для доступа к роутеру.

1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `mikrotik-router`.
1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

Создание виртуальной машины может занять несколько минут. Когда виртуальная машина перейдет в статус `RUNNING`, вы можете зайти на нее.

{% note alert %}

Сразу после создания ВМ задайте сложный пароль администратора. Чтобы сохранить доступ к роутеру, нужно изменить пароль администратора в течение 5 минут после запуска.

{% endnote %}


## Смените на роутере пароль администратора {#change-password}

Роутер создается с публичным IP-адресом, поэтому для безопасности необходимо изменить пароль администратора, установленный по умолчанию.

1. В [консоли управления]({{ link-console-main }}) выберите каталог.
1. [Перейдите]({{ link-console-main }}/link/compute) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. Скопируйте публичный IP-адрес виртуальной машины `mikrotik-router` и откройте его в браузере.
1. На открывшейся странице в поле **IP Address** введите внутренний IP-адрес виртуальной машины.
1. В поле **Password** введите новый пароль администратора, подтвердите его в поле **Confirm Password** и нажмите кнопку **Apply Configuration**. Все остальные настройки можно задать позже.


## Создайте тестовую ВМ {#create-test-vm}

Создайте тестовую ВМ в одной подсети с роутером, чтобы проверить возможность подключения между роутером и ВМ.

1. На странице [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления]({{ link-console-main }}) нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** в поле **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** введите `Ubuntu` и выберите публичный образ [Ubuntu](/marketplace?tab=software&search=Ubuntu&categories=os).
1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите ту же [зону доступности](../../overview/concepts/geo-scope.md), в которой находится ВМ `mikrotik-router`.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` и укажите необходимую [платформу](../../compute/concepts/vm-platforms.md), количество vCPU и объем RAM:

    * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
    * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
    * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `20%`.
    * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `1 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

    * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите сеть и подсеть, в которых находится ВМ `mikrotik-router`.
    * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`.

1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа на ВМ:

    * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
    * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `test-vm`.
1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.


### Проверьте связь роутера и тестовой ВМ {#test-connection}

{% note alert %}

Если вы используете для доступа к роутеру программу WinBox, подключайтесь к роутеру через IP-адрес ВМ. Доступ через MAC-адрес не поддерживается в {{ yandex-cloud }}.

{% endnote %}

Убедитесь, что есть сетевое соединение между роутером и тестовой ВМ:

1. Откройте административный интерфейс роутера в браузере.
1. Введите логин: `admin`.
1. Введите указанный ранее пароль администратора.
1. Нажмите кнопку **Terminal**.
1. В открывшемся терминале выполните команду `ping <внутренний_IP-адрес_тестовой_ВМ>`.

Если пакеты доходят до тестовой ВМ, можно переходить к настройке роутера. О работе с роутером читайте в [документации Mikrotik](https://wiki.mikrotik.com/wiki/Main_Page).


## Удалите созданные ресурсы {#clear-out}

Чтобы перестать платить за развернутые ресурсы:

1. [Удалите](../../compute/operations/vm-control/vm-delete.md) виртуальные машины `mikrotik-router` и `test-vm`.
1. [Удалите](../../vpc/operations/security-group-delete.md) группу безопасности `mikrotik-router-group`.
1. [Удалите](../../vpc/operations/address-delete.md) публичный статический IP-адрес, если вы его зарезервировали.
