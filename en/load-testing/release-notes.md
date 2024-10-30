---
title: '{{ load-testing-full-name }} Release notes'
description: This section contains {{ load-testing-name }} release notes.
---

# {{ load-testing-full-name }} release notes

## Q2 2024 {#q2-2024}

* Released a plugin for {{ monitoring-name }}.
* Implemented a selection of agents for tests by filtering via the API, CLI, and SDK.
* Added a [time-based autostop](./concepts/auto-stop.md) to the test creation form. This parameter will become a required one moving forward.
* Agents automatically clean up disk space. By default, an agent cleans 2 GB of space. You can manage automatic cleanup settings using the [Resource Check plugin](https://yandextank.readthedocs.io/en/latest/core_and_modules.html#resource-check).