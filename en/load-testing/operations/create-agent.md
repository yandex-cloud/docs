---
title: How to create a test agent in {{ load-testing-full-name }}
description: In this tutorial, you will learn how to create a test agent.
---

# Creating a test agent

## Preparing an infrastructure {#infrastructure-prepare}

1. Create a service account for test agent:

   {% include [sa-create](../../_includes/load-testing/sa-create.md) %}
1. [Set up](../../load-testing/operations/security-groups-agent.md) the test agent's security group.

## Creating a test agent {#create-agent}

{% include [create-agent](../../_includes/load-testing/create-agent.md) %}