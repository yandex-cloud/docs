---
title: '{{ KF }} cluster user roles in {{ mkf-full-name }}'
description: In this article, you will learn about user types in a {{ KF }} cluster.
---

# User roles in {{ mkf-full-name }}

A role is a set of permissions [assigned to a user](../operations/cluster-accounts.md#grant-permission) to manage {{ KF }} cluster resources.

#### ACCESS_ROLE_CONSUMER {#access-role-consumer}

The `ACCESS_ROLE_CONSUMER` role grants these resource management permissions:
* Topic: Viewing info and configuration, reading.
* Cluster: Viewing info.
* Consumer group: Reading.

You can issue the role for a specific topic or group of topics with names sharing the same prefix (`<prefix>*`).

#### ACCESS_ROLE_PRODUCER {#access-role-producer}

The `ACCESS_ROLE_PRODUCER` role grants these resource management permissions:
* Transaction ID: Writing.
* Topic: Viewing info and configuration, writing to a topic, and creating a topic.
* Cluster: Viewing info, idempotent writing.
* Consumer group: Viewing info, reading.

You can issue the role for a specific topic or group of topics with names sharing the same prefix (`<prefix>*`).

#### ACCESS_ROLE_TOPIC_ADMIN {#access-role-topic-admin}

The `ACCESS_ROLE_TOPIC_ADMIN` role grants these resource management permissions:
* Topic: Reading from a topic, writing to a topic, creating/deleting a topic.
* Consumer group: Viewing info, reading.

You can issue the role for a specific topic or group of topics with names sharing the same prefix (`<prefix>*`).

#### ACCESS_ROLE_ADMIN {#access-role-admin}

The `ACCESS_ROLE_ADMIN` role grants these resource management permissions:
* Transaction ID: Writing.
* Topic: Viewing/editing info and configuration, reading from a topic, writing to a topic, creating/deleting a topic.
* Cluster: Viewing info and configuration, idempotent writing, creating a cluster.
* Consumer group: Viewing info, reading, deleting a group.

A role can be assigned only for all topics at once (`*`).
