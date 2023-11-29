---
title: "How to set up code review rules"
description: "Follow this guide to set up code review rules."
---

# Setting up code review rules

{% include [preview note](../../_includes/note-preview.md) %}

With {{ mgl-name }}, you can flexibly set up mandatory code review rules before any code can be added to the target branch of the project. For more information on how code review rules work, see [Code review rules](../concepts/approval-rules.md).

To use code review rules:

1. [{#T}](#enable)
1. [{#T}](#rules)
1. [{#T}](#code-ownership) (available in **Standard** and **Advanced** [configurations](../concepts/approval-rules.md#packages)).

If necessary, enable [debugging mode](#debugging) and check out the [rules for handling exceptions](#exceptions).

## Enable code review rules {#enable}

1. Activate the {{ GL }} setting that disables incorporating changes to the target branch until all threads are resolved in a merge request:
   1. Open your project in {{ GL }}.
   1. In the left-hand menu, select **Settings** → **Merge requests**.
   1. Under **Merge checks**, select **All threads must be resolved**.
   1. Click **Save changes**.
1. Add a system webhook:
   1. Open your {{ GL }} instance.
   1. In the left-hand menu, select **Search or go to** → **Admin Area**.
   1. In the left-hand menu, select **System Hooks**.
   1. Click **Add new webhook**.
   1. Specify the webhook parameters:
      * **URL**: `http://localhost:24080/default`.
      * In the **Trigger** section, disable all options except **Merge request events**, **Push events**, and **Repository update events**.
   1. Click **Add system hook**.
1. Enable the code review rules in the {{ mgl-name }} instance:
   1. In the {{ yandex-cloud }} [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where the [{{ GL }} instance](../concepts/index.md#instance) is located.
   1. Select **{{ mgl-name }}**.
   1. Select the instance and click ![image](../../_assets/pencil.svg) **Edit** at the top of the page.
   1. Enable the **Code review rules** and select the appropriate [configuration](../concepts/approval-rules.md#packages).
   1. Click **Save**.

## Set up the code review rules {#rules}

The code review rules for the repository are stored in the `APPROVALRULES` file in the root directory. The configuration is read from the `master` branch when running the instance and is automatically loaded at file update.

The file consists of two sections:

* `ApprovalRules`: Describes the rules.
* `BranchGroups`: Describes what branches the rules apply to.

The `APPROVALRULES` file structure is as follows:

```text
ApprovalRules:
  - <rule_name>:
    approvers:
        - <user_name>
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

* `approvers`: Name of the {{ GL }} user who can approve the merge request.
* `groups`: Name of the {{ GL }} group whose users can approve the merge request.
* `branches`: Name of the branch the updates of which require a review.
* `rules`: Name of the rule that applies to the specified branches.

You can use the `*` wildcard instead of user names and in branch names.

> For example, to apply the Four Eyes Principle to the repository master branch, add the following to the `APPROVALRULES` file:
>
> ```text
> ApprovalRules:
>   - FourEyesRule:
>       approvers:
>         - "*"
>       count: 1
>
> BranchGroups:
>   - Master:
>       branches:       
>         - master
>       rules:
>         - FourEyesRule
> ```

## Set up Code Ownership {#code-ownership}

The feature is available in **Standard** and **Advanced** [configurations](../concepts/approval-rules.md#packages).

The Code Ownership settings for the repository are stored in the `CODEOWNERS` file in the root directory. The configuration is read from the `master` branch when running the instance and is automatically loaded at file update.

The file structure supports the [{{ GL }} syntax](https://docs.gitlab.com/ee/user/project/codeowners/reference.html), except for the use of user subgroups and email addresses as user IDs.

{% note info %}

If multiple records in the `CODEOWNERS` file concurrently include the same file or directory, the rules from the most recent record apply.

{% endnote %}

To use the Code Ownership settings when handling merge requests to specific branches, add the following record to the `APPROVALRULES` file:

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

Add the `detailed_AR` keyword to a merge request description to have detailed information on each rule output in a thread:

* Names of users who approved the merge request.
* How many approvals are left to be received.
* Names of remaining users who can approve the merge request.

## Handling exceptions {#exceptions}

### Incorrect configuration of code review rules {#errors}

Issues related to the `APPROVALRULES` file are handled as follows:

* If the file is missing from the repository, no code review rules apply to the repository's merge requests.
* If the file is available but is configured incorrectly:
   * An email notification of the error is sent to users with the `Maintainer` role.
   * All merge requests of the repository are locked.

### Bypassing the rules {#force-merge}

If merge request changes need to be committed but the team members who can do that are not available and cannot approve the MR, a user with at least the `Maintainer` role can commit them bypassing the set rules:

1. Add a comment with the `force_merge` keyword to the merge request.
1. Update the MR description so that {{ mgl-name }} gets notified of the MR change.

This will close the thread and the MR integration will be unlocked. When it is integrated, users with at least the `Maintainer` role will receive an email notifying them of a violation of the established code review procedure.
