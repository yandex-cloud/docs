---
title: '{{ datalens-full-name }} error ERR.DS_API.DB.SOURCE_CONNECT_ERROR'
description: This page describes the Data source refused connection {{ datalens-full-name }} error.
---

# [{{ datalens-full-name }}] Data source refused connection

`ERR.DS_API.DB.SOURCE_CONNECT_ERROR`

Error loading data.

This error means that a connection to the database could not be established.

To fix the error, check the [connection](../../concepts/connection/index.md) settings:

* Make sure the data specified in the connection is correct: **Host name**, **HTTP interface port**, **Username**, and **Password**. If required, check them with your administrator.
* If the specified port only works over HTTP, disable the **HTTPS** connection option.
* If the host list contains only one host, enter all the cluster hosts separated by commas in the **Host name** field.
* If you are connecting to a database that is not a {{ yandex-cloud }} resource, follow [this guide](../../concepts/connection/index.md#external-db-connection) to check the setup for correctness on the database side.
* If you are connecting to a database that is a {{ yandex-cloud }} resource, in `Select in organization` mode, check that the **{{ ui-key.yacloud.mdb.forms.additional-field-datalens }}** option is enabled in the managed database cluster. If in `Specify manually` mode, check that the hosts you are using have public addresses.