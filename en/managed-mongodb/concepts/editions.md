---
title: "{{ MG }} editions in {{ mmg-full-name }}"
description: "In this tutorial, you will learn about {{ MG }} editions available to {{ yandex-cloud }} users."
---

# {{ MG }} editions

Some features provided in {{ mmg-name }} depend on the {{ MG }} edition:

| Name | Description | `Community Edition` | `Enterprise Edition` |
|---------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:------------------------------------:|:------------------------------------:|
| Transactions | Performing an atomic operation with one or more documents, including those distributed across collections, databases, and shards | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| [Audit logs](https://docs.mongodb.com/manual/core/auditing/) | Configuring event auditing and event recording to the console, `syslog`, JSON, or BSON files | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| [Transparent data encryption in storage](https://docs.mongodb.com/manual/core/security-encryption-at-rest/) | Enabling data encryption in collections on the WiredTiger storage engine, which ensures compliance with industry security standards (such as PCI DSS) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| Security and encryption | Support for TLS/SSL, user authentication (including intra-cluster) using SCRAM and x.509 certificates and role-based access control (RBAC) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Index management | Support for multi-component and multi-key indexes and geolocation data | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Sharding and replication | Distributing data across shards and replica sets | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |

To use `Enterprise` Edition, {{ MG }} version 4.4 or higher is required. To update your {{ mmg-name }} cluster, follow [this guide](../operations/cluster-version-update.md).
