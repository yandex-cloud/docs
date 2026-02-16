В этом руководстве вы развернете решение Nextcloud на [виртуальной машине](../../../compute/concepts/vm.md) {{ compute-name }} с помощью образа [{{ coi }}](../../../cos/concepts/index.md) и подключите к нему [бакет](../../../storage/concepts/bucket.md) {{ objstorage-name }}. Для реализации этого решения вам потребуется [доменное имя](https://ru.wikipedia.org/wiki/Доменное_имя), по которому будет осуществляться доступ к ресурсам в Nextcloud.

Чтобы развернуть Nextcloud с интеграцией бакета {{ objstorage-name }} на ВМ с помощью образа {{ coi }}:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте и настройте облачную сеть](#setup-network).
1. [Создайте сервисный аккаунт и статический ключ доступа](#setup-sa).
1. [Создайте бакет {{ objstorage-name }}](#create-bucket).
1. [Создайте виртуальную машину](#create-vm).
1. [Создайте ресурсную A-запись в публичной зоне DNS вашего домена](#create-a-record).
1. [Настройте Nextcloud на виртуальной машине](#setup-nextcloud).
1. [Протестируйте работу решения](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость предлагаемого решения входят: 
* плата за [диски](../../../compute/concepts/disk.md) и постоянно запущенные [ВМ](../../../compute/concepts/vm.md) (см. [тарифы {{ compute-full-name }}](../../../compute/pricing.md));
* плата за использование [публичных IP-адресов](../../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../../vpc/pricing.md));
* плата за [хранение данных](../../../storage/concepts/bucket.md) в {{ objstorage-name }} и [операции](../../../storage/operations/index.md) с ними (см. [тарифы {{ objstorage-full-name }}](../../../storage/pricing.md));
* при использовании {{ dns-full-name }} плата за [DNS-зоны](../../../dns/concepts/dns-zone.md#public-zones) и публичные DNS-запросы (см. [тарифы {{ dns-name }}](../../../dns/pricing.md)).

## Создайте и настройте облачную сеть {#setup-network}

1. {% include [create-network](../../_tutorials_includes/integrate-nextcloud/create-network.md) %}
1. Создайте [группу безопасности](../../../vpc/concepts/security-groups.md), разрешающую необходимый для работы инфраструктуры Nextcloud трафик:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
      1. На панели слева выберите ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**. 
      1. Нажмите **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
      1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** укажите имя `nextcloud-sg`.
      1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** выберите созданную ранее сеть `nextcloud-network`.
      1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** [создайте](../../../vpc/operations/security-group-add-rule.md) следующие правила для управления трафиком:

          | Направление<br/>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
          | --- | --- | --- | --- | --- | --- |
          | Входящий | `http`           | `8080` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
          | Входящий | `https`           | `443` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
          | Входящий | `ssh`            | `22`   | `TCP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
          | Исходящий | `any`           | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
      1. Нажмите **{{ ui-key.yacloud.common.create }}**.

    {% endlist %}

## Создайте сервисный аккаунт и статический ключ доступа {#setup-sa}

{% include [create-sa-and-aws-key](../../_tutorials_includes/integrate-nextcloud/create-sa-and-aws-key.md) %}

## Создайте бакет {{ objstorage-name }} {#create-bucket}

{% include [create-bucket](../../_tutorials_includes/integrate-nextcloud/create-bucket.md) %}

## Создайте виртуальную машину {#create-vm}

Создайте виртуальную машину, на которой будет развернут Nextcloud:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}** и нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_coi }}** и нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.image_coi_label_empty-button }}**. В открывшемся окне:

      1. Перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.value_docker-compose-yaml }}** и в открывшееся поле скопируйте [спецификацию docker compose](https://github.com/nextcloud/all-in-one/blob/main/compose.yaml) `compose.yaml` из официального репозитория Nextcloud на GitHub.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.apply }}**.
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет создана ваша виртуальная машина.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** задайте размер диска не менее `40 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** выберите конфигурацию `2 {{ ui-key.yacloud.component.compute.resources.field_cores }} 4 {{ ui-key.yacloud.common.units.label_gigabyte }} {{ ui-key.yacloud.component.compute.resources.field_memory }}`.

      Указанной конфигурации будет достаточно для одновременной работы до 10 пользователей. Если активных пользователей решения будет больше, увеличьте объем доступных виртуальной машине ресурсов.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите сеть `nextcloud-network` и подсеть в зоне доступности создаваемой виртуальной машины.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** оставьте значение `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, чтобы назначить ВМ случайный публичный IP-адрес из пула {{ yandex-cloud }}.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** выберите группу безопасности `nextcloud-sg`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа к ВМ:

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя, например: `yc-user`. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
      * {% include [access-ssh-key](../../../_includes/compute/create/access-ssh-key.md) %}
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `nextcloud-vm`.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}

{% note tip %}

Чтобы в будущем [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) созданной виртуальной машины не изменился в случае ее возможной остановки, [сделайте](../../../vpc/operations/set-static-ip.md) его статическим.

{% endnote %}

## Создайте ресурсную A-запись в публичной зоне DNS вашего домена {#create-a-record}

Для выполнения этого шага вам понадобится зарегистрированное доменное имя. Например: `example.com`.

Для того чтобы запросы, поступающие к вашему домену, направлялись на созданную ранее виртуальную машину, создайте в вашей [публичной зоне DNS](../../../dns/concepts/dns-zone.md#public-zones) ресурсную [A-запись](../../../dns/concepts/resource-record.md#a), указывающую на публичный IP-адрес виртуальной машины. Порядок действий на этом шаге будет зависеть от того, управляет вашим доменом сервис [{{ dns-full-name }}](../../../dns/index.yaml) или сторонний DNS-провайдер.

{% cut "**Если вашим доменом управляет сервис {{ dns-full-name }}**" %}
 
{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Выберите нужную зону DNS, нажмите кнопку **{{ ui-key.yacloud.dns.button_record-set-create }}** и в открывшемся окне:

      {% note info %}

      Если для нужного доменного имени у вас еще нет публичной зоны DNS, [создайте](../../../dns/operations/zone-create-public.md) ее.

      {% endnote %}

      1. В поле **{{ ui-key.yacloud.common.name }}** выберите `{{ ui-key.yacloud.dns.label_create-subdomain }}` и введите `nextcloud`, чтобы создать поддомен (например, `nextcloud.example.com`) в вашей доменной зоне.
      1. В поле **{{ ui-key.yacloud.common.type }}** выберите `A`.
      1. В поле **{{ ui-key.yacloud.dns.label_records }}** укажите публичный IP-адрес виртуальной машины.

          Узнать публичный IP-адрес виртуальной машины вы можете в [консоли управления]({{ link-console-main }}) на странице с информацией о ВМ в блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}** в поле **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}**.
      1. Значения других параметров оставьте без изменения и нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

{% endcut %}

{% cut "**Если вашим доменом управляет сторонний DNS-провайдер**" %}

Разместите у своего DNS-провайдера или на собственном [DNS-сервере](../../../glossary/dns.md#dns-server) ресурсную A-запись со следующими значениями:

* Хост — `nextcloud.<имя_вашего_домена>.`.
* Тип — `A`.
* Значение — `<IP-адрес_ВМ>`.

{% endcut %}

## Настройте Nextcloud на виртуальной машине {#setup-nextcloud}

В рамках этого руководства вы выполните базовую настройку вашего экземпляра Nextcloud и интеграцию в Nextcloud бакета {{ objstorage-name }}.

### Выполните базовую настройку Nextcloud {#initialize}

Выполните базовую настройку решения Nextcloud на созданной виртуальной машине. Для настройки используйте веб-интерфейс Nextcloud:

1. В окне браузера введите зарегистрированный ранее поддомен с номером порта `8080`. Например: `https://nextcloud.example.com:8080`.

    Браузер выдаст предупреждение о небезопасном соединении, так как для вашего экземпляра Nextcloud еще не настроен [TLS](https://ru.wikipedia.org/wiki/TLS)-сертификат. Переходите на страницу, несмотря на предупреждение. Позднее Nextcloud самостоятельно настроит сертификат для вашего экземпляра.
1. В открывшемся окне скопируйте парольную фразу из поля **Passphrase**.

    {% note warning %}

    Парольная фраза отображается всего один раз: повторно вывести ее на экран не получится. Без парольной фразы вы не сможете получить пароль администратора и настроить Nextcloud.

    {% endnote %}
1. Нажмите кнопку **Open Nextcloud AIO login**.
1. В окне **Nextcloud AIO Login** введите скопированную парольную фразу и нажмите кнопку **Log in**.
1. В открывшемся окне в секции **New AIO instance** введите имя домена, по которому доступен ваш экземпляр Nextcloud (например, `nextcloud.example.com`), и нажмите **Submit Domain**.
1. В следующем окне в секции **Optional containers** отключите опцию `Nextcloud Talk` и нажмите кнопку **Save changes**.

    В рамках этого руководства этот модуль не является обязательным. При необходимости вы сможете установить его позднее в административном интерфейсе Nextcloud.
1. Нажмите кнопку **Download and start containers**.

    Загрузка и запуск необходимых контейнеров могут занять несколько минут. Дождитесь завершения этого процесса.
1. После запуска всех контейнеров в окне браузера в поле **Initial Nextcloud password:** отобразится пароль администратора вашего экземпляра Nextcloud. Сохраните этот пароль и нажмите кнопку **Open your Nextcloud**.
1. В окне аутентификации введите имя пользователя `admin` и пароль, полученный на предыдущем шаге. Затем нажмите кнопку **Log in**.

### Настройте интеграцию бакета {{ objstorage-name }} {#integrate-bucket}

1. Откройте меню управления приложениями. Для этого в правом верхнем углу экрана нажмите на значок пользователя и в открывшемся контекстном меню выберите ![plus](../../../_assets/console-icons/plus.svg) **Apps**.
1. В открывшемся окне на панели слева выберите ![person](../../../_assets/console-icons/person.svg) **Your apps**.
1. В открывшемся списке найдите приложение `External storage support` и в строке с этим приложением нажмите кнопку **Enable**.

    При необходимости для подтверждения действия во всплывающем окне введите ваш пароль администратора Nextcloud.
1. Откройте основное меню настроек. Для этого в правом верхнем углу экрана нажмите на значок пользователя и в открывшемся контекстном меню выберите ![admin-icon](../../../_assets/tutorials/integrate-nextcloud/admin-icon.svg) **Administration settings**.
1. В открывшемся окне на панели слева в блоке **Administration** выберите ![app-dark-icon](../../../_assets/tutorials/integrate-nextcloud/app-dark-icon.svg) **External storage** и в открывшемся окне в блоке **External storage** задайте настройки интеграции с {{ objstorage-name }}:

    1. В секции **External storage** выберите `Amazon S3`.
    1. В секции **Authentication** выберите `Access key`.
    1. В секции **Configuration**:

        * В поле **Bucket** укажите имя созданного ранее бакета. Например: `my-nextcloud-bucket`.
        * В поле **Hostname** укажите `{{ s3-storage-host }}`.
        * В поле **Port** укажите `443`.
        * В поле **Access key** вставьте идентификатор созданного ранее статического ключа доступа.
        * В поле **Secret key** вставьте секретный ключ созданного ранее статического ключа доступа.
    1. В секции **Available for** включите опцию **All people**.
    1. В правой части редактируемого блока нажмите значок ![check](../../../_assets/console-icons/check.svg), чтобы сохранить изменения.

        Для подтверждения действия во всплывающем окне введите ваш пароль администратора Nextcloud.

## Протестируйте работу решения {#test}

Чтобы проверить работу интеграции {{ objstorage-name }} с Nextcloud:

1. На вашем локальном компьютере откройте браузер и в адресной строке введите имя домена, на котором развернут ваш экземпляр Nextcloud:

    ```text
    https://nextcloud.example.com
    ```
1. Аутентифицируйтесь в Nextcloud с помощью логина `admin` и сохраненного пароля.
1. В левой части верхнего меню выберите ![folder-fill](../../../_assets/console-icons/folder-fill.svg) **Files**.
1. В меню слева выберите **External storage** и выберите **AmazonS3**.
1. Нажмите ![plus](../../../_assets/console-icons/plus.svg) **New** и выберите ![arrow-shape-up-from-line](../../../_assets/console-icons/arrow-shape-up-from-line.svg) **Upload files**, чтобы загрузить в хранилище файл с локального компьютера.
1. Выберите файл на локальном компьютере и загрузите его в хранилище.

    Загруженный файл отобразится в хранилище `AmazonS3` Nextcloud.
1. В сервисе {{ objstorage-full-name }} [убедитесь](../../../storage/operations/objects/list.md), что файл был загружен в бакет.

На этом завершено развертывание экземпляра решения Nextcloud и его интеграция с хранилищем {{ objstorage-name }}.

## Как удалить созданные ресурсы {#clear-out}

1. Удалите ресурсную запись [в {{ dns-full-name }}](../../../dns/operations/resource-record-delete.md) или в личном кабинете вашего регистратора доменных имен.
1. Если вы создавали публичную зону DNS, удалите ее в [{{ dns-full-name }}](../../../dns/operations/zone-delete.md) или в личном кабинете вашего регистратора доменных имен.
1. [Удалите](../../../compute/operations/vm-control/vm-delete.md) виртуальную машину.
1. [Удалите](../../../storage/operations/objects/delete.md) созданные в бакете объекты, затем [удалите](../../../storage/operations/buckets/delete.md) сам бакет.
1. [Удалите](../../../iam/operations/sa/delete.md) сервисный аккаунт.
1. Последовательно удалите [подсети](../../../vpc/operations/subnet-delete.md), [группу безопасности](../../../vpc/operations/security-group-delete.md) и [облачную сеть](../../../vpc/operations/network-delete.md).