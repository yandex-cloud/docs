Jobs are run from the {{ yandex-cloud }} CLI with the help of a {{ dataproc-name }} agent installed on the cluster master host. The agent gets job properties through the [{{ dataproc-name }} API](../../data-proc/api-ref/Job/index.md).

The executable and its dependencies must reside in a storage accessible to the {{ dataproc-name }} cluster's service account. The application itself must have access to the storage containing the source data and execution results.
