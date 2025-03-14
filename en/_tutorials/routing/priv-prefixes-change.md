## Changing private connection IP prefixes {#priv-change}

To change IP prefixes in a private connection, do the following:
1. Delete the existing IP prefixes from the private connection. 
1. Add new IP prefixes to the private connection.

To change your private connection IP prefixes, create a [new support ticket]({{ link-console-support }}).

### Contacting support to change IP prefixes in a private connection {#prefix-change}

Follow this request format:
```s
Subject: [CIC] Changing IP prefixes in a private connection.

Request text:
Please change IP prefixes in the private connection 
prc_id: cf3qdug4fsf737******

1. Delete the following IP prefixes from the specified networks (vpc_net_id):
 
 vpc_net_id: enpdffqsg8r221******
   {{ region-id }}-a: 10.60.192.0/21
   {{ region-id }}-b: 10.60.200.0/21, 10.60.220.0/24
   {{ region-id }}-d: 10.60.208.0/20

2. Add the following IP prefixes to the specified networks (vpc_net_id):

 vpc_net_id: enpdffqsg8r221******
   {{ region-id }}-a: 10.60.1.0/24
   {{ region-id }}-b: 10.60.4.0/24, 10.60.8.0/24
   {{ region-id }}-d: 10.60.10.0/20

 vpc_net_id: enpdhpdcp2u748******
   {{ region-id }}-a: 10.45.11.0/21, 10.45.100.0/24
   {{ region-id }}-b: 10.45.21.0/21
   {{ region-id }}-d: 10.45.31.0/20

```

Where:

* `vpc_net_id`: {{ vpc-full-name }} virtual network ID. For each such virtual network, you need to specify IPv4 subnet prefixes grouped by {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md).


### Contacting support to add IP prefixes to a private connection {#prefix-add}

Follow this request format:

```s
Subject: [CIC] Adding IP prefixes to a private connection.

Request text:
Please add IP prefixes to the private connection
prc_id: cf3qdug4fsf737******

Add the following IP prefixes to the specified networks (vpc_net_id):

 vpc_net_id: enpdffqsg8r221******
   {{ region-id }}-a: 10.60.1.0/24
   {{ region-id }}-b: 10.60.4.0/24, 10.60.8.0/24
   {{ region-id }}-d: 10.60.10.0/20

 vpc_net_id: enpdhpdcp2u748******
   {{ region-id }}-a: 10.45.11.0/21, 10.45.100.0/24
   {{ region-id }}-b: 10.45.21.0/21
   {{ region-id }}-d: 10.45.31.0/20

```

Where:

* `vpc_net_id`: {{ vpc-full-name }} virtual network ID. For each such virtual network, you need to specify IPv4 subnet prefixes grouped by {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md).


### Contacting support to delete IP prefixes from a private connection {#prefix-del}

Follow this request format:
```s
Subject: [CIC] Deleting IP prefixes from a private connection.

Request text:
Please delete IP prefixes from the private connection
prc_id: cf3qdug4fsf737******

1. Delete the following IP prefixes from the specified networks (vpc_net_id):

 vpc_net_id: enpdffqsg8r221******
   {{ region-id }}-a: 10.60.192.0/21
   {{ region-id }}-b: 10.60.200.0/21, 10.60.220.0/24
   {{ region-id }}-d: 10.60.208.0/20

 vpc_net_id: enpdffqsg8r221******
   {{ region-id }}-a: 10.60.1.0/24
   {{ region-id }}-b: 10.60.4.0/24, 10.60.8.0/24
   {{ region-id }}-d: 10.60.10.0/20
```

Where:

* `vpc_net_id`: {{ vpc-full-name }} virtual network ID. For each such virtual network, you need to specify IPv4 subnet prefixes grouped by {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md).


### Support team's response to your ticket {#priv-ticket-resp}

Here is an example of the support response to a request for changing private connection IP prefixes (for reference only):

```s
Requested changes to the private connection IP prefixes have been accepted.
prc_id: cf3qdug4fsf737******
```

{% note info %}

Changing IP prefixes may take up to two business days. You will be notified once the process is completed.  

{% endnote %}

If there are any connectivity issues, contact support for diagnostics and troubleshooting.

