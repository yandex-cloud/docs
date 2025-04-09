# Configuring a {{ sw-name }} workflow integrated with {{ tracker-full-name }}, {{ foundation-models-full-name }}, and {{ postbox-full-name }}

{% include [workflows-preview-note](../../_includes/serverless-integrations/workflows-preview-note.md) %}

In this tutorial, you will create {{ sw-full-name }} [workflows](../../serverless-integrations/concepts/workflows/workflow.md) and configure their integration with [{{ tracker-full-name }}]({{ link-tracker-cloudless }}), [{{ foundation-models-full-name }}](../../foundation-models/concepts/yandexgpt/index.md), and [{{ postbox-full-name }}](../../postbox/index.yaml).

Your workflows will receive information about the issues in a given {{ tracker-name }} [queue]({{ link-tracker-cloudless }}about-tracker#ochered) and use {{ gpt-pro }} to analyze the workcompleted within these issues, their statuses, and evaluation. The results of the analysis and a brief progress report will be saved in a comment to one of the {{ tracker-name }} issues and also sent to the specified email address via {{ postbox-name }}.

To configure a {{ sw-name }} workflow:

1. [Get your cloud ready](#before-you-begin).
1. [Create a service account](#service-account).
1. [Prepare {{ tracker-name }}](#prepare-tracker).
1. [Configure workflow access in {{ tracker-name }}](#setup-tracker-access).
1. [Create an address and pass a domain rights check in {{ postbox-name }}](#setup-postbox).
1. [Create a {{ sw-name }} workflow](#setup-workflow).
1. [Test the workflow](#test).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

1. [Log in]({{ link-passport-login }}) to your Yandex account. If you do not have an account, [create]({{ support-passport-create }}) one.
1. Sign up in {{ yandex-cloud }} and create a [billing account](../../billing/concepts/billing-account.md):
    1. Navigate to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or register a new account.
    1. On the **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** page, make sure you have a billing account linked and it has the `ACTIVE` or `TRIAL_ACTIVE` [status](../../billing/concepts/billing-account-statuses.md). If you do not have a billing account, [create one](../../billing/quickstart/index.md) and [link](../../billing/operations/pin-cloud.md) a cloud to it.

    If you have an active billing account, you can navigate to the [cloud page]({{ link-console-cloud }}) to create or select a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) for your infrastructure to operate in.

    [Learn more about clouds and folders](../../resource-manager/concepts/resources-hierarchy.md). 
1. Install [cURL](https://curl.haxx.se): you will need it to send a request for an OAuth token for the Yandex ID application.

### Required paid resources {#paid-resources}

The cost of the web service infrastructure support includes:

* Fee for storing the [secret](../../lockbox/concepts/secret.md) and requests to the secret (see [{{ lockbox-name }} pricing](../../lockbox/pricing.md)).
* Fee for using {{ foundation-models-full-name }} (see [{{ foundation-models-full-name }} pricing](../../foundation-models/pricing.md)).
* Fee for using {{ tracker-full-name }} (see [{{ tracker-name }} pricing]({{ link-tracker-cloudless }}pricing)).
* Fee for using {{ postbox-full-name }} (see [{{ postbox-name }} pricing](../../postbox/pricing.md)).

## Create a service account {#service-account}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you will be creating your workflows in.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**, and in the window that opens:
      1. Enter a name for the [service account](../../iam/concepts/users/service-accounts.md): `workflow-sa`.
      1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `serverless.workflows.executor` [role](../../iam/concepts/access-control/roles.md).
      1. Repeat the previous step to add the [`postbox.sender`](../../postbox/security/index.md#postbox-sender) and [`ai.languageModels.user`](../../foundation-models/security/index.md#languageModels-user) roles.
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

## Prepare your queue and issues in {{ tracker-name }} {#prepare-tracker}

For the workflows you are creating in this tutorial to work correctly, configure your queue in {{ tracker-full-name }}.

{% list tabs group=instructions %}

- {{ tracker-name }} interface {#console}

  1. If your organization does not have {{ tracker-full-name }} connected, [connect]({{ link-tracker-cloudless }}enable-tracker) it.
  1. If you do not have a queue in {{ tracker-name }} yet, [create]({{ link-tracker-cloudless }}manager/create-queue) one.
  1. [Create]({{ link-tracker-cloudless }}user/create-ticket) 5-10 test issues in your queue meeting the following requirements:

      * The test issues must be created in one queue.
      * All test issues must have the `product` [tag]({{ link-tracker-cloudless }}glossary#rus-t) set in the **Tags** field.
      * All test issues must be evaluated in [Story Points]({{ link-tracker-cloudless }}glossary#en-s) in the **Story Points** field.
      * Some of the test issues should be in `Closed` [status]({{ link-tracker-cloudless }}about-tracker#process), and some in `Open` status.
      * Comments about your progress on closed test issues must be [added]({{ link-tracker-cloudless }}user/comments) to these issues.

{% endlist %}

## Configure access for workflow authentication in {{ tracker-name }} {#setup-tracker-access}

To authenticate your workflow in {{ tracker-full-name }}, get a token of an [OAuth application](https://yandex.ru/dev/id/doc/ru/concepts/ya-oauth-intro) with read and write permissions for {{ tracker-name }}.

### Create an OAuth application in Yandex ID {#create-app}

To create an OAuth application with read and write access rights to {{ tracker-name }}:

1. In your browser, go to the [OAuth application creation page](https://oauth.yandex.com/client/new/). On the page that opens:
    1. In the **Service name** field, enter the name of the OAuth application you are creating: `My Tracker Workflow`.
    1. Under **Application platforms**, select the **Web services** option and specify Redirect URI in the field that appears: `https://oauth.yandex.com/verification_code`.
    1. Under **Data access**, in the **Access name** field, enter `tracker:read` and select the `Read from tracker` access. 

        The `Read from tracker` access will appear below in the list of application accesses.

        Similarly, add the `tracker:write` access (`Write to tracker`).
    1. Under **Email for communication**, specify your email address to send notifications about the new application.
    1. Click **Create app**.

On the new application's page, copy the **ClientID** and **Client secret** field values. You will need them in the next step to get an OAuth token.

### Get the application's OAuth token {#create-token}

1. [Get](https://yandex.ru/dev/id/doc/ru/codes/code-url#code) the confirmation code. To do this, paste the following address into your browser address bar with the value you copied in the previous step as `client_id`:

    ```text
    https://oauth.yandex.ru/authorize?response_type=code&client_id=<ClientID_value>
    ```

    Confirm granting your OAuth application access to {{ tracker-name }}.

    In the window that opens, copy and save the confirmation code you get. You will need this code to get an OAuth token.
1. Get the application's OAuth token by running this command in the terminal:

    ```bash
    curl \
      --request POST \
      --header "Content-type: application/x-www-form-urlencoded" \
      --data "grant_type=authorization_code&code=<confirmation_code>&client_id=<ClientID_value>&client_secret=<Client_secret_value>" \
      https://oauth.yandex.ru/token
    ```

    Where:
    * `code`: Confirmation code you got in the previous step.
    * `client_id`: Your OAuth application's **ClientID** value you got earlier.
    * `client_secret`: Your OAuth application's **Client secret** value you got earlier.

    Result:

    ```json
    {"access_token": "y0__wgBhMmiugUY4b40IJCda4YSeAfV5tAoPqy2tttkQsy********", "expires_in": 31536000, "refresh_token": "1:7WGrfpErRSTlkTJI:NGU-BJxhvhUdwDxDuez5ana4Befm63bXXhNpJFnbWDX1XJ_rJ3qh6DH_AItBhFJk********:ZZP-Pf0nxo4nil********", "token_type": "bearer"}%
    ```

    Save the resulting `access_token` field value. This is the application's OAuth token the workflow will need to access {{ tracker-name }}.

### Create a {{ lockbox-full-name }} secret {#create-secret}

Create a {{ lockbox-name }} [secret](../../lockbox/quickstart.md) to store your OAuth token and assign access permissions for the new secret to the service account .

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you created the service account in earlier.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Click **{{ ui-key.yacloud.lockbox.button_create-secret }}**, and in the window that opens:

      1. In the **{{ ui-key.yacloud.common.name }}** field, specify the secret name: `tracker-oauth-token`.
      1. In the **{{ ui-key.yacloud.lockbox.forms.title_secret-type }}** field, select `{{ ui-key.yacloud.lockbox.forms.title_secret-type-custom }}`.
      1. Under **{{ ui-key.yacloud.lockbox.label_version-dialog-title }}**:
          * In the **{{ ui-key.yacloud.lockbox.forms.label_key }}** field, enter the secret key: `oauth`.
          * In the **{{ ui-key.yacloud.lockbox.forms.label_value }}** field, specify the application OAuth token you got in the previous step.
      1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Click the line with the new secret (`tracker-oauth-token`) and do the following in the window that opens:

      1. Copy and save the **{{ ui-key.yacloud.lockbox.label_secret-id }}** field value. You will need it later when creating the workflow specification.
      1. Go to the ![persons](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab and click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
      1. In the search bar, enter the name of the service account created earlier (`workflow-sa`) and select the service account you found.
      1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the `lockbox.payloadViewer` [role](../../lockbox/security/index.md#lockbox-payloadViewer).
      1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Create an address and pass a domain rights check in {{ postbox-name }} {#setup-postbox}

For the workflow to be able to send emails, create a {{ postbox-name }} [address](../../postbox/concepts/glossary.md#adress) and confirm the ownership of the domain the emails will be sent from.

### Create a {{ postbox-name }} address {#create-address}

1. Generate a key to create a DKIM signature by running this command in the terminal:

    ```bash
    openssl genrsa -out privatekey.pem 2048
    ```

    The new key will be saved in the `privatekey.pem` file in the current directory.

1. Create an address:

    {% list tabs group=instructions %}

    - Management console {#console}

        1. In the [management console]({{ link-console-main }}), select the folder you used to create the service account and secret in.
        1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
        1. Click **{{ ui-key.yacloud.postbox.button_create-identity }}**.
        1. In the **{{ ui-key.yacloud.postbox.label_address }}** field, specify the domain to send emails from. e.g., `example.com`.

            The domain can be of any level. You must have permissions to add [resource records](../../dns/concepts/resource-record.md) to the public [DNS zone](../../dns/concepts/dns-zone.md) of the specified domain. This is required to confirm your right to use it.
        1. In the **{{ ui-key.yacloud.postbox.label_selector }}** field, specify a selector, e.g., `tracker_workflow`. 

            The name of the selector will be used to create a TXT resource record, so each selector you create must be unique within your domain.
        1. In the **{{ ui-key.yacloud.postbox.label_private-key }}** field, copy the contents of the `privatekey.pem` private key file you created earlier.
        1. Click **{{ ui-key.yacloud.postbox.button_create-identity }}**.
        1. In the list of addresses that appears, select the created address and, under **{{ ui-key.yacloud.postbox.label_signature-verification }}** on the page that opens, copy and save the values ​​of the **{{ ui-key.yacloud.postbox.label_dns-record-name }}** and **{{ ui-key.yacloud.postbox.label_dns-record-value }}** fields. You will need these to create a TXT resource record.

    {% endlist %}

### Pass a domain rights check {#validate-domain}

1. In the public DNS zone of your domain, create a [TXT resource record](../../dns/concepts/resource-record.md#txt) using the following values:

    * **Record name**: **{{ ui-key.yacloud.postbox.label_dns-record-name }}** field value you copied in the previous step.

        In {{ dns-full-name }}, specify the name portion generated when creating the address (without specifying the domain) in `<selector>._domainkey` format, e.g., `tracker_workflow._domainkey`.

        For other DNS services, you may need to copy the entire record. The final record must look like this: `<selector>._domainkey.<domain>.`, e.g., `tracker_workflow._domainkey.example.com.`.

    * **Record type**: `TXT`.
    * **Record value**: **{{ ui-key.yacloud.postbox.label_dns-record-value }}** field value you copied in the previous step.
    
        Note that the record value must be enclosed in quotes, for example:

        ```text
        "v=DKIM1;h=sha256;k=rsa;p=M1B...aCA8"
        ```

    {% note info %}

    If your domain is delegated to {{ dns-full-name }}, use [this guide](../../dns/operations/resource-record-create.md) to create a resource record. In other cases, use your domain name registrar's personal account page. If you have any questions, refer to the relevant documentation or contact the registrar's support service.

    {% endnote %}
1. Run a domain rights check.

    {% list tabs group=instructions %}

    - Management console {#console}

        1. In the [management console]({{ link-console-main }}), select the folder the new address is in.
        1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}** and select the required address.
        1. Click **{{ ui-key.yacloud.postbox.button_validate }}**. If the TXT record is created correctly, the verification status on the address page will change to `Success`.

            DNS server responses are cached, so delays may occur when updating a resource record.

    {% endlist %}

## Create a {{ sw-name }} workflow {#setup-workflow}

1. Select the specification you will use to create your workflow. Both the above specifications use integrations with {{ tracker-full-name }}, {{ foundation-models-full-name }}, and {{ postbox-full-name }}; however, they analyze the input data differently.

    {% list tabs %}

    - Option 1

      The suggested workflow will analyze the {{ tracker-name }} issues in the specified queue, generate and publish a progress report for these issues:

      1. Analyzing issues with specified tag in a given {{ tracker-name }} queue:
          * Total number of issues.
          * Total sum of [Story Points]({{ link-tracker-cloudless }}glossary#en-s) awarded to issues.
          * Number of closed issues.
          * Percentage ratio of the number of closed issues to the total number of issues.
          * Sum of `Story Points` awarded to closed issues.
          * Percentage ratio of the sum of `Story Points` awarded to closed issues to the total sum of `Story Points` awarded to all issues.
      1. Generating a report with the results of the analysis.
      1. Publishing a report in a comment to a specified {{ tracker-name }} issue, sending the report to a specified email address.

      **Specification code**:

      ```yaml
      yawl: "0.1"
      start: fetch_tickets
      steps:
        fetch_tickets:
          tracker:
            organization:
              cloudOrganizationId: <organization_ID>
            oauthToken: '\(lockboxPayload("<secret_ID>"; "oauth"))'
            listIssues:
              filter:
                issueProperties:
                  queue: <queue_key_in_{{ tracker-name }}>
                  tags: "product"
            output: |-
              \({
                "sp_sum": [.[].storyPoints] | add,
                "closed_sp_sum": . | map(select(.status.key == "closed")) | map(.storyPoints) | add,
                "ticket_count": . | length,
                "closed_ticket_count": . | map(select(.status.key == "closed")) | length,
                "non_closed_ticket_texts": . | map(select(.status.key != "closed")) | map({
                  "key": .key,
                  "summary": .summary,
                  "description": .description            
                })
              })
            next: summarize_texts
        summarize_texts:
          foundationModelsCall:
            next: create_report
            modelUrl: gpt://<folder_ID>/yandexgpt
            generate:
              maxTokens: 500
              temperature: 0.5
              messages:
                messages:
                  - role: system
                    text: "Next you will get names of unfinished {{ tracker-name }} issues and their descriptions. State as briefly as possible (no more than three sentences) what remains to be done"
                  - role: user
                    text: |-
                      \("
                        \(.non_closed_ticket_texts | map(.summary + ": " + .description) | join(". "))
                      ")
            output: |-
              \({
                "summary": .alternatives.[0].message.text
              })
        create_report:
          noOp:
            output: |-
              \({
              "report_text": "**Total amount of work:** \(.ticket_count) issue(s), \(.sp_sum) sp
              **Work completed:** \(.closed_ticket_count) (\(100 * .closed_ticket_count / .ticket_count | round)%) issue(s), \(.closed_sp_sum) (\(100 * .closed_sp_sum / .sp_sum | round)%) sp

              **Unfinished issues:**
                \(.non_closed_ticket_texts | map(.key) | join("\n"))

              **Summary of what remains:**
                \(.summary)
              ",
              "report_text_html": "<b>Total amount of work:</b> \(.ticket_count) issue(s), \(.sp_sum) sp<br>
              <b>Work completed:</b> \(.closed_ticket_count) (\(100 * .closed_ticket_count / .ticket_count | round)%) issue(s), \(.closed_sp_sum) (\(100 * .closed_sp_sum / .sp_sum | round)%) sp<br>
              <br>
              <b>Unfinished issues:</b><br>
                \(.non_closed_ticket_texts | map("<a href=https://tracker.yandex.ru/" + .key + ">" + .key + "</a>") | join("<br>"))<br>
              <br>
              <b>Summary of what remains:</b><br>
                \(.summary | gsub("\\n"; "<br>"))
              "})
            next: deliver_report
        deliver_report:
          parallel:
            branches:
              tracker:
                start: write_report_to_tracker
                steps:
                  write_report_to_tracker:
                    tracker:
                      organization:
                        cloudOrganizationId: <organization_ID>
                      oauthToken: '\(lockboxPayload("<secret_ID>"; "oauth"))'
                      createComment:
                        key: <issue_key_with_report>
                        text: \(.report_text)
              postbox:
                start: send_report_via_postbox
                steps:
                  send_report_via_postbox:
                    postbox:
                      simple:
                        subject:
                          data: "Dev progress report"
                          charset: UTF_8
                        body:
                          text:
                            data: \(.report_text)
                            charset: UTF_8
                          html:
                            data: \("<p>\(.report_text_html)</p>")
                            charset: UTF_8
                      fromAddress: tracker-robot@<your_domain>
                      destination:
                        toAddresses: <recipient_address>
      ```

      Where:

      * `<organization_ID>`: [ID](../../organization/operations/organization-get-id.md) of your {{ org-full-name }}.
      * `<secret_ID>`: Previously saved [secret](../../lockbox/concepts/secret.md) ID with the application's OAuth token.
      * `<queue_key_in_{{ tracker-name }}>`: [Key]({{ link-tracker-cloudless }}glossary#rus-k) of the {{ tracker-name }} queue you created the test issues in.
      * `<folder_ID>`: [ID](../../resource-manager/operations/folder/get-id.md) of the folder you are creating a workflow in.
      * `<issue_key_with_report>`: Key of the {{ tracker-name }} [issue]({{ link-tracker-cloudless }}glossary#rus-z) in the comment to which the summary of the analyzed test issues will be uploaded.
      * `<your_domain>`: Domain you specified when creating the {{ postbox-name }} address. For the sender address (`fromAddress`) you can specify any address on this domain. Example: `tracker-robot@example.com` or `noreply@example.com`.
      * `<recipient_address>`: Email address the workflow will send an email to with a summary of the analyzed {{ tracker-name }} test issues.

      A workflow comprises the following steps: `fetch_tickets`, `summarize_texts`, `send_report_via_postbox`, and `write_report_to_tracker`.

    - Option 2

      The suggested workflow will analyze closed {{ tracker-name }} issues for the last week, generate and publish a progress report for these issues:
      1. Analysis of issues closed over the past week:
          * Uploading comments to issues.
          * Analysis and summation of comments for each closed issue.
      1. Generating a report summarizing the work done for each closed issue.
      1. Publishing the report in a comment to a specified {{ tracker-name }} issue, sending the report to a specified email address.

      **Specification code**:

      ```yaml
      yawl: "0.1"
      start: fetch_tickets
      steps:
        fetch_tickets:
          tracker:
            organization:
              cloudOrganizationId: <organization_ID>
            oauthToken: '\(lockboxPayload("<secret_ID>"; "oauth"))'
            listIssues:
              query: 'Status: changed(to: Closed date: >now()-2w)'
            output: |-
              \({
                "closed_tickets": . | map({"ticket_key": .key})
              })
            next: fetch_comments_fe
        fetch_comments_fe:
          foreach:
            input: \(.closed_tickets)
            do:
              start: fetch_comments
              steps:
                fetch_comments:
                  tracker:
                    organization:
                      cloudOrganizationId: <organization_ID>
                    oauthToken: '\(lockboxPayload("<secret_ID>"; "oauth"))'
                    listComments:
                      key: \(.ticket_key)
                    output: |-
                      \({
                        "comments": .
                      })
            output: |-
              \({
                "comment_text": map(.comments[].text) | join("\n")
              })
            next: summarize_texts
        summarize_texts:
          foundationModelsCall:
            modelUrl: gpt://<folder_ID>/yandexgpt
            generate:
              maxTokens: 500
              temperature: 0.5
              messages:
                messages:
                  - role: system
                    text: "Next you will be given comments of completed issues in {{ tracker-name }}. State as briefly as possible (no more than three sentences) what work has been done."
                  - role: user
                    text: \(.comment_text)
            output: |-
              \({
                "summary": .alternatives.[0].message.text
              })
            next: create_report
        create_report:
          noOp:
            output: |-
              \({
                "report_text": "
                  Completed issues:
                    \(.closed_tickets | map(.ticket_key) | join("\n"))
                  Summary of closed issues:
                    \(.summary)
                ",
                "report_text_html": "
                  Completed issues:<br>
                    \(.closed_tickets | map("<a href=https://tracker.yandex.ru/" + .ticket_key + ">" + .ticket_key + "</a>") | join("<br>"))<br>

                  <br>
                  Summary of closed issues:<br>
                    \(.summary | gsub("\\n"; "<br>")))
                "
              })
            next: deliver_report
        deliver_report:
          parallel:
            branches:
              tracker:
                start: write_report_to_tracker
                steps:
                  write_report_to_tracker:
                    tracker:
                      organization:
                        cloudOrganizationId: <organization_ID>
                      oauthToken: '\(lockboxPayload("<secret_ID>"; "oauth"))'
                      createComment:
                        key: <issue_key_with_report>
                        text: \(.report_text)
              postbox:
                start: send_report_via_postbox
                steps:
                  send_report_via_postbox:
                    postbox:
                      simple:
                        subject:
                          data: "Dev progress report (closed issues)"
                          charset: UTF_8
                        body:
                          text:
                            data: \(.report_text)
                            charset: UTF_8
                          html:
                            data: \("<p>\(.report_text_html)</p>")
                            charset: UTF_8
                      fromAddress: tracker-robot@<your_domain>
                      destination:
                        toAddresses: <recipient_address>
        ```

      Where:

      * `<organization_ID>`: [ID](../../organization/operations/organization-get-id.md) of your {{ org-full-name }}.
      * `<secret_ID>`: Previously saved [secret](../../lockbox/concepts/secret.md) ID with the application's OAuth token.
      * `<folder_ID>`: [ID](../../resource-manager/operations/folder/get-id.md) of the folder you are creating a workflow in.
      * `<issue_key_with_report>`: Key of the {{ tracker-name }} [issue]({{ link-tracker-cloudless }}glossary#rus-z) in the comment to which the summary of the analyzed test issues will be uploaded.
      * `<your_domain>`: Domain you specified when creating the {{ postbox-name }} address. For the sender address (`fromAddress`) you can specify any address on this domain. Example: `tracker-robot@example.com` or `noreply@example.com`.
      * `<recipient_address>`: Email address to which the workflow will send a summary of the analyzed {{ tracker-name }} test issues.

      A workflow comprises the following steps: `fetch_tickets`, `fetch_comments`, `summarize_texts`, `send_report_via_postbox`, and `write_report_to_tracker`.

    {% endlist %}

1. Create a {{ sw-name }} workflow using the selected specification:

    {% list tabs group=instructions %}

    - Management console {#console}

        1. In the [management console]({{ link-console-main }}), select the folder containing the previously created resources: service account, secret, and {{ postbox-name }} address.
        1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
        1. In the left-hand panel, select ![GraphNode](../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
        1. In the top-right corner, click **{{ ui-key.yacloud.serverless-workflows.button_create-workflow }}** and do the following in the window that opens:

            1. In the **{{ ui-key.yacloud.serverless-workflows.spec-editor-type_label_text-editor }}** field, add the previously selected specification.
            1. Expand the **{{ ui-key.yacloud.serverless-workflows.label_additional-parameters }}** section.
            1. In the **{{ ui-key.yacloud.common.name }}** field, enter the workflow name: `my-tracker-workflow`.
            1. In the **{{ ui-key.yacloud.serverless-workflows.label_service-account }}** field, select the previously created service account named `workflow-sa`.
        1. Click **{{ ui-key.yacloud.common.create }}**.

    {% endlist %}

## Test your workflow {#test}

Make sure the {{ sw-name }} workflow is being executed.

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder the new {{ sw-name }} workflow is in.
    1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
    1. In the left-hand panel, select ![GraphNode](../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
    1. Click ![ellipsis](../../_assets/console-icons/ellipsis.svg) next to `my-tracker-workflow` and select ![TriangleRight](../../_assets/console-icons/triangle-right.svg) **{{ ui-key.yacloud.serverless-workflows.label_run-workflow }}**.
    1. In the window that opens, click **{{ ui-key.yacloud.common.start }}**. The previously created workflow will be executed; it may take a few minutes to complete.
    1. Navigate to the ![Timeline](../../_assets/console-icons/timeline.svg) **{{ ui-key.yacloud.serverless-workflows.label_timeline }}** tab.

        Make sure all workflow steps are completed successfully. Each successful step will be marked by a green box with the ![CircleCheck](../../_assets/console-icons/circle-check.svg) icon in the relevant line of the time scale.

        If there is an error at any of the steps, a red box with the ![TriangleExclamation](../../_assets/console-icons/triangle-exclamation.svg) icon will be displayed in the relevant line of the time scale. Click this box to view the details about the error.

{% endlist %}

As a result of the workflow, a comment with a summary of the analyzed test issues will be added to the {{ tracker-name }} issue named in the specification. This summary will also be backed up with an email to the address given in the specification.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. Delete your workflow:

    {% list tabs group=instructions %}

    - Management console {#console}

        1. In the [management console]({{ link-console-main }}), select the folder the created resources are located in.
        1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
        1. In the left-hand panel, select ![GraphNode](../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
        1. Click ![ellipsis](../../_assets/console-icons/ellipsis.svg) next to `my-tracker-workflow` and select ![TrashBin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
        1. Confirm the deletion.

    {% endlist %}
1. [Delete the secret](../../lockbox/operations/secret-delete.md).
1. Delete the {{ tracker-name }} [issues]({{ link-tracker-cloudless }}user/ticket-cancel) and the [queue]({{ link-tracker-cloudless }}manager/delete-queue).
1. Delete the {{ postbox-name }} address if you need to:

    {% list tabs group=instructions %}

    - Management console {#console}

        1. In the [management console]({{ link-console-main }}), select the folder the {{ postbox-name }} address is in.
        1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
        1. In the row with the {{ postbox-name }} address, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select ![TrashBin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
        1. Confirm the deletion.

    {% endlist %}