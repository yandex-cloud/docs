# Создание адреса {{ postbox-full-name }} и проверка владения доменом с помощью {{ TF }}

В этом руководстве вы с помощью {{ TF }} создадите [адрес](../../postbox/concepts/glossary.md#adress) в [{{ postbox-full-name }}](../../postbox/index.md), а также добавите в [DNS-зону](../../dns/concepts/dns-zone.md) вашего домена необходимые [ресурсные записи](../../dns/concepts/resource-record.md#txt) для подтверждения владения доменом и отправки писем.

Ресурсную запись для подтверждения владения доменом можно добавить в [{{ dns-full-name }}](../../dns/index.md), если вы [делегировали](#delegate) домен, или у вашего регистратора домена.

Для работы с {{ postbox-name }} в руководстве используется API, совместимый с AWS SESv2, поэтому для создания и управления ресурсами {{ postbox-name }} используется провайдер [AWS](https://github.com/hashicorp/terraform-provider-aws). Для управления всеми остальными ресурсами используется провайдер [{{ yandex-cloud }}](https://github.com/yandex-cloud/terraform-provider-yandex).

1. [Подготовьте облако к работе](#before-you-begin).
1. [Делегируйте домен сервису {{ dns-name }}](#delegate).
1. [Подготовьте ключи для подписи электронных писем](#generate-keys).
1. [Создайте инфраструктуру](#deploy).
1. [Проверьте работу сервиса](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для создания адреса, подтверждения владения доменом и отправки писем входят:
* плата за отправленные [электронные письма](../../postbox/concepts/index.md) (см. тарифы [{{ postbox-name }}](../../postbox/pricing.md));
* плата за публичные [DNS-запросы](../../glossary/dns.md) и [зоны DNS](../../dns/concepts/dns-zone.md), если вы используете [{{ dns-full-name }}](../../dns/index.md) (см. [тарифы {{ dns-name }}](../../dns/pricing.md)).


## Делегируйте домен сервису {{ dns-name }} {#delegate}

Если у вас есть зарегистрированное доменное имя, то вы можете воспользоваться {{ dns-full-name }} для управления доменом.

Чтобы делегировать домен сервису {{ dns-name }}, в личном кабинете вашего регистратора домена укажите в настройках домена адреса DNS-серверов:

* `ns1.{{ dns-ns-host-sld }}`
* `ns2.{{ dns-ns-host-sld }}`

Делегирование происходит не сразу. Серверы интернет-провайдеров обычно обновляют записи в течение 24 часов (86400 секунд). Это обусловлено значением TTL, в течение которого кешируются записи для доменов.

Проверить делегирование домена можно с помощью [сервиса Whois](https://www.reg.ru/whois/check_site) или утилиты `dig`:

```bash
dig +short NS example.com
```

Результат:

```
ns2.{{ dns-ns-host-sld }}.
ns1.{{ dns-ns-host-sld }}.
```


## Подготовьте ключи для подписи электронных писем {#generate-keys}

Для подписи электронных писем создайте [RSA](https://ru.wikipedia.org/wiki/RSA)-ключ. Воспользуйтесь скриптом для создания ключа, так как AWS-провайдер ожидает ключ не в формате [PEM](https://ru.wikipedia.org/wiki/Почта_с_повышенной_секретностью), а в виде строки, из которой удалены переносы и убраны первая и последняя строки. 

1. Создайте скрипт `generate-key.sh` со следующим содержимым:

   ```bash
   #!/bin/bash

   # Generate private key
   openssl genrsa -out raw_privatekey.pem 2048

   # Generate public key from the private key
   openssl rsa -in raw_privatekey.pem -pubout -out publickey.pem

   # Process private key for AWS (remove headers and line breaks)
   cat raw_privatekey.pem | grep -v "BEGIN" | grep -v "END" | tr -d '\n' > privatekey.pem

   # Format public key for DKIM DNS TXT record
   # Remove headers, strip newlines and concatenate for DNS TXT record
   DKIM_DNS_VALUE=$(cat publickey.pem | grep -v "BEGIN" | grep -v "END" | tr -d '\n')
   echo "$DKIM_DNS_VALUE" > dkim_dns_value.txt

   echo "Keys generated:"
   echo "- privatekey.pem (AWS-formatted private key)"
   echo "- publickey.pem (Public key)"
   echo "- raw_privatekey.pem (Original private key with headers)"
   echo "- dkim_dns_value.txt (Public key formatted for DKIM DNS TXT record)"
   ```

1. В терминале перейдите в папку со скриптом и выполните:

   ```bash
   ./generate-key.sh
   ```

В результате выполнения скрипта будут созданы:
* `privatekey.pem` — приватный ключ в формате AWS-провайдера;
* `publickey.pem` — публичный ключ;
* `raw_privatekey.pem` — оригинальный приватный ключ;
* `dkim_dns_value.txt` — значение для создания DKIM-записи.


## Создайте инфраструктуру {#deploy}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

Для создания инфраструктуры с помощью {{ TF }}:
1. [Установите {{ TF }}](../infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

     1. Клонируйте репозиторий с конфигурационными файлами.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-postbox-tf.git
        ```

     1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
        * `postbox-email-identity.tf` — конфигурация создаваемой инфраструктуры.
        * `postbox-email-identity.auto.tfvars` — файл с пользовательскими данными.

   Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:
   * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
   * [Назначение прав доступа](../../iam/concepts/access-control/roles.md) — [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
   * [Статический ключ доступа](../../iam/concepts/authorization/access-key.md) — [yandex_iam_service_account_static_access_key]({{ tf-provider-resources-link }}/iam_service_account_static_access_key).
   * [DNS-зона](../../dns/concepts/dns-zone.md) — [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone).
   * [Ресурсная запись DNS](../../dns/concepts/resource-record.md) — [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset).

1. В файле `postbox-email-identity.auto.tfvars` задайте пользовательские параметры:
   * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
   * `domain_signing_selector` — селектор для подписи домена, например `_postbox`.
   * `domain` — домен для отправки писем, например `mail.example.com`.
   * `dns_zone_name` — имя существующей DNS-зоны, в которую будет добавлена запись.

1. Создайте ресурсы:

   1. В терминале перейдите в директорию с конфигурационным файлом.
   1. Проверьте корректность конфигурации с помощью команды:
   
      ```bash
      terraform validate
      ```
   
      Если конфигурация является корректной, появится сообщение:
   
      ```bash
      Success! The configuration is valid.
      ```
   
   1. Выполните команду:
   
      ```bash
      terraform plan
      ```
   
      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
   1. Примените изменения конфигурации:
   
      ```bash
      terraform apply
      ```
   
   1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

{% note info %}

Если вы используете другой DNS-сервис, то следует самостоятельно добавить DKIM-запись в соответствии с его документацией. Значение DKIM-записи можно получить, используя следующий код для {{ TF }}:

```hcl
output "dkim_record" {
  value = {
    value = "v=DKIM1;h=sha256;k=rsa;p=${trim(local.public_key, "\n")}"
    name  = "${var.domain_signing_selector}._domainkey.${var.domain}"
    type  = "TXT"
    ttl   = 3600
  }
}
```

{% endnote %}

После создания инфраструктуры, [проверьте работу сервиса](#test).


## Проверьте работу сервиса {#test}

Убедитесь, что адрес успешно создан, и отправьте тестовое письмо:
1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором создавали адрес.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
1. Выберите созданный адрес и убедитесь, что статус проверки на странице адреса изменился на `Success`.
1. [Отправьте](../../postbox/operations/send-email.md) тестовое письмо.


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `postbox-email-identity.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    1. В терминале перейдите в директорию с конфигурационным файлом.
    1. Проверьте корректность конфигурации с помощью команды:
    
       ```bash
       terraform validate
       ```
    
       Если конфигурация является корректной, появится сообщение:
    
       ```bash
       Success! The configuration is valid.
       ```
    
    1. Выполните команду:
    
       ```bash
       terraform plan
       ```
    
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
    1. Примените изменения конфигурации:
    
       ```bash
       terraform apply
       ```
    
    1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.