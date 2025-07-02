---
title: Adding {{ tracker-full-name }} API access to a {{ sw-name }} workflow
description: Follow this guide to add accessing the {{ tracker-full-name }} API to a {{ sw-full-name }} workflow using the workflow step constructor.
---

# Accessing the {{ tracker-full-name }} API

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. From the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** section on the left side of the screen, drag the ![tracker-icon](../../../../_assets/tracker-icon.svg) **{{ tracker-name }}** element to the relevant workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the new **{{ tracker-name }}** section to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. Optionally, if the {{ tracker-full-name }} API uses a non-standard endpoint, edit the default value in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_endpoint_view_spec_layout_title }}** field accordingly.
      1. Under **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_oauth_token_view_spec_layout_title }}**, specify the [app OAUth token]({{ link-tracker-cloudless }}concepts/access#about_OAuth) or {{ lockbox-full-name }} [secret](../../../../lockbox/concepts/secret.md) that stores the token. Select:

          {% include [oauth](../../../../_includes/serverless-integrations/workflows-constructor/oauth.md) %}

      1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_organization_view_spec_layout_title }}** field, select the type of the organization your {{ tracker-name }} is connected to: `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_organization_description_cloud }}` or `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_organization_description_yandex }}`. Alternatively, set it to `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_organization_description_none }}` if you do not want to specify any organization.

          If you specified the organization type, specify its ID in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_organization_properties_cloud_view_spec_layout_title }}** field.

          For more information about organizations, see the [Yandex Tracker documentation]({{ link-tracker-cloudless }}enable-tracker).
      1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_view_spec_layout_title }}** field, select the action to perform with {{ tracker-name }} issues:

          {% cut "`{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_description_get_issue }}`" %}

          1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_get_issue_properties_key_view_spec_layout_title }}** field, specify the issue [key]({{ link-tracker-cloudless }}glossary#rus-k), i.e., its unique ID.

          {% endcut %}

          {% cut "`{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_description_create_issue }}`" %}

          1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_queue_view_spec_layout_title }}** field, specify the ID of the [queue]({{ link-tracker-cloudless }}queue-intro) to create your issue in.
          1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_title_view_spec_layout_title }}** field, enter the issue name.
          1. Optionally, in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_parent_view_spec_layout_title }}** field, specify the parent issue key.
          1. Optionally, in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_description_view_spec_layout_title }}** field, enter a description for the new issue.
          1. Under **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_sprints_view_spec_layout_title }}**, specify the [sprints]({{ link-tracker-cloudless }}manager/create-agile-sprint) to add your issue to, if required. Select:

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_sprints_description_none }}` if you do not want to add the issue to any sprint.
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_sprints_description_array }}` to add sprints one by one using ![plus](../../../../_assets/console-icons/plus.svg).
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_sprints_description_simple }}` to add sprints as a JSON array or jq template.

          1. Optionally, in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_type_view_spec_layout_title }}** field, specify the issue [type]({{ link-tracker-cloudless }}glossary#rus-t).
          1. Optionally, in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_priority_view_spec_layout_title }}** field, specify the issue priority.
          1. Under **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_followers_view_spec_layout_title }}**, specify the users to add to your new issue as followers. Select:

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_sprints_description_none }}` if you do not want to add any followers.
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_sprints_description_array }}` to add followers by their usernames or IDs one by one using ![plus](../../../../_assets/console-icons/plus.svg).
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_sprints_description_simple }}` to add followers by their usernames or IDs provided as a JSON array or jq template.

          1. Optionally, in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_assignee_view_spec_layout_title }}** field, specify the username or ID of the user to assign the issue to.
          1. Optionally, in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_author_view_spec_layout_title }}** field, specify the username or ID of the user creating the issue.
          1. Optionally, in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_additional_properties_view_spec_layout_title }}** field, use ![plus](../../../../_assets/console-icons/plus.svg) to set additional fields for the new issue, in `<field_name>`:`<field_value>` format.

          {% endcut %}

          {% cut "`{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_description_update_issue }}`" %}

          {% note info %}

          If you do not set new values for the optional fields, they will remain the same.

          {% endnote %}

          1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_comment_properties_key_view_spec_layout_title }}** field, specify the [key]({{ link-tracker-cloudless }}glossary#rus-k) of the issue you want to update.
          1. Optionally, in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_title_view_spec_layout_title }}** field, set a new name for the issue.
          1. Optionally, in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_parent_view_spec_layout_title }}** field, specify the new parent issue key.
          1. Optionally, in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_description_view_spec_layout_title }}** field, set a new description for the issue.
          1. Under **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_view_spec_layout_title }}**, edit the sprints which include the issue, if required. Select:

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_description_none }}` to not edit the sprints which include the issue.

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_description_set }}` to replace all current sprints the issue is included in with new ones. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_view_spec_layout_title }}** field, select:

                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_array }}` to set new sprints one by one using ![plus](../../../../_assets/console-icons/plus.svg).
                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_simple }}` to set new sprints as a JSON array or jq template.

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_description_add }}` to add new sprints to those which already include the issue. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_view_spec_layout_title }}** field, select:

                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_array }}` to add sprints one by one using ![plus](../../../../_assets/console-icons/plus.svg).
                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_simple }}` to add sprints as a JSON array or jq template.

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_description_remove }}` to delete the issue from sprints. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_view_spec_layout_title }}** field, select:

                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_array }}` to set the sprints you want to remove the issue from one by one using ![plus](../../../../_assets/console-icons/plus.svg).
                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_simple }}` to set the sprints you want to remove the issue from as a JSON array or jq template.

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_description_replace }}` to replace all current sprints which include the issue with the specified ones. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_view_spec_layout_title }}** field, select:

                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_replace_description_key_value }}` to specify the update rules for the sprints using ![plus](../../../../_assets/console-icons/plus.svg), in `<Original_value>`:`<New_value>` format, where `<Original_value>` is the current sprint which includes the issue and `<New_value>` is the sprint to replace the current one.
                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_replace_description_plain }}` to specify the update rules for your sprints as a JSON object or jq template.

          1. Optionally, in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_type_view_spec_layout_title }}** field, set the new issue type.
          1. Optionally, in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_priority_view_spec_layout_title }}** field, set a new priority for the issue.
          1. Under **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_followers_view_spec_layout_title }}**, edit the issue followers, if required. Select:

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_followers_description_none }}` to not edit the issue followers.
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_followers_description_set }}` to replace all current issue followers with new ones. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_followers_properties_add_view_spec_layout_title }}** field, select:

                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_array }}` to set new followers by their usernames or IDs one by one using ![plus](../../../../_assets/console-icons/plus.svg).
                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_simple }}` to set new followers by their usernames or IDs provided as a JSON array or jq template.

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_followers_description_add }}` to add new issue followers to the existing ones. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_followers_properties_add_view_spec_layout_title }}** field, select:

                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_array }}` to add followers by their usernames or IDs one by one using ![plus](../../../../_assets/console-icons/plus.svg).
                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_simple }}` to add followers by their usernames or IDs provided as a JSON array or jq template.

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_followers_description_remove }}` to remove followers from the issue. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_followers_properties_add_view_spec_layout_title }}** field, select:

                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_array }}` to set the followers you want to remove from the issue by their usernames or IDs one by one using ![plus](../../../../_assets/console-icons/plus.svg).
                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_simple }}` to set the followers you need to remove from the issue by their usernames or IDs as a JSON array or jq template.

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_followers_description_replace }}` to replace current issue followers with the specified ones. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_followers_properties_add_view_spec_layout_title }}** field, select:

                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_followers_properties_replace_description_key_value }}` to specify the update rules for the followers using ![plus](../../../../_assets/console-icons/plus.svg), in `<Original_value>`:`<New_value>` format, where `<Original_value>` is the username or ID of a current follower and `<New_value>` is that of the follower to replace the current one.
                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_simple }}` to specify the update rules for the followers as a JSON object or jq template.

          1. Optionally, in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_additional_properties_view_spec_layout_title }}** field, edit the additional fields of your issue. To do this, click ![plus](../../../../_assets/console-icons/plus.svg). In the settings section that opens, do the following:
          
              1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_additional_properties_items_properties_key_view_spec_placeholder }}** field, enter the name of the field you want to edit.
              1. Under **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_additional_properties_items_properties_action_view_spec_layout_title }}**, select:

                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_additional_properties_items_properties_action_description_set }}` to replace all current field values with new ones. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_additional_properties_items_properties_action_properties_add_view_spec_layout_title }}** field, select:

                      * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_array }}` to set new field values one by one using ![plus](../../../../_assets/console-icons/plus.svg).
                      * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_simple }}` to set new field values as a JSON array or jq template.

                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_additional_properties_items_properties_action_description_add }}` to add new field values to the existing ones. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_additional_properties_items_properties_action_properties_add_view_spec_layout_title }}** field, select:

                      * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_array }}` to add field values one by one using ![plus](../../../../_assets/console-icons/plus.svg).
                      * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_simple }}` to add field values as a JSON array or jq template.

                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_additional_properties_items_properties_action_description_remove }}` to delete the field values. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_additional_properties_items_properties_action_properties_add_view_spec_layout_title }}** field, select:

                      * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_array }}` to set the field values you want to delete one by one using ![plus](../../../../_assets/console-icons/plus.svg).
                      * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_simple }}` to set the field values you need to delete as a JSON array or jq template.

                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_additional_properties_items_properties_action_description_replace }}` to replace current field values with the specified ones. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_additional_properties_items_properties_action_properties_add_view_spec_layout_title }}** field, select:

                      * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_additional_properties_items_properties_action_properties_replace_description_key_value }}` to specify the update rules for the field values using ![plus](../../../../_assets/console-icons/plus.svg), in `<Original_value>`:`<New_value>` format, where `<Original_value>` is the current field value and `<New_value>` is the field value to replace the current one.
                      * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_simple }}` to specify the update rules for the field values as a JSON object or jq template.

          {% endcut %}

          {% cut "`{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_description_link_issues }}`" %}

          1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_link_issues_properties_key_view_spec_layout_title }}** field, specify the key of the first issue you want to create a link for.
          1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_link_issues_properties_link_key_view_spec_layout_title }}** field, specify the key of the second issue which you want to link to the first one.
          1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_link_issues_properties_relationship_view_spec_layout_title }}** field, select the type of the link between the issues.

          {% endcut %}

          {% cut "`{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_description_list_issues }}`" %}

          1. Under **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_list_issues_properties_search_options_view_spec_layout_title }}**, select:

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_list_issues_properties_search_options_description_queue }}` to get issues from the specified queue. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_list_issues_properties_search_options_properties_queue_view_spec_layout_title }}** field, enter the [key of the queue]({{ link-tracker-cloudless }}glossary#rus-k) you want to get issues from.

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_list_issues_properties_search_options_description_keys }}` to get issues with the specified keys. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_list_issues_properties_search_options_properties_keys_view_spec_layout_title }}** field, select:

                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_array }}` to set issue keys one by one using ![plus](../../../../_assets/console-icons/plus.svg).
                  * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_properties_sprints_properties_add_description_simple }}` to set issue keys as a JSON array or jq template.

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_list_issues_properties_search_options_description_filter }}` to get issues with the specified field values.

                  1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_list_issues_properties_search_options_properties_filter_properties_issue_properties_view_spec_layout_title }}** field, use ![plus](../../../../_assets/console-icons/plus.svg) to specify the fields to filter your issues by and the values of those fields.
                  1. Optionally, to sort the returned issues, select `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_list_issues_properties_search_options_properties_filter_properties_sort_description_on }}` in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_list_issues_properties_search_options_properties_filter_properties_sort_view_spec_layout_title }}** field and specify the name of the field to sort your issues by. Enable the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_list_issues_properties_search_options_properties_filter_properties_sort_properties_on_properties_order_view_spec_layout_title }}** option to sort your issues in descending order.

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_list_issues_properties_search_options_description_query }}` to return issues for the specified {{ tracker-full-name }} [query language filter]({{ link-tracker-cloudless }}user/query-filter).

          1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_list_issues_properties_page_size_view_spec_layout_title }}** field, specify the number of issues to show per [page]({{ link-tracker-cloudless }}common-format#displaying-results) with search results.
          1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_list_issues_properties_page_number_view_spec_layout_title }}** field, specify the number of the search results page you want to get.

          {% endcut %}

          {% cut "`{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_description_update_issue_status }}`" %}

          1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_status_properties_key_view_spec_layout_title }}** field, specify the [key]({{ link-tracker-cloudless }}glossary#rus-k) of the issue to edit the status for.
          1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_issue_status_properties_transition_view_spec_layout_title }}** field, specify the issue transition ID.
          1. Optionally, in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_issue_properties_additional_properties_view_spec_layout_title }}** field, use ![plus](../../../../_assets/console-icons/plus.svg) to set additional fields for the issue and their values required for the transition.

          {% endcut %}

          {% cut "`{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_description_create_comment }}`" %}

          1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_comment_properties_key_view_spec_layout_title }}** field, specify the [key]({{ link-tracker-cloudless }}glossary#rus-k) of the issue you want to add a comment to.
          1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_comment_properties_text_view_spec_layout_title }}** field, specify the comment text.
          1. Optionally, under **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_comment_properties_mentions_view_spec_layout_title }}**, set the users to invite to the issue in the comment you are adding. Select:

              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_comment_properties_mentions_description_none }}` to not invite anyone.
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_comment_properties_mentions_description_array }}` to specify users to invite by their usernames or IDs one by one using ![plus](../../../../_assets/console-icons/plus.svg).
              * `{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_comment_properties_mentions_description_simple }}` to specify usernames or IDs of the users you invite as a JSON array or jq template.

          {% endcut %}

          {% cut "`{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_description_update_comment }}`" %}

          1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_comment_properties_id_view_spec_layout_title }}** field, specify the ID of the comment you want to update.
          1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_comment_properties_issue_key_view_spec_layout_title }}** field, specify the [key]({{ link-tracker-cloudless }}glossary#rus-k) of the issue where you want to update a comment.
          1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_comment_properties_text_view_spec_layout_title }}** field, add the new comment text.

          {% endcut %}

          {% cut "`{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_description_list_comments }}`" %}

          1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_create_comment_properties_key_view_spec_layout_title }}** field, specify the [key]({{ link-tracker-cloudless }}glossary#rus-k) of the issue to get comments from.
          1. Optionally, in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_update_comment_properties_id_view_spec_layout_title }}** field, specify the _from_ comment ID. The response will return comments created later than the one you specify, excluding that comment.
          1. Optionally, in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.tracker_properties_action_properties_list_comments_properties_page_size_view_spec_layout_title }}** field, set the maximum number of comments to return in the response.

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
