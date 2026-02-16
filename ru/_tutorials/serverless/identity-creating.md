

В этом руководстве вы с помощью {{ TF }} создадите [адрес](../../postbox/concepts/glossary.md#adress) в [{{ postbox-full-name }}](../../postbox/), а также добавите в [DNS-зону](../../dns/concepts/dns-zone.md) вашего домена необходимые [ресурсные записи](../../dns/concepts/resource-record.md#txt) для подтверждения владения доменом и отправки писем.

Ресурсную запись для подтверждения владения доменом можно добавить в [{{ dns-full-name }}](../../dns/), если вы [делегировали](#delegate) домен, или у вашего регистратора домена.

Для работы с {{ postbox-name }} в руководстве используется API, совместимый с AWS SESv2, поэтому для создания и управления ресурсами {{ postbox-name }} используется провайдер [AWS](https://github.com/hashicorp/terraform-provider-aws). Для управления всеми остальными ресурсами используется провайдер [{{ yandex-cloud }}](https://github.com/yandex-cloud/terraform-provider-yandex).

1. [Подготовьте облако к работе](#before-you-begin).
1. [Делегируйте домен сервису {{ dns-name }}](#delegate).
1. [Подготовьте ключи для подписи электронных писем](#generate-keys).
1. [Создайте инфраструктуру](#deploy).
1. [Проверьте работу сервиса](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для создания адреса, подтверждения владения доменом и отправки писем входят:
* плата за отправленные [электронные письма](../../postbox/concepts/index.md) (см. тарифы [{{ postbox-name }}](../../postbox/pricing.md));
* плата за публичные [DNS-запросы](../../glossary/dns.md) и [зоны DNS](../../dns/concepts/dns-zone.md), если вы используете [{{ dns-full-name }}](../../dns/) (см. [тарифы {{ dns-name }}](../../dns/pricing.md)).


## Делегируйте домен сервису {{ dns-name }} {#delegate}

Если у вас есть зарегистрированное доменное имя, то вы можете воспользоваться {{ dns-full-name }} для управления доменом.

{% include [dns-delegate](../_tutorials_includes/bind-domain-vm/dns-delegate.md) %}


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

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

Для создания инфраструктуры с помощью {{ TF }}:
1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
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

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

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
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
1. Выберите созданный адрес и убедитесь, что статус проверки на странице адреса изменился на `Success`.
1. [Отправьте](../../postbox/operations/send-email.md) тестовое письмо.


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `postbox-email-identity.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}
