Jobs are run using the {{ yandex-cloud }} CLI through the {{ dataproc-name }} agent installed on the cluster master host. Job parameters are passed to the agent through the [Data Proc API](../../data-proc/api-ref/Job/index.md).

An executable file and its dependencies must be located in storage that the {{dataproc-name}} cluster service account has access to. The application being run must have access to storage where the source data set and run results are saved.

