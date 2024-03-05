# Reports

A report is aggregate data that was collected during load testing.

## To view a report

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder for testing.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
   1. In the left-hand panel, select ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}**.
   1. Select the test to view the report for.
   1. Go to one of these tabs:
      * Overview: Basic information about the test run.
      * [Test results](load-test-results.md): Visualization of various dependencies.
      * [Monitoring](monitoring.md): Collected metrics on the test agent status.
      * Tables: Indicators of aggregated test results.

{% endlist %}