---
title: Code examples for connecting to a {{ MG }} cluster in {{ mmg-full-name }}
description: Use these examples to connect to a database in a {{ MG }} cluster from your app code.
---

# Code examples for connecting to a {{ MG }} cluster

Examples were tested in the following environment:

* {{ yandex-cloud }} virtual machine running Ubuntu 20.04 LTS
* Bash: `5.0.16`
* Python: `3.8.2`; pip3: `20.0.2`
* PHP: `7.4.3`
* OpenJDK: `11.0.8`; Maven: `3.6.3`
* Node.JS: `10.19.0`, npm: `6.14.4`
* Go: `1.13.8`

{% include [see-fqdn-in-console](../../../_includes/mdb/see-fqdn-in-console.md) %}

All examples assume that the `root.crt` [SSL certificate](index.md#get-ssl-cert) is located in the `/home/<home_directory>/.mongodb/` directory.

If the connection to the cluster and the test query are successful, the following data is output:

* For PHP examples, the `ping` command result.
* For other examples, the name of the database the connection was established to.

Available connection methods depend on whether the cluster [sharding](../../concepts/sharding.md) is enabled:

* [Examples for connection to a non-sharded cluster](non-sharded.md)
* [Examples for connection to a sharded cluster](sharded.md)
