---
title: Approval rules in {{ mgl-name }}
description: With {{ mgl-name }}, you can flexibly set up mandatory approval rules before any code can be added to the target branch of the project. This feature is an alternative to the Approval Rules Enterprise Edition tool built in {{ GL }} and is available regardless of the {{ GL }} version.
---

# Approval rules in {{ mgl-name }}

With {{ mgl-name }}, you can flexibly set up mandatory approval rules before any code can be added to the target branch of the project. This feature is an alternative to the [Approval Rules](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/rules.html) Enterprise Edition tool built in {{ GL }} and is available regardless of the {{ GL }} [version](https://about.gitlab.com/pricing).

If a {{ GL }} instance has the approval rules enabled, {{ mgl-name }} analyzes approvals by reviewers for compliance with the specified rules. If there are not enough approvals, a thread is created in a merge request that blocks it from being merged to the target branch. Editing the merge request creates or updates a comment in the thread with its current compliance status. Once all the required approvals are obtained, the thread is closed.

If you close a thread manually, it will be created again. If a merge request is merged regardless of the approval rules, users with the `Maintainer` role or higher will receive an email notification about the violated code approval workflow.

For more information about working with approval rules, see [Setting up approval rules](../operations/approval-rules.md).

## {{ GL }} Token {#gitlab-token}

You need a _[{{ GL }} token]({{ gl.docs }}/ee/user/profile/personal_access_tokens.html)_ to set up code approval rules. A token is requested for authorization when working with the repository: this is how the {{ GL }} API is accessed.

A {{ GL }} token has a lifetime, which is set when [creating the token](../operations/approval-rules.md#gitlab-token). The lifetime expires at midnight UTC on the specified day. The maximum lifetime is one year from the token creation date.

One day before the expiration date, {{ GL }} sends a notification that the token is about to expire. The notification is emailed to the account by which the token was created.

Issue a new token and add it to your {{ GL }} instance settings before the previous token expires. Otherwise, {{ mgl-name }} will not operate correctly.

## Available configurations {#packages}

{% include [note-approval-rules-pricing](../../_includes/managed-gitlab/note-approval-rules-pricing.md) %}

You can choose a suitable configuration based on your team's objectives:

* **Basic**: Allows you to create a single rule with no additional conditions. It is suitable for small teams (up to 10 people).
* **Standard**: Allows configuring multiple rules and assigning [code owners](../operations/approval-rules.md#code-ownership) to individual files or directories (up to 10 records). It is suitable for medium-sized teams (10 to 30 people).
* **Advanced**: Includes all features of the standard configuration with no limit on the number of code ownership records and allows setting up different approval rules for different project branches. It is suitable for large teams (over 30 people).

See the table below for a more detailed comparison of what different configurations provide:

| Functionality | Description | Basic<br>configuration | Standard<br>configuration | Advanced<br>configuration |
|:----------------------------------|:---------|:------------------------------------:|:---------------------------------------:|:------------------------------------:|
| One approval rule | You can assign reviewers, one of whom must review new commits before merging branches. | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Protected branches | You can select the branches for which the approval rules will apply. | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Code ownership | You can assign individual files and directories (including by mask) to specific users. These users become code owners and can participate in code approval if commits in the merge request affect their files. | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Multiple approval rules | You can set more than one approval rule. | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Branch-specific rules | You can specify different approval rules for different branches, e.g., `release` and `master`. | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
