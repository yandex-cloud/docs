---
title: "Test data in {{ load-testing-full-name }}"
description: "In this tutorial, you will learn about the types of test data in {{ load-testing-full-name }} and where you can store them."
---

# Payload

_Payloads_ are used by load generators for testing applications. A payload can be any relevant data that can be used to test your application. For example:

* Sets of names of test scripts that the load generator should execute.
* Sets of SQL queries for loading the database.
* HTTP requests to be sent to the server.
* Different parameters for the same request.

The testing tools uses Pandora and Phantom load generators. Available data types depend on the formats supported by the load generator you select.

Types of payloads:

* [URI](payloads/uri.md)
* [URIPOST](payloads/uripost.md)
* [PHANTOM](payloads/phantom.md)
* [RAW](payloads/raw.md)
* [HTTP_JSON](payloads/http-json.md)
* [GRPC_JSON](payloads/grpc-json.md)

To store payloads, you can use [{{ objstorage-full-name }}](../../storage/). In this case, a data file is uploaded to a [bucket](../../storage/concepts/bucket.md) and remains in the user's cloud.

{% note info %}

To handle large amounts of data and ensure maximum security, we recommend using this particular method of storing payloads.

{% endnote %}
