## Changing a set of IP prefixes in a private connection {#priv-change}

To change a set of IP prefixes in a private connection, do the following:
1. Deleting the existing IP prefixes from the private connection. 
2. Adding new IP prefixes to the private connection.

To change a set of IP prefixes in a private connection, create a [new support request]({{ link-console-support }}).

### Contacting support to change a set of IP prefixes in a private connection {#prefix-change}

Follow this request format:
```s
Subject: [CIC] Changing a set of IP prefixes in a private connection.

Request text:
Please change a set of IP prefixes for private connection 
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

* `vpc_net_id`: ID of the {{ vpc-full-name }} virtual network that will be changed. You need to specify a list of IPv4 subnet prefixes grouped by {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md) for each virtual network.


### Contacting support to add a set of IP prefixes to a private connection {#prefix-add}

Follow this request format:

```s
Subject: [CIC] Adding a set of IP prefixes to a private connection.

Request text:
Please add a set of IP prefixes to private connection
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

* `vpc_net_id`: ID of the {{ vpc-full-name }} virtual network that will be changed. You need to specify a list of IPv4 subnet prefixes grouped by {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md) for each virtual network.


### Contacting support to delete a set of IP prefixes from a private connection {#prefix-del}

Follow this request format:
```s
Subject: [CIC] Deleting a set of IP prefixes from a private connection.

Request text:
Please delete a set of IP prefixes from private connection
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

* `vpc_net_id`: ID of the {{ vpc-full-name }} virtual network that will be changed. You need to specify a list of IPv4 subnet prefixes grouped by {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md) for each virtual network.


### Support team's response to the customer's request {#priv-ticket-resp}

Here is an example of support's response when requested to change IP prefixes in a private connection (for information):

```s
Changes to a set of IP prefixes for the private connection have been accepted.
prc_id: cf3qdug4fsf737******
```

{% note info %}

Changing a set of IP prefixes may take up to two business days. You will be additionally notified once the process is completed.  

{% endnote %}

If there are any IP connectivity issues, contact support for diagnostics and troubleshooting.

