# Развертывание S2S VPN с помощью strongSwan в Yandex Cloud


В этом руководстве вы развернете защищенное site‑to‑site (S2S) VPN‑соединение между облачной инфраструктурой в Yandex Cloud и удаленной площадкой с помощью IPsec‑шлюза на базе [strongSwan](https://www.strongswan.org/). Для этого будет использоваться приложение [strongSwan S2S VPN](https://yandex.cloud/ru/marketplace/products/yc/ipsec-sgw) из каталога [Yandex Cloud Apps](https://yandex.cloud/ru/services/cloud-apps/). Приложение автоматизирует развертывание и базовую настройку IPsec‑туннеля, позволяя:

* быстро создать защищенный канал поверх публичного интернета;
* обеспечить шифрование трафика между подсетями;
* интегрировать облачные ресурсы в корпоративную сеть с сохранением контроля над маршрутизацией.

{% note info %}

Готовое приложение автоматизирует развертывание инфраструктуры в Yandex Cloud.

При использовании strongSwan S2S VPN на удаленной площадке (в вашем локальном ЦОД, филиале или другом облаке) необходима настройка вручную.

{% endnote %}

Чтобы развернуть защищенное соединение:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте сервисный аккаунт](#create-service-account).
1. [Создайте облачную сеть](#create-vpc).
1. [Зарезервируйте публичный статический IP-адрес](#reserve-public-static-ip).
1. [Создайте пару ключей SSH](#create-ssh-keys).
2. [Разверните приложение](#app-deploy).

Если созданные ресурсы вам больше не нужны, [удалите](#clear-out) их.


## Необходимые платные ресурсы {#paid-resources}

В стоимость развертывания инфраструктуры для данного решения входят:

* Плата за постоянно запущенную виртуальную машину ([тарифы Yandex Compute Cloud](../../../compute/pricing.md)).
* Плата за использование статического внешнего IP-адреса ([тарифы Yandex Virtual Private Cloud](../../../vpc/pricing.md)).
* Плата за исходящий трафик ([тарифы Yandex Virtual Private Cloud](../../../vpc/pricing.md))


## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


## Создайте сервисный аккаунт {#create-service-account}

Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) `s2s-vpn-sa` для автоматического создания ресурсов при установке приложения. Назначьте ему роли `resource-manager.admin`, `iam.admin`, `compute.admin` и `vpc.admin`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **Identity and Access Management**.
  1. Нажмите **Создать сервисный аккаунт**.
  1. Укажите имя сервисного аккаунта: `s2s-vpn-sa`.
  1. Нажмите **Добавить роль** и выберите роли:
      * `resource-manager.admin`
      * `iam.admin`
      * `compute.admin`
      * `vpc.admin`.

  1. Нажмите **Создать**.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Создайте сервисный аккаунт `s2s-vpn-sa`:

      ```bash
      yc iam service-account create --name s2s-vpn-sa
      ```

      Результат:

      ```text
      id: nfersamh4sjq********
      folder_id: b1gc1t4cb638********
      created_at: "2023-03-21T10:36:29.726397755Z"
      name: s2s-vpn-sa
      ```

      Сохраните идентификатор сервисного аккаунта `s2s-vpn-sa` (`id`) и каталога, в котором его создали (`folder_id`).

  1. Назначьте сервисному аккаунту роли `resource-manager.admin`, `iam.admin`, `compute.admin` и `vpc.admin` на каталог:

      ```bash
      yc resource-manager folder add-access-binding <идентификатор_каталога> \
        --role resource-manager.admin \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>

      yc resource-manager folder add-access-binding <идентификатор_каталога> \
        --role iam.admin \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>

      yc resource-manager folder add-access-binding <идентификатор_каталога> \
        --role compute.admin \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>

      yc resource-manager folder add-access-binding <идентификатор_каталога> \
        --role vpc.admin \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

      Результат:

      ```text
      done (1s)
      ```

- API {#api}

  Чтобы создать сервисный аккаунт, воспользуйтесь методом [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).

  Чтобы назначить сервисному аккаунту роли на каталог, воспользуйтесь методом [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md).

{% endlist %}

## Создайте облачную сеть {#create-vpc}

Создайте [облачную сеть](../../vpc/concepts/network.md), в которой будет размещена ВМ.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **Virtual Private Cloud**.
  1. Справа сверху нажмите **Создать сеть**.
  1. В поле **Имя** укажите `s2s-vpn-network`.
  1. В поле **Дополнительно** отключите опцию **Создать подсети**.
  1. Нажмите **Создать сеть**.

- Yandex Cloud CLI {#cli}

  Выполните команду:

  ```bash
  yc vpc network create s2s-vpn-network
  ```

  Результат:

  ```text
  id: enp1gg8kr3pv********
  folder_id: b1gt6g8ht345********
  created_at: "2023-12-20T20:08:11Z"
  name: s2s-vpn-network
  default_security_group_id: enppne4l2eg5********
  ```

- API {#api}

  Чтобы создать облачную сеть, воспользуйтесь методом REST API [create](../../vpc/api-ref/Network/create.md) для ресурса [Network](../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md).

{% endlist %}


## Зарезервируйте публичный статический IP-адрес {#reserve-public-static-ip}

Зарезервируйте статический [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses) для ВМ, на которой будет установлено приложение.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **Virtual Private Cloud**.
  1. На панели слева выберите ![image](../../_assets/console-icons/map-pin.svg) **Публичные IP-адреса** и нажмите **Зарезервировать публичный IP-адрес**.
  1. В открывшемся окне в поле **Зона доступности** выберите `ru-central1-b` и нажмите **Зарезервировать**.

{% endlist %}


## Создайте пару ключей SSH {#create-ssh-keys}

Чтобы подключаться к [ВМ](../../compute/concepts/vm.md) по [SSH](../../glossary/ssh-keygen.md), нужна пара ключей: открытый ключ размещается на ВМ, а закрытый ключ хранится у пользователя. Такой способ безопаснее, чем подключение по логину и паролю.

{% note info %}

В публичных образах Linux, предоставляемых Yandex Cloud, возможность подключения по протоколу SSH с использованием логина и пароля по умолчанию отключена.

{% endnote %}

Чтобы создать пару ключей:

{% list tabs group=operating_system %}

- Linux/macOS {#linux-macos}

  1. Откройте терминал.
  1. Создайте новый ключ с помощью команды `ssh-keygen`:
  
      ```bash
      ssh-keygen -t ed25519 -C "<опциональный_комментарий>"
      ```
  
      Вы можете передать в параметре `-C` пустую строку, чтобы не добавлять комментарий, или не указывать параметр `-C` вообще — в таком случае будет добавлен комментарий по умолчанию.
  
      После выполнения команды вам будет предложено указать имя и путь к файлам с ключами, а также ввести пароль для закрытого ключа. Если задать только имя, пара ключей будет создана в текущей директории. Открытый ключ будет сохранен в файле с расширением `.pub`, закрытый ключ — в файле без расширения.
  
      По умолчанию команда предлагает сохранить ключ под именем `id_ed25519` в директории `/home/<имя_пользователя>/.ssh`. Если в этой директории уже есть SSH-ключ с именем `id_ed25519`, вы можете случайно перезаписать его и потерять доступ к ресурсам, в которых он используется. Поэтому рекомендуется использовать уникальные имена для всех SSH-ключей.

- Windows 10/11 {#windows}

  Если у вас еще не установлен [OpenSSH](https://ru.wikipedia.org/wiki/OpenSSH), установите его по [инструкции](https://learn.microsoft.com/ru-ru/windows-server/administration/openssh/openssh_install_firstuse).
  
  1. Запустите `cmd.exe` или `powershell.exe` (предварительно обновите PowerShell).
  1. Создайте новый ключ с помощью команды `ssh-keygen`:
  
      ```shell
      ssh-keygen -t ed25519 -C "<опциональный_комментарий>"
      ```
  
      Вы можете передать в параметре `-C` пустую строку, чтобы не добавлять комментарий, или не указывать параметр `-C` вообще — в таком случае будет добавлен комментарий по умолчанию.
  
      После выполнения команды вам будет предложено указать имя и путь к файлам с ключами, а также ввести пароль для закрытого ключа. Если задать только имя, пара ключей будет создана в текущей директории. Открытый ключ будет сохранен в файле с расширением `.pub`, закрытый ключ — в файле без расширения.
  
      По умолчанию команда предлагает сохранить ключ под именем `id_ed25519` в папку `C:\Users\<имя_пользователя>/.ssh`. Если в этой директории уже есть SSH-ключ с именем `id_ed25519`, вы можете случайно перезаписать его и потерять доступ к ресурсам, в которых он используется. Поэтому рекомендуется использовать уникальные имена для всех SSH-ключей.

- Windows 7/8 {#windows7-8}

  Создайте ключи с помощью приложения PuTTY:
  
  1. [Скачайте](https://www.putty.org) и установите PuTTY.
  1. Добавьте папку с PuTTY в переменную `PATH`:
  
      1. Нажмите кнопку **Пуск** и в строке поиска Windows введите **Изменение системных переменных среды**.
      1. Справа снизу нажмите кнопку **Переменные среды...**.
      1. В открывшемся окне найдите параметр `PATH` и нажмите **Изменить**.
      1. Добавьте путь к папке в список.
      1. Нажмите кнопку **ОК**.
  
  1. Запустите приложение PuTTYgen.
  1. В качестве типа генерируемой пары выберите **EdDSA**. Нажмите **Generate** и поводите курсором в поле выше до тех пор, пока не закончится создание ключа.
  
      ![ssh_generate_key](../../_assets/compute/ssh-putty/ssh_generate_key.png)
  
  1. В поле **Key passphrase** введите надежный пароль. Повторно введите его в поле ниже.
  1. Нажмите кнопку **Save private key** и сохраните закрытый ключ. Никому не сообщайте ключевую фразу от него.
  1. Нажмите кнопку **Save public key** и сохраните открытый ключ в файле `<имя_ключа>.pub`.

{% endlist %}


## Разверните приложение {#app-deploy}

### Установите приложение {#install-app}

В результате установки приложения будут автоматически созданы ресурсы Yandex Cloud:

* [сервисный аккаунт](../../iam/concepts/users/service-accounts.md);
* [подсеть](../../vpc/concepts/network.md#subnet);
* [IP-адрес](../../vpc/concepts/address.md#public-addresses);
* [таблица маршрутизации](../../vpc/concepts/routing.md#rt-vm);
* [группа безопасности](../../vpc/concepts/security-groups.md);
* [виртуальная машина](../../compute/concepts/vm.md).

{% note warning %}

[Убедитесь](../../quota-manager/operations/read-quotas.md), что в целевом облаке не израсходованы квоты:

* **Количество сервисных аккаунтов**
* **Количество подсетей**
* **Количество статических публичных IP-адресов**
* **Количество таблиц маршрутизации**
* **Количество статических маршрутов**
* **Количество групп безопасности**
* **Количество виртуальных машин**
* **Количество дисков**
* **Общий объём SSD-дисков**
* **Общий объём RAM виртуальных машин**

Если какая-либо квота израсходована, создайте запрос на расширение квоты и дождитесь его исполнения.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **Cloud Apps**.
  1. На панели слева выберите ![image](../../_assets/console-icons/shopping-cart.svg) **Магазин приложений**.
  1. В поле **Поиск продуктов** введите `strongswan`, выберите **strongSwan S2S VPN** и нажмите **Использовать**.
  1. В открывшемся окне укажите:

      * **Имя** — `s2s-vpn`.
      * **Сервисный аккаунт** — `s2s-vpn-sa`.
      * **Сеть VPC** — `s2s-vpn-network`.
      * **CIDR новой подсети** — `10.130.0.0/24`.
      * **Зона новой подсети** — `ru-central1-b`.
      * **IP-адрес удалённого шлюза** — IP-адрес удаленного VPN-шлюза, который будет добавлен в конфигурацию strongSwan.
      * **CIDR удаленных подсетей** — список подсетей в виде перечисления CIDR через запятую, которые будут автоматически добавлены в таблицу маршрутизации.
      * **Ключ SSH** — содержимое открытого SSH-ключа, созданного [ранее](#create-ssh-keys).
      * **IPsec IKE Proposal** — `aes128gcm16-prfsha256-ecp256`.
      * **IPsec ESP Proposal** — `aes128gcm16`.
      * **IPsec PSK** — ключ IPsec Pre-Shared Key (PSK), который будет указан в конфигурации strongSwan.

  1. Нажмите **Установить** и дождитесь завершения установки.

{% endlist %}


### Привяжите таблицу маршрутизации {#bind-table}

Чтобы трафик между облачной и удаленной сетями направлялся через VPN-туннель, свяжите таблицу маршрутизации и подсеть.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **Virtual Private Cloud**.
  1. На панели слева выберите ![image](../../_assets/console-icons/nodes-right.svg) **Подсети**.
  1. В строке автоматически созданной подсети `ipsec-sgw-...` нажмите ![image](../../_assets/console-icons/ellipsis.svg) → **Привязать таблицу маршрутизации** и выберите автоматически созданную таблицу `ipsec-sgw-...`.
  1. Нажмите **Привязать**.

- Yandex Cloud CLI {#cli}

  Выполните команду:

  ```bash
  yc vpc subnet update <имя_автоматически_созданной_подсети> \
    --route-table-name=<имя_автоматически_созданной_таблицы>
  ```

  Результат:

  ```text
  id: e9b6n3jj3gh6********
  folder_id: b1g681qpemb4********
  created_at: "2024-05-19T13:24:58Z"
  name: ipsec-sgw-ru-central1-b
  network_id: enppoggov6ub********
  zone_id: ru-central1-b
  v4_cidr_blocks:
    - 10.1.0.0/16
  route_table_id: enp4v8foko6s********
  dhcp_options: {}
  ```

- API {#api}

  Чтобы привязать таблицу маршрутизации к подсети, воспользуйтесь методом REST API [update](../../vpc/api-ref/Subnet/update.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Update](../../vpc/api-ref/grpc/Subnet/update.md).

  {% note warning %}
  
  Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
  
  {% endnote %}

{% endlist %}


### Настройте виртуальную машину {#configure-vm}

После установки приложения выполните финальную настройку IPsec-шлюза на ВМ.

1. [Подключитесь](../../compute/operations/images-with-pre-installed-software/operate.md#vm-connect) к ВМ по SSH. Для этого используйте логин `admin` и закрытый SSH-ключ [созданный ранее](#create-ssh-keys).
1. Получите права администратора:

    ```bash
    sudo su
    ```

1. Перейдите в домашнюю папку администратора и запустите скрипт:

    ```bash
    cd /root
    ./update.sh
    ```

    В папке `/root` будут созданы текстовые файлы `ipsec-*.txt`, которые могут быть использованы как пример для настройки подключения на удаленном эндпоинте.

    {% note tip %}

    В случае совпадения IP-диапазонов в Yandex Cloud и удаленной сети может потребоваться использование Source NAT. Для этого выполните команду:

    ```bash
    iptables \
      -t nat \
      -A POSTROUTING \
      -s <локальная_подсеть> \
      -d <удаленная_подсеть> \
      -j SNAT \
      --to-source <новый_адрес>
    ```

    {% endnote %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

* Удалите приложение strongSwan S2S VPN:

    1. Перейдите в сервис **Cloud Apps**.
    1. В строке с приложением нажмите ![image](../../_assets/console-icons/ellipsis.svg) → **Удалить** и подтвердите удаление.

        Вместе с приложением удалятся все связанные с ним ресурсы.

* [Удалите](../../vpc/operations/delete-route-table.md) таблицу маршрутизации.
* [Удалите](../../iam/operations/sa/delete.md) сервисный аккаунт.
* [Удалите](../../vpc/operations/address-delete.md) статический публичный IP-адрес.
* [Удалите](../../vpc/operations/network-delete.md) облачную сеть.