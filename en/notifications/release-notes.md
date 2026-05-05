---
title: '{{ cns-full-name }} release notes'
description: This section contains the {{ cns-name }} release notes.
---

# {{ cns-name }} release notes

## Q1 2026 {#q1-2026}

Added the ability to create SMS templates for channels with an individual sender. Templates define the SMS notification type: transactional, authentication, or service. If the message text does not match any of the templates, such message is classified as an ad. [Sending costs](pricing.md) vary by notification type. In {{ cns-name }}, you can create an SMS template and register it with telecom providers.

Read more in [{#T}](concepts/sms.md#templates).

## Q3 2025 {#q3-2025}

Implemented [topics](concepts/topics.md) to centrally send notifications to multiple endpoints.

In {{ cns-name }}, the topics format is compatible with the [Amazon SNS API](https://docs.aws.amazon.com/sns/latest/api/welcome.html).

For examples of commands for topics, refer to the [management console]({{ link-console-main }}) and the [step-by-step guide](operations/index.md#topics) sections.

## Q1 2025 {#q1-2025}

* Added the option to send push notifications to browsers and progressive web applications ([PWAs](https://en.wikipedia.org/wiki/Progressive_web_app)). Browser integration is available in the management console, CLI, API, and SDK.

   For more information, see [{#T}](concepts/browser.md).

* You can now set up push notifications for the [RuStore](https://www.rustore.ru/help/users/about-rustore) platform from the management console. The previously available options were the CLI, API, and SDK.

  For more information, see [{#T}](quickstart-push.md).

* Added the option to write and view logs in {{ cloud-logging-full-name }}.
  
   For more information, see [{#T}](concepts/logging.md).

* Added the option to build charts based on notification metrics in {{ monitoring-full-name }}.

   For more information, see [{#T}](metrics.md).

* Implemented AWS SDK support for [C++](tools/sdk-cpp.md), [Go](tools/sdk-go.md), [Java](tools/sdk-java.md), [JavaScript](tools/sdk-javascript.md), [Kotlin](tools/sdk-kotlin.md), and [.NET](tools/sdk-dot-net.md). Added examples for these SDKs to the management console:
  
  * Creating an endpoint for a device.
  * Sending messages to an endpoint.

  The examples will be available after you create a channel on the page with its settings.

## Q4 2024 {#q4-2024}

* Now you can send push notifications to mobile devices with RuStore. Added integration with [RuStore](https://www.rustore.ru/help/users/about-rustore) to the CLI, API, and SDK interfaces.
* Added support for the [AWS SDK for PHP](https://docs.aws.amazon.com/sdk-for-php).
* Added examples for the AWS CLI, Python, and PHP to the [management console]({{ link-console-main }}):
  * Creating an endpoint for a device.
  * Sending messages to an endpoint.

  The examples will be available after you create a channel on the page with its settings.

## Q3 2024 {#q3-2024}

The service is available upon request at the [Preview](../overview/concepts/launch-stages.md) stage.
