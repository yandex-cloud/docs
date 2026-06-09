# Настроить аутентификацию в OpenVPN Community Edition через Yandex Identity Hub по протоколу OIDC


[OpenVPN Community Edition](https://openvpn.net/community/) — бесплатная версия OpenVPN с открытым исходным кодом для организации защищенных VPN-соединений. Начиная с версии 2.6.2, OpenVPN Community Edition поддерживает аутентификацию через внешние провайдеры по протоколу [OpenID Connect](https://ru.wikipedia.org/wiki/OpenID#OpenID_Connect) (OIDC) с помощью плагина [openvpn-auth-oauth2](https://github.com/jkroepke/openvpn-auth-oauth2).

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в OpenVPN Community Edition с помощью технологии единого входа по стандарту OpenID Connect, создайте [OIDC-приложение](../../../organization/concepts/applications.md#oidc) и настройте его на стороне Yandex Identity Hub и на стороне OpenVPN.

Управлять OIDC-приложениями может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-oauthApplications-admin) `organization-manager.oauthApplications.admin` или выше.

Чтобы настроить аутентификацию пользователей вашей организации в OpenVPN Community Edition через Yandex Identity Hub:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Установите OpenVPN](#install-openvpn).
1. [Создайте Certificate Authority](#create-ca).
1. [Настройте OpenVPN-сервер](#configure-server).
1. [Создайте OIDC-приложение в Yandex Identity Hub](#create-app).
1. [Установите и настройте плагин openvpn-auth-oauth2](#setup-plugin).
1. [Проверьте работу интеграции](#validate).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за постоянно запущенную [виртуальную машину](../../../compute/concepts/vm.md) (см. [тарифы Yandex Compute Cloud](../../../compute/pricing.md));
* плата за использование [OIDC-приложения](../../../organization/concepts/applications.md#oidc) (см. [тарифы Yandex Identity Hub](../../../organization/pricing.md)).

## Создайте инфраструктуру {#deploy}

1. [Создайте виртуальную машину](../../../compute/operations/vm-create/create-linux-vm.md) (ВМ) на базе Ubuntu 24.04 с публичным IP-адресом. Эта ВМ будет выступать в роли OpenVPN-сервера.

1. Подключитесь к ВМ по SSH:

   ```bash
   ssh <имя_пользователя>@<публичный_IP-адрес_ВМ>
   ```

1. Убедитесь, что у вас есть:

   * Доменное имя, которое ведет на публичный IP-адрес ВМ. Оно потребуется для настройки плагина `openvpn-auth-oauth2`.
   * TLS-сертификат для этого доменного имени. Вы можете использовать сертификат из [Yandex Certificate Manager](../../../certificate-manager/operations/managed/cert-create.md).

## Установите OpenVPN {#install-openvpn}

{% note info %}

Плагин `openvpn-auth-oauth2` поддерживается начиная с OpenVPN версии 2.6.2.

{% endnote %}

1. Обновите список пакетов и установите OpenVPN и Easy-RSA:

   ```bash
   sudo apt update && sudo apt install openvpn easy-rsa
   ```

1. Проверьте версию OpenVPN:

   ```bash
   openvpn --version
   ```

   Результат:

   ```text
   OpenVPN 2.6.19 x86_64-pc-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [PKCS11] [MH/PKTINFO] [AEAD] [DCO]
   library versions: OpenSSL 3.0.13 30 Jan 2024, LZO 2.10
   ...
   ```
   Убедитесь, что версия не ниже 2.6.2.

## Создайте Certificate Authority {#create-ca}

1. Создайте каталог для Easy-RSA и скопируйте в него необходимые файлы:

   ```bash
   mkdir -p ~/openvpn-ca
   cd ~/openvpn-ca
   sudo mkdir /etc/openvpn/easy-rsa
   sudo cp -r /usr/share/easy-rsa/* /etc/openvpn/easy-rsa/
   cd /etc/openvpn/easy-rsa/
   ```

1. Инициализируйте инфраструктуру открытых ключей (PKI):

   ```bash
   sudo ./easyrsa init-pki
   ```

1. Создайте корневой центр сертификации (CA). Команда запросит пароль (не менее четырех символов) и Common Name — произвольное имя CA, например `YC-OpenVPN-CA`:

   ```bash
   sudo ./easyrsa build-ca
   ```

1. Сгенерируйте сертификат и ключ сервера:

   ```bash
   sudo ./easyrsa gen-req server nopass
   sudo ./easyrsa sign-req server server
   ```

   При подписании сертификата введите `yes` для подтверждения.

1. Сгенерируйте параметры Диффи-Хеллмана:

   ```bash
   sudo ./easyrsa gen-dh
   ```

## Настройте OpenVPN-сервер {#configure-server}

### Скопируйте сертификаты и ключи {#copy-certs}

Скопируйте необходимые файлы в рабочий каталог OpenVPN:

```bash
sudo cp pki/ca.crt pki/private/server.key pki/issued/server.crt /etc/openvpn/
sudo cp /etc/openvpn/easy-rsa/pki/dh.pem /etc/openvpn/
```

### Создайте конфигурационный файл сервера {#server-config}

1. Создайте файл `/etc/openvpn/server.conf`:

   ```bash
   sudo nano /etc/openvpn/server.conf
   ```

1. Добавьте в файл следующее содержимое:

   ```text
   port 1194
   proto udp
   dev tun
   ca ca.crt
   cert server.crt
   key server.key
   dh dh.pem
   auth SHA256
   server 10.8.0.0 255.255.255.0
   ifconfig-pool-persist ipp.txt
   push "redirect-gateway def1 bypass-dhcp"
   push "dhcp-option DNS 8.8.8.8"
   push "dhcp-option DNS 8.8.4.4"
   keepalive 10 120
   cipher AES-256-GCM
   user nobody
   group nogroup
   persist-key
   persist-tun
   status openvpn-status.log
   log-append /var/log/openvpn.log
   verb 3
   ```

### Настройте сеть {#configure-network}

1. Включите IP-форвардинг:

   ```bash
   echo 'net.ipv4.ip_forward=1' | sudo tee -a /etc/sysctl.conf
   sudo sysctl -p
   ```

1. Откройте порт для OpenVPN в файрволе:

   ```bash
   sudo ufw allow 1194/udp
   sudo ufw allow OpenSSH
   ```

1. Настройте NAT-маскарадинг для VPN-подсети:

   ```bash
   sudo iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
   sudo iptables-save | sudo tee /etc/iptables/rules.v4
   ```

### Запустите OpenVPN-сервер {#start-server}

1. Запустите OpenVPN-сервер:

   ```bash
   sudo systemctl start openvpn@server
   sudo systemctl enable openvpn@server
   ```
1. Проверьте статус OpenVPN-сервера:

   ```bash
   systemctl status openvpn@server
   ```

### Создайте клиентский сертификат {#client-cert}

1. Перейдите в каталог Easy-RSA и сгенерируйте клиентский сертификат:

   ```bash
   cd /etc/openvpn/easy-rsa/
   sudo ./easyrsa gen-req client1 nopass
   sudo ./easyrsa sign-req client client1
   ```

1. Создайте конфигурационный файл клиента `~/client1.ovpn`:

   ```bash
   nano ~/client1.ovpn
   ```

1. Добавьте в файл следующее содержимое, указав сертификаты и ключи:

   ```text
   client
   dev tun
   proto udp
   remote <публичный_IP-адрес_или_домен_сервера> 1194
   resolv-retry infinite
   nobind
   persist-key
   persist-tun
   remote-cert-tls server
   auth SHA256
   cipher AES-256-GCM
   verb 3
   <ca>
   -----BEGIN CERTIFICATE-----
   # Вставьте содержимое /etc/openvpn/ca.crt
   -----END CERTIFICATE-----
   </ca>
   <cert>
   -----BEGIN CERTIFICATE-----
   # Вставьте содержимое /etc/openvpn/easy-rsa/pki/issued/client1.crt
   -----END CERTIFICATE-----
   </cert>
   <key>
   -----BEGIN PRIVATE KEY-----
   # Вставьте содержимое /etc/openvpn/easy-rsa/pki/private/client1.key
   -----END PRIVATE KEY-----
   </key>
   key-direction 1
   ```

## Создайте OIDC-приложение в Yandex Identity Hub {#create-app}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения**.
  1. В центре страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **Создать приложение** и в открывшемся окне:
      1. Выберите метод единого входа **OIDC (OpenID Connect)**.
      1. В поле **Имя** задайте имя создаваемого приложения, например `openvpn-oidc-app`.
      1. В поле **Каталог** выберите каталог, в котором будет создан OAuth-клиент для приложения.
      1. (Опционально) В поле **Описание** задайте описание приложения.
      1. Нажмите **Создать приложение**.
  1. На странице созданного приложения справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **Редактировать** и в открывшемся окне:
      1. В поле **Redirect URI** укажите Redirect URI в формате:

         ```text
         https://<доменное_имя>:9000/oauth2/callback
         ```

      1. В поле **Scopes** отметьте атрибуты `email`, `profile`.
      1. Нажмите **Сохранить**.
  1. В блоке **Секреты приложения** нажмите кнопку **Добавить секрет** и в открывшемся окне:
     
     1. (Опционально) Добавьте произвольное описание создаваемого секрета.
     1. Нажмите **Создать**.
     
     В окне отобразится сгенерированный [секрет приложения](../../../organization/concepts/applications.md#oidc-secret). Сохраните полученное значение.
     
     {% note warning %}
     
     После обновления или закрытия страницы с информацией о приложении посмотреть секрет будет невозможно.
     
     {% endnote %}
     
     Если вы закрыли или обновили страницу, не сохранив сгенерированный секрет, используйте кнопку **Добавить секрет**, чтобы создать новый.
     
     Чтобы удалить секрет, в списке секретов на странице OIDC-приложения в строке с нужным секретом нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **Удалить**.

     Сохраните значение секрета — оно понадобится при настройке плагина `openvpn-auth-oauth2`.

  1. В блоке **Конфигурация поставщика удостоверений (IdP)** скопируйте значение поля **ClientID** — оно понадобится при настройке плагина.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Создайте OAuth-клиент:

     ```bash
     yc iam oauth-client create \
       --name openvpn-oauth-client \
       --scopes openid,email,profile \
       --redirect-uris "https://<доменное_имя>:9000/oauth2/callback"
     ```

     Где:

     * `--name` — имя OAuth-клиента.
     * `--scopes` — набор атрибутов пользователей, которые будут доступны OpenVPN:
       * `openid` — идентификатор пользователя. Обязательный атрибут.
       * `email` — адрес электронной почты пользователя.
       * `profile` — дополнительная информация о пользователе.
     * `--redirect-uris` — URI перенаправления после аутентификации.

     Результат:

     ```text
     id: ajeqqip130i1********
     name: openvpn-oauth-client
     folder_id: b1g500m2195v********
     status: ACTIVE
     ```

     Сохраните значение поля `id` — оно понадобится для создания приложения.

  1. Создайте секрет для OAuth-клиента:

     ```bash
     yc iam oauth-client-secret create \
       --oauth-client-id <идентификатор_OAuth-клиента>
     ```

     Результат:

     ```text
     oauth_client_secret:
       id: ajeq9jfrmc5t********
       oauth_client_id: ajeqqip130i1********
       masked_secret: yccs__939233b8ac****
       created_at: "2025-10-21T10:14:17.861652377Z"
     secret_value: yccs__939233b8ac********
     ```

     Сохраните значение поля `secret_value` — оно понадобится при настройке плагина `openvpn-auth-oauth2`.

  1. Создайте OIDC-приложение:

     ```bash
     yc organization-manager idp application oauth application create \
       --organization-id <идентификатор_организации> \
       --name openvpn-oidc-app \
       --description "OIDC-приложение для интеграции с OpenVPN Community Edition" \
       --client-id <идентификатор_OAuth-клиента> \
       --authorized-scopes openid,email,profile
     ```

     Где:

     * `--organization-id` — [идентификатор организации](../../../organization/operations/organization-get-id.md).
     * `--name` — имя OIDC-приложения.
     * `--description` — описание приложения. Необязательный параметр.
     * `--client-id` — идентификатор OAuth-клиента, полученный на предыдущем шаге.
     * `--authorized-scopes` — те же атрибуты, которые были указаны при создании OAuth-клиента.

     Результат:

     ```text
     id: ek0o663g4rs2********
     name: openvpn-oidc-app
     organization_id: bpf2c65rqcl8********
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
         - email
         - profile
     status: ACTIVE
     created_at: "2025-10-21T10:51:28.790866Z"
     ```

{% endlist %}

### Добавьте пользователей в приложение {#add-users}

Чтобы пользователи вашей организации могли аутентифицироваться в OpenVPN через OIDC-приложение Yandex Identity Hub, добавьте в приложение нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md).

{% note info %}

Управлять пользователями и группами, добавленными в OIDC-приложение, может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-oidcApplications-userAdmin) `organization-manager.oidcApplications.userAdmin` или выше.

{% endnote %}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите созданное приложение.
  1. Перейдите на вкладку **Пользователи и группы**.
  1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **Добавить пользователей**.
  1. В открывшемся окне выберите нужного пользователя или группу пользователей.
  1. Нажмите **Добавить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Получите [идентификатор пользователя](../../../organization/operations/users-get.md) или [группы пользователей](../../../organization/operations/group-get-id.md).

  1. Добавьте пользователя или группу в приложение:

     ```bash
     yc organization-manager idp application oauth application add-assignments \
       --id <идентификатор_приложения> \
       --subject-id <идентификатор_пользователя_или_группы>
     ```

     Где:

     * `--id` — идентификатор OIDC-приложения.
     * `--subject-id` — идентификатор пользователя или группы пользователей.

     Результат:

     ```text
     assignment_deltas:
       - action: ADD
         assignment:
           subject_id: ajetvnq2mil8********
     ```

{% endlist %}

## Установите и настройте плагин openvpn-auth-oauth2 {#setup-plugin}

### Установите плагин {#install-plugin}

На ВМ с OpenVPN выполните следующие команды:

```bash
curl -L https://raw.githubusercontent.com/jkroepke/openvpn-auth-oauth2/refs/heads/main/packaging/apt/openvpn-auth-oauth2.sources | sudo tee /etc/apt/sources.list.d/openvpn-auth-oauth2.sources
sudo apt update
sudo apt install openvpn-auth-oauth2
```

### Подготовьте TLS-сертификат {#prepare-tls}

Плагин `openvpn-auth-oauth2` требует TLS-сертификат для защиты соединения на порту `9000`.

{% note tip %}

Разработчики плагина [рекомендуют](https://github.com/jkroepke/openvpn-auth-oauth2/blob/main/docs/Configuration.md#openvpn-auth-oauth2-config) не завершать TLS-соединения непосредственно в `openvpn-auth-oauth2`, а использовать для этого отдельный обратный прокси-сервер (reverse proxy). Реализовать этот подход можно с помощью [Yandex Application Load Balancer](../../../application-load-balancer/tutorials/tls-termination/index.md).

{% endnote %}

1. Если у вас есть сертификат в [Yandex Certificate Manager](../../../certificate-manager/index.md), экспортируйте его с помощью [Yandex Cloud CLI](../../../cli/index.md):

   ```bash
   yc certificate-manager certificates content \
     --id <идентификатор_сертификата> \
     --chain tls.crt \
     --key tls.key
   ```

1. Создайте каталог для файлов плагина и перенесите в него сертификат и ключ:

   ```bash
   sudo mkdir -p /etc/openvpn-auth-oauth2
   sudo mv tls.crt tls.key /etc/openvpn-auth-oauth2/
   sudo chown root:openvpn-auth-oauth2 /etc/openvpn-auth-oauth2/tls.key
   sudo chown root:openvpn-auth-oauth2 /etc/openvpn-auth-oauth2/tls.crt
   ```

### Создайте файл конфигурации плагина {#plugin-config}

1. Создайте файл `/etc/openvpn-auth-oauth2/config.yaml`:

   ```bash
   sudo nano /etc/openvpn-auth-oauth2/config.yaml
   ```

1. Добавьте в файл следующее содержимое:

   ```yaml
   http:
     listen: :9000
     baseurl: https://<доменное_имя>:9000
     tls: true
     key: /etc/openvpn-auth-oauth2/tls.key
     cert: /etc/openvpn-auth-oauth2/tls.crt
     secret: <произвольная_строка_длиной_16_символов>
   openvpn:
     addr: unix:///run/openvpn/server.sock
     password: <пароль_управляющего_интерфейса>
   oauth2:
     issuer: https://auth.yandex.cloud
     client:
       id: <идентификатор_OAuth-клиента>
       secret: <значение_секрета_приложения>
     endpoint:
       discovery: https://auth.yandex.cloud/.well-known/openid-configuration
     scopes:
       - openid
       - profile
       - email
   ```

   Где:

   * `http.baseurl` — публичный URL плагина в формате `https://<доменное_имя>:9000`.
   * `http.secret` — произвольная строка длиной не менее 16 символов для защиты сессий.
   * `openvpn.password` — пароль для подключения плагина к управляющему интерфейсу OpenVPN. Сохраните это значение — оно должно совпадать с содержимым файла `/etc/openvpn/password.txt`.
   * `oauth2.client.id` — идентификатор OAuth-клиента, полученный при создании OIDC-приложения.
   * `oauth2.client.secret` — значение секрета приложения, сохраненное при создании OIDC-приложения.

   Подробнее о настройке читайте в [Документации openvpn-auth-oauth2](https://github.com/jkroepke/openvpn-auth-oauth2/blob/main/docs/Configuration.md).

### Настройте управляющий интерфейс OpenVPN {#configure-management}

1. Создайте файл с паролем управляющего интерфейса:

   ```bash
   echo '<пароль_управляющего_интерфейса>' | sudo tee /etc/openvpn/password.txt
   sudo chmod 600 /etc/openvpn/password.txt
   ```

   {% note warning %}

   Значение пароля в файле `/etc/openvpn/password.txt` должно совпадать со значением параметра `openvpn.password` в файле `/etc/openvpn-auth-oauth2/config.yaml`.

   {% endnote %}

1. Откройте файл `/etc/openvpn/server.conf` и добавьте в конец следующие строки:

   ```text
   management /run/openvpn/server.sock unix /etc/openvpn/password.txt
   management-hold
   management-client-auth
   ```

1. Перезапустите OpenVPN:

   ```bash
   sudo systemctl restart openvpn@server
   sudo systemctl status openvpn@server
   ```

1. Откройте порт `9000` в файрволе:

   ```bash
   sudo ufw allow 9000/tcp
   ```

### Запустите плагин как системный сервис {#start-plugin-service}

1. Создайте файл юнита systemd:

   ```bash
   sudo nano /etc/systemd/system/openvpn-auth-oauth2.service
   ```

   Добавьте в файл следующее содержимое:

   ```ini
   [Unit]
   Description=openvpn-auth-oauth2
   Requires=openvpn@server.service
   After=openvpn@server.service

   [Service]
   ExecStart=openvpn-auth-oauth2 --config /etc/openvpn-auth-oauth2/config.yaml
   Restart=on-failure
   User=root

   [Install]
   WantedBy=multi-user.target
   ```

1. Перезагрузите конфигурацию systemd, включите и запустите сервис:

   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable openvpn-auth-oauth2.service
   sudo systemctl start openvpn-auth-oauth2.service
   sudo systemctl status openvpn-auth-oauth2.service
   ```

## Проверьте работу интеграции {#validate}

1. Установите [OpenVPN-клиент](https://openvpn.net/community-downloads/) на клиентское устройство.

1. Импортируйте клиентский конфигурационный файл `client1.ovpn` в OpenVPN-клиент.

1. Инициируйте подключение к VPN-серверу. OpenVPN-клиент откроет браузер и перенаправит вас на страницу аутентификации Yandex Cloud.

1. Введите учетные данные пользователя, добавленного в OIDC-приложение.

1. После успешной аутентификации VPN-соединение будет установлено.

1. Проверьте связь с VPN-сервером:

   ```bash
   ping 10.8.0.1
   ```

   Ожидаемый результат — успешный пинг без потерь.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../../compute/operations/vm-control/vm-delete.md) ВМ.
1. [Удалите](../../../organization/operations/applications/oidc-deactivate-remove.md#delete) OIDC-приложение.