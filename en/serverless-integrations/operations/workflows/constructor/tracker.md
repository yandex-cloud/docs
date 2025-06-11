---
title: Adding {{ tracker-full-name }} API access to a {{ sw-name }} workflow
description: Follow this guide to add accessing the {{ tracker-full-name }} API to a {{ sw-full-name }} workflow using the workflow step constructor.
---

# Accessing the {{ tracker-full-name }} API

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. From the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** section on the left side of the screen, drag the ![tracker-icon](../../../../_assets/tracker-icon.svg) **{{ tracker-name }}** element to desired workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the added **{{ tracker-name }}** section to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. Optionally, if the {{ tracker-full-name }} API uses a non-standard endpoint, edit the default value in the **Endpoint** field accordingly.
      1. Under **OAuth token**, specify the [app OAUth token]({{ link-tracker-cloudless }}concepts/access#about_OAuth) or {{ lockbox-full-name }} [secret](../../../../lockbox/concepts/secret.md) storing that token. Select:

          {% include [oauth](../../../../_includes/serverless-integrations/workflows-constructor/oauth.md) %}

      1. In the **Organization** field, select the type of the organization {{ tracker-name }} is connected to: `{{ org-full-name }}` or `{{ yandex-360 }}`. Alternatively, set it to `Not specified` if you do not want to specify any organization.

          If you specified the organization type, specify its ID in the **Organization ID** field.

          For more information about organizations, see the [Yandex Tracker documentation]({{ link-tracker-cloudless }}enable-tracker).
      1. In the **Action** field, select the action to perform with {{ tracker-name }} issues:

          {% cut "`Get an issue`" %}

          1. In the **Issue key** field, specify the issue [key]({{ link-tracker-cloudless }}glossary#rus-k), i.e., its unique ID.

          {% endcut %}

          {% cut "`Create an issue`" %}

          1. In the **Queue** field, specify the ID of the [queue]({{ link-tracker-cloudless }}queue-intro) to create your issue in.
          1. In the **Name** field, enter the issue name.
          1. Optionally, in the **Parent issue** field, specify the parent issue key.
          1. Optionally, in the **Description** field, specify the issue description.
          1. Under **Add to sprints**, specify the [sprints]({{ link-tracker-cloudless }}manager/create-agile-sprint) to add your issue to, if required. Select:

              * `Do not add` if you do not want to add the issue to any sprint.
              * `List` to add sprints one by one using ![plus](../../../../_assets/console-icons/plus.svg).
              * `JSON` to add sprints as a JSON array or jq template.

          1. Optionally, in the **Type** field, specify the issue [type]({{ link-tracker-cloudless }}glossary#rus-t).
          1. Optionally, in the **Priority** field, specify the issue priority.
          1. Under **Add followers**, specify the users to add to your new issue as followers. Select:

              * `Do not add` if you do not want to add any followers.
              * `List` to add followers by their usernames or IDs one by one using ![plus](../../../../_assets/console-icons/plus.svg).
              * `JSON` to add followers by their usernames or IDs provided as a JSON array or jq template.

          1. Optionally, in the **Assignee** field, specify the username or ID of the user to assign the issue to.
          1. Optionally, in the **Author** field, specify the username or ID of the user creating the issue.
          1. Optionally, in the **Additional fields**, use ![plus](../../../../_assets/console-icons/plus.svg) to set additional fields for the new issue, in `<field_name>`:`<field_value>` format.

          {% endcut %}

          {% cut "`Update an issue`" %}

          {% note info %}

          If you do not set new values for the optional fields, they will remain the same.

          {% endnote %}

          1. In the **Issue key** field, specify the [key]({{ link-tracker-cloudless }}glossary#rus-k) of the issue you want to update.
          1. Optionally, in the **Name** field, set a new name for the issue.
          1. Optionally, in the **Parent issue** field, specify a new key for the parent issue.
          1. Optionally, in the **Description** field, set a new description for the issue.
          1. Under **Change sprints**, edit the sprints which include the issue, if required. Select:

              * `Do not change` to not edit the sprints which include the issue.

              * `Replace sprints` to replace all current sprints the issue is included in with new ones. In the **Sprint** field, select:

                  * `List` to set new sprints one by one using ![plus](../../../../_assets/console-icons/plus.svg).
                  * `JSON` to set new sprints as a JSON array or jq template.

              * `Add sprint` to add new sprints to those which already include the issue. In the **Sprint** field, select:

                  * `List` to add sprints one by one using ![plus](../../../../_assets/console-icons/plus.svg).
                  * `JSON` to add sprints as a JSON array or jq template.

              * `Delete sprint` to delete the issue from sprints. In the **Sprint** field, select:

                  * `List` to set sprints to remove the issue from one by one using ![plus](../../../../_assets/console-icons/plus.svg).
                  * `JSON` to set sprints to remove the issue from as a JSON array or jq template.

              * `Update sprint` to replace all current sprints which include the issue with the specified ones. In the **Sprint** field, select:

                  * `Dictionary` to specify the update rules for the sprints using ![plus](../../../../_assets/console-icons/plus.svg), in `<Original_value>`:`<New_value>` format, where `<Original_value>` is the current sprint which includes the issue and `<New_value>` is the sprint to replace the current one.
                  * `JSON` to specify the update rules for your sprints as a JSON object or jq template.

          1. Optionally, in the **Type** field, set a new issue type.
          1. Optionally, in the **Priority** field, set a new priority for the issue.
          1. Under **Edit followers**, edit the followers added to the issue, if required. Select:

              * `Do not change` to not edit the issue followers.
              * `Replace followers` to replace all current issue followers with new ones. In the **Follower** field, select:

                  * `List` to set new followers by their usernames or IDs one by one using ![plus](../../../../_assets/console-icons/plus.svg).
                  * `JSON` to set new followers by their usernames or IDs provided as a JSON array or jq template.

              * `Add follower` to add new issue followers to the existing ones. In the **Follower** field, select:

                  * `List` to add followers by their usernames or IDs one by one using ![plus](../../../../_assets/console-icons/plus.svg).
                  * `JSON` to add followers by their usernames or IDs provided as a JSON array or jq template.

              * `Remove follower` to remove followers from the issue. In the **Follower** field, select:

                  * `List` to set the followers you want to remove from the issue by their usernames or IDs one by one using ![plus](../../../../_assets/console-icons/plus.svg).
                  * `JSON` to set the followers you need to remove from the issue by their usernames or IDs as a JSON array or jq template.

              * `Update follower` to replace current followers in the issue with the specified ones. In the **Follower** field, select:

                  * `Dictionary` to specify the update rules for the followers using ![plus](../../../../_assets/console-icons/plus.svg), in `<Original_value>`:`<New_value>` format, where `<Original_value>` is the username or ID of a current follower and `<New_value>` is that of the follower to replace the current one.
                  * `JSON` to specify the update rules for the followers as a JSON object or jq template.

          1. Optionally, in the **Additional fields** field, edit the additional fields of your issue. To do this, click ![plus](../../../../_assets/console-icons/plus.svg). In the settings section that opens, do the following:
          
              1. Inder **Field name**, enter the name of the field you want to edit.
              1. Under **Change field**, select:

                  * `Replace value` to replace all current field values with new ones. In the **Value** field, select.

                      * `List` to set new field values one by one using ![plus](../../../../_assets/console-icons/plus.svg).
                      * `JSON` to set new field values as a JSON array or jq template.

                  * `Add value` to add new field values to the existing ones. In the **Value** field, select.

                      * `List` to add field values one by one using ![plus](../../../../_assets/console-icons/plus.svg).
                      * `JSON` to add field values as a JSON array or jq template.

                  * `Delete value` to delete the field values. In the **Value** field, select.

                      * `List` to set the field values to delete one by one using ![plus](../../../../_assets/console-icons/plus.svg).
                      * `JSON` to set the field values you need to delete as a JSON array or jq template.

                  * `Update value` to replace current field values with the specified ones. In the **Value** field, select.

                      * `Dictionary` to specify the update rules for the field values using ![plus](../../../../_assets/console-icons/plus.svg), in `<Original_value>`:`<New_value>` format, where `<Original_value>` is the current field value and `<New_value>` is that to replace the current one.
                      * `JSON` to specify the update rules for the field values as a JSON object or jq template.

          {% endcut %}

          {% cut "`Link issues`" %}

          1. In the **Key of first issue** field, specify the key for the first issue you want to create a link for.
          1. In the **Key of second issue** field, specify the key for the second issue, which you want to link to the first one.
          1. In the **Link type** field, select the type of the link between the issues.

          {% endcut %}

          {% cut "`Find an issue`" %}

          1. Under **Search parameters**, select:

              * `Queue` to get issues from the specified queue. In the **Queue name** field, enter the [key of the queue]({{ link-tracker-cloudless }}glossary#rus-k) you want to get issues from.

              * `Issue key list` to get issues with the specified keys. In the **Issue keys** field, select:

                  * `List` to set issue keys one by one using ![plus](../../../../_assets/console-icons/plus.svg).
                  * `JSON` to set issue keys as a JSON array or jq template.

              * `Issue filtering parameters` to return issues with the specified field values.

                  1. Under **Filtering fields**, use ![plus](../../../../_assets/console-icons/plus.svg) to specify the fields to filter your issues by and the values of those fields.
                  1. Optionally, to sort the returned issues, select `Enabled` in the **Sorting** field and specify the name of the field to sort your issues by. Enable the **Descending** option to sort your issues in descending order.

              * `Query language filter` to return issues filtered using a {{ tracker-full-name }} [query filter]({{ link-tracker-cloudless }}user/query-filter).

          1. In the **Page size** field, specify the number of issues to show per [page]({{ link-tracker-cloudless }}common-format#displaying-results) with search results.
          1. In the **Page number** field, specify the number of the page with search results you want to get.

          {% endcut %}

          {% cut "`Update an issue status`" %}

          1. In the **Issue key** field, specify the [key]({{ link-tracker-cloudless }}glossary#rus-k) of the issue to edit the status for.
          1. In the **Transition** field, specify the issue transition ID.
          1. Optionally, under **Additional fields**, use ![plus](../../../../_assets/console-icons/plus.svg) to set additional fields for the issue and their values required for the transition.

          {% endcut %}

          {% cut "`Add a comment`" %}

          1. In the **Issue key** field, specify the [key]({{ link-tracker-cloudless }}glossary#rus-k) of the issue you want to add a comment to.
          1. In the **Text** field, specify the text for the comment to add.
          1. Optionally, under **Invite users**, set the users to invite to the issue in the comment you are adding. Select:

              * `Do not invite` to not invite anyone.
              * `List` to specify users to invite by their usernames or IDs one by one using ![plus](../../../../_assets/console-icons/plus.svg).
              * `JSON` to specify usernames or IDs of the users you invite as a JSON array or jq template.

          {% endcut %}

          {% cut "`Update a comment`" %}

          1. In the **Comment ID** field, specify the ID of the comment you want to update.
          1. In the **Issue key** field, specify the [key]({{ link-tracker-cloudless }}glossary#rus-k) for the issue where you want to update a comment.
          1. In the **Text** field, add the new comment text.

          {% endcut %}

          {% cut "`Get a comment`" %}

          1. In the **Issue key** field, specify the [key]({{ link-tracker-cloudless }}glossary#rus-k) for the issue to get comments from.
          1. Optionally, in the **Comment ID** field, specify the _from_ comment ID. The response will return comments created after the one you specify, excluding that comment.
          1. Optionally, under **Number of comments**, set the maximum number of comments to return in the response.

          {% endcut %}

      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}

{% endlist %}

## See also {#see-also}

* [YaWL specification](../../../concepts/workflows/yawl/integration/tracker.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
