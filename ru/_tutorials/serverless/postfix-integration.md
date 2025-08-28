В этом руководстве вы научитесь отправлять электронные письма через [{{ postbox-full-name }}](../../postbox/) с использованием [Postfix](https://ru.wikipedia.org/wiki/Postfix) на виртуальной машине [{{ compute-full-name }}](../../compute/).

Чтобы начать отправлять электронные письма:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте ВМ для Postfix](#vm-postfix).
1. [Установите и настройте Postfix](#install-postfix).
1. [Отправьте письмо](#send-email).
1. [Отправьте MIME-письмо с вложением](#send-mime).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за постоянно запущенную ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md));
* плата за использование {{ postbox-full-name }} (см. [тарифы {{ postbox-name }}](../../postbox/pricing.md));
* плата за публичные [DNS-запросы](../../glossary/dns.md) и [зоны DNS](../../dns/concepts/dns-zone.md), если вы создаете ресурсную запись в {{ dns-name }} (см. [тарифы {{ dns-name }}](../../dns/pricing.md)).


### Подготовьте ресурсы {#infrastructure}

1. [Создайте](../../postbox/operations/create-address.md) адрес.
1. [Пройдите](../../postbox/operations/check-domain.md) проверку владения доменом.
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт в том же каталоге, в котором находится адрес. Если вы создадите сервисный аккаунт и адрес в разных каталогах, при попытке отправить письмо возникнет ошибка.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../../postbox/security/index.md#postbox-sender) `postbox.sender`.
1. Создайте ключ для сервисного аккаунта:

    * Для отправки письма по протоколу SMTP с аутентификацией по API-ключу [создайте](../../iam/operations/authentication/manage-api-keys.md#create-api-key) API-ключ. При создании API-ключа задайте область действия `yc.postbox.send`. Надежно сохраните полученный секретный ключ. После того как вы закроете окно, параметры секретного ключа станут недоступны.
    * Для отправки письма с помощью AWS CLI или по протоколу SMTP с аутентификацией по паролю [создайте](../../iam/operations/authentication/manage-access-keys.md#create-access-key) статический ключ доступа. Надежно сохраните идентификатор и секретный ключ. После того как вы закроете окно, параметры секретного ключа станут недоступны.

## Создайте ВМ для Postfix {#vm-postfix}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. Нажмите **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Выберите вариант **{{ ui-key.yacloud.compute.instances.create.option_create-form-extended-title }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите образ [Ubuntu 24.04 LTS](/marketplace/products/yc/ubuntu-24-04-lts).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** настройте загрузочный [диск](../../compute/concepts/disk.md):

      * **{{ ui-key.yacloud.compute.disk-form.field_type }}** — `{{ ui-key.yacloud.compute.value_disk-type-network-hdd_cw9XD }}`.
      * **{{ ui-key.yacloud.compute.disk-form.field_size }}** — `20 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** и укажите рекомендуемые параметры для сервера почты:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `100%`.
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `2 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** укажите подсеть в зоне доступности создаваемой ВМ или выберите [облачную сеть](../../vpc/concepts/network.md#network) из списка.

          * У облачной сети должна быть как минимум одна [подсеть](../../vpc/concepts/network.md#subnet). Если подсети нет, создайте ее, выбрав **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
          * Если сети нет, нажмите **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** и создайте ее:

              * В открывшемся окне укажите имя сети и выберите каталог, в котором она будет создана.
              * Нажмите **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, чтобы назначить виртуальной машине случайный внешний IP-адрес из пула {{ yandex-cloud }}, или выберите статический адрес из списка, если вы зарезервировали его заранее.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа к ВМ:

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя, который будет создан на виртуальной машине, например `ubuntu`.

        {% note alert %}

        Не используйте логин `root` или другие имена, зарезервированные операционной системой. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.

        {% endnote %}

      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ.  Требования к имени:

      {% include [name-format](../../_includes/name-format.md) %}

      {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

  1. Нажмите **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания виртуальной машины:

      ```bash
      yc compute instance create --help
      ```

  1. Создайте виртуальную машину в каталоге по умолчанию:

      ```bash
      yc compute instance create \
        --name postfix-server \
        --zone {{ region-id }}-b \
        --platform-id standard-v3 \
        --cores 2 \
        --core-fraction 100 \
        --memory 2 \
        --create-boot-disk image-family=ubuntu-2404-lts,image-folder-id=standard-images,size=20GB,type=network-hdd \
        --network-interface subnet-name=<имя_подсети>,nat-ip-version=ipv4 \
        --ssh-key <путь_к_SSH-ключу>
      ```

      Где:

      * `--name` — имя ВМ. Требования к имени:

          {% include [name-format](../../_includes/name-format.md) %}

          {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

      * `--zone` — [зона доступности](../../overview/concepts/geo-scope.md), которая соответствует выбранной подсети.
      * `--platform-id` — [платформа](../../compute/concepts/vm-platforms.md)
      * `--cores` — [количество vCPU](../../compute/concepts/vm.md) ВМ.
      * `--core-fraction` — гарантированная доля vCPU в %.
      * `--memory` — [объем оперативной памяти](../../compute/concepts/vm.md) ВМ.
      * `--create-boot-disk` — параметры загрузочного диска: `size` — размер, `image-id` — идентификатор используемого образа.
      * `--network-interface` — настройки [сетевого интерфейса](../../compute/concepts/network.md) ВМ:

          * `subnet-name` — имя выбранной подсети.
          * `nat-ip-version=ipv4` – [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses). Чтобы создать ВМ без публичного IP-адреса, исключите параметр.

      * `--ssh-key` — путь к файлу и имя файла с открытой частю SSH-ключа. Пару SSH-ключей необходимо [создать самостоятельно](../../compute/operations/vm-connect/ssh.md).

      Результат:

      ```text
      id: epde5biu1a4e********
      folder_id: b1g681qpemb4********
      created_at: "2025-08-20T11:01:11Z"
      name: postfix-server
      zone_id: {{ region-id }}-b
      platform_id: standard-v3
      resources:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      status: RUNNING
      metadata_options:
        gce_http_endpoint: ENABLED
        aws_v1_http_endpoint: ENABLED
        gce_http_token: ENABLED
        aws_v1_http_token: DISABLED
      boot_disk:
        mode: READ_WRITE
        device_name: epd1akno91gv********
        auto_delete: true
        disk_id: epd1akno91gv********
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:**:**:**:**
          subnet_id: e2lb1da2dd9v********
          primary_v4_address:
            address: 10.129.**.**
            one_to_one_nat:
              address: 84.201.***.***
              ip_version: IPV4
      serial_port_settings:
        ssh_authorization: OS_LOGIN
      gpu_settings: {}
      fqdn: epde5biu1a4e********.auto.internal
      scheduling_policy: {}
      network_settings:
        type: STANDARD
      placement_policy: {}
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V1
      ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../compute/api-ref/Instance/create.md) для ресурса [Instance](../../compute/api-ref/Instance/) или вызовом gRPC API [InstanceService/Create](../../compute/api-ref/grpc/Instance/create.md).

{% endlist %}


## Установите и настройте Postfix {#install-postfix}

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к ВМ по SSH:

    ```bash
    ssh -i <путь_к_закрытому_SSH-ключу> <имя_пользователя_ВМ>@<публичный_IP-адрес_ВМ>
    ```

1. Установите Postfix и необходимые модули:

    ```bash
    sudo apt update
    sudo apt install -y postfix libsasl2-modules
    ```

1. После установки в терминале появится интерфейс настройки Postfix:

    1. На первом шаге выберите `Internet with smarthost`, затем с помощью клавиш **TAB** и **Enter** нажмите **OK**.
    1. Нажмите **OK** на всех последующих шагах.
    1. Дождитесь завершения настройки.

1. Выполните команду настройки Postfix:

    ```bash
    sudo postconf -e \
    "relayhost = {{ postbox-host }}:587" \
    "smtp_sasl_auth_enable = yes" \
    "smtp_sasl_security_options = noanonymous" \
    "smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd" \
    "smtp_use_tls = yes" \
    "smtp_tls_security_level = secure" \
    "smtp_tls_note_starttls_offer = yes"
    ```

1. Проверьте, не задана ли в конфигурации директива резервного узла доставки, и отключите ее:

    1. Откройте файл `/etc/postfix/master.cf` и найдите строку:

        ```text
        -o smtp_fallback_relay=
        ```

    1. Если такая строка есть, закомментируйте ее, добавив символ `#` в начало строки.
    1. Сохраните файл.

1. Укажите учетные данные SMTP для {{ postbox-full-name }}:

    1. Откройте (или создайте) файл `/etc/postfix/sasl_passwd` и добавьте в него строку:

        ```text
        {{ postbox-host }}:587 SMTP_USERNAME:SMTP_PASSWORD
        ```

    1. Аутентифицируйтесь:

        {% list tabs group=auth_keys %}

        - API-ключ {#api-key}

          В файле `/etc/postfix/sasl_passwd`:

          * Замените `SMTP_USERNAME` на идентификатор API-ключа, который вы получили при [подготовке ресурсов](#infrastructure).
          * Замените `SMTP_PASSWORD` на секретную часть API-ключа.

        - Cтатический ключ доступа {#static-key}

          1. Создайте файл `generate.py` и вставьте в него код:

              ```python
              #!/usr/bin/env python3

              import hmac
              import hashlib
              import base64
              import argparse
              import sys

              # These values are required to calculate the signature. Do not change them.
              DATE = "20230926"
              SERVICE = "postbox"
              MESSAGE = "SendRawEmail"
              REGION = "{{ region-id }}"
              TERMINAL = "aws4_request"
              VERSION = 0x04


              def sign(key, msg):
                  return hmac.new(key, msg.encode("utf-8"), hashlib.sha256).digest()


              def calculate_key(secret_access_key):
                  signature = sign(("AWS4" + secret_access_key).encode("utf-8"), DATE)
                  signature = sign(signature, REGION)
                  signature = sign(signature, SERVICE)
                  signature = sign(signature, TERMINAL)
                  signature = sign(signature, MESSAGE)
                  signature_and_version = bytes([VERSION]) + signature
                  smtp_password = base64.b64encode(signature_and_version)
                  return smtp_password.decode("utf-8")


              def main():
                  if sys.version_info[0] < 3:
                      raise Exception("Must be using Python 3")

                  parser = argparse.ArgumentParser(
                      description="Convert a Secret Access Key to an SMTP password."
                  )
                  parser.add_argument("secret", help="The Secret Access Key to convert.")
                  args = parser.parse_args()

                  print(calculate_key(args.secret))


              if __name__ == "__main__":
                  main()
              ```

          1. Сгенерируйте пароль:

              ```bash
              python3 generate.py <секретный_ключ>
              ```

              Где `<секретный_ключ>` — секретный ключ статического ключа доступа сервисного аккаунта, который вы получили при [подготовке ресурсов](#infrastructure).

              Используйте Python не ниже версии 3.

          1. В файле `/etc/postfix/sasl_passwd`:

              * Замените `SMTP_USERNAME` на идентификатор статического ключа доступа.
              * Замените `SMTP_PASSWORD` на сгенерированный пароль.

        {% endlist %}

    1. Сохраните файл `/etc/postfix/sasl_passwd`.

1. Создайте хеш-таблицу с учетными данными:

    ```bash
    sudo postmap hash:/etc/postfix/sasl_passwd
    ```

1. (Рекомендуется) Ограничьте доступ к файлам с учетными данными:

    ```bash
    sudo chown root:root /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
    sudo chmod 0600 /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
    ```

1. Укажите корневой сертификат для проверки TLS-соединения:

    ```bash
    sudo postconf -e 'smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt'
    ```

1. Перезапустите Postfix, чтобы применить настройки:

    ```bash
    sudo systemctl restart postfix
    ```

## Отправьте письмо {#send-email}

В этом примере вы отправите письмо с простым текстом без вложений.

1. Выполните команду:

    ```bash
    sendmail -f <адрес_отправителя> <адрес_получателя>
    ```

    {% note warning %}

    Здесь и далее адрес отправителя должен соответствовать домену, для которого вы проходили проверку владения при [подготовке ресурсов](#infrastructure).

    {% endnote %}

1. Вставьте в терминал следующий текст и нажмите **Enter**:

    ```text
    From: <адрес_отправителя>
    Subject: Test {{ postbox-full-name }} via Postfix

    This is a test message sent via {{ postbox-full-name }} (SMTP, Postfix).
    .
    ```

1. Проверьте почтовый ящик получателя.

    Если письмо не пришло, изучите лог Postfix: `/var/log/mail.log`.

{% cut "Подробности отправки сообщения" %}

* После запуска команды `sendmail -f ... <адрес_получателя>` терминал перейдет в интерактивный режим ввода письма.
* Сначала введите заголовки, по одному на строку. Минимум: `From:` и `Subject:`.

    * Заголовок `From:` должен соответствовать домену, разрешенному в {{ postbox-full-name }}.
    * Заголовок `To:` можно добавить для наглядности, но он не обязателен — получатель уже задан в команде.

* Вставьте пустую строку, чтобы отделить заголовки от тела письма.
* Введите текст письма. Можно несколько строк.
* Завершите ввод, поставив одиночную точку на отдельной строке и нажав **Enter**. В этой строке не должно быть пробелов.
* При успешной отправке `sendmail` завершится без вывода. Для подробного отладочного вывода используйте ключ `-v`:

    ```bash
    sendmail -v -f <адрес_отправителя> <адрес_получателя>
    ```

* Чтобы отменить ввод без отправки, нажмите `Ctrl+C`.
* Для нескольких получателей перечислите их через пробел в команде:

    ```bash
    sendmail -f <адрес_отправителя> <адрес_получателя_1> <адрес_получателя_2>
    ```

* Не используйте в примере не-ASCII-текст. Если требуется не-ASCII (UTF-8), кодируйте:

    * Заголовки по RFC 2047 (пример для темы): `Subject: =?UTF-8?B?BASE64_ENCODED_SUBJECT?=`.
    * Тело письма через MIME с `charset=UTF-8` и `Content-Transfer-Encoding: quoted-printable` или `base64`.

* Для адресов с международными доменами используйте [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode) ([IDNA](https://ru.wikipedia.org/wiki/IDN)), например:

    ```bash
    sendmail -f user@xn--d1acpjx3f.xn--p1ai recipient@xn--e1afmkfd.xn--p1ai
    From: <user@xn--d1acpjx3f.xn--p1ai>
    ```

{% endcut %}


## Отправьте MIME-письмо с вложением {#send-mime}

В этом примере вы отправите письмо с текстом в формате HTML и прикрепленным файлом `example.txt`.

1. Создайте файл `mime-email.txt` и вставьте в него код:

    ```text
    From: <адрес_отправителя>
    Subject: Test email via {{ postbox-full-name }}
    MIME-Version: 1.0
    Content-Type: multipart/mixed; boundary="BOUNDARY-OUTER"

    --BOUNDARY-OUTER
    Content-Type: multipart/alternative; boundary="BOUNDARY-INNER"

    --BOUNDARY-INNER
    Content-Type: text/plain; charset=UTF-8
    Content-Transfer-Encoding: quoted-printable

    This is the plain text part sent via {{ postbox-full-name }} SMTP.

    --BOUNDARY-INNER
    Content-Type: text/html; charset=UTF-8
    Content-Transfer-Encoding: quoted-printable

    <html>
      <body>
        <h1>Hello!</h1>
        <p>This is the HTML part sent via {{ postbox-full-name }} SMTP.</p>
      </body>
    </html>
    --BOUNDARY-INNER--

    --BOUNDARY-OUTER
    Content-Type: application/octet-stream
    MIME-Version: 1.0
    Content-Transfer-Encoding: base64
    Content-Disposition: attachment; filename="example.txt"

    U2FtcGxlIGF0dGFjaG1lbnQgY29udGVudA==
    --BOUNDARY-OUTER--
    ```

    Где:

    * `From:` — адрес отправителя.
    * `Subject:` — тема письма.

1. Отправьте письмо:

    ```bash
    sendmail -f <адрес_отправителя> <адрес_получателя> < mime-email.txt
    ```

1. Проверьте почтовый ящик получателя.

    Если письмо не пришло, изучите лог Postfix: `/var/log/mail.log`.

## Удалите созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../compute/operations/vm-control/vm-delete.md) ВМ `postfix-server`.
1. Удалите [адрес](../../postbox/concepts/glossary.md#adress).
1. [Удалите](../../dns/operations/zone-delete.md) зону DNS, если создавали в ней ресурсную запись.