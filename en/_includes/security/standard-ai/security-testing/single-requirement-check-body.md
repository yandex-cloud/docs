The reviewer performs the following actions:

1. Reviews the required target result and applicability condition.
1. Selects the exact resource, version, subject, and data path.
1. Selects the officially documented interface for the check: the management console, CLI, API, or log. Matches the test with a specific requirement and configuration.
1. Checks the configuration and effective permissions in read only mode.
1. Runs an approved scenario.
1. Runs a prohibited or boundary scenario, if safe to do so.
1. Maps the cloud event to the application trace and documented gaps in telemetry.
1. Saves the minimum evidence and output.

The requirement check result is recorded with one of these statuses: _met_, _not met_, _not applicable_, or _not checked_.

The _met_ status is only acceptable if the observed state matches the required one in all relevant branches, and there is no unexplained bypass, or a documented [exception](../../../../security/standard-ai/intro.md#exceptions) applies. A partial check of the relevant branches fails to satisfy the requirement.

The requirement is not met if a prohibited subject, stream, or action succeeds, a required setting is missing, or the evidence pertains to the wrong resource or version.

If even a single relevant branch is not checked, the final status will be _not checked_ stating the unchecked branch and reason. The _not checked_ status does not indicate compliance and requires further checking or creating an exception.
