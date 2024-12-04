---
title: Scheduled scaling of instance groups
description: Follow this tutorial to create a {{ compute-full-name }} VM group and set up scheduled scaling for it using {{ sf-full-name }} functions and timer.
---

# Scheduled scaling of instance groups


Follow this tutorial to create a [VM group](../../compute/concepts/instance-groups/index.md) using [{{ compute-full-name }}](../../compute/) and set up scheduled [scaling](../../compute/concepts/instance-groups/scale.md) for it. A [{{ sf-full-name }}](../../functions/) [function](../../functions/concepts/function.md) triggered by a [timer](../../functions/concepts/trigger/timer.md) will manage the instance group size.

You can use one of the following tools to configure VM group scaling:
