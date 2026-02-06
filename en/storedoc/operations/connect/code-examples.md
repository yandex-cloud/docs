---
title: Code examples for connecting to a {{ SD }} cluster in {{ mmg-full-name }}
description: These examples show you how to connect to a {{ SD }} cluster database from your application.
---

# Code examples for connecting to a {{ SD }} cluster

The examples were tested in the following environment:

* {{ yandex-cloud }} VM running Ubuntu 20.04 LTS
* Bash: `5.0.16`.
* Python: `3.8.2`, pip3: `20.0.2`.
* PHP: `7.4.3`.
* OpenJDK: `11.0.8`, Maven: `3.6.3`.
* Node.JS: `10.19.0`, npm: `6.14.4`.
* Go: `1.13.8`.

{% include [see-fqdn-in-console](../../../_includes/mdb/see-fqdn-in-console.md) %}

All examples assume that the `root.crt` [SSL certificate](index.md#get-ssl-cert) is located in the `/home/<home_directory>/.mongodb/` directory.

Once you successfully connect to the cluster and run a test query, you will see the following output:

* For PHP examples, the result of the `ping` command.
* For other examples, the target database name.

The available connection methods depend on whether the [sharding](../../concepts/sharding.md) is enabled in the cluster:

* [Connection examples for non-sharded clusters](non-sharded.md)
* [Connection examples for sharded clusters](sharded.md)
