For any unmet requirement, the owner must define the reason, affected resources, remediation steps, responsible person, and due date. The implemented fix must be first tested on the initial scenario, and then the related allowed and prohibited scenarios. Patching one service is insufficient if a patch bypass remains possible via a different service.

If immediate remediation is currently unfeasible, apply the standard exception process from [{#T}](../../../../security/standard-ai/intro.md). Exceptions do not alter the core requirement or hide unverified branches.

The final check package must contain:

* Up-to-date architecture description.
* List of relevant requirements with reasons for classifying any as N/A.
* Results and evidence links.
* List of unmet requirements and remediation plan.
* List of unchecked requirements and branches with reasons and check plan.
* Current exceptions.
* Cloud and application telemetry boundaries.
* Final review date, scope, and participant list.

After changing a model, data, RAG source, tool, external recipient, role, public endpoint, or runtime, the owner must repeat the relevant checks. A full new review is required if the impact of changes cannot be reliably isolated.
