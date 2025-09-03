---
title: '{{ KF }} cluster user roles in {{ mkf-full-name }}'
description: In this article, you will learn about user types in a {{ KF }} cluster.
---

# User roles in {{ mkf-full-name }}

A role is a set of permissions [assigned to a user](../operations/cluster-accounts.md#grant-permission) to manage {{ KF }} cluster resources.

#### ACCESS_ROLE_SCHEMA_READER {#access-role-schema-reader}

The `ACCESS_ROLE_SCHEMA_READER` role grants these resource management permissions:
* Data schema: Reading.
* Topic: Viewing info (only for topics related to schemas).
* Cluster: Viewing info.

You can assign the role for one or several [subjects](managed-schema-registry.md#subjects). Instead of specifying a topic or group of topics, list all the subjects you need, including the nested ones, separated by semicolons.

#### ACCESS_ROLE_SCHEMA_WRITER {#access-role-schema-writer}

The `ACCESS_ROLE_SCHEMA_WRITER` role grants these resource management permissions:
* Data schema: Reading and writing.
* Topic: Viewing info (only for topics related to schemas).
* Cluster: Viewing info.

You can assign the role for one or several subjects. Instead of specifying a topic or group of topics, list all the subjects you need, including the nested ones, separated by semicolons.

#### ACCESS_ROLE_TOPIC_CONSUMER {#access-role-topic-consumer}

The `ACCESS_ROLE_TOPIC_CONSUMER` role grants these resource management permissions:
* Topic: Viewing info and configuration, reading.
* Cluster: Viewing info.
* Consumer group: Reading.

You can issue the role for a specific topic or group of topics with names sharing the same prefix (`<prefix>*`) or for all topics at once (`*`).

#### ACCESS_ROLE_CONSUMER {#access-role-consumer}

The `ACCESS_ROLE_CONSUMER` role grants these resource management permissions:
* Data schema: Reading.
* Topic: Viewing info and configuration, reading.
* Cluster: Viewing info.
* Consumer group: Reading.

You can issue the role for a specific topic or group of topics with names sharing the same prefix (`<prefix>*`) or for all topics at once (`*`).

#### ACCESS_ROLE_TOPIC_PRODUCER {#access-role-topic-producer}

The `ACCESS_ROLE_TOPIC_PRODUCER` role grants these resource management permissions:
* Transaction ID: Writing.
* Topic: Viewing info and configuration, writing to a topic, and creating a topic.
* Cluster: Viewing info, idempotent writing.
* Consumer group: Viewing info, reading.

You can issue the role for a specific topic or group of topics with names sharing the same prefix (`<prefix>*`) or for all topics at once (`*`).

#### ACCESS_ROLE_PRODUCER {#access-role-producer}

The `ACCESS_ROLE_PRODUCER` role grants these resource management permissions:
* Data schema: Reading and writing.
* Transaction ID: Writing.
* Topic: Viewing info and configuration, writing to a topic, and creating a topic.
* Cluster: Viewing info, idempotent writing.
* Consumer group: Viewing info, reading.

You can issue the role for a specific topic or group of topics with names sharing the same prefix (`<prefix>*`) or for all topics at once (`*`).

#### ACCESS_ROLE_TOPIC_ADMIN {#access-role-topic-admin}

The `ACCESS_ROLE_TOPIC_ADMIN` role grants these resource management permissions:
* Data schema: Reading and writing.
* Topic: Reading from a topic, writing to a topic, creating/deleting a topic.
* Consumer group: Viewing info, reading.

You can issue the role for a specific topic or group of topics with names sharing the same prefix (`<prefix>*`) or for all topics at once (`*`).

#### ACCESS_ROLE_ADMIN {#access-role-admin}

The `ACCESS_ROLE_ADMIN` role grants these resource management permissions:
* Data schema: Reading and writing.
* Transaction ID: Writing.
* Topic: Viewing/editing info and configuration, reading from a topic, writing to a topic, creating/deleting a topic.
* Cluster: Viewing info and configuration, idempotent writing, creating a cluster.
* Consumer group: Viewing info, reading, deleting a group.

A role can be assigned only for all topics at once (`*`).
