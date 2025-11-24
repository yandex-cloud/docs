---
title: Producers and consumers
description: In this article, you will learn about producers and consumers.
---

# Producers and consumers

{{ KF }} is a distributed system for exchanging messages between data producers and consumers.

* _Producer_ is a data source application. It connects to an {{ KF }} cluster and writes messages with data to specific [topics](topics.md) and topic partitions. To write messages to a topic and partition, the user must have relevant permissions which come from [roles](account-roles.md).
* _Consumer_ is an application that receives and processes data from producers. Instead of getting data directly from a producer, it connects to the {{ KF }} cluster, subscribes to relevant [topics](topics.md), and reads messages from them. To subscribe to a topic, the user must have relevant permissions which come from [roles](account-roles.md).

## Consumer groups {#consumer-groups}

{{ KF }} supports two consumer management modes:

* _Autonomous mode_: Each consumer selects which {{ KF }} topic sections to read all by themselves.

* _Group mode_: The {{ KF }} topic sections are automatically distributed among the group's consumers. The consumers thus read messages in a coordinated manner.

A consumer group consists of one or more consumers who collectively read messages from a topic. To keep track of messages already read by the consumer group, each {{ KF }} topic section is mapped to a sequence number called _group offset_. As a result, each one of the topic's messages is delivered to only one consumer from the group.

The {{ KF }} topic sections are distributed among the group's consumers:

* Each section is assigned to one consumer within a specific group. At the same time, one consumer can process multiple sections.
* If there are changes in group membership or the number of sections, rebalancing takes place: the sections get redistributed among the group's consumers.

For more information, see the {{ KF }} documentation for [producers](https://kafka.apache.org/documentation/#theproducer) and [consumers](https://kafka.apache.org/documentation/#theconsumer).
