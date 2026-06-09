---
title: Recommendations for using approval rules in {{ mgl-full-name }}
description: 'This article gives examples of the files named APPROVALRULES and CODEOWNERS for common scenarios: two-stage review, change approval in CI/CD, and role-based approval in {{ mgl-name }}.'
---

# Recommendations for using approval rules in {{ mgl-full-name }}

{% include [approval-rules-intro](../../_includes/managed-gitlab/approval-rules-intro.md) %}

For more information, see [{#T}](./approval-rules.md).

{% include [note-approval-rules-pricing](../../_includes/managed-gitlab/note-approval-rules-pricing.md) %}

This section gives examples of `APPROVALRULES` and, optionally, `CODEOWNERS` for the following common scenarios:
* [{#T}](#role-based-review)
* [{#T}](#two-stage-review)
* [{#T}](#cicd-review)

In addition to approval rules, you can also set up [branch protection](https://docs.gitlab.com/user/project/repository/branches/protected/) in your repository. These two mechanisms work in parallel; therefore, approval rules alone may not be enough for a merge request to merge into the target branch. For clarity, the examples assume that the referenced branches are not the repository's main branches (e.g., `main`) and are protected against direct pushes only.

The approval rules will take effect after changes made to `APPROVALRULES` and, optionally, `CODEOWNERS` are merged into the repository's [main branch](https://docs.gitlab.com/ee/user/project/repository/branches/default.html). There is no need to propagate these changes to other branches.

{% note warning %}

By default, the repository's main branch is [safeguarded](https://docs.gitlab.com/user/project/repository/branches/protected/) against changes by the [fully protected](https://docs.gitlab.com/user/project/repository/branches/default/#protect-initial-default-branches) policy. Only users with the `Maintainer` [role](https://docs.gitlab.com/user/permissions/#roles) can push changes to it.

{% endnote %}

Merge request reviewers must have at least the `Reporter` role in the {{ GL }} project; in most cases, the more privileged `Developer` role is used.

## Getting started {#preparations}

1. If you have no {{ GL }} instance yet, [create and activate](../operations/instance/instance-create.md) one.
1. If no approval rules have been configured in your {{ GL }} instance and project so far, [configure](../operations/approval-rules.md) them.

    {% note info %}

    The minimum [configuration](./approval-rules.md#packages) you need for approval rules to function is specified in each example.

    {% endnote %}

1. Create users and [groups](https://docs.gitlab.com/user/group/) as described in the examples below.
1. Create the files named `APPROVALRULES` and, optionally, `CODEOWNERS` in the repository's main branch according to the examples below.

## Rule setup example for role-based review {#role-based-review}

#|
|| **Minimum [configuration](./approval-rules.md#packages)** | **Comment** ||
|| Basic | 
* One rule per project.
* Rule valid for one branch.
* No code ownership. ||
|#

This example presents a scenario for mandatory reviews of merge requests by information security officers. For a merge into the `release` branch, the merge request has to be approved by a user with this `username`: `security-expert1` or `security-expert2`.

This scenario also suits other simple cases where you want to protect a single branch and assign specific approvers.

`APPROVALRULES` file contents:

```yaml
# Approval rules
ApprovalRules:
  # Rule name (any)
  - SecurityReview:
      # List of users (usernames) authorized to approve the merge request
      approvers:
        - "security-expert1"
        - "security-expert2"
      # Required number of approvals
      count: 1
# Branch groups subject to the rules
BranchGroups:
  # Branch group name (any)
  - Release:
      # List of branches subject to the rules
      branches:
        - release
      # Rules to apply
      rules:
        - SecurityReview
```

As a result, when a merge request for the `release` branch is created, one of the specified users gets auto-assigned in the **Reviewer** field, and the merge request gets blocked until approved.

{% note tip %}

Instead of listing specific users under `approvers`, you can use `groups` to specify a user [group](https://docs.gitlab.com/user/group/).

{% cut "Example" %}

```yaml
ApprovalRules:
  - SecurityReview:
      groups:
        - "soc"
        - "secops"
      count: 1
...
```

{% endcut %}

In which case one of the users from one of these groups will be automatically added to the merge request as a reviewer.

Simultaneous use of the `approvers` and `groups` sections within the same rule is redundant.

{% endnote %}

## Rule setup example for two-stage review {#two-stage-review}

#|
|| **Minimum [configuration](./approval-rules.md#packages)** | **Comment** ||
|| Advanced | 
* Several rules per project.
* Branch-specific rules.
* No code ownership. ||
|#

This example presents a scenario for mandatory two-stage reviews of merge requests:
1. For a merge into the `stage` branch, you need one approval by a developer from the `devs` [group](https://docs.gitlab.com/user/group/), who reviews the code for correctness, style, tests, and architecture.
1. For a merge into the `release` branch, you need two approvals: one by a developer from the `devs` group and one by a tech lead from the `tech-leads` group, the latter reviewing alignment with business goals and team standards.

This implies that changes first go from the main development branch (e.g., `dev`) into staging (`stage` branch) for tests, and only then to release (`release` branch).

You can also adapt this scenario for cases where different approval rules are required for merge requests to be merged into different branches.

`APPROVALRULES` file contents:

```yaml
# Approval rules
ApprovalRules:
  # Rule name (any)
  - TechnicalReview:
      # List of groups whose members can approve a merge request
      groups:
        - devs
      # Required number of approvals
      count: 1
  - LeadApproval:
      groups:
        - tech-leads
      count: 1
# Branch groups subject to the rules
BranchGroups:
  # Branch group name (any)
  - Stage:
      # List of branches subject to the rules
      branches:
        - stage
      # Rules to apply
      rules:
        - TechnicalReview
  - Release:
      branches:
        - release
      rules:
        - TechnicalReview
        - LeadApproval
```

As a result, when a merge request for the `stage` branch is created, one of the `devs` group members gets auto-assigned in the **Reviewer** field, and the merge request gets blocked until approved. After the merge, the changes are tested on staging.

Next, the developer creates a merge request from `stage` to `release`. Reviewers from the `devs` and `tech-leads` groups get auto-assigned in the **Reviewer** field, one from each group, and the merge request gets blocked until approved by both of these.

{% note tip %}

Instead of the `groups` section referencing user [groups](https://docs.gitlab.com/user/group/), you can use the `approvers` section to list specific users.

{% cut "Example" %}

```yaml
ApprovalRules:
  - TechnicalReview:
      approvers:
        - "dev1"
        - "dev2"
      count: 1
...
```

{% endcut %}

In which case one of these users will be automatically added to the merge request as a reviewer.

Simultaneous use of the `approvers` and `groups` sections within the same rule is redundant.

{% endnote %}

## Rule setup example for review of changes in CI/CD {#cicd-review}

#|
|| **Minimum [configuration](./approval-rules.md#packages)** | **Comment** ||
|| Standard | 
* One rule per project.
* Rule valid for one branch.
* Code ownership. ||
|#

This example presents a scenario for mandatory reviews of merge requests by DevOps engineers, only if the CI/CD configuration was modified. If a merge request changes the `.gitlab-ci.yml` file or `.yml` files in the `ci/` directory, you need approval by one of the `devops-team` [group](https://docs.gitlab.com/user/group/) member for a merge into the `release` branch.

This scenario also suits other cases where you want different teams or users have different scopes of review across the repository directories or files.

Path-based filtering is not supported by `APPROVALRULES`; therefore, you should combine approval rules with the [code ownership](../operations/approval-rules.md#code-ownership) mechanism.

`CODEOWNERS` file contents:

```text
# <filepaths_or_filtering_patterns> @<group_in_charge>
.gitlab-ci.yml @devops-team
ci/*.yml @devops-team
```

`APPROVALRULES` file contents:

```yaml
# Branch groups subject to the rules
BranchGroups:
  # Branch group name (any)
  - Release:
      # List of branches subject to the rules
      branches:
        - release
      # Rules to apply
      rules:
        - CODE_OWNERS
```

As a result, when a merge request for the `release` branch is created affecting `.gitlab-ci.yml` or `ci/*.yml`, one of the `devops-team` group members gets auto-assigned in the **Reviewer** field, and the merge request gets blocked until approved.

{% note tip %}

We recommend selective use of code ownership rules: use them only for branches that receive the final changes. However, you can also apply them to all branches as needed.

{% cut "Example" %}

```yaml
BranchGroups:
  - All:
      branches:
        - "*"
      rules:
        - CODE_OWNERS
```

{% endcut %}

{% endnote %}

### See also {#see-also}

* [{#T}](./approval-rules.md)
* [{#T}](../operations/approval-rules.md)
* [{#T}](../operations/instance/instance-create.md)

### GitLab guides {#gl-docs}

* [Merge request approval rules](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/rules.html)
* [Syntax of CODEOWNERS file](https://docs.gitlab.com/user/project/codeowners/reference/)
* [Protected branches](https://docs.gitlab.com/user/project/repository/branches/protected/)
* [Default branch](https://docs.gitlab.com/ee/user/project/repository/branches/default.html)
* [Roles and permissions](https://docs.gitlab.com/user/permissions/)
* [Groups](https://docs.gitlab.com/user/group/)
