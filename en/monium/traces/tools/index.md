---
title: Instrumentation types
description: This section covers different types of instrumentation to transmit data to {{ monium-name }}.
---

# Instrumentation

Traces describe the request's path through a distributed system, from the entry point down to all the services and components involved. They consist of linked spans, each one representing a separate operation.

To send traces from an application, you need to add to it the code that creates and sends traces. This process is called _instrumentation_.

Instrumentation can be either automatic or manual.

## Automatic instrumentation

Traces are generated automatically without any changes to the application code.

Features:

* Uses agents, libraries, or bytecode injection.
* Automatically tracks HTTP requests, database calls, and external APIs.
* Quick to implement with minimum effort.
* Limited flexibility and granularity.

## Manual instrumentation

Traces are created in the code explicitly by the developer.

Features:

* Full control over spans and attributes.
* Tracing of business logic and specific operations.
* Adds custom metadata.
* Longer to implement.
