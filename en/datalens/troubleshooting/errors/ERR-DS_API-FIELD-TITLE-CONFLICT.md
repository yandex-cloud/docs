---
title: '{{ datalens-full-name }} error ERR.DS_API.FIELD.TITLE.CONFLICT'
description: This page describes the Field title conflicts with another field {{ datalens-full-name }} error.
---

# [{{ datalens-full-name }}] Field title conflicts with another field

`ERR.DS_API.FIELD.TITLE.CONFLICT`

Conflicting field names. The new field must not have the same name as any existing field in the dataset.

Check that the field has a unique name within the dataset.

Possible reason: the field with this name was added first to the chart and then to its source dataset.
In this situation, it makes sense to rename the field added to the chart.
