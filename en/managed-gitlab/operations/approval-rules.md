---
title: How to set up approval rules
description: Follow this guide to set up approval rules.
---

# Setting up approval rules

With {{ mgl-name }}, you can flexibly set up mandatory approval rules before merging code into the target branch of the project. For more information on how approval rules work, see [Approval rules](../concepts/approval-rules.md).

Before getting started, [create a service account](create-user.md#create) with administrator privileges and [add it to your {{ GL }} project](create-user.md#add-to-project). Assign the `Maintainer` or `Owner` [role]({{ gl.docs }}/ee/user/permissions.html) to the account, as other roles do not enough permissions to set up approval rules. Next, log in to your {{ GL }} instance and set up approval rules using the service account.

To use approval rules:

1. [Create a {{ GL }} token](#gitlab-token).
1. [Enable approval rules](#enable).
1. [Configure approval rules](#rules).
1. [Set up Code Ownership](#code-ownership) (available in **Standard** and **Advanced** [configurations](../concepts/approval-rules.md#packages)).

Enable [debugging mode](#debugging) and check out the [exception handling rules](#exceptions).

## Create a {{ GL }} token {#gitlab-token}

You need a [{{ GL }}](../concepts/approval-rules.md#gitlab-token) token to [enable approval rules](#enable) and access the repository, since the token is used for {{ GL }} API authentication.

To create a token:

1. Open your {{ GL }} instance.
1. Click the profile icon and select **Edit profile**.
1. Go to **Access Tokens** in the left-hand menu.
1. Click **Add new token**.
1. In the window that opens, enter a name in the **Token name** field to easily locate the token in your {{ GL }} project.
1. In the **Expiration date** field, specify the date when the token expires.

    The default value is one month from the token creation date, and the maximum is one year. The token expires at 00:00 UTC on the specified date.

1. Under **Select scopes**, select **api**.
1. Click **Create personal access token**.

    This will generate a new token.

1. Copy and save it, as you will not be able to copy it later in {{ GL }}.

## Enable approval rules {#enable}

1. Activate the {{ GL }} setting that prevents merging into the target branch until every thread in the merge request is resolved:
    1. Open your project in {{ GL }}.
    1. In the left-hand menu, select **Settings** → **Merge requests**.
    1. Under **Merge checks**, enable **All threads must be resolved**.
    1. Click **Save changes**.
1. Add a system hook:
    1. Open your {{ GL }} instance.
    1. In the left-hand menu, select **Search or go to** → **Admin Area**.
    1. In the left-hand menu, select **System Hooks**.
    1. Click **Add new webhook**.
    1. Configure the hook as follows:
        * **URL**: `http://localhost:24080/default`.
        * In the **Trigger** section, disable all options except **Merge request events**, **Push events**, and **Repository update events**.
    1. Click **Add webhook**.
1. Enable the {{ GL }} setting which allows sending messages to the local network:
    1. Open your {{ GL }} instance.
    1. In the left-hand menu, select **Search or go to** → **Admin Area**.
    1. In the left-hand menu, select **Settings** → **Network**.
    1. Under **Outbound requests**, enable **Allow requests to the local network from system hooks**.
    1. In the list of IP addresses and domain names, specify `http://localhost:24080`.
    1. Click **Save changes**.
1. Enable approval rules in your {{ mgl-name }} instance:
    1. In the {{ yandex-cloud }} [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing your [{{ GL }} instance](../concepts/index.md#instance).
    1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
    1. Select the instance and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** at the top of the page.
    1. In the **{{ ui-key.yacloud.gitlab.field_approval-rules }}** field, select the approval rule [configuration](../concepts/approval-rules.md#packages).

        {% include [note-approval-rules-pricing](../../_includes/managed-gitlab/note-approval-rules-pricing.md) %}

    1. In the **{{ ui-key.yacloud.gitlab.field_approval-rules-token }}** field, specify the [token you created earlier](#gitlab-token).
    1. Click **{{ ui-key.yacloud.common.save }}**.

{% note tip %}

If you encounter issues when accessing the system hook, use the `127.0.0.1` IP address instead of `localhost`:

1. In the system hook settings (**Admin area** → **System Hooks**), change the **URL** value to `http://127.0.0.1:24080/default`.
1. In the {{ GL }} settings that allow sending messages to the local network (**Admin area** → **Settings** → **Network** → **Expand outbound requests**, the CIDR input field), add `http://127.0.0.1:24080` to the list of IP addresses and domain names.

{% endnote %}

## Configure approval rules {#rules}

The approval rules for the repository are stored in the `APPROVALRULES` file in the root directory. The configuration is read from the [default branch]({{ gl.docs }}/ee/user/project/repository/branches/default.html) when running the instance and is automatically reloaded when you modify the file.

The file consists of two sections:

* `ApprovalRules`: Describes the rules.
* `BranchGroups`: Describes which branches the rules apply to.

The structure of the `APPROVALRULES` file is as follows:

```text
ApprovalRules:
  - <rule_name>:
      approvers:
        - <username>
        ...
      groups:
        - <group_name>
        ...
      count: <required_number_of_approvals>
BranchGroups:
  - <branch_group_name>:
      branches:
        - <branch_name>
        ...
      rules:
        - <rule_name>
        ...
```

Where:

* `approvers`: Names of {{ GL }} users who can approve the merge request. The users must be added to the project either directly or via a group. When counting approvals, the merge request author is not counted in. A user on this list who has committed to the merge request and is not the author can also be an approver.
* `groups`: List of names of {{ GL }} groups whose members can approve the merge request (except for members of the group for which this group is a subgroup).
* `count`: Integer from `0` to `100`. If it is `0`, the rule is optional.
* `branches`: List of names of branches where changes must be approved.
* `rules`: List of rules that apply to the specified branches.

You may use the `*` wildcard instead of usernames and in branch names.

> For example, to apply the _four-eyes principle_ to the repository main branch, add the following to the `APPROVALRULES` file:
>
> ```text
> ApprovalRules:
>   - FourEyesRule:
>       approvers:
>         - "*"
>       count: 1
> BranchGroups:
>   - Master:
>       branches:
>         - master
>       rules:
>         - FourEyesRule
> ```

## Set up code ownership {#code-ownership}

This feature is available in **Standard** and **Advanced** [configurations](../concepts/approval-rules.md#packages).

The code ownership settings for the repository are stored in the `CODEOWNERS` file in the root directory. The configuration is read from the [default branch]({{ gl.docs }}/ee/user/project/repository/branches/default.html) when running the instance and is automatically reloaded when you modify the file.

The file structure follows [{{ GL }} syntax](https://docs.gitlab.com/ee/user/project/codeowners/reference.html), except that user subgroups and email addresses cannot be used as user IDs.

{% note info %}

If multiple entries in the `CODEOWNERS` file include the same file or directory at once, the rules from the most recent entry apply.

{% endnote %}

To use the code ownership settings when handling merge requests on specific branches, add the following entry to the `APPROVALRULES` file:

```text
BranchGroups:
  - <branch_group_name>:
      branches:
        - <branch_name>
        ...
      rules:
        - CODE_OWNERS
```

## Debugging {#debugging}

Add the `detailed_AR` keyword to a merge request description to show detailed information on each rule in a thread:

* Users who have approved the merge request.
* Number of approvals still needed.
* Users who can still approve the merge request.

## Handling exceptions {#exceptions}

### Incorrect configuration of approval rules {#errors}

Issues related to the `APPROVALRULES` file are handled as follows:

* If the file is missing from the repository, no approval rules apply to the repository's merge requests.
* If the file is available but is configured incorrectly:
    * Users with the `Maintainer` role receive an email notification about the error.
    * All merge requests for this repository are blocked.

### Bypassing the rules {#force-merge}

If you need to commit merge request changes, but the responsible team members are not available, a user with the `Maintainer` role or higher can commit the changes by bypassing the existing approval rules:

1. Add `force_merge` as a comment in the merge request.
1. Update the merge request description so that {{ mgl-name }} is notified of the changes in the merge request.

This will resolve the thread and unblock the merge request. Users with the `Maintainer` role or higher will receive an email notification about the violated approval workflow.
