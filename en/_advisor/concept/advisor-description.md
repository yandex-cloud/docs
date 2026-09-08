Managed database clusters regularly undergo diagnostics to detect possible issues, increase the cluster's reliability, and improve its performance. The results of such checks are displayed as inspections under **{{ ui-key.yacloud.mdb.cluster.switch_recommendations }}**. You can see notifications about successful checks and recommendations on eliminating discovered risks. The responsibility to troubleshoot any detected issues lies within the {{ yandex-cloud }} user's [remit](../../overview/concepts/mdb-responsibilities.md).

All checks have a severity level:

* High level: Criteria of high cluster availability, significant risks of reduced performance, data loss risks. Such checks warrant special attention and require following the recommendations provided. 
* Moderate level: Possible risks of reduced performance, suboptimal memory and disk space usage.
* Low level: Potential risks and cluster operation limitations.

The list of recommendations is updated regularly. For each recommendation, the following timestamps are fixed: the date of the risk's first detection and the date of the most recent status update on this issue. If the recommendation seems to be excessive or incorrect, you can hide it, specifying a reason. Once the hiding period expires, the recommendation will automatically become available again if the issue persists.

Recommendations are available at the cluster, folder, and cloud levels and provide tips for all your resources. However, the absence of recommendations does not mean that your cluster is optimized: the list of checks gets continuously appended but still remains incomprehensive and cannot replace monitoring, since it is **targeted at detecting patterns rather than specific issues**. You can additionally run cluster performance diagnostics and analyze monitoring metrics.

