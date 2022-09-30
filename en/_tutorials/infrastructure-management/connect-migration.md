# Migrating DNS zones from Yandex 360 to {{ dns-full-name }}

If your domain is delegated to Yandex 360 and your services are hosted in {{ yandex-cloud }}, you can transfer domain control to {{ yandex-cloud }} DNS servers and migrate DNS zones to {{ dns-full-name }} for even more convenience. {{ dns-full-name }} is tightly integrated with other {{ yandex-cloud }} services ([such as {{ compute-full-name }}](../../dns/concepts/compute-integration.md)).

To migrate DNS zones from Yandex 360 to {{ dns-full-name }}:
1. [Delegate your domain](#domain-delegate).
1. [Transfer records](#yaconnect-records-move).

## Delegating your domain {#domain-delegate}

Before transferring DNS zones to {{ dns-full-name }} control, you need to delegate your domain to {{ yandex-cloud }} servers. To do this, specify the addresses of {{ yandex-cloud }} name servers in the `NS` records of your registrar:


* `ns1.yandexcloud.net.`
* `ns2.yandexcloud.net.`



## Moving records {#yaconnect-records-move}

You can only move your domain's DNS records from Yandex 360 to {{ dns-full-name }} manually.

Before that, create a [public DNS zone](../../dns/operations/zone-create-public.md) for your domain's DNS records.

{% list tabs %}

- A, AAAA, CNAME, and NS

   1. [Create a new record](../../dns/operations/resource-record-create.md) of the appropriate type.
   1. In the **Value** field, enter the value of the Yandex 360 record to be transferred in the original format.
   1. In the **TTL** field, enter the value of the TTL parameter from Yandex 360.

   Example:

   | Yandex 360 | {{ dns-name }} |
   --- | ---
   | **Record type**: `CNAME`</br></br>**Record value**: `domain.mail.yandex.net.`</br></br>**TTL**: `600` | **Type**: `CNAME`</br></br>**Value**: `domain.mail.yandex.net.`</br></br>**TTL**: `600` |

- MX

   1. [Create a new MX record](../../dns/operations/resource-record-create.md).
   1. In the **Value** field, specify the parameters of the Yandex 360 MX record to be transferred in `<Priority> <Record value>` format.
   1. In the **TTL** field, enter the value of the TTL parameter from Yandex 360.

   Example:

   | Yandex 360 | {{ dns-name }} |
   --- | ---
   | **Record type**: `MX`</br></br>**Record value**: `mx.yandex.net.`</br></br>**Priority**: `10`</br></br>**TTL**: `21600` | **Type**: `MX`</br></br>**Value**: `10 mx.yandex.net.`</br></br>**TTL**: `21600` |

- TXT

   1. [Create a new TXT record](../../dns/operations/resource-record-create.md).
   1. In the **Value** field, specify the parameters of the Yandex 360 TXT record to be transferred in `"<record value>"` format.

      {% note warning %}

      {{ dns-name }} uses [MASTER FILES](https://www.ietf.org/rfc/rfc1035.html#section-5) format when parsing TXT records. According to the format specifications, a `;` indicates the beginning of a comment, meaning that any content following it is ignored. To use a `;` and spaces in the record value, enclose them in double quotes `""`.

      {% endnote %}

   1. In the **TTL** field, enter the value of the TTL parameter from Yandex 360.

   Example:

   | Yandex 360 | {{ dns-name }} |
   --- | ---
   | **Record type**: `TXT`</br></br>**Record value**: `v=DMARC1; p=none;`</br>`sp=quarantine; pct=100;`</br>`rua=mailto: dmarcreports@example.com;`</br></br>**TTL**: `26000` | **Type**: `TXT`</br></br>**Value**: `"v=DMARC1; p=none;`</br>`sp=quarantine; pct=100;`</br>`rua=mailto: dmarcreports@example.com;"`</br></br>**TTL**: `26000` |

- SRV

   1. Copy all the characters after `SRV` from the value of a Yandex 360 SRV record. For example, from the `86400 IN SRV 0 5 5060 _sip._tcp.example.com.` value, only copy `0 5 5060 _sip._tcp.example.com.`.
   1. [Create a new SRV record](../../dns/operations/resource-record-create.md).
   1. In the **Value** field, enter the characters you copied.
   1. In the **TTL** field, enter the value of the TTL parameter from Yandex 360.

   Example:

   | Yandex 360 | {{ dns-name }} |
   --- | ---
   | **Record type**: `SRV`</br></br>**Record value**: `86400 IN SRV 0 5 5060 _sip._tcp.example.com.`</br></br>**Priority**: `0`</br></br>**TTL**: `86400` | **Type**: `SRV`</br></br>**Value**: `0 5 5060 _sip._tcp.example.com.`</br></br>**TTL**: `86400` |

{% endlist %}

For more information about the types of resource records supported by the service, see [{#T}](../../dns/concepts/resource-record.md).
