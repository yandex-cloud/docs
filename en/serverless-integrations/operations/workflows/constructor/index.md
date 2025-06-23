---
title: Guidelines on using the workflow step constructor
description: In this article, you will learn how to use the {{ sw-full-name }} workflow step constructor. You will learn how to use the constructor to add integration and management steps to a workflow.
---

# {{ sw-name }} workflow step constructor overview

You can use the constructor to configure integration and management steps for your [workflow](../../../concepts/workflows/workflow.md). The constructor is available in the [management console]({{ link-console-main }}) when you [create](../workflow/create-constructor.md) and [update](../workflow/update.md) a workflow.

You can configure the following workflow steps using the constructor:

## Integration steps {#integration-steps}

* [{{ sf-short-name }}](./functioncall.md)
* [{{ serverless-containers-name }}](./containercall.md)
* [{{ postbox-short-name }}](./postbox.md)
* [{{ tracker-name }}](./tracker.md)
* [HTTP](./httpcall.md)
* [gRPC](./grpccall.md)
* [{{ objstorage-name }}](./objectstorage.md)
* [{{ foundation-models-name }}](./foundationmodelscall.md)
* [{{ ydb-name }}](./ydbdocument.md)
* [{{ yds-name }}](./yds.md)
* [{{ message-queue-name }}](./ymq.md)
* [Yandex Disk](./yadisk.md)
* [{{ sw-name }}](./workflow.md)
* [AI agent](./aiagent.md)

## Control steps {control-steps}

* [Switch](./switch.md)
* [Foreach](./foreach.md)
* [While](./while.md)
* [Parallel](./parallel.md)
* [No op](./noop.md)
* [Fail](./fail.md)
* [Success](./success.md)
* [Wait](./wait.md)

## General settings {#general-settings}

* [{#T}](./setup-restart-policy.md)
