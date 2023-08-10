# Миграция DNS-зон из Яндекс 360 в {{ dns-full-name }}

Если ваш домен делегирован Яндекс 360, а ваши сервисы находятся в {{ yandex-cloud }}, то вы можете передать управление доменом на DNS-серверы {{ yandex-cloud }} и перенести DNS-зоны в сервис {{ dns-full-name }} для большего удобства. {{ dns-full-name }} тесно интегрирован с другими сервисами {{ yandex-cloud }} (например, с [{{ compute-full-name }}](../../dns/concepts/compute-integration.md)).

Чтобы мигрировать DNS-зоны из Яндекс 360 в {{ dns-full-name }}:
1. [Делегируйте домен](#domain-delegate).
1. [Перенесите записи](#yaconnect-records-move).

## Делегируйте доменное имя {#domain-delegate}

Перед переводом DNS-зон под управление сервиса {{ dns-full-name }} необходимо делегировать ваш домен на серверы {{ yandex-cloud }}. Для этого укажите адреса серверов имен {{ yandex-cloud }} в `NS`-записях вашего регистратора:


* `ns1.{{ dns-ns-host-sld }}.`
* `ns2.{{ dns-ns-host-sld }}.`



## Перенесите записи {#yaconnect-records-move}

Перенести DNS-записи домена из Яндекс 360 в {{ dns-full-name }} можно только вручную.

Перед переносом [создайте публичную зону DNS](../../dns/operations/zone-create-public.md) для DNS-записей вашего домена.

{% list tabs %}

- A, AAAA, CNAME, NS

  1. [Создайте новую запись](../../dns/operations/resource-record-create.md) соответствующего типа.
  1. Укажите в поле **{{ ui-key.yacloud.dns.label_records }}** значение переносимой записи Яндекс 360 без изменений формата.
  1. Укажите в поле **{{ ui-key.yacloud.dns.label_form-ttl }}**  значение параметра TTL из Яндекс 360.

  Пример:

  Яндекс 360 | {{ dns-name }}
  --- | ---
  **Тип записи** — `CNAME`</br></br>**Значение записи** — `domain.mail.yandex.net.`</br></br>**TTL** — `600` | **{{ ui-key.yacloud.common.type }}** — `CNAME`</br></br>**{{ ui-key.yacloud.dns.label_records }}** — `domain.mail.yandex.net.`</br></br>**{{ ui-key.yacloud.dns.label_form-ttl }}** — `600`

- MX

  1. [Создайте новую MX-запись](../../dns/operations/resource-record-create.md).
  1. Укажите в поле **{{ ui-key.yacloud.dns.label_records }}** параметры переносимой MX-записи Яндекс 360 в формате `<Приоритет> <Значение записи>`.
  1. Укажите в поле **{{ ui-key.yacloud.dns.label_form-ttl }}**  значение параметра TTL из Яндекс 360.

  Пример:
  
  Яндекс 360 | {{ dns-name }}
  --- | ---
  **Тип записи** — `MX`</br></br>**Значение записи** — `mx.yandex.net.`</br></br>**Приоритет** — `10`</br></br>**TTL** — `21600` | **{{ ui-key.yacloud.common.type }}** — `MX`</br></br>**{{ ui-key.yacloud.dns.label_records }}** — `10 mx.yandex.net.`</br></br>**{{ ui-key.yacloud.dns.label_form-ttl }}** — `21600`

- TXT
  
  1. [Создайте новую TXT-запись](../../dns/operations/resource-record-create.md).
  1. Укажите в поле **{{ ui-key.yacloud.dns.label_records }}** параметры переносимой TXT-записи Яндекс 360 в формате `"<значение записи>"`.

      {% note warning %}

      Сервис {{ dns-name }} использует формат [MASTER FILES](https://www.ietf.org/rfc/rfc1035.html#section-5) при разборе TXT-записей. Согласно спецификации этого формата с символа `;` начинается комментарий, т. е. все содержимое после него игнорируется. Чтобы использовать символ `;` и пробелы в значении записи, заключите ее в двойные кавычки `""`.

      {% endnote %}

  1. Укажите в поле **{{ ui-key.yacloud.dns.label_form-ttl }}**  значение параметра TTL из Яндекс 360.

  Пример:

  Яндекс 360 | {{ dns-name }}
  --- | ---
  **Тип записи** — `TXT`</br></br>**Значение записи** — `v=DMARC1; p=none;`</br>`sp=quarantine; pct=100;`</br>`rua=mailto: dmarcreports@example.com;`</br></br>**TTL** — `26000` | **{{ ui-key.yacloud.common.type }}** — `TXT`</br></br>**{{ ui-key.yacloud.dns.label_records }}** — `"v=DMARC1; p=none;`</br>`sp=quarantine; pct=100;`</br>`rua=mailto: dmarcreports@example.com;"`</br></br>**{{ ui-key.yacloud.dns.label_form-ttl }}** — `26000`

- SRV

  1. Скопируйте из значения SRV-записи Яндекс 360 все символы после `SRV`. Например, из значения `86400 IN SRV 0 5 5060 _sip._tcp.example.com.` скопируйте только строку `0 5 5060 _sip._tcp.example.com.`.
  1. [Создайте новую SRV-запись](../../dns/operations/resource-record-create.md).
  1. Вставьте в поле **{{ ui-key.yacloud.dns.label_records }}** скопированную строку.
  1. Укажите в поле **{{ ui-key.yacloud.dns.label_form-ttl }}**  значение параметра TTL из Яндекс 360.

  Пример:

  Яндекс 360 | {{ dns-name }}
  --- | ---
  **Тип записи** — `SRV`</br></br>**Значение записи** — `86400 IN SRV 0 5 5060 _sip._tcp.example.com.`</br></br>**Приоритет** — `0`</br></br>**TTL** — `86400` | **{{ ui-key.yacloud.common.type }}** — `SRV`</br></br>**{{ ui-key.yacloud.dns.label_records }}** — `0 5 5060 _sip._tcp.example.com.`</br></br>**{{ ui-key.yacloud.dns.label_form-ttl }}** — `86400`

{% endlist %}

Подождите, пока изменения вступят в силу. Может потребоваться до 72 часов, чтобы DNS-серверы в интернете обменялись данными о новых DNS-записях.

Подробнее о типах ресурсных записей, поддерживаемых сервисом, см. в разделе [{#T}](../../dns/concepts/resource-record.md).
