# Установка виртуального роутера Mikrotik CHR

В {{ yandex-cloud }} можно развернуть виртуальный роутер Mikrotik Cloud Hosted Router из готового образа ВМ. Чтобы установить Mikrotik Cloud Hosted Router и проверить его работу:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте ВМ с Mikrotik Cloud Hosted Router](#create-router).
1. [Зайдите на ВМ и смените пароль](#change-password).
1. [Создайте тестовую ВМ](#create-test-vm).
1. [Проверьте связь роутера и тестовой ВМ](#test-connection).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% note alert %}

Пропускная способность роутера при использовании образа Mikrotik Cloud Hosted Router без лицензии ограничена 1 Мбит/с. Чтобы снять ограничение, [установите лицензию](https://wiki.mikrotik.com/wiki/Manual:CHR#CHR_Licensing).

{% endnote %}

В стоимость использования виртуального роутера и тестовой ВМ входят:

* плата за диски и постоянно запущенные виртуальные машины (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование публичного IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md));


## Создайте ВМ с Mikrotik Cloud Hosted Router {#create-router}

1. В [консоли управления]({{ link-console-main }}) выберите каталог.
1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
   1. В поле **{{ ui-key.yacloud.compute.instances.create.field_name }}** укажите имя ВМ, например `mikrotik-router`.
   1. В поле **{{ ui-key.yacloud.compute.instances.create.field_zone }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой есть подсеть. Если вы не знаете, какая зона доступности вам нужна, оставьте выбранную по умолчанию.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** и выберите образ [Cloud Hosted Router](/marketplace/products/yc/cloud-hosted-router).
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** укажите параметры:
   * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
   * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
   * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `100%`.
   * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `1 ГБ`.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}** выберите нужную сеть, подсеть и назначьте ВМ публичный IP-адрес из списка или автоматически. Если у вас нет сети и подсети, их можно создать на экране создания ВМ.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}**:
   1. В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** укажите имя пользователя.
   1. В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла с публичным [SSH-ключом](../../glossary/ssh-keygen.md). Пару ключей для подключения по SSH необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.

      Обратите внимание, что эти данные нужны только для создания ВМ, их нельзя использовать для доступа к роутеру.

1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

Создание виртуальной машины может занять несколько минут. Когда виртуальная машина перейдет в статус `RUNNING`, вы можете зайти на нее.

{% note alert %}

Сразу после создания ВМ задайте сложный пароль администратора.

{% endnote %}

## Смените на роутере пароль администратора {#change-password}

Роутер создается с публичным IP-адресом, поэтому для безопасности необходимо изменить пароль администратора, установленный по умолчанию.

1. В [консоли управления]({{ link-console-main }}) выберите каталог.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. Скопируйте публичный IP-адрес виртуальной машины `mikrotik-router` и откройте его в браузере.
1. В поле **IP Address** введите внутренний IP-адрес виртуальной машины. 
1. На открывшейся странице введите новый пароль администратора, подтвердите его, и нажмите кнопку **Apply Configuration**. Все остальные настройки можно задать позже.

## Создайте тестовую ВМ {#create-test-vm}

Создайте тестовую ВМ в одной подсети с роутером, чтобы проверить возможность подключения между роутером и ВМ.

1. В [консоли управления]({{ link-console-main }}) выберите каталог.
1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
   1. В поле **{{ ui-key.yacloud.compute.instances.create.field_name }}** укажите имя ВМ, например `test-vm`.
   1. В поле **{{ ui-key.yacloud.compute.instances.create.field_zone }}** выберите ту же [зону доступности](../../overview/concepts/geo-scope.md), в которой находится ВМ `mikrotik-router`.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** и выберите образ [Ubuntu](/marketplace?tab=software&search=Ubuntu&categories=os).
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** укажите параметры:
   * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
   * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
   * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `20%`.
   * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `1 ГБ`.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
   1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите сеть и подсеть, в которых находится ВМ `mikrotik-router`.
   1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}**:
   1. В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** укажите имя пользователя.
   1. В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла с публичным [SSH-ключом](../../glossary/ssh-keygen.md).
1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

### Проверьте связь роутера и тестовой ВМ {#test-connection}

{% note alert %}

Если вы используете для доступа к роутеру программу WinBox, подключайтесь к роутеру через IP-адрес ВМ. Доступ через MAC-адрес не поддерживается в {{ yandex-cloud }}.

{% endnote %}

Убедитесь, что есть сетевое соединение между роутером и тестовой ВМ:

1. Откройте административный интерфейс роутера в браузере.
1. Нажмите кнопку **Terminal**.
1. В открывшемся терминале выполните команду `ping <внутренний IP-адрес тестовой ВМ>`.

Если пакеты доходят до тестовой ВМ, можно переходить к настройке роутера. О работе с роутером читайте в [документации Mikrotik](https://wiki.mikrotik.com/wiki/Main_Page).

## Удалите созданные ресурсы {#clear-out}

Чтобы перестать платить за развернутые ресурсы, [удалите](../../compute/operations/vm-control/vm-delete.md) виртуальные машины `mikrotik-router` и `test-vm`. 

Если вы зарезервировали публичный статический IP-адрес, [удалите его](../../vpc/operations/address-delete.md).
