---
title: '{{ load-testing-full-name }} is decommissioned.'
description: '{{ load-testing-full-name }} is decommissioned.'
---

# {{ load-testing-full-name }} is decommissioned

{% note warning %}

{{ load-testing-full-name }} ceased to operate on July 1, 2026. 

{% endnote %}

## What happens to your data {#data}

You can request backups of test configurations and load test results through [support](https://center.yandex.cloud/support/).

If your clouds contain virtual machines that were used as load testing agents, they will continue to run after {{ load-testing-name }} is decommissioned. You are responsible for deleting or or reconfiguring these former agents.

## Migration {#migration}

As an alternative, migrate your load testing scenarios to [k6](https://k6.io/), an open-source load testing tool.

Here is a guide we prepared to help you adapt your tests: [Migrating from {{ load-testing-name }} to k6](tutorials/loadtesting-migration-to-k6.md).

{% include [k6-legal-note](../_includes/load-testing/k6-legal-note.md) %}

## Further questions {#support}

If you have questions about the shutdown or require assistance with your migration:

* Contact [support](https://center.yandex.cloud/support).
* Contact your account manager.

Thank you for using {{ load-testing-name }}.
