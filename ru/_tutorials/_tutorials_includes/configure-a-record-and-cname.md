В инструкции ниже описана настройка DNS для доменного имени `example.com`.

### Добавьте зону DNS {#create-dns-zone}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы добавить [публичную зону DNS](../../dns/concepts/dns-zone.md#public-zones):
   1. Откройте раздел **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}** в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder), где требуется создать [зону DNS](../../dns/concepts/dns-zone.md).
   1. Нажмите кнопку **{{ ui-key.yacloud.dns.button_zone-create }}**.
   1. Задайте настройки зоны DNS:
      * **{{ ui-key.yacloud.dns.label_zone }}** — `example.com.`. Или укажите ваш зарегистрированный домен.
      * **{{ ui-key.yacloud.common.type }}** — `{{ ui-key.yacloud.dns.label_public }}`.
      * **{{ ui-key.yacloud.common.name }}** — `example-zone-1`.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Добавьте ресурсные записи {#create-dns-records}

Создайте в публичной зоне записи DNS:

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}** на странице [виртуальной машины](../../compute/concepts/vm.md) в [консоли управления]({{ link-console-main }}) найдите [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses) ВМ.
   1. Создайте запись [типа А](../../dns/concepts/resource-record.md#a):
      * Откройте раздел **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}** в каталоге, где находится зона DNS `example.com`.
      * Выберите зону DNS `example.com` из списка.
      * Нажмите кнопку **{{ ui-key.yacloud.dns.button_record-set-create }}**.
      * Задайте параметры записи:
         * **{{ ui-key.yacloud.common.name }}** — оставьте пустым.
         * **{{ ui-key.yacloud.common.type }}** — оставьте значение `А`.
         * **{{ ui-key.yacloud.dns.label_records }}** — введите публичный адрес вашей ВМ.
         * **{{ ui-key.yacloud.dns.label_form-ttl }}** (время кэширования записи) — оставьте значение по умолчанию.
      * Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
   1. Создайте запись [типа CNAME](../../dns/concepts/resource-record.md#cname):
      * Выберите зону DNS `example.com` из списка.
      * Нажмите кнопку **{{ ui-key.yacloud.dns.button_record-set-create }}**.
      * Задайте параметры записи:
         * **{{ ui-key.yacloud.common.name }}** — `www`.
         * **{{ ui-key.yacloud.common.type }}** — выберите значение `CNAME`.
         * **{{ ui-key.yacloud.dns.label_records }}** — введите `example.com`.
         * **{{ ui-key.yacloud.dns.label_form-ttl }}** (время кэширования записи) — оставьте значение по умолчанию.
      * Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Делегируйте доменное имя {#delegate-domain}

Делегирование — это перенос ответственности с серверов регистратора на ваши серверы. Для домена создаются ресурсные записи [типа NS](../../dns/concepts/resource-record.md#ns) (`ns1.{{ dns-ns-host-sld }}` и `ns2.{{ dns-ns-host-sld }}`).

Чтобы делегировать домен, укажите для него DNS-серверы в личном кабинете регистратора.

Делегирование происходит не сразу. Серверы интернет-провайдеров обычно обновляют записи до 24 часов (86 400 секунд). Это обусловлено значением TTL, в течение которого кэшируются записи для доменов.

Проверить делегирование домена можно с помощью [сервиса Whois](https://www.reg.ru/whois/check_site) или утилиты `dig`:

```bash
dig +short NS example.com
```

Результат:

```text
ns2.{{ dns-ns-host-sld }}.
ns1.{{ dns-ns-host-sld }}.
```