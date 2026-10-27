---
title: '{{ datalens-full-name }} error: ERR.DS_API.DB.CANNOT_INSERT_NULL_IN_ORDINARY_COLUMN'
description: This page describes the `Cannot convert NULL value to non-Nullable type` {{ datalens-full-name }} error.
---

# [{{ datalens-full-name }}] Cannot convert NULL value to non-Nullable type

`ERR.DS_API.DB.CANNOT_INSERT_NULL_IN_ORDINARY_COLUMN`


This error occurs when {{ CH }} attempts to write or convert the `NULL` value into a field with a data type that does not allow the `NULL` value.

To fix the error, check the schema and source data, match the `Nullable` types, or replace `NULL` with a suitable value using `ifNull`/`coalesce`.



If the error occurs in an automatically generated query and it is not possible to fix the source or calculated field, contact {{ yandex-cloud }} [support]({{ link-console-support }}). In your message, describe when the error occurs.

