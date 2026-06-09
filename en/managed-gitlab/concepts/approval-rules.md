---
title: Approval rules in {{ mgl-name }}
description: With {{ mgl-name }}, you can flexibly set up mandatory approval rules before merging code into the target branch of the project. This feature is an alternative to the {{ GL }} Enterprise Edition’s Approval Rules tool and is available regardless of the {{ GL }} version.
---

# Approval rules in {{ mgl-full-name }}

{% include [approval-rules-intro](../../_includes/managed-gitlab/approval-rules-intro.md) %}

{% include [note-approval-rules-pricing](../../_includes/managed-gitlab/note-approval-rules-pricing.md) %}

If approval rules are enabled in your {{ GL }} instance, {{ mgl-name }} analyzes obtained approvals for compliance with the specified rules. If there are not enough approvals, a blocking thread is created in the merge request, preventing it from being merged into the target branch. When the merge request is updated, a comment with the current compliance status is created or updated in the thread. Once all required approvals are obtained, the thread is resolved.

If you manually resolve the thread, it will be recreated. If the merge request is approved regardless of the existing rules, users with the `Maintainer` role or higher will receive an email notification about the violated approval workflow.

For more information about working with approval rules, see [Setting up approval rules](../operations/approval-rules.md).

## {{ GL }} token {#gitlab-token}

Approval rules are configured using a _[{{ GL }} token]({{ gl.docs }}/ee/user/profile/personal_access_tokens.html)_. When you contact a repository, a token is required for authorization – this is how you access the {{ GL }} API.

A {{ GL }} token has a lifetime, which is set when [creating the token](../operations/approval-rules.md#gitlab-token). The token expires at 00:00 UTC on the specified date. The maximum lifetime is one year from the token creation date.

The day before the expiration date, {{ GL }} sends a notification that the token is about to expire to the email address of the account that created the token.

Issue a new token and add it to the {{ GL }} instance settings before the current token expires Otherwise, {{ mgl-name }} will not work correctly.

## Available configurations {#packages}

The configuration you select affects the [cost of using the instance computing resources](../../managed-gitlab/pricing.md#prices).

You can choose a suitable configuration based on your team's objectives:

* **Basic**: Allows you to create a single rule for each project with no additional conditions. This option is best suited for smaller teams (up to 10 people).
* **Standard**: Allows you to configure multiple rules for each project and assign [code owners](../operations/approval-rules.md#code-ownership) to specific files or directories (up to 10 entries). It work best for medium-sized teams (10 to 30 people).
* **Advanced**: Includes all features of the standard configuration with no limit on the number of code ownership entries, and allows setting up different approval rules for different project branches. This configuration is a fit for for large teams (over 30 people).

See the table below for a more detailed comparison of what different configurations provide:

| Features                  | Description | Basic<br>configuration | Standard<br>configuration | Advanced<br>configuration |
|:----------------------------------|:---------|:------------------------------------:|:---------------------------------------:|:------------------------------------:|
| One approval rule per project      | You can assign a user group, with at least one member required to approve the merge request before merging. | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg)    | ![yes](../../_assets/common/yes.svg) |
| Protected branches                  | You can select branches the approval rules will apply to. | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg)    | ![yes](../../_assets/common/yes.svg) |
| Code Ownership                    | You can assign specific files and directories (including using patterns) to particular users. These users become code owners and can participate in code approval if commits in the merge request affect their files. | ![no](../../_assets/common/no.svg)   | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Multiple approval rules            | You can set more than one approval rule per project. | ![no](../../_assets/common/no.svg)   | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Branch-specific rules          | You can specify different approval rules for different branches, e.g., `release` and `master`. | ![no](../../_assets/common/no.svg)   | ![no](../../_assets/common/no.svg)      | ![yes](../../_assets/common/yes.svg) |

## Use cases {#examples-mgl}

* [{#T}](approval-rules-scenarios.md)
* [{#T}](../tutorials/gitlab-lockbox-integration.md)
