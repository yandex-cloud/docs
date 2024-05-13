---
title: "How to manage {{ ES }} users"
description: "This guide describes how you can manage {{ ES }} users."
---

# Managing {{ ES }} users

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

You can manage cluster users as an `admin` user. You can specify a password for this user when [creating](cluster-create.md#create-cluster) or [updating](cluster-update.md#change-admin-password) a cluster.

Interfaces available for user management:
- [Security API {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/reference/current/security-api.html#security-user-apis).
- [Kibana](https://www.elastic.co/guide/en/kibana/current/xpack-security.html#_users_2). For more information about how to connect to Kibana, see [Connecting to a cluster](cluster-connect.md).

To perform routine tasks, create individual users with the minimum required [set of privileges](https://www.elastic.co/guide/en/elasticsearch/reference/current/security-privileges.html). It's not recommended to use the `admin` account for these purposes, because it has full access to the cluster. Running an incorrect command under the admin account may cause the cluster to fail.

To learn more about roles and privileges, see the [{{ ES }} documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/authorization.html).

