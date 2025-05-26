---
title: How to create a test agent in {{ load-testing-full-name }}
description: In this guide, you will learn how to create a test agent.
---

# Creating a test agent

## Setting up your infrastructure {#infrastructure-prepare}

1. Create a service account for your test agent:

    {% include [sa-create](../../_includes/load-testing/sa-create.md) %}
1. [Configure](../../load-testing/operations/security-groups-agent.md) a test agent security group.

## Creating a test agent {#create-agent}

{% include [create-agent](../../_includes/load-testing/create-agent.md) %}