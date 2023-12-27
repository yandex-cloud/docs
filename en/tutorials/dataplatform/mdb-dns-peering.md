---
title: "Configuring {{ dns-full-name }} for accessing managed database clusters from other cloud networks"
description: "Clients (such as virtual machines) on the same cloud network as the cluster can access cluster hosts by their Fully Qualified Domain Names (FQDNs). However, if the clients are on another cloud network, this will not be possible. This is because the required DNS service zones are created automatically and only support name resolution within a single cloud network."
---

# Configuring {{ dns-full-name }} for access to managed database clusters from other cloud networks

{% include notitle [mdb-peering-all-in-one](../../_tutorials/infrastructure/mdb-dns-peering-all-in-one.md) %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
