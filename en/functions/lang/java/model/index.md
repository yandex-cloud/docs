---
title: Java programming model
description: In this article, you will learn about the Java programming models supported by {{ sf-name }} and the handler requirements.
---

# Java programming model

{{ sf-name }} provides four Java programming models which are based on the [Function](jdk-function.md) and [YcFunction](yc-function.md) interfaces, the [HttpServlet](servlet-api.md) class, and [Spring Boot](spring-boot.md). The first three ways of setting a function handler involve implementing custom implementations of these interfaces or classes, while the last one involves uploading the application in its original form without any changes.

The difference between the [Function](jdk-function.md) and [YcFunction](yc-function.md) models is the availability of the [invocation context](../context.md). For example, if you need to work with {{ yandex-cloud }} services using the [SDK](../sdk.md), we recommend opting for [YcFunction](yc-function.md). With the [HttpServlet](servlet-api.md) model, you can fully manage the return value and `HTTP` method used to invoke the function, and, like the `YcFunction` model, provides access to the [invocation context](../context.md).

There are two separate types for the [Function](jdk-function.md) and [YcFunction](yc-function.md) models: `byte[]` and `String`. They are used differently from other types. If you use them as the handler argument type, the runtime will not convert the incoming request into `JSON` and instead will provide it directly to the user-defined handler, unless [?integration=raw](../../../concepts/function-invoke.md#http) is used.

{% note info %}

The [jsoniter](http://jsoniter.com/java-features.html) library is used for serializing and deserializing `JSON`.

{% endnote %}

## Handler requirements {#requirements}

No matter which model you select, the project can be uploaded as source code, a JAR archive, or a Maven project. The class that contains the handler must also meet the following requirements:

* It must be public.
* It must have a public no-argument constructor.

   It is provided by default. However, if you created your own constructor with arguments, you should also create a no-argument one.

* It must not be [generic](https://docs.oracle.com/javase/8/docs/technotes/guides/language/generics.html).
