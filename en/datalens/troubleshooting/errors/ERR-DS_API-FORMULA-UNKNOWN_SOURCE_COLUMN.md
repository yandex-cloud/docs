---
title: '{{ datalens-full-name }} error ERR.DS_API.FORMULA.UNKNOWN_SOURCE_COLUMN'
description: This page describes the Unknown referenced source column {{ datalens-full-name }} error.
alternate:
  - href: en/datalens/troubleshooting/errors/ERR-DS_API-FORMULA-UNKNOWN_SOURCE_COLUMN.md
    type: text/markdown
    title: Markdown version
---

# [{{ datalens-full-name }}] Unknown referenced source column

`ERR.DS_API.FORMULA.UNKNOWN_SOURCE_COLUMN`

The field references the column that is missing from the source. Probably, the column existed before but was deleted.

If it exists in the data source but is not recognized by the dataset, [update the fields](../../dataset/create-dataset.md#update-fields).
