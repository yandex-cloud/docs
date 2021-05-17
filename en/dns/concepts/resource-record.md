# Resource records

A resource record is the main unit of information in a DNS. Using resource records, you determine where to route queries that come to specific domain names. Resource records have the following parameters:

* Domain name.
* Record type.
* Record time to live (TTL) in seconds before updating the record value.
* Record value.

{{ dns-name }} uses record sets. A set may contain a single record or a collection of resource records with the same name and type but different values.

Sample record set:

| Name | Type | TTL | Value |
| ----- | ----- | ----- | ----- |
| example.com | A | 600 | 10.0.0.1 |
| example.com | A | 600 | 10.0.0.2 |
| example.com | A | 600 | 10.0.0.3 |

You can update record sets by adding or deleting records.

## Types of resource records {#rr-types}

{{ dns-name }} supports the following types of resource records:

### A {#a}

`A`: Points a domain name to an IPv4 address. For example, requesting the `www.example.com` A record should return an IPv4 address in `xxx.xxx.xxx.xxx` format.

| Name | Type | TTL | Value |
| ----- | ----- | ----- | ----- |
| example.com. | A | 600 | 10.0.0.100 |

### MX {#mx}

`MX`: The name of a server that processes emails, such as `mail.example.com`. MX records let you set the priority of mail servers. An MX record must point to an A or AAAA record.

| Name | Type | TTL | Value |
| ----- | ----- | ----- | ----- |
| example.com. | MX | 600 | 10 mail1.example.com. |
| example.com. | MX | 600 | 50 mail2.example.com. |

### CNAME {#cname}

`CNAME`: Creates an alias for an FQDN. You can use CNAME records to access different services running on the same IP address. For example, CNAME records like `first.example.com` and `second.example.com` may point to the same `example.com` A record.

| Name | Type | TTL | Value |
| ----- | ----- | ----- | ----- |
| first.example.com. | CNAME | 600 | example.com |
| second.example.com. | CNAME | 600 | example.com |
| example.com. | A | 600 | 10.0.0.100 |

### SRV {#srv}

`SRV`: A record that specifies the hostname and port number of the server for a particular service. An SRV record must point to an A or AAAA record. When creating a record, specify the server priority and weight for request distribution. This helps distribute the load both between and within groups of servers. The client accesses the server with the lowest priority number and, if multiple servers have the same priority, requests are distributed according to the weight.

| Name | Type | TTL | Value |
| ----- | ----- | ----- | ----- |
| _sip._tcp.example.com. | SRV | 600 | 10 70 8080 farm1.example.com. |
| _sip._tcp.example.com. | SRV | 600 | 10 20 8080 farm2.example.com. |
| _sip._tcp.example.com. | SRV | 600 | 10 10 8080 farm3.example.com. |
| _sip._tcp.example.com. | SRV | 600 | 20 0 8080 farm4.example.com. |

### AAAA {#aaaa}

`AAAA`: Points a domain name to an IPv6 address. Operates in a similar way to an A record.

### PTR {#ptr}

`PTR`: Resolves an IP address to a domain name. Automatic creation of PTR records is only available in internal zones.

### TXT {#txt}

`TXT`: A record with additional information about a zone.

### SOA {#soa}

`SOA`: A record with basic information about a zone. Created automatically.

### NS {#ns}

`NS`: A record that stores addresses of name servers. You can specify the default server addresses at your registrar to delegate a domain. NS records are used to delegate a domain to another authoritative name server.

