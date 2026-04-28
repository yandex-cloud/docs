---
title: '{{ load-testing-full-name }} shutdown'
description: We are sunsetting {{ load-testing-full-name }}. This page outlines the decommissioning timeline and procedure, and provides guidance for migration.
---

# {{ load-testing-full-name }} shutdown

{% note warning %}

We are sunsetting {{ load-testing-full-name }}. This page outlines the decommissioning timeline and procedure, and provides guidance for migration.

{% endnote %}

## What's happening {#what-happens}

We have made the decision to discontinue {{ load-testing-name }}. We understand this may impact your workflows, and we are committed to supporting you through a smooth transition to alternative solutions.

## Key dates {#key-dates}

The decommissioning process will follow these three stages:

* **April 13, 2026**: {{ load-testing-name }} end of sale.
* **June 1, 2026**: Transition to read-only mode. You will no longer be able to run new tests or modify configurations. Yet, you will still be able to view results of previous tests and existing settings.
* **July 1, 2026**: Full decommissioning. Access to the interface will be disabled.

## What happens to your data {#data}

Your test configurations and load testing results will be preserved. After decommissioning, we will retain backup copies of your data, which you can request via our [support](https://center.yandex.cloud/support/).

{% note info %}

If your cloud contains virtual machines that were used as load testing agents, they will continue to run after {{ load-testing-name }} is decommissioned. You are responsible for deleting or or reconfiguring these former agents.

{% endnote %}

## Migration {#migration}

As an alternative, migrate your load testing scenarios to [k6](https://k6.io/), an open-source load testing tool.

Here is a guide we prepared to help you adapt your tests: [Migrating from {{ load-testing-name }} to k6](tutorials/loadtesting-migration-to-k6.md).

{% include [k6-legal-note](../_includes/load-testing/k6-legal-note.md) %}

## Further questions {#support}

If you have questions about the shutdown or require assistance with your migration:

* Contact [support](https://center.yandex.cloud/support).
* Contact your account manager.

Thank you for using {{ load-testing-name }}.
