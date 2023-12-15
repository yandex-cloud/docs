---
title: "How to make incremental updates in {{ compute-full-name }}"
description: "Follow this guide to start your terminal in the Windows serial console (SAC)."
---

# Incremental update

You might need to update your service incrementally, undeploying no more than *N* instances at a time:

1. Describe the appropriate instance [template](../../../concepts/instance-groups/instance-template.md).
1. Set the [deployment policy](../../../concepts/instance-groups/policies/deploy-policy.md) with a non-zero value of `max_unavailable`: the maximum number of instances to undeploy at the same time.
1. Run a group's [update operation](../../../operations/instance-groups/update.md).

For example, to update an instance group sequentially by undeploying one instance at a time, set the following parameters in the `deploy-policy`:
```
...
deploy-policy:
    max_unavailable: 1
    max_expansion: 0
    ...
...
```

The group will be updated as follows:

![Rolling update](../../../../_assets/instance-groups/rolling-update.gif "Rolling update")