### Why cannot I set more than N threads for a transfer from {{ GP }} to {{ GP }}? {#threads_limit}

If a {{ GP }}-to-{{ GP }} transfer does not use direct reads from segments, the number of threads cannot exceed the minimum number of segments in the participating clusters.

Learn more about the specifics of working with a {{ GP }} source [here](../../../../data-transfer/operations/endpoint/source/greenplum.md#advanced).