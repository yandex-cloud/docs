---
title: '{{ datalens-full-name }} error: ERR.DS_API.DB.EST_EXEC_TOO_LONG'
description: 'This page describes the `Estimated query execution time is too long` {{ datalens-full-name }} error. Maximum: 14400.'
---

# [{{ datalens-full-name }}] Estimated query execution time is too long. Maximum: 14400

`ERR.DS_API.DB.EST_EXEC_TOO_LONG`

This error occurs when {{ CH }} estimates the request execution time to exceed the allowed maximum based on the current speed.

To fix this error, reduce the amount of processed data using filters, simplify joins and calculations, and use sort keys, pre-aggregation, or a materialized view.

If the request legitimately requires a longer execution time, contact the {{ CH }} administrator to review the time and execution speed limits.
