{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.dns.button_zone-create }}**.
  1. Задайте настройки зоны DNS:
     * **{{ ui-key.yacloud.dns.label_zone }}** — укажите ваш зарегистрированный домен, например `example.com.` (с точкой в конце).
     * **{{ ui-key.yacloud.common.type }}** — выберите `{{ ui-key.yacloud.dns.label_public }}`.
     * **{{ ui-key.yacloud.common.name }}** — укажите имя зоны, например `example-zone`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

  1. Делегируйте домен на серверы {{ yandex-cloud }}. Для этого в личном кабинете вашего регистратора доменных имен укажите адреса DNS-серверов `ns1.{{ dns-ns-host-sld }}` и `ns2.{{ dns-ns-host-sld }}`.

     Делегирование происходит не сразу. Серверы интернет-провайдеров обновляют записи до 24 часов. Проверить делегирование домена можно с помощью [сервиса Whois](https://www.reg.ru/whois/check_site) или утилиты `dig`:

     ```bash
     dig +short NS example.com
     ```

     Результат:

     ```text
     ns2.{{ dns-ns-host-sld }}.
     ns1.{{ dns-ns-host-sld }}.
     ```

- {{ yandex-cloud }} CLI {#cli}

  1. Создайте публичную зону DNS:

     ```bash
     yc dns zone create \
       --name example-zone \
       --zone example.com. \
       --public-visibility
     ```

     Где `--zone` — имя вашего домена, например `example.com.`. Значение параметра `--zone` должно заканчиваться точкой.

     Результат:

     ```text
     id: dns39gihj0ef********
     folder_id: b1g681qpemb4********
     created_at: "2024-09-09T15:23:34.919887Z"
     name: example-zone
     zone: example.com.
     public_visibility: {}
     ```

     Подробнее о команде `yc dns zone create` читайте в [справочнике CLI](../../../cli/cli-ref/dns/cli-ref/zone/create.md).

  1. Делегируйте домен на серверы {{ yandex-cloud }}. Для этого в личном кабинете вашего регистратора доменных имен укажите адреса DNS-серверов `ns1.{{ dns-ns-host-sld }}` и `ns2.{{ dns-ns-host-sld }}`.

     Делегирование происходит не сразу. Серверы интернет-провайдеров обновляют записи в течение 24 часов.

- API {#api}

  Чтобы создать публичную зону DNS, воспользуйтесь методом REST API [create](../../../dns/api-ref/DnsZone/create.md) для ресурса [DnsZone](../../../dns/api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/Create](../../../dns/api-ref/grpc/DnsZone/create.md).

  Делегируйте домен на серверы {{ yandex-cloud }}. Для этого в личном кабинете вашего регистратора доменных имен укажите адреса DNS-серверов `ns1.{{ dns-ns-host-sld }}` и `ns2.{{ dns-ns-host-sld }}`.

{% endlist %}