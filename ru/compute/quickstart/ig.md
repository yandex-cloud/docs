# Создание группы виртуальных машин

Создайте группу ВМ с помощью компонента [Instance Groups](../concepts/instance-groups/index.md) в консоли управления {{ yandex-cloud }}.

## Перед началом работы {#before-you-begin}

1. Войдите в [консоль управления]({{ link-console-main }}) или зарегистрируйтесь. Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. [На странице биллинга]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../../resource-manager/operations/folder/create.md).

## Создайте группу виртуальных машин {#create-ig}

Вы можете создать автоматически масштабируемую группу или группу с фиксированным количеством ВМ. Подробнее читайте в разделе [{#T}](../concepts/instance-groups/scale.md).

{% include [warning.md](../../_includes/instance-groups/warning.md) %}

Чтобы создать группу виртуальных машин:
1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана группа виртуальных машин.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. На панели слева выберите ![image](../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.compute.groups.button_create }}**.
1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_base }}**:
    * Введите имя и описание группы ВМ. Требования к имени:

        {% include [name-format](../../_includes/name-format.md) %}

        {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

    * Выберите [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) из списка или создайте новый. Чтобы иметь возможность создавать, обновлять и удалять виртуальные машины в группе, назначьте сервисному аккаунту роль `editor`. По умолчанию все операции в {{ ig-name }} выполняются от имени сервисного аккаунта.

      {% include [sa-dependence-brief](../../_includes/instance-groups/sa-dependence-brief.md) %}

1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_allocation }}** выберите нужные зоны доступности. Виртуальные машины группы могут находиться в разных зонах и регионах доступности. Подробнее о географии {{ yandex-cloud }} см. в разделе [Обзор платформы](../../overview/concepts/geo-scope.md).
1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_instance }}** нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}**, чтобы задать конфигурацию базовой виртуальной машины:
    * В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** введите описание базовой ВМ.
    * В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите публичный образ.
    * В блоке **{{ ui-key.yacloud.compute.instances.create.section_disk }}**:
        * Выберите [тип диска](../../compute/concepts/disk.md#disks_types).
        * Укажите размер диска.
        * (опционально) Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.label_add-disk }}**, чтобы добавить дополнительные диски.
    * В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
        * Выберите [платформу](../../compute/concepts/vm-platforms.md).
        * Укажите [гарантированную долю](../../compute/concepts/performance-levels.md) и необходимое количество vCPU, а также объем RAM.
        * (опционально) Укажите, что виртуальная машина должна быть [прерываемой](../../compute/concepts/preemptible-vm.md).
    * В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
        * Выберите [облачную сеть](../../compute/concepts/vm.md#network) и [подсеть](../../compute/concepts/network.md#subnet). Если подсети нет, создайте ее:
            * Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create-subnetwork-new }}**.
            * Введите имя и описание новой подсети, укажите зону доступности и CIDR.
            * Нажмите кнопку **{{ ui-key.yacloud.component.vpc.create-subnetwork-dialog.button_create }}**.
        * В поле **{{ ui-key.yacloud.compute.instances.create.field_instance-group-address }}** выберите способ назначения адреса:
            * `{{ ui-key.yacloud.compute.instances.create.value_address-auto }}` — чтобы назначить случайный IP-адрес из пула адресов {{ yandex-cloud }}.
            * `{{ ui-key.yacloud.compute.instances.create.value_address-none }}` — чтобы не назначать публичный IP-адрес.
        * (опционально) Выберите [группу безопасности](../../vpc/concepts/security-groups.md). Если группы безопасности нет, создайте ее:
            * Нажмите кнопку ![image](../../_assets/plus-sign.svg) **{{ ui-key.yacloud.component.vpc-security-group-select.label_add-security-group }}**.
            * Введите имя и описание группы безопасности. Правила для группы безопасности вы сможете добавить позже в сервисе **{{ vpc-name }}**.
            * Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

            {% include [security-groups-note-vm](../../_includes/vpc/security-groups-note-vm.md) %}

    * В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}**:
        * Выберите [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) из списка или создайте новый.
        * Если вы выбрали публичный образ на базе Linux:
            * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.
            * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла открытого ключа. Пару ключей для подключения по [SSH](../../glossary/ssh-keygen.md) необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
        * Если вы выбрали публичный образ на базе Windows:
            * В поле **{{ ui-key.yacloud.common.password }}** задайте пароль пользователя `Administrator`. Пользователь с именем `Administrator` создается автоматически.
        * Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
        * Если требуется, разрешите доступ к [серийной консоли](../operations/serial-console/index.md).
    * Нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_deploy }}** укажите:
    * **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-expansion }}** — на какое количество виртуальных машин можно превышать размер группы.
    * **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-unavailable }}** — на какое количество виртуальных машин можно уменьшать размер группы.
    * **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-creating }}** — сколько виртуальных машин можно одновременно создавать.
    * **{{ ui-key.yacloud.compute.groups.create.field_deploy-startup-duration }}** — время запуска, после которого ВМ начнет получать нагрузку.
    * **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-deleting }}** — сколько виртуальных машин можно одновременно останавливать.
    * **{{ ui-key.yacloud.compute.groups.create.field_deploy-strategy }}** — стратегию остановки машины: `{{ ui-key.yacloud.compute.groups.create.value_strategy-proactive }}` или `{{ ui-key.yacloud.compute.groups.create.value_strategy-opportunistic }}`.

        Подробнее читайте в разделе [{#T}](../concepts/instance-groups/policies/deploy-policy.md).
1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_scale }}**:
    * Выберите [тип масштабирования](../../compute/concepts/instance-groups/scale.md).
    * Если вы выбрали `{{ ui-key.yacloud.compute.groups.create.value_scale-fixed }}`, укажите размер группы.
    * Если вы выбрали `{{ ui-key.yacloud.compute.groups.create.value_scale-auto }}`, укажите:
        * Минимальное количество ВМ в одной зоне доступности.
        * Максимальный размер группы.
        * Промежуток измерения нагрузки — период, за который следует усреднять замеры нагрузки для каждой ВМ в группе.
        * Время на разогрев ВМ, в течение которого созданная ВМ не учитывается при замере средней нагрузки на группу.
        * Период стабилизации, в течение которого требуемое количество ВМ в группе не может быть снижено.
        * Начальный размер группы — количество ВМ, которые создаются вместе с группой.
    * Если вы выбрали `{{ ui-key.yacloud.compute.groups.create.value_scale-fixed-test-auto }}`, укажите размеры группы и параметры для автоматического масштабирования. Автоматическое масштабирование группы в данном типе работает в экспериментальном режиме.
1. Если ранее вы выбрали `{{ ui-key.yacloud.compute.groups.create.value_scale-auto }}` тип масштабирования, то в блоке **{{ ui-key.yacloud.compute.groups.create.label_custom-metrics }}** укажите целевой уровень загрузки CPU в процентах.
1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_ylb }}**:
    * (опционально) Нажмите переключатель **{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}**. [Целевые группы](../../network-load-balancer/concepts/target-resources.md) нужны для распределения нагрузки [сетевым балансировщиком](../../network-load-balancer/concepts/index.md).
        * Введите имя и описание целевой группы.
1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_health-check }}**:
    * (опционально) Нажмите переключатель **{{ ui-key.yacloud.compute.groups.create.field_enable-health-check }}**.
       * Выберите тип проверки: `HTTP` или `TCP`.
       * Укажите путь, по которому будут выполняться проверки.
       * Укажите порт из диапазона 1-32767.
       * Укажите время ожидания ответа в секундах.
       * Укажите интервал отправки проверок состояния в секундах.
       * Укажите порог работоспособности — количество успешных проверок, после которого ВМ будет считаться готовой к приему трафика.
       * Укажите порог неработоспособности — количество проваленных проверок, после которого на ВМ перестанет подаваться трафик.
1. Нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_create }}**.

Группа виртуальных машин появится в списке.

## Что дальше {#what-is-next}

* Посмотрите [сценарии создания веб-сервисов в {{ yandex-cloud }}](../../tutorials/web/index.md).
* Узнайте, [как работать с группами виртуальных машин](../operations/index.md).
* Прочитайте [ответы на часто задаваемые вопросы](../qa/general.md).
