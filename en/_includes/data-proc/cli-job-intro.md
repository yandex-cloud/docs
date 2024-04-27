Jobs are run using the {{ yandex-cloud }} CLI through the {{ dataproc-name }} agent installed on the cluster master host. Job parameters are communicated to the agent through the [{{ dataproc-name }} API](../../data-proc/api-ref/Job/index.md).

The executable file and its dependencies must be located in a storage accessible to the {{ dataproc-name }} cluster service account. The executed application itself must have access to the storages in which the source data set and execution results are saved.
