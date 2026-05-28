---
title: Resource groups in {{ mtr-name }}
description: ''
---

# Resource groups in {{ mtr-name }}

_Resource groups_ in {{ mtr-name }} are used to manage workload and allow you to:

* Distribute user queries across groups.
* Limit cluster resource usage per group.
* Manage queues and concurrency within groups.
* Set group priorities and use different query scheduling policies.

Learn more about resource groups in [this {{ TR }} guide](https://trino.io/docs/current/admin/resource-groups.html).

Configuration of resource groups in a {{ mtr-name }} cluster includes:

* Group tree definition: Each group can have its own limits and scheduling settings.

* Selector rules: Define how incoming queries are distributed across groups in the cluster.

For more information about resource group and selector rule management in {{ mtr-name }}, see [this guide](../operations/manage-resource-groups.md).

## Resource group tree and limits {#rg-tree}

Resource groups are arranged in a hierarchical tree. Root groups are at the top level. A group with sub-groups is called a _parent group_. A group that does not have sub-groups is called a _leaf group_.
Only leaf groups can accept queries.

You can set separate limits for each group; when the limits are reached, new queries are queued. These include:
* Memory usage limit.
* CPU time limits.
* Limit on the number of concurrent queries.

You can set an individual limit for each group's queue length. When it is reached, new queries are rejected with an error.

Each query counts not only toward the group where it runs, but also toward all parent groups. Limits apply at each level of the group tree.

## Group names {#rg-names}

{{ mtr-name }} uses group names of two types:
* Predefined name, such as `global` or `admins`.
* Template name containing variable placeholders, such as `${USER}`. When a query targets such a group, the system creates a dynamically named instance if it does not already exist.

Learn more about resource group properties in [this guide](../operations/manage-resource-groups.md).

## Selector rules {#rules}

Selector rules are used to determine a target group for a query based on its properties.

Each query received by the cluster is matched against the selector rules. Rules are checked in their declaration order. The first rule that matches all specified query properties will apply. The query is routed to the group specified in the rule. If a query does not match any rule, it is rejected with an error.

Learn more about selector rule properties in [this guide](../operations/manage-resource-groups.md).

## Query scheduling {#policy}

Sub-groups compete if the following conditions are met:
* The queues of two or more sub-groups include queries ready to run.
* These sub-groups have not yet reached their limits.
* The parent group limit does not allow all sub-group queries to run at the same time.

To manage query scheduling across sub-groups, assign a scheduling policy to the parent group:

* `fair`: Sub-groups take turns receiving the opportunity to start queries. When a group receives such a scheduling opportunity, it selects the first query in its queue (FIFO).

* `weighted_fair`: For each sub-group, the system calculates the following:
  * Current concurrency level: Ratio of the number of running queries in the group to the total number of running queries across all sub-groups.
  * Expected concurrency level: Ratio of the group's weight (`schedulingWeight`) to the total weight of all sub-groups.

  The group with the largest gap below its expected concurrency level receives the opportunity to start the next query. When a group receives such a scheduling opportunity, it selects the first query in its queue (FIFO).

* `weighted`: Sub-groups receive the opportunity to start new queries with a probability proportional to their weight (`schedulingWeight`). When a group receives such a scheduling opportunity, it selects the first query in its queue. The probability of a query being selected is proportional to its priority (the `query_priority` session property).

* `query_priority`: All queues of sub-groups are treated as a single queue whose queries are scheduled in order of their priority (the `query_priority` session property). Make sure the `query_priority` scheduling policy is also selected for all non-leaf sub-group.

A scheduling policy defined for a resource group only applies to its immediate sub-groups. Non-leaf sub-groups can have their own scheduling policies, which, in turn, govern their own sub-groups. Scheduling proceeds down the group tree hierarchy until it reaches a leaf group, which runs the query.
