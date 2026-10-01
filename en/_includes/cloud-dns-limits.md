#### Quotas {#cloud-dns-quotas}

#|
|| Type of limit | Value ||
|| Number of zones per cloud 
`dns.zones.count` | 100 ||
|| Number of record sets per cloud
`dns.recordSets.count` | 1,000 ||
|| Number of inbound DNS connections per cloud
`dns.endpoints.count` | 5 ||
|| Number of DNS filters per cloud
`dns.firewalls.count` | 10 ||
|#

#### Limits {#cloud-dns-limits}

Type of limit | Value
----- | -----
Maximum number of records per record set | 100
Maximum number of concurrent record set updates | 1,000
Maximum number of networks per zone | 128
Maximum number of whitelisted FQDNs per DNS filter | 255
Maximum number of blacklisted FQDNs per DNS filter | 255
Maximum number of connected resources per DNS filter | 100
