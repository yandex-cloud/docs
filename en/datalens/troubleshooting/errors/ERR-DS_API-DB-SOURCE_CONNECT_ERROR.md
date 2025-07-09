---
title: ERR.DS_API.DB.SOURCE_CONNECT_ERROR error
description: This page describes the ERR.DS_API.DB.SOURCE_CONNECT_ERROR error.
---

# Data source refused connection

`ERR.DS_API.DB.SOURCE_CONNECT_ERROR`

Error loading data.

This error means that a connection to the database could not be established.

To fix the error, check the [connection](../../concepts/connection.md) settings:

* Make sure the data specified in the connection is correct: **Host name**, **HTTP interface port**, **Username**, and **Password**. If required, check them with your administrator.
* If the specified port only works over HTTP, disable the **HTTPS** connection option.
* If the host list contains only one host, enter all the cluster hosts separated by commas in the **Host name** field.