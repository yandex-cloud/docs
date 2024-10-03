---
title: '{{ api-gw-full-name }} specification constructor guide'
description: In this tutorial, you will learn how to work with the {{ api-gw-full-name }} specification constructor in {{ yandex-cloud }}. You will learn how to add extensions to a specification using the constructor.
---

# Specification constructor overview

You can use the specification constructor to work with {{ api-gw-name }} [integrations](../../concepts/extensions/index.md#integration). To add the `x-yc-apigateway-integration` extension to an OpenAPI specification using the constructor, fill out a form in the management console when [creating](../api-gw-create.md) or [changing](../api-gw-update.md) an API gateway.

Available integrations:

* [{{ sf-name }}](cloud-functions.md)
* [Static response](dummy.md)
* [{{ objstorage-name }}](object-storage.md)
* [{{ serverless-containers-name }}](containers.md)
* [Access over HTTP](http.md)
* [{{ message-queue-name }}](ymq.md)
* [{{ yds-name }}](datastreams.md)
* [{{ ydb-name }}](ydb.md)
* [{{ ml-platform-name }}](datasphere.md)
* [{{ yagpt-name }}](yagpt.md)