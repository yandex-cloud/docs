---
title: Resource records in {{ dns-full-name }}
description: A resource record is the main unit of information in a DNS. Using resource records, you determine where to route queries that come to specific domain names.
---

# Resource records

A resource record is the main unit of information in a DNS. Using resource records, you determine where to route queries that come to specific domain names. Resource records have the following parameters:

* Domain name.
* Type of writes.
* Record time to live (TTL) in seconds before updating the record value.
* Record value.

{% note warning %}

Resource records only support ASCII characters.

{% endnote %}

{{ dns-name }} uses record sets. A set may contain a single record or a collection of resource records with the same name and type but different values.

Sample record set:

| Name          | Type | TTL | Value                                                        |
|--------------|-----|-----|-----------------------------------------------------------------|
| example.com. | A   | 600 | <ul><li>192.0.2.1</li><li>192.0.2.2</li><li>192.0.2.3</li></ul> |

You can update record sets by adding or deleting records.

{% note info %}

All the records in a single set have the same TTL value.

{% endnote %}

{{ dns-name }} supports the following types of resource records.


## A {#a}

`A` resolves a domain name to an IPv4 address. For example, requesting the `www.example.com` A record should return an IPv4 address in `xxx.xxx.xxx.xxx` format.

| Name          | Type | TTL | Value  |
|--------------|-----|-----|-----------|
| example.com. | A   | 600 | 192.0.2.1 |

For more information about A records, see [RFC-1035](https://www.ietf.org/rfc/rfc1035.html#section-3.4.1).


## AAAA {#aaaa}

`AAAA` resolves a domain name to an IPv6 address. It works in a similar way to an A record.

| Name          | Type  | TTL | Value    |
|--------------|------|-----|-------------|
| example.com. | AAAA | 600 | 2001:db8::1 |

For more information about AAAA records, see [RFC-3596](https://tools.ietf.org/html/rfc3596).


## CAA {#caa}

`CAA`: Certification Authority Authorization, specifies certification authorities authorized to issue certificates for a particular zone and its subzones.

A record consists of the following parts:

* `FLAG`: Single-byte unsigned integer that may take these two values:
    * `0`: Noncritical record. The certification authority may issue a certificate at its discretion.
    * `128`: Critical record. The certification authority must not issue a certificate for an FQDN if the appropriate CAA record contains a critical property for an unknown or unsupported tag.
* `TAG`: String consisting of Latin characters and numbers representing the purpose of the record:
    * `issue`: Specifies the certification authority authorized to issue certificates for a zone or subzone.
    * `issuewild`: Specifies the certification authority authorized to issue certificates for a zone and all its subzones (wildcard, `*.example.com`).
    * Contact information the certification authority must use to notify the zone owner about receiving a request for a certificate in violation of the rules defined in CAA records:
        * `iodef`: Phone number, website, or email address in any format.
        * `contactemail`: Email address.
        * `contactphone`: Phone number.

    If the server fails to process an unknown tag, the flag value is parsed:

    * `0`: The tag is ignored.
    * `128`: Regardless of the value in the `VALUE` field, the record prohibits the issuance of certificates for the specified zone.

* `VALUE`: Record enclosed in double quotes, `""`. This field value is processed based on the tag value.

| Name          | Type | TTL | Value                                | Description                                                                                                                                           |
|--------------|-----|-----|-----------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|
| example.com. | CAA | 600 | 128 issue "ca.example.net"              | Only the `ca.example.net` certification authority is authorized to issue a certificate for the `example.com` zone                                                    |
| example.com. | CAA | 600 | 0 issuewild "ca.example.net"            | The `ca.example.net` certification authority may, at its discretion, issue certificates for the `example.com` zone and its subzones                               |
| example.com. | CAA | 600 | 0 issue ";"                             | Certification authorities are not authorized to issue certificates for the `example.com` zone                                                                           |
| example.com. | CAA | 600 | 0 iodef "mailto:security@example.com"   | If any of the conditions described in CAA records is violated, contact the owner of the `example.com` zone at `security@example.com`          |
| example.com. | CAA | 600 | 0 iodef "https://security.example.com/" | If any of the conditions described in CAA records is violated, contact the owner of the `example.com` zone at `https://security.example.com` |

For more information about CAA records, see [RFC-8659](https://tools.ietf.org/html/rfc8659).


## CNAME {#cname}

`CNAME`: Alias for an FQDN. You can use CNAME records to access different services running on the same IP address. For example, CNAME records `first.example.com` and `second.example.com` may point to the same A record, `host.example.com`.

| Name                 | Type   | TTL | Value          |
|---------------------|-------|-----|-------------------|
| first.example.com.  | CNAME | 600 | host.example.com. |
| second.example.com. | CNAME | 600 | host.example.com. |
| host.example.com.   | A     | 600 | 192.0.2.100       |

Note that CNAME records cannot be combined with other records in the same domain. For more information about CNAME records and their [limitations](https://www.rfc-editor.org/rfc/rfc1912#section-2.4), see [RFC-1035](https://www.ietf.org/rfc/rfc1035.html#section-3.3.1).

## ANAME {#aname}

An `ANAME` record is similar to a `CNAME` record, but can be used in the same domain with other records. For example, you can use an `ANAME` record in a second-level domain along with `MX` records.

| Name                  | Type   | TTL | Value                           |
|----------------------|-------|-----|------------------------------------|
| example.com.         | ANAME | 600 | example.com.{{ s3-web-host }} |
| example.com.         | MX    | 600 | 10 mx.example.com                  |
| example.com.         | TXT   | 600 | v=spf1 redirect=_spf.example.com   |
| example.com.         | TXT   | 600 | v=DKIM1; k=rsa; t=s; p=<key>      |

{% note info %}

Do not use an `ANAME` resource record with domain names for [{{ cdn-full-name }}](../../cdn/) content distribution; otherwise, the end user will get a response from a CDN server not linked to the user's geolocation. The response will always be the same for all users.

{% endnote %}

## MX {#mx}

`MX` is the name of an email processing server, e.g., `mx.example.com`.

A record consists of two parts:

* `PREFERENCE`: 16-bit integer representing the host priority. The lower the value, the more preferred the host is.
* `EXCHANGE`: FQDN of the email processing host in the specified zone. This field value must point to an A or AAAA record.

| Name          | Type | TTL | Value                   |
|--------------|-----|-----|----------------------------|
| example.com. | MX  | 600 | 10 mx-primary.example.com. |
| example.com. | MX  | 600 | 50 mx-reserve.example.com. |

For more information about MX records, see [RFC-1035](https://www.ietf.org/rfc/rfc1035.html#section-3.3.9).


## NS {#ns}

`NS` is a record that stores the address of the name server in charge of the specified zone.

| Name          | Type | TTL | Value         |
|--------------|-----|-----|------------------|
| example.com. | NS  | 600 | ns1.example.com. |
| example.com. | NS  | 600 | ns2.example.com. |

For more information about NS records, see [RFC-1035](https://www.ietf.org/rfc/rfc1035.html#section-3.3.11).


## PTR {#ptr}

`PTR` resolves an IP address to a domain name.

| IP address  | Type | TTL | Value           |
|-----------|-----|-----|--------------------|
| 192.0.2.1 | PTR | 600 | host1.example.com. |
| 192.0.2.2 | PTR | 600 | host2.example.com. |

For more information about PTR records, see [RFC-1035](https://www.ietf.org/rfc/rfc1035.html#section-3.3.12).


## SOA {#soa}

`SOA`: Record with basic information about a zone. It is created automatically.

It consists of the following parts:

* `MNAME`: Domain name of the server in charge of the zone. Default:
    * `ns.internal.` for private zones.
    * `ns1.{{ dns-ns-host-sld }}.` for public zones.
* `RNAME`: Domain name of the mail server in charge of the zone. The default value is `{{ dns-mx-host }}.`.
* `SERIAL`: Unsigned 32-bit integer pointing to a zone copy number. When synchronizing data between DNS servers, the value in the `SERIAL` field is checked. The larger the value, the more recent the data. The default value is `1`.

    {% note warning %}

    The {{ dns-name }} service does not change the `SERIAL` field value in SOA records when editing zone resource records. If you want to force updating the cache of the DNS servers storing your resource records data, increase the value in this field manually.

    {% endnote %}

* `REFRESH`: Time, in seconds, between updates of information about zone resource records. The default value is `10800` (3 hours).
* `RETRY`: Time, in seconds, before retrying to update information about zone resource records if the previous attempt failed. Default value: `900` (15 minutes).
* `EXPIRE`: Time, in seconds, after which the zone will no longer be authoritative. The default value is `604800` (7 days).
* `MINIMUM`: Minimum TTL value, in seconds, for any resource record exported from the zone. The default value is `86400` (24 hours).

| Name          | Type | TTL  | Value                                                           |
|--------------|-----|------|--------------------------------------------------------------------|
| example.com. | SOA | 3600 | ns1.{{ dns-ns-host-sld }}. {{ dns-mx-host }}. 1 10800 900 604800 86400 |
| example.com. | SOA | 3600 | ns.internal. {{ dns-mx-host }}. 1 10800 900 604800 86400         |

For more information about SOA records, see [RFC-1035](https://www.ietf.org/rfc/rfc1035.html#section-3.3.13).


## SRV {#srv}

`SRV` is a record specifying the host name and port of the server a particular service operates on. An SRV record must point to an A or AAAA record.

It consists of the following parts:

* `Priority`: 16-bit unsigned integer representing the host priority. The lower the value, the more preferred the host is.
* `Weight`: 16-bit unsigned integer representing the weight of hosts of the same priority. The closer the value is to 0, the less likely it is that this host will be selected. If the service operates on one host only, set the field to `0`.
* `Port`: 16-bit unsigned integer for the port the service is using.
* `Target`: FQDN of the host the service is on.

The client accesses the server with the lowest priority. If multiple servers have the same priority, the load is distributed according to the weight. Specify the server priority and the weight of records to distribute the load both between and within groups of servers.

| Name                           | Type | TTL | Value                          |
|-------------------------------|-----|-----|-----------------------------------|
| _sip._tcp.example.com.        | SRV | 600 | 10 70 8080 host.example.com.      |
| _postgresql._tcp.example.com. | SRV | 600 | 10 60 6432 pg-master.example.com. |
| _postgresql._tcp.example.com. | SRV | 600 | 10 30 6432 pg-repl1.example.com.  |
| _postgresql._tcp.example.com. | SRV | 600 | 10 10 6432 pg-repl2.example.com.  |

{% note warning %}

{{ dns-name }} only supports `IN` class SRV records. When creating records, there is no need to specify the `IN` prefix.

{% endnote %}

For more information about SRV records, see [RFC-2782](https://www.ietf.org/rfc/rfc2782.html).

## SVCB and HTTPS {#svcb-https}

`SVCB` is a record specifying the host name and port of the server a particular service operates on. It provides the client with additional information on how to connect to the server.

`HTTPS` is a record that provides information about HTTPS connections. The HTTPS record is a variation of the SVCB record type.

It consists of the following parts:

* `priority`: 16-bit unsigned integer representing the host priority. When `priority` equals 0, the SVCB record is in `AliasMode`; otherwise, it is in `ServiceMode`.

    * `AliasMode`: SVCB record mode that creates an alias for `target`. It allows creating aliases in the zone's domain.
    * `ServiceMode`: SVCB record mode that specifies an alternative host name. The lower the `priority` value, the more preferred the host is.

* `target`: FQDN of the host the service is on.
* `port`: 16-bit unsigned integer for the port the service is using.
* `alpn` (Application-Layer Protocol Negotiation): Specifies IDs and associated transport protocols supported by the host.

    * `no-default-alpn`: Indicates that, by default, no additional protocols should be used for a secure connection to the specified host.

* `ipv4hint` and `ipv6hint`: Describe the IPs clients can use to access the service.
* `echconfig`: Indicates that the host supports Encrypted Client Hello.
* `mandatory`: Specifies the required keys for the record in addition to the existing ones.

| Name                         | Type   | TTL  | Value                                            |
|-----------------------------|-------|------|-----------------------------------------------------|
| _1234._bar.example.com.     | SVCB  | 300  | 1 svc1.example.net. ipv6hint=2001:db8::1 port=1234  |
| _1234._bar.example.com.     | SVCB  | 300  | 2 svc2.example.net. ipv6hint=2001:db8::2 port=1234  |
| _8443._foo.api.example.com. | SVCB  | 7200 | 0 svc4.example.net.                                 |
| svc4.example.net.           | SVCB  | 7200 | 3 svc4.example.net. alpn=bar port=8004              |
| svc2.example.net.           | HTTPS | 7200 | 1 . port=8002                                       |
| example.net.                | HTTPS | 1800 | 1 . alpn=h3,h3-29,h2 ipv4hint=10.0.0.1 ipv6hint=::1 |

For more information about SVCB records, see [RFC-9460](https://www.ietf.org/rfc/rfc9460.html), [RFC-9461](https://www.ietf.org/rfc/rfc9461.html).

## TXT {#txt}

`TXT` is a free-form record that can store human-readable text or structured machine-readable data.

It is mostly used to verify:

* Domain ownership.
* Authenticity of email messages.

    * DMARC, [RFC-7489](https://www.ietf.org/rfc/rfc7489.html)
    * DKIM, [RFC-6376](https://datatracker.ietf.org/doc/html/rfc6376/)
    * SPF, [RFC-7208](https://datatracker.ietf.org/doc/html/rfc7208)

TXT record implementation in {{ dns-full-name }} has the following special features and limitations:

* The service uses [MASTER FILES](https://www.ietf.org/rfc/rfc1035.html#section-5) format. According to the format specification, `;` marks the beginning of a comment, i.e., all content that comes after it is ignored. If you want to use the `;` character in a TXT record, enclose the string containing it in double quotes (`""`).

* The service supports a single TXT record.

* A TXT record may not exceed 1,024 characters in length.

* A TXT record can store multiple values. Enclose each one in double quotes (`""`) as needed.

* The space character serves as a separator. If an input string has spaces, it will be perceived as multiple strings.

    For example, we have the following string:

    ```text
    Long string "string with spaces in quotes" #1 and_without_spaces
    ```

    When saving, this string will not change but will be processed as five strings:

    ```text
    "Long"
    "string"
    "string with spaces in quotes"
    "#1"
    "and_without_spaces"
    ```

    If you have to keep the spaces, enclose the whole string in double quotes (`""`).

| Name                              | Type | TTL  | Value                                                                           |
|----------------------------------|-----|------|------------------------------------------------------------------------------------|
| example.com.                     | TXT | 600  | "v=DMARC1; p=none; sp=quarantine; pct=100; rua=mailto: dmarcreports@example.com;"  |
| big-email._domainkey.example.com | TXT | 6000 | "v=DKIM1; p=76E629F05F70 9EF665853333 EEC3F5ADE69A 2362BECE4065 8267AB2FC3CB 6CBE" |
| example.com.                     | TXT | 6000 | "v=spf1 ip4=192.0.2.0 ip4=192.0.2.1 include:examplesender.email -all"              |

For more information about TXT records, see [RFC-1035](https://www.ietf.org/rfc/rfc1035.html#section-3.3.14) and [RFC-1464](https://tools.ietf.org/html/rfc1464).


## Service records {#service-records}

Some {{ yandex-cloud }} services use {{ dns-name }} resource records and allow you to create them. In the list of {{ dns-name }} resource records, such records are marked with icons of the services they were created in:

* {{ api-gw-full-name }}: [ANAME record](#aname) required to [bind](../../api-gateway/operations/api-gw-domains.md) the domain to the API gateway and marked with the ![logo](../../_assets/api-gateway/api-gateway-logo.svg) sign.
* {{ certificate-manager-full-name }}: [CNAME record](#cname) required to pass the [domain rights check](../../certificate-manager/concepts/challenges.md) and marked with the ![logo](../../_assets/certificate-manager/certificate-manager-logo.svg) sign.
* {{ objstorage-full-name }}: [ANAME record](#aname) required to [bind](../../storage/operations/hosting/own-domain) the domain to the bucket and marked with the ![logo](../../_assets/storage/storage-logo.svg) sign.

You cannot modify service records and you can only delete one at a time. After you delete the resource for which the service resource record was created, you have to [delete](../operations/resource-record-delete.md) this resource record manually.


## Use cases {#examples}

* [{#T}](../tutorials/connect-migration.md#yaconnect-records-move)
* [{#T}](../tutorials/bind-domain-vm/console.md#create-record)
* [{#T}](../tutorials/prefetch.md)
* [{#T}](../tutorials/tls-termination/console.md#configure-dns)