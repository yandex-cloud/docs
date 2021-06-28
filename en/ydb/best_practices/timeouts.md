---
title: Using timeouts in Yandex Database (YDB)
description: 'The operation_timeout value shows the time during which the query result is interesting to the user. If the operation fails during this time, the server returns an error with the Timeout code and tries to terminate the query, but its cancellation is not guaranteed. We recommend that you always set an operation timeout and transport timeout.'
---

This section describes available timeouts and provides examples of their usage in various programming languages.

## Operation timeout

The ``operation_timeout`` value shows the time during which the query result is interesting to the user. If the operation fails during this time, the server returns an error with the ``Timeout`` code and tries to terminate the query, but its cancellation is not guaranteed. So the query that the user was returned the ``Timeout`` error for can be both successfully executed on the server and canceled.

## Timeout for canceling an operation

The ``cancel_after`` value shows the time after which the server will start canceling the query, if it can be canceled. If canceled, the server returns the ``Cancelled`` error code.

## Transport timeout

The client can set a transport timeout for each query. This value lets you determine the amount of time that the client is ready to wait for a response from the server. If the server doesn't respond during this time, the client will get a transport error with the ``DeadlineExceeded`` code.

## Using timeouts

We recommend that you always set an operation timeout and transport timeout. The value of the transport timeout should be 50-100 milliseconds more than that of the operation timeout, that way there is some time left for the client to get a server error with the ``Timeout`` code.

Below are examples of using timeouts in various programming languages:

{% list tabs %}

- Python

  ```python
  from kikimr.public.sdk.python import client as ydb
  
  def execute_in_tx(session, query):
    settings = ydb.BaseRequestSettings()
    settings = settings.with_timeout(0.5)  # transport timeout
    settings = settings.with_operation_timeout(0.4)  # operation timeout
    settings = settings.with_cancel_after(0.4)  # cancel after timeout
    session.transaction().execute(
        query,
        commit_tx=True,
        settings=settings,
    )
  ```

{% endlist %}

