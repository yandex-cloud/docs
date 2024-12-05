1. View the logs of the `scan-on-push` function and make sure it has executed.

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
     1. Go to the **{{ ui-key.yacloud.serverless-functions.switch_list }}** section and select the `scan-on-push` function.
     1. In the window that opens, go to **{{ ui-key.yacloud.serverless-functions.item.switch_logs }}** and specify the time period. The default time period is one hour.

   - CLI {#cli}

     {% include [function-list-note](../../../_includes/functions/function-list-note.md) %}

     View the function execution log:

     ```bash
     yc serverless function logs scan-on-push
     ```

     Result:

     ```text
     2021-05-18 09:27:43  START RequestID: 34dc9533-ed6e-4468-b9f2-2aa0******** Version: b09i2s85a0c1********
     2021-05-18 09:27:43  END RequestID: 34dc9533-ed6e-4468-b9f2-2aa0********
     2021-05-18 09:27:43  REPORT RequestID: 34dc9533-ed6e-4468-b9f2-2aa0******** Duration: 538.610 ms Billed Duration: 538.700 ms Memory Size: 128 MB Max Memory Used: 13 MB
     2021-05-18 09:29:25  START RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f******** Version: b09i2s85a0c1********
     2021-05-18 09:29:26  END RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f********
     2021-05-18 09:29:26  REPORT RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f******** Duration: 554.904 ms Billed Duration: 555.000 ms Memory Size: 128 MB Max Memory Used: 13 MB
     ...
     ```

   {% endlist %}

1. Make sure that a new scan started when you pushed the Docker image.

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the parent folder of the registry containing the Docker image.
     1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
     1. Select the registry where you pushed your Docker image.
     1. Open the repository with the Docker image.
     1. Select the relevant Docker image and check the **{{ ui-key.yacloud.cr.image.label_last-scan-time }}** parameter value.

   - CLI {#cli}

     To view scans by Docker image, run the command:

     ```bash
     yc container image list-scan-results --repository-name=<registry_ID>/<Docker_image_name>
     ```

     Result:

     ```text
     +----------------------+----------------------+---------------------+--------+--------------------------------+
     |          ID          |        IMAGE         |     SCANNED AT      | STATUS |        VULNERABILITIES         |
     +----------------------+----------------------+---------------------+--------+--------------------------------+
     | crpu20rpdc2f******** | crpqmsqp5mtb******** | 2021-05-18 14:34:02 | READY  | medium:6, low:13, negligible:3 |
     +----------------------+----------------------+---------------------+--------+--------------------------------+
     ```

   {% endlist %}