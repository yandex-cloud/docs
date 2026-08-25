#### Quotas {#cloud-dns-quotas}

#|
|| Type of limit | Value ||
|| Number of zones per cloud 
`dns.zones.count` | 100 ||
|| Number of record sets per cloud
`dns.recordSets.count` | 1,000 ||
|| Number of inbound DNS endpoints per cloud
`dns.endpoints.count` | 5 ||
|| Number of DNS filters per cloud
`dns.firewalls.count` | 10 ||
|#

#### Limits {#cloud-dns-limits}

Type of limitation | Value
----- | -----
Maximum number of records per record set | 100
Maximum number of concurrent record set updates | 1,000
Maximum number of networks per zone | 128
Maximum number of FQDNs in the allowlist of a single DNS filter | 255
Maximum number of FQDNs in the blocklist of a single DNS filter | 255
Maximum number of resources a single DNS filter can be attached to | 100
