---
title: '{{ datalens-full-name }} error: ERR.DS_API.DB.COMMIT_OR_ROLLBACK_FAILED'
description: This page describes the `Failed to COMMIT or ROLLBACK` {{ datalens-full-name }} error.
---

# [{{ datalens-full-name }}] Failed to COMMIT or ROLLBACK

`ERR.DS_API.DB.COMMIT_OR_ROLLBACK_FAILED`

This error occurs when the driver fails to complete the transaction with the `COMMIT` or `ROLLBACK` command. The error may be caused by a connection failure, server unavailability, or an issue with the transaction state.

To fix this error, try the following:

* Repeat the request.
* Make sure the server is available and check its logs, status of transactions, and connection settings.


* If the error persists, contact the database administrator or {{ yandex-cloud }} [support]({{ link-console-support }}). In your message, describe when the error occurs.

