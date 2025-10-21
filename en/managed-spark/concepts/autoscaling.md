---
title: Autoscaling in {{ msp-full-name }}
description: Autoscaling is changing the number of {{ SPRK }} cluster hosts depending on current load.
---

# Autoscaling in {{ msp-full-name }}

*Autoscaling* is changing the number of {{ SPRK }} cluster hosts depending on current load.

Host pools for drivers and executors get scaled independently:

* If there is not enough free CPUs or RAM to run a new app, i.e., a new driver, {{ msp-full-name }} starts a new host in the host pool for drivers. If the number of running apps decreases, and an idling host appears in the host pool for drivers, such a host gets deleted.

* If there is not enough free CPUs or RAM to host all executors of every running app, {{ msp-full-name }} starts new hosts in the host pool for executors. If the number of running executors decreases, and an idling host appears in the host pool for executors, such a host gets deleted.

Autoscaling advantages:
* The cluster becomes more productive when running demanding jobs; whereas, during idling, excessive hosts get deleted so you pay less for them.
* Time per job is less dependent on the number of concurrent jobs.
* Dynamic allocation becomes more efficient: host pool for executors adjusts to the changing app needs.

## Autoscaling management {#settings}

You can enable and disable autoscaling for each of the two host pools when [creating](../operations/cluster-create.md) and [updating](../operations/cluster-update.md) an {{ SPRK }} cluster.

For each host pool, you can set a range for the number of hosts in that pool:

* The minimum number cannot be less than zero.
* The maximum number cannot be more than 100 or less than the minimum number.

What the minimum number of pool hosts does:

* The higher the minimum number of hosts in the pool for drivers, the more apps of the same type can be run concurrently without waiting for additional hosts to start.
* The higher the minimum number of hosts in the pool for executors, the greater the load that can be channeled to the cluster without waiting for additional hosts to start.
* As the minimum number of hosts in the pools increases, you pay more for the cluster when idling or under low load.

What the maximum number of pool hosts does:

* The higher the maximum number of hosts in the pool for drivers, the more apps of the same type can be run concurrently.
* The higher the maximum number of hosts in the pool for executors, the higher the maximum cluster performance.
* As the maximum number of hosts in the pools increases, you pay more for the cluster under maximum load.

## Recommendations on the choice of autoscaling parameters {#recommendations}

The choice autoscaling parameters depends on the particular cluster use case. The table values are approximate.

The number of concurrent same-type jobs on a cluster and their processing speed depend on the following:
* Number and class of hosts in each pool.
* Parameters of each job.
* Amount of cluster resources reserved for internal needs.
* Time spent on process planning.
* Time spent on pool scaling.
* Use of shuffle operations.

| Scenario          | Number of hosts for drivers | Number of hosts for executors | Comment |
|-------------------|----------------------------|-------------------------------|-------------|
| Short-lived batch jobs; execution speed is not critical | Minimum: `0`. Maximum: `1`. | Minimum: `0`. Maximum: As per the budget. | Such settings allow you to pay less for the cluster during prolonged idling; however, when running a job, you will have to wait for hosts to start. |
| Short-lived batch jobs; execution speed is critical | Fixed: `1`. | Minimum: `0`. Maximum: As per the budget. | Such settings eliminate host startup delays. |
| Long-lived batch jobs with intensive use of Shuffle operations | Minimum: `1`. Maximum: As per your service's target metrics. | Minimum: From `2` to `5`. Maximum: As per the budget and your service's target metrics. | Such settings allow you to avoid excessive "shrinking" of the host pool for executors when there is a load drop between stages and save the time you spend on increasing the pool again. |
| Same cluster used by several teams | Minimum: As per the maximum number of concurrent jobs. Maximum: As per the budget and your service's target metrics. | Minimum: From `2` to `5`. Maximum: As per the budget and your service's target metrics. | Such settings allow you to eliminate host startup delays when using the cluster together by all teams. |