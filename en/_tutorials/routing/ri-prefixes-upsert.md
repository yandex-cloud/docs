## Changing VPC IP prefixes in a routing instance {#ri-ip-change}

To change IP prefixes in a private connection, do the following:
1. Delete the existing IP prefixes from the private connection. 
1. Add new IP prefixes to the private connection.

To change your private connection IP prefixes, create a [new support ticket]({{ link-console-support }}).

### Contacting support to change IP prefixes in a private connection {#prefix-change}

Follow this request format:




Where:

* `vpc_net_id`: {{ vpc-full-name }} virtual network ID. For each such virtual network, you need to specify IPv4 subnet prefixes grouped by {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md).


### Contacting support to add IP prefixes to a private connection {#prefix-add}

Follow this request format:



Where:

* `vpc_net_id`: {{ vpc-full-name }} virtual network ID. For each such virtual network, you need to specify IPv4 subnet prefixes grouped by {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md).


### Contacting support to delete IP prefixes from a private connection {#prefix-del}

Follow this request format:



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

If there are any IP connectivity issues, contact support for diagnostics and troubleshooting.

