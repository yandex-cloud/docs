# Создание интернет-магазина на платформе OpenCart с помощью консоли управления

Чтобы создать инфраструктуру для [интернет-магазина на платформе OpenCart](index.md) с помощью консоли управления {{ yandex-cloud }}:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте ВМ с платформой OpenCart](#create-vm).
1. [(опционально) Создайте кластер БД {{ MY }}](#create-mysql).
1. [Настройте OpenCart](#configure-opencart).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

* Виртуальная машина: использование вычислительных ресурсов, хранилища, публичного IP-адреса и операционной системы (см. [тарифы {{ compute-name }}](../../../compute/pricing.md)).
* Кластер {{ mmy-name }}, если он создан для поддержки и обслуживания СУБД: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы {{ mmy-name }}](../../../managed-mysql/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ (см. [тарифы {{ vpc-name }}](../../../vpc/pricing.md)).

## Создайте ВМ с платформой OpenCart {#create-vm}

На загрузочном диске ВМ будет предустановлена платформа OpenCart и необходимые для ее работы компоненты, включая PHP и {{ MY }}.

Чтобы создать ВМ:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **Виртуальные машины**.
  1. Нажмите кнопку **Создать виртуальную машину**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** в поле **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** введите `OpenCart` и выберите публичный образ [OpenCart](https://yandex.cloud/ru/marketplace/products/yc/opencart-3).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** настройте загрузочный [диск](../../../compute/concepts/disk.md):

      * Выберите [тип диска](../../../compute/concepts/disk.md#disks_types) `{{ ui-key.yacloud.compute.value_disk-type-network-ssd_4Mmub }}`.
      * Задайте размер диска `13 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` и укажите необходимую [платформу](../../../compute/concepts/vm-platforms.md), количество vCPU и объем RAM:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `20%`.
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `4 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** укажите идентификатор подсети в зоне доступности создаваемой ВМ или выберите [облачную сеть](../../../vpc/concepts/network.md#network) из списка.

          * У каждой сети должна быть как минимум одна [подсеть](../../../vpc/concepts/network.md#subnet). Если подсети нет, создайте ее, выбрав **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
          * Если сети нет, нажмите **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** и создайте ее:

              * В открывшемся окне укажите имя сети и выберите каталог, в котором она будет создана.
              * (Опционально) Выберите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**, чтобы автоматически создать подсети во всех зонах доступности.
              * Нажмите **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, чтобы назначить случайный IP-адрес из пула адресов {{ yandex-cloud }}, или выберите статический адрес из списка, если вы зарезервировали его заранее.

    1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа к ВМ:

        * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите предпочтительное имя пользователя, который будет создан на ВМ, например, `ubuntu`.
        * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../../organization/concepts/membership.md).
          
          Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
          
          1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**.
          1. Задайте имя SSH-ключа.
          1. Выберите вариант:
          
              * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-manual }}` — вставьте содержимое открытого [SSH](../../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
              * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-upload }}` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
              * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-generate }}` — автоматическое создание пары SSH-ключей.
              
                При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
          
          1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
          
          SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** введите имя ВМ, например `opencart`. Требования к имени:

      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
  1. Получите [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) ВМ — он потребуется далее, чтобы [настроить OpenCart](#configure-opencart). Публичный IP-адрес можно узнать в консоли управления в поле **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** блока **{{ ui-key.yacloud.compute.instance.overview.section_network }}** на странице ВМ.

{% endlist %}

Если вы рассчитываете на существенную нагрузку на БД, или хотели бы использовать сервис управляемых СУБД, то [создайте кластер БД](#create-mysql) с помощью сервиса {{ mmy-name }}. Если нет — [настройте OpenCart](#configure-opencart).

## Создайте кластер БД {{ MY }} {#create-mysql}

Сервис {{ mmy-name }} берет на себя поддержку и обслуживание СУБД, в том числе мониторинг ее состояния и текущей активности, автоматическое создание резервных копий и легко настраиваемую отказоустойчивость.

Если необходимости в кластере нет, пропустите этот шаг и [настройте OpenCart](#configure-opencart).

Чтобы создать кластер БД:

{% list tabs %}

- Консоль управления

  1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку ![plus](../../../_assets/console-icons/plus.svg) **Создать ресурс** и выберите пункт **Кластер {{ MY }}**.
  1. Укажите имя кластера, например, `opencart`.
  1. В блоке **Класс хоста** выберите `s2.micro`. Данных характеристик хватит для работы системы без особых нагрузок.
  1. В блоке **База данных** укажите:
     * **Имя БД** — оставьте значение по умолчанию, `db1`.
     * **Имя пользователя** для подключения к БД — оставьте значение по умолчанию, `user1`.
     * **Пароль**, который OpenCart будет использовать для доступа к БД {{ MY }}.
  1. В блоке **Хосты**, при необходимости поменяйте **Зону доступности**, в которой должна находиться БД. Для этого нажмите значок ![pencil](../../../_assets/console-icons/pencil.svg) справа от текущей выбранной зоны доступности и выберите из выпадающего списка нужную.

     {% note tip %}

     Рекомендуется выбрать ту же зону доступности, которую вы выбрали при создании ВМ. Это позволит уменьшить задержку (latency) между ВМ и БД.

     {% endnote %}

  1. (опционально) Если вы хотите обеспечить отказоустойчивость БД, добавьте дополнительные хосты в кластер: для этого нажмите **Добавить хост** и укажите, в какой зоне доступности он должен быть размещен.
  1. Остальные поля оставьте без изменений.
  1. Нажмите кнопку **Создать кластер**.

{% endlist %}

Создание кластера БД может занять несколько минут. После создания [настройте OpenCart](#configure-opencart).

## Настройте OpenCart {#configure-opencart}

1. Откройте веб-интерфейс интернет-магазина OpenCart. Для этого откройте в браузере адрес `http://<публичный_IP-адрес_ВМ>/`. Откроется страница настройки OpenCart.
1. Ознакомьтесь с лицензией и нажмите **Continue**.

   ![Шаг 1](../../../_assets/tutorials/opencart/opencart1.png)

1. Убедитесь, что все строки с требованиями к системе отмечены зелеными галочками, и нажмите кнопку **Continue**.

   ![Шаг 2](../../../_assets/tutorials/opencart/opencart2.png)

1. Настройте доступ к БД:

   {% list tabs %}

   - Локальный сервер {{ MY }}

     Атрибуты подключения к БД генерируются в специальном файле при создании ВМ:
     1. Зайдите по SSH на созданную ВМ.
     1. Перейдите в режим администратора `sudo -i`.
     1. Откройте файл `default_passwords.txt` в домашней директории администратора:

        ```bash
        root@opencart:~# cat default_passwords.txt
        MYSQL_USER=opencart
        MYSQL_PASS=qDbvN1R6tA6ET
        MYSQL_ROOT_PASS=5DiVb80l1kXVz
        MYSQL_DB=opencart
        ```

     1. На странице настройки OpenCart в секции БД, введите соответствующие данные:
        * **Username** — значение переменной `MYSQL_USER`.
        * **Database** — значение переменной `MYSQL_DB`.
        * **Password** — значение переменной `MYSQL_PASS`.

        Остальные поля оставьте без изменения.

   - Кластер {{ mmy-name }}

     Если вы используете кластер {{ mmy-name }}, введите нужные атрибуты кластера:
     * **Hostname** — укажите [полное доменное имя (FQDN)](../../../compute/concepts/network.md#hostname) созданной БД. Чтобы его узнать:
       1. Перейдите в новой вкладке браузера на страницу каталога в [консоли управления]({{ link-console-main }}).
       1. Выберите раздел **{{ mmy-name }}**.
       1. В таблице выберите созданный вами кластер.
       1. В меню слева выберите вкладку **Хосты**.
       1. Подведите курсор к полю **Имя хоста** (например, `rc1c-vok617m35g3dj23i`) и скопируйте полное доменное имя БД, нажав на значок ![copy](../../../_assets/console-icons/copy.svg).
     * **Username** — имя пользователя (в примере `user1`).
     * **Database** — имя БД (в примере `db1`).
     * **Password** — указанный вами пароль пользователя.

     Остальные поля оставьте без изменения.

   {% endlist %}

1. Задайте имя администратора, его пароль и актуальный электронный адрес. После этого нажмите кнопку **Continue**.

   ![Шаг 3](../../../_assets/tutorials/opencart/opencart3.png)

1. Откроется страница с уведомлением о том, что система настроена. Чтобы настроить интернет-магазин, нажмите кнопку **Login to your administration** и введите логин и пароль администратора.

   ![Шаг 4](../../../_assets/tutorials/opencart/opencart4.png)

1. После завершения установки зайдите на ВМ по SSH и удалите ненужные установочные файлы:

   ```bash
   user@opencart:~$ sudo -i
   root@opencart:~# rm -rf /var/www/opencart/install/
   ```

1. Чтобы проверить главную страницу сайта, перейдите по адресу `http://<публичный_IP-адрес_ВМ>/`. Вы увидите главную страницу сайта глазами пользователя, посетившего ваш интернет-магазин.

   ![Шаг 5](../../../_assets/tutorials/opencart/opencart5.png)

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../../compute/operations/vm-control/vm-delete.md) ВМ `opencart`.
1. Если вы использовали БД {{ MY }}, то [удалите кластер {{ mmy-name }}](../../../managed-mysql/operations/cluster-delete.md) (в примере кластер БД создается с именем `opencart`).

Если вы зарезервировали статический публичный IP-адрес специально для этой ВМ:
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}** в вашем каталоге.
1. Перейдите на вкладку **IP-адреса**.
1. Найдите нужный IP-адрес, нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите пункт **Удалить**.

#### См. также {#see-also}

* [{#T}](terraform.md).