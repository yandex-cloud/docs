# Migrating load testing results from OverLoad


[Yandex OverLoad](https://overload.yandex.net/) is a service for monitoring load testing and analyzing its results. You can migrate [test results](../../load-testing/concepts/load-test-results.md) from Yandex OverLoad to {{ load-testing-full-name }}.

To migrate load testing results:

1. [Prepare your cloud](#before-you-begin).
1. [Get an API token and Yandex OverLoad test IDs](#get-overload).
1. [Migrate the testing results](#transfer-results).
1. [Check the results](#check-results).

If you no longer need the OverLoad test results, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% note info %}

The minimum folder role required to migrate load testing results from Yandex OverLoad is `loadtesting.loadTester`. For more information, see:
 * [Role description](../../load-testing/security/index.md#roles-list).
 * [How to assign a role](../../iam/operations/sa/assign-role-for-sa.md#binding-role-resource).

{% endnote %}

### Required paid resources {#paid-resources}

At the [Preview](../../overview/concepts/launch-stages.md) stage, {{ load-testing-name }} is free of charge.

## Get an API token and Yandex OverLoad test IDs {#work-with-overload}

1. Get authenticated in Yandex OverLoad:

    1. Click **Sign in** on the [service page](https://overload.yandex.net/).
    1. Select the account you used to sign up to Yandex OverLoad: [Yandex ID](https://yandex.ru/support/id/) or [GitHub](https://docs.github.com/en/account-and-profile).

1. Click the account image and select **My api token**. Save the API token.
1. In the **Public tests** tab, click **show my tests only**. Save the IDs of the tests whose results you want to migrate to {{ load-testing-name }}.

## Migrate the testing results {#transfer-results}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
  1. In the left-hand panel, go to the ![tests](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}** tab.
  1. At the top right, click ![options](../../_assets/options.svg) and select **{{ ui-key.yacloud.load-testing.label_import-tests-from-overload }}**.
  1. In the window that opens, specify the import parameters:
      * **{{ ui-key.yacloud.load-testing.field_overload-token }}**: Yandex OverLoad API token you previously obtained.
      * **{{ ui-key.yacloud.load-testing.field_overload-test-id }}**: ID of the Yandex OverLoad test whose results you want to migrate. If there are multiple tests, click **{{ ui-key.yacloud.load-testing.button_add-overload-test-id }}** and enter the next ID.
  1. Click **{{ ui-key.yacloud.common.import }}**.

  It takes some time to transfer the load testing results.

{% endlist %}

## Check the results {#check-results}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
  1. In the left-hand panel, go to the ![operations](../../_assets/mdb/operations.svg) **{{ ui-key.yacloud.common.operations-key-value }}** tab.
  1. Make sure the following operations completed successfully:
      * **Overload Migration**.
      * **Overload Migrate Test** for each migrated test.
  1. In the left-hand panel, go to the ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}** tab.
  1. Check that the list contains tests named as `[overload <test_ID>]<test_description>`.
  1. Choose one of the migrated tests and view its results.

{% endlist %}

## How to delete the resources you created {#clear-out}

To delete the test results migrated from Yandex OverLoad:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
  1. In the left-hand panel, go to the ![tests](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}** tab.
  1. Next to the test to delete the results for, click ![options](../../_assets/options.svg) and select **{{ ui-key.yacloud.common.delete }}**.
  1. Confirm the deletion.

{% endlist %}
