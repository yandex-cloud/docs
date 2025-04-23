---
title: '{{ load-testing-full-name }} release notes'
description: This section contains {{ load-testing-name }} release notes.
---

# {{ load-testing-full-name }} release notes

## Q1 2025 {#q1-2025}

* Added prompts on how to configure your test. For example, we recommend specifying auto-stop for each instance (this affects the accuracy and validity of test results) and enable discarding of outdated requests to guarantee the planned test duration.
* In the agent and test interface, you can specify the log group to which logs will be exported. This will help you to analyze what is happening on your agent during tests, as well as tackle any issues during a test run, e.g., incorrect test data.
* Regressions display the time and date format based on the console settings.
* When navigating to a completed test from the list, you will now see the test results instead of its overview.

## Q4 2024 {#q4-2024}

* Test configuration is partially pre-populated with default values.
* Now you can use public IP addresses for agents without configuring the network.
* Setting up SSH access to the agent is now optional.

## Q3 2024 {#q3-2024}

* Added the ability to export reports.
* Implemented {{ load-testing-name }} object search via {{ search-api-name }} in the management console.
* Implemented integration with the quota service.
* Discarded requests are now displayed on charts.
* The test page now states the reason why autostop was triggered.

## Q2 2024 {#q2-2024}

* Released a plugin for {{ monitoring-name }}.
* Implemented a selection of agents for tests by filtering via the API, CLI, and SDK.
* Added a [time-based autostop](./concepts/auto-stop.md) to the test creation form. This parameter will become a required one moving forward.
* Agents automatically clean up disk space. By default, an agent cleans up 2 GB of space. You can manage automatic cleanup settings using the [Resource Check plugin](https://yandextank.readthedocs.io/en/latest/core_and_modules.html#resource-check).