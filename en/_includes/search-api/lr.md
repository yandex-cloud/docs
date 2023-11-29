#### Search region ID {#lr}

Only supported for *{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}* and *{{ ui-key.yacloud.search-api.test-query.label_search_type-turkish }}* search types.

The `lr` field contains the ID of the search country or region that impacts the document ranking rules. For example, if you set this field to `11316` (Novosibirsk region), the search results will be generated based on the formula specified for the Novosibirsk region.

For a list of frequently used country and region IDs, see [{#T}](../../search-api/reference/regions.md).