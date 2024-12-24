# Создание бастионного хоста


Если вы когда-нибудь интересовались строительством древних фортификационных сооружений, то слово «бастион» должно быть вам знакомо. Бастионом назывался элемент внешней стены крепости, выступающий за ее основной контур. Как и средневековые крепости, компьютерные сети нуждаются в многоуровневой защите от внешнего вторжения. Роль бастионов в сетях выполняют так называемые бастионные хосты, образующие часть сетевого периметра.

Бастионный хост — это виртуальная машина, которой присваивается публичный IP-адрес для доступа по протоколу [SSH](../../glossary/ssh-keygen.md). Настроив бастионный хост, вы получаете своего рода [джамп-сервер](https://ru.wikipedia.org/wiki/Инсталляционный_сервер), который позволяет установить защищенное соединение с виртуальными машинами, не имеющими публичных IP-адресов. В этом руководстве вы узнаете о том, как можно развернуть бастионный хост и защитить доступ к удаленным виртуальным машинам, расположенным внутри вашего виртуального частного облака.

Таким образом, создание бастионного хоста позволит вам снизить уязвимость серверов в своем виртуальном частном облаке. При этом административные задачи на конкретных серверах будут выполняться в рамках прокси-соединения через бастионный хост по SSH.

Чтобы создать бастионный хост:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте пару ключей SSH](#create-ssh-keys).
1. [Создайте сети](#create-networks).
1. [Создайте группы безопасности](#create-sg).
1. [Зарезервируйте статический публичный IP-адрес](#get-static-ip).
1. [Создайте виртуальную машину для бастионного хоста](#create-bastion-instance).
1. [Протестируйте бастионный хост](#test-bastion).
1. [Добавьте виртуальный сервер во внутренний сегмент бастионного хоста](#add-virtual-server).
1. [Подключитесь к созданной ВМ](#connect-to-instance).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

![](../../_assets/tutorials/bastion-yc.svg)

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* плата за диски и постоянно запущенные ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md#prices-public-ip)).

## Создайте пару ключей SSH {#create-ssh-keys}

{% include [vm-ssh-rsa-key](../../_includes/vm-ssh-rsa-key.md) %}

{% note warning %}

Надежно сохраните закрытый ключ: без него подключиться к виртуальной машине будет невозможно.

{% endnote %}

## Создайте внешнюю и внутреннюю сети {#create-networks}

### Создайте внешнюю сеть и подсеть {#create-external-network}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором вы создаете инфраструктуру для бастионного хоста.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. Задайте имя сети: `external-bastion-network`.
  1. Отключите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. Создайте подсеть:

     1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.vpc.network.overview.button_create_subnetwork }}**.
     1. Укажите параметры подсети:

        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** — `bastion-external-segment`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** — `{{ region-id }}-b`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** — `172.16.17.0/28`.

     1. Нажмите кнопку **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.

{% endlist %}

### Создайте внутреннюю сеть и подсеть {#create-internal-network}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором вы создаете инфраструктуру для бастионного хоста.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. Задайте имя сети: `internal-bastion-network`.
  1. Отключите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. Создайте подсеть:

     1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.vpc.network.overview.button_create_subnetwork }}**.
     1. Укажите параметры подсети:

        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** — `bastion-internal-segment`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** — `{{ region-id }}-b`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** — `172.16.16.0/24`.

     1. Нажмите кнопку **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.

{% endlist %}

## Создайте группы безопасности {#create-sg}

### Создайте группу безопасности бастионного хоста {#create-internet-sg}

Создайте [группу безопасности](../../vpc/concepts/security-groups.md) и настройте правила для входящего трафика на бастионном хосте, чтобы обеспечить к нему доступ из интернета:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором вы создаете инфраструктуру для бастионного хоста.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}** и сеть `external-bastion-network`.
  1. В меню слева выберите ![image](../../_assets/vpc/security-group.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
  1. Задайте имя группы безопасности: `secure-bastion-sg`.
  1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** перейдите на вкладку **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}** и нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
  1. Укажите настройки правила:

     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `22`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}** в окне создания правила, а затем — в окне создания группы безопасности.

{% endlist %}

### Создайте группу безопасности для внутренних хостов {#create-internal-hosts-sg}

Создайте группу безопасности и настройте правила для входящего трафика, идущего с бастионного хоста на внутренние хосты:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором вы создаете инфраструктуру для бастионного хоста.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}** и сеть `internal-bastion-network`.
  1. В меню слева выберите ![image](../../_assets/vpc/security-group.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
  1. Задайте имя группы безопасности: `internal-bastion-sg`.
  1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** перейдите на вкладку **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}** и нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
  1. Укажите настройки правила:

     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `22`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `172.16.16.254/32`.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}** в окне создания правила.
  1. Перейдите на вкладку **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** и нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
  1. Укажите настройки правила:

     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `22`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}** в окне создания правила, а затем — в окне создания группы безопасности.

{% endlist %}

## Зарезервируйте статический публичный IP-адрес {#get-static-ip}

Для работы бастионному хосту потребуется статический [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses).

{% list tabs group=instructions %}

- Консоль управления {#console}  

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором вы создаете инфраструктуру для бастионного хоста.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/vpc/ip-addresses.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.addresses.button_create }}**.
  1. В открывшемся окне выберите [зону доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-b`.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.addresses.popup-create_button_create }}**.
  
{% endlist %}

## Создайте виртуальную машину для бастионного хоста {#create-bastion-instance}

После того как вы создали подсеть и группу безопасности, перейдите к созданию виртуального сервера для бастионного хоста:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления]({{ link-console-main }}) нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.  
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** в поле **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** введите `NAT-инстанс на основе Ubuntu 22.04 LTS` и выберите публичный образ [NAT-инстанс на основе Ubuntu 22.04 LTS](/marketplace/products/yc/nat-instance-ubuntu-22-04-lts).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-b`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**  настройте первый сетевой интерфейс:

      * **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** — `bastion-external-segment`.
      * **{{ ui-key.yacloud.component.compute.network-select.field_external }}** — нажмите `{{ ui-key.yacloud.component.compute.network-select.switch_list }}` и выберите [зарезервированный ранее IP-адрес](#get-static-ip).
      * **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** — `secure-bastion-sg`.

  1. Нажмите **{{ ui-key.yacloud.compute.instances.create.label_add-network-interface }}** и настройте второй сетевой интерфейс:

      * **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** — `bastion-internal-segment`.
      * **{{ ui-key.yacloud.component.compute.network-select.field_external }}** — `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`.
      * **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** — `internal-bastion-sg`.
      * Разверните блок **{{ ui-key.yacloud.component.compute.network-select.section_additional }}** и в поле **{{ ui-key.yacloud.component.internal-v4-address-field.field_internal-ipv4-address }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_manual }}`.
      * В появившемся поле для ввода укажите `172.16.16.254`.

      {% note info %}

      Убедитесь, что первый интерфейс на новой виртуальной машине принадлежит к внешнему сегменту, поскольку шлюз по умолчанию будет автоматически задан именно на этом интерфейсе.

      {% endnote %}

      Публичный IP-адрес указывается только для внешнего сегмента. Для внутреннего сегмента указывается внутренний статический IP-адрес.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа на ВМ:

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя: `bastion`.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `bastion-host`.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  Когда серверная ВМ запустится и перейдет в статус **Running**, вы сможете увидеть назначенный ей публичный IP-адрес в поле **{{ ui-key.yacloud.compute.group.overview.label_instance-address }}**.

{% endlist %}

## Протестируйте бастионный хост {#test-bastion}

После запуска бастионного хоста попробуйте подключиться к нему через SSH-клиент:

```bash
ssh -i ~/.ssh/<имя_файла_приватного_ключа> bastion@<публичный_IP_адрес_бастионного_хоста>
```

## Добавьте виртуальный сервер во внутренний сегмент бастионного хоста {#add-virtual-server}

Для администрирования ваших серверов добавьте сетевой интерфейс во внутренний сетевой сегмент бастионного хоста — `bastion-internal-segment`.

Если у вас уже создана виртуальная машина, [добавьте](../../compute/operations/vm-control/attach-network-interface.md) к ней дополнительный сетевой интерфейс. Если нет — создайте новую машину для тестирования конфигурации бастионного хоста:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления]({{ link-console-main }}) нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.  
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите публичный образ с произвольной операционной системой, например [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-b`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}** настройте сетевой интерфейс:

      * **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** — `bastion-internal-segment`.
      * **{{ ui-key.yacloud.component.compute.network-select.field_external }}** — `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`.
      * **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** — `internal-bastion-sg`.
      * Разверните блок **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_advanced }}** и в поле **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа на ВМ:

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя: `test`.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `test-vm`.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}

## Подключитесь к созданной ВМ {#connect-to-instance}

Подключаясь к ВМ по протоколу SSH через внутренний IP-адрес, вы будете использовать бастионный хост в роли джамп-хоста.

Для упрощения SSH-доступа и его настройки добавьте параметр `-J` (ProxyJump) в команду SSH:

```bash
ssh -i ~/.ssh/<имя_файла_приватного_ключа> -J bastion@<публичный_IP_адрес_бастионного_хоста> test@<внутренний_IP_адрес_виртуального_сервера>
```

SSH-клиент автоматически подключится к внутреннему серверу.

Флаг `-J` поддерживается в OpenSSH начиная с версии 7.3. В более ранних версиях `-J` недоступен. В таком случае самый безопасный и простой способ — это использовать перенаправление стандартного ввода-вывода (флаг `-W`) для «проброса» соединения через бастионный хост. Например:

```bash
ssh -i ~/.ssh/<имя_файла_приватного_ключа> -o ProxyCommand="ssh -W %h:%p bastion@<публичный_IP_адрес_бастионного_хоста>" test@<внутренний_IP_адрес_виртуального_сервера>
```

## Дополнительные опции подключения {#more-options}

### Использование SSH-агента для подключения через бастионный хост {#using-ssh-agent}

По умолчанию доступ к серверу настраивается только для аутентификации с помощью публичного SSH-ключа. Не рекомендуется хранить ключи на самих бастионных хостах (в особенности без кодовой фразы). Поэтому лучше использовать SSH-агент. В таком случае приватные SSH-ключи будут храниться только на вашем компьютере, и их можно будет безопасно использовать для аутентификации на следующем сервере.

Добавить ключ в аутентификационный агент можно с помощью команды `ssh-add`. Если ключ хранится в файле `~/.ssh/id_rsa`, он будет добавлен автоматически. Вы также можете указать, какой конкретно ключ нужно использовать, при помощи следующей команды:

```bash
ssh-add <путь_к_файлу_ключа>
```

Пользователи macOS могут настроить у себя файл `~/.ssh/config`. Тогда ключи можно будет загрузить в агент при помощи следующей команды:

```bash
AddKeysToAgent yes
```

Эта команда подключения к бастионному хосту позволяет пробросить агент и войти на следующий сервер, передавая учетные данные с локальной машины:

```bash
ssh -A bastion@<публичный_IP_адрес_бастионного_хоста>
```

Пользователи Windows могут использовать агент Pageant и загрузить в него свой файл приватного ключа. Затем, чтобы обеспечить проброс агента, нужно в окне настроек [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) выбрать **Соединение** → **SSH** → **Аутентификация**.

### Доступ к сервисам через SSH-туннели {#ssh-tunneling}

Иногда одного SSH-доступа недостаточно для выполнения поставленной задачи. В таких ситуациях SSH-туннели дают возможность с легкостью подключаться к веб-приложениям и другим сервисам, обрабатывающим входящие подключения.

Основные типы SSH-туннелей — локальные, удаленные и динамические:

* **Локальный** туннель предоставляет открытый порт на локальном интерфейсе обратной связи, который подключается к адресу `IP:порт` на вашем SSH-сервере.

   Например, можно подключить локальный порт 8080 к адресу `IP_адрес_веб_сервера:80`, который доступен с вашего бастионного хоста, а затем в браузере открыть `http://localhost:8080`:

   ```bash
   ssh bastion@<публичный_IP_адрес_бастионного_хоста> -L 8080:<IP_адрес_веб_сервера>:80
   ```

* **Удаленный** туннель работает в обратном, по отношению к локальному туннелю, направлении, открывая локальный порт для подключения к удаленному серверу.
* **Динамический** туннель предоставляет SOCKS-прокси на локальном порту, при этом подключения устанавливаются с удаленного хоста. Например, можно настроить динамический туннель на порту 1080, а затем в браузере указать его как SOCKS-прокси. В итоге вы сможете подключаться ко всем ресурсам, которые доступны с вашего бастионного хоста и находятся в приватной подсети.

   ```bash
   ssh bastion@<публичный_IP_адрес_бастионного_хоста> -D 1080
   ```

Эти методики основаны на простой замене, при которой зачастую требуется VPN-подключение, а также сочетание с подключениями ProxyJump или ProxyCommand.

Пользователи Windows могут настроить туннели через PuTTY, выбрав **Подключение** → **SSH** → **Туннели**.

Для простого установления подключений к сервисам удаленного рабочего стола (Remote Desktop Services, RDS) — т.е. работающим хостам Windows в облаке — можно использовать переадресацию портов (в особенности, локальную) путем установления туннельного подключения на порт 3389 и последующего подключения к `localhost` через RDS-клиент. Если RDS уже ожидает подключения на локальной машине, вы можете выбрать другой порт, как показано в примере:

```bash
ssh bastion@<публичный_IP_адрес_бастионного_хоста> -L 3390:<IP_адрес_Windows_хоста>:3389
```

### Передача файлов {#file-transfers}

Для клиентов и серверов Linux можно настроить протокол [SCP](https://ru.wikipedia.org/wiki/SCP) для безопасной передачи файлов через бастионный хост на внутренние хосты и обратно. Для этого используются те же опции ProxyCommand и ProxyJump, указываемые в командной строке SSH. Например:

```bash
scp -o "ProxyJump bastion@<публичный_IP_адрес_бастионного_хоста>" <имя_файла> bastion@<внутренний_IP_адрес_виртуального_сервера>:<путь_к_файлу>
```

Если вы используете Windows-клиент, то одно из наиболее популярных SCP-приложений на Windows — это [WinSCP](https://winscp.net). Чтобы передать файлы через бастионный хост на удаленную машину Linux, выполните следующие действия:

1. Создайте сеанс подключения к IP-адресу приватного хоста без пароля. Настройте SSH-ключ на машине Linux.
1. В меню навигации слева нажмите **Дополнительно** и выберите **Туннель**.
1. Введите IP-адрес и имя пользователя для вашего бастионного хоста. В поле **Файл закрытого ключа** выберите и установите файл закрытого ключа, который вы будете использовать для аутентификации на бастионном хосте.
1. В меню навигации слева в блоке **SSH** выберите **Аутентификация**.
1. Проверьте, что установлена опция **Разрешить пересылку агента**.
1. Выберите закрытый ключ для аутентификации на приватном хосте.

Такая настройка позволяет осуществлять непосредственную передачу файлов между машиной Windows и приватным хостом Linux. При этом соединение будет защищено бастионным хостом.

В случае хостов Windows, расположенных за бастионом Linux, передачу файлов можно осуществлять при помощи протокола [RDP](https://ru.wikipedia.org/wiki/Remote_Desktop_Protocol) через туннель. Этот метод обеспечивает эффективную и безопасную передачу файлов.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

* [удалите](../../compute/operations/vm-control/vm-delete.md) ВМ;
* [удалите](../../vpc/operations/address-delete.md) статический публичный IP-адрес.
