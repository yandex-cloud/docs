# Resource records

A resource record is the main unit of information in a DNS. Using resource records, you determine where to route queries that come to specific domain names. Resource records have the following parameters:

* Domain name.
* Record type.
* Record time to live (TTL) in seconds before updating the record value.
* Record value.

{% note warning %}

Resource records only support ASCII characters.

{% endnote %}

{{ dns-name }} uses record sets. A set may contain a single record or a collection of resource records with the same name and type but different values.

Sample record set:

| Name | Type | TTL | Value |
|--------------|-----|-----|-----------------------------------------------------------------|
| example.com. | A | 600 | <ul><li>192.0.2.1</li><li>192.0.2.2</li><li>192.0.2.3</li></ul> |

You can update record sets by adding or deleting records.

{% note info %}

All the records in a single set have the same TTL value.

{% endnote %}

{{ dns-name }} supports the following types of resource records.

## A {#a}

`A`: Points a domain name to an IPv4 address. For example, requesting the `www.example.com` A record should return an IPv4 address in `xxx.xxx.xxx.xxx` format.

| Name | Type | TTL | Value |
|--------------|-----|-----|-----------|
| example.com. | A | 600 | 192.0.2.1 |

For more information about A records, see [RFC-1035](https://www.ietf.org/rfc/rfc1035.html#section-3.4.1).


## AAAA {#aaaa}

`AAAA`: Points a domain name to an IPv6 address. Operates in a similar way to an A record.

| Name | Type | TTL | Value |
|--------------|------|-----|-------------|
| example.com. | AAAA | 600 | 2001:db8::1 |

For more information about AAAA records, see [RFC-3596](https://tools.ietf.org/html/rfc3596).


## CAA {#caa}

`CAA` (Certification Authority Authorization): Identifies which certification authorities are authorized to issue certificates for a particular zone and its subzones.

A record consists of the following parts:

* `FLAG`: A single-byte unsigned integer that may take two values:
   * `0`: Indicates a noncritical record. The certification authority may issue a certificate at its discretion.
   * `128`: Indicates a critical record. The certification authority should not issue a certificate for an FQDN if the corresponding CAA record contains a critical property for an unknown or unsupported tag.
* `TAG`: A string that consists of Latin characters and numbers and identifies the purpose of a record:
   * `issue`: Determines which certification authority is authorized to issue certificates for a zone or subzone.
   * `issuewild`: Determines which certification authority is authorized to issue certificates for a zone and all of its subzones (wildcard, `*.example.com`).
   * Contact information that the certification authority should use to notify zone owners about receiving a request to issue a certificate in violation of the rules defined in CAA records:
      * `iodef`: The phone number, website, or email address in any format.
      * `contactemail`: The email address.
      * `contactphone`: The phone number.

   If the server fails to process an unknown tag, the flag value is parsed:

   * `0`: The tag is ignored.
   * `128`: Regardless of the value in the `VALUE` field, the record prohibits the issuance of certificates for the specified zone.

* `VALUE`: A record enclosed in double quotes: `""`. This field value is handled based on the tag value.

| Name | Type | TTL | Value | Description |
|--------------|-----|-----|-----------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|
| example.com. | CAA | 600 | 128 issue "ca.example.net" | Only the `ca.example.net` certification authority is authorized to issue a certificate for the `example.com` zone |
| example.com. | CAA | 600 | 0 issuewild "ca.example.net" | The `ca.example.net` certification authority decides whether to issue certificates for the `example.com` zone and its subzones |
| example.com. | CAA | 600 | 0 issue ";" | Certification authorities are not authorized to issue certificates for the `example.com` zone |
| example.com. | CAA | 600 | 0 iodef "mailto:security@example.com" | If any of the conditions described in CAA records is violated, contact the owner of the `example.com` zone at `security@example.com` |
| example.com. | CAA | 600 | 0 iodef "https://security.example.com/" | If any of the conditions described in CAA records is violated, contact the owner of the `example.com` zone at `https://security.example.com` |

For more information about CAA records, see [RFC-8659](https://tools.ietf.org/html/rfc8659).


## CNAME {#cname}

`CNAME`: Creates an alias for an FQDN. You can use CNAME records to access different services running on the same IP address. For example, CNAME records like `first.example.com` and `second.example.com` may point to the same `host.example.com` A record.

| Name | Type | TTL | Value |
|---------------------|-------|-----|-------------------|
| first.example.com. | CNAME | 600 | host.example.com. |
| second.example.com. | CNAME | 600 | host.example.com. |
| host.example.com. | A | 600 | 192.0.2.100 |

Note that CNAME records cannot be combined with other records in the same domain. For more information about CNAME records and their limitations, see [RFC-1035](https://www.ietf.org/rfc/rfc1035.html#section-3.3.1).

## ANAME {#aname}

An `ANAME` record is similar to a `CNAME` record, but can be used in the same domain with other records. For example, you can use `ANAME` records with `MX` records in a second-level domain.

| Name | Type | TTL | Value |
|----------------------|-------|-----|------------------------------------|
| example.com. | ANAME | 600 | example.com.{{ s3-web-host }} |
| example.com. | MX | 600 | 10 mx.example.com |
| example.com. | TXT | 600 | v=spf1 redirect=_spf.example.com |
| example.com. | TXT | 600 | v=DKIM1; k=rsa; t=s; p=<key> |

## MX {#mx}

`MX`: The name of a server that processes emails, such as `mx.example.com`.

A record consists of two parts:

* `PREFERENCE`: A 16-bit integer that specifies the host priority. The lower the value, the higher the host preference.
* `EXCHANGE`: The FQDN of the host that processes emails in the specified zone. This field value must point to an A or AAAA record.

| Name | Type | TTL | Value |
|--------------|-----|-----|----------------------------|
| example.com. | MX | 600 | 10 mx-primary.example.com. |
| example.com. | MX | 600 | 50 mx-reserve.example.com. |

For more information about MX records, see [RFC-1035](https://www.ietf.org/rfc/rfc1035.html#section-3.3.9).


## NS {#ns}

`NS`: A record that stores the address of the name server that handles the specified zone.

| Name | Type | TTL | Value |
|--------------|-----|-----|------------------|
| example.com. | NS | 600 | ns1.example.com. |
| example.com. | NS | 600 | ns2.example.com. |

For more information about NS records, see [RFC-1035](https://www.ietf.org/rfc/rfc1035.html#section-3.3.11).


## PTR {#ptr}

`PTR`: Resolves an IP address to a domain name.

| IP address | Type | TTL | Value |
|-----------|-----|-----|--------------------|
| 192.0.2.1 | PTR | 600 | host1.example.com. |
| 192.0.2.2 | PTR | 600 | host2.example.com. |

For more information about PTR records, see [RFC-1035](https://www.ietf.org/rfc/rfc1035.html#section-3.3.12).


## SOA {#soa}

`SOA`: A record with basic information about a zone. Created automatically.

It consists of the following parts:

* `MNAME`: The domain name of the server that handles the zone. Default: 0.
   * `ns.internal.` for private zones.
   * `ns1.{{ dns-ns-host-sld }}.` for public zones.
* `RNAME`: The domain name of the mail server that handles the zone. Default value: `{{ dns-mx-host }}.`.
* `SERIAL`: An unsigned 32-bit integer that points to the number of a zone copy. When synchronizing data between DNS servers, the value in the `SERIAL` field is checked. The larger it is, the more recent the data. The default value is `1`.

   {% note warning %}

   The {{ dns-name }} service doesn't change the `SERIAL` field value in SOA records when editing zone resource records. If you want to forcibly update the cache of the DNS servers that store information about your resource records, increase the value in this field manually.

   {% endnote %}

* `REFRESH`: The time, in seconds, between updates of information about zone resource records. The default value is `10800` (3 hours).
* `RETRY`: The time, in seconds, before retrying to update information about zone resource records if the previous attempt failed. The default value is `900` (15 minutes).
* `EXPIRE`: The time, in seconds, after which the zone will no longer be authoritative. The default value is `604800` (7 days).
* `MINIMUM`: The minimum TTL value, in seconds, for any resource record exported from the zone. The default value is `86400` (24 hours).

| Name | Type | TTL | Value |
|--------------|-----|------|--------------------------------------------------------------------|
| example.com. | SOA | 3600 | ns1.{{ dns-ns-host-sld }}. {{ dns-mx-host }}. 1 10800 900 604800 86400 |
| example.com. | SOA | 3600 | ns.internal. {{ dns-mx-host }}. 1 10800 900 604800 86400 |

For more information about SOA records, see [RFC-1035](https://www.ietf.org/rfc/rfc1035.html#section-3.3.13).


## SRV {#srv}

`SRV`: A record that specifies the hostname and port number of the server for a particular service. An SRV record must point to an A or AAAA record.

It consists of the following parts:

* `Priority`: A 16-bit unsigned integer that specifies the host priority. The lower the value, the higher the host preference.
* `Weight`: A 16-bit unsigned integer that specifies the weight for hosts with the same priority. The closer the field value is to 0, the less likely it is that this host will be selected. If the service is only running on a single host, set the field value to `0`.
* `Port`: A 16-bit unsigned integer that specifies the port used by the service.
* `Target`: The FQDN of the host for the service.

The client accesses the server with the lowest priority. If multiple servers have the same priority, the load is distributed according to the weight. Specify the server priority and the weight of records to distribute the load both between and within groups of servers.

| Name | Type | TTL | Value |
|-------------------------------|-----|-----|-----------------------------------|
| _sip._tcp.example.com. | SRV | 600 | 10 70 8080 host.example.com. |
| _postgresql._tcp.example.com. | SRV | 600 | 10 60 6432 pg-master.example.com. |
| _postgresql._tcp.example.com. | SRV | 600 | 10 30 6432 pg-repl1.example.com. |
| _postgresql._tcp.example.com. | SRV | 600 | 10 10 6432 pg-repl2.example.com. |

{% note warning %}

The {{ dns-name }} service only supports `IN` class SRV records. When creating records, there is no need to specify the `IN` prefix.

{% endnote %}

For more information about SRV records, see [RFC-2782](https://www.ietf.org/rfc/rfc2782.html).


## TXT {#txt}

`TXT` is a free-form record that can store human-readable text or structured machine-readable data.

Mostly used to verify:

* Domain ownership.
* Authenticity of email messages.

   * DMARC, [RFC-7489](https://www.ietf.org/rfc/rfc7489.html);
   * DKIM, [RFC-6376](https://datatracker.ietf.org/doc/html/rfc6376/);
   * SPF, [RFC-7208](https://datatracker.ietf.org/doc/html/rfc7208).

TXT record implementation in {{ dns-full-name }} has the following special features and limitations:

* The service uses [MASTER FILES](https://www.ietf.org/rfc/rfc1035.html#section-5) format. According to the format specifications, a `;` indicates the beginning of a comment, meaning that any content following it is ignored. If you wish to use the `;` character in a TXT record, enclose the string containing it in double quotes (`""`).

* A TXT record can store multiple values. Each record is subject to the following limitations: no more than 255 characters per line and 1024 characters total. If the value of a TXT record contains more than 1024 characters, split it into multiple values in the same TXT record. Enclose each value in double quotes (`""`) as required.

* The space character serves as separator. If an input string has spaces, it will be perceived as several strings.

   For example, the following string is entered:

   ```text
   Long string "string with spaces in quotes" #1 and_without_spaces
   ```

   When saving, this string will not change, but will be processed as 5 strings:

   ```text
   "Long"
   "string"
   "string with spaces in quotes"
   "#1"
   "and_without_spaces"
   ```

   If you need to save the spaces, enclose the entire string in double quotes (`""`).

| Name | Type | TTL | Value |
|----------------------------------|-----|------|------------------------------------------------------------------------------------|
| example.com. | TXT | 600 | "v=DMARC1; p=none; sp=quarantine; pct=100; rua=mailto: dmarcreports@example.com;" |
| big-email._domainkey.example.com | TXT | 6000 | "v=DKIM1; p=76E629F05F70 9EF665853333 EEC3F5ADE69A 2362BECE4065 8267AB2FC3CB 6CBE" |
| example.com. | TXT | 6000 | "v=spf1 ip4=192.0.2.0 ip4=192.0.2.1 include:examplesender.email -all" |

For more information about TXT records, see [RFC-1035](https://www.ietf.org/rfc/rfc1035.html#section-3.3.14) and [RFC-1464](https://tools.ietf.org/html/rfc1464).
