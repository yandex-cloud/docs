---
title: Events
editable: false
---

# Events

#|
|| **Event** | **Description** ||
|| [issue.create](issue-create.md) | IssueCreate event - represents creation of a new issue

**CI execution_ref:** Default branch.

**can-trigger-ci:** `true` ||
|| [issue.delete](issue-delete.md) | IssueDelete event - represents deletion of an issue

**CI execution_ref:** Default branch.

**can-trigger-ci:** `true` ||
|| [issue.update](issue-update.md) | IssueUpdate event - represents update of an issue

**CI execution_ref:** Default branch.

**can-trigger-ci:** `true` ||
|| [issue_comment.create](issue-comment-create.md) | IssueCommentCreate event - represents creation of an issue comment

**CI execution_ref:** Default branch.

**can-trigger-ci:** `true` ||
|| [issue_comment.delete](issue-comment-delete.md) | IssueCommentDelete event - represents deletion of an issue comment

**CI execution_ref:** Default branch.

**can-trigger-ci:** `true` ||
|| [issue_comment.reactions_update](issue-comment-reactions-update.md) | IssueCommentReactionsUpdate event - represents update of reactions on an issue comment

**CI execution_ref:** Default branch.

**can-trigger-ci:** `true` ||
|| [issue_comment.update](issue-comment-update.md) | IssueCommentUpdate event - represents update of an issue comment

**CI execution_ref:** Default branch.

**can-trigger-ci:** `true` ||
|| [pull_request.create](pull-request-create.md) | PullRequestCreate event - represents creation of a new pull request

**CI execution_ref:** Pull request source branch.

**can-trigger-ci:** `true` ||
|| [pull_request.merge](pull-request-merge.md) | PullRequestMerge event - represents merge success of a pull request

**CI execution_ref:** Pull request target branch.

**can-trigger-ci:** `true` ||
|| [pull_request.merge_failure](pull-request-merge-failure.md) | PullRequestMergeFailure event - represents merge failure of a pull request

**CI execution_ref:** Pull request source branch.

**can-trigger-ci:** `true` ||
|| [pull_request.new_iteration](pull-request-new-iteration.md) | PullRequestNewIteration event - represents new iteration on a pull request

**CI execution_ref:** Pull request source branch.

**can-trigger-ci:** `true` ||
|| [pull_request.publish](pull-request-publish.md) | PullRequestPublish event - represents publish of a pull request

**CI execution_ref:** Pull request source branch.

**can-trigger-ci:** `true` ||
|| [pull_request.refresh](pull-request-refresh.md) | PullRequestRefresh event - represents refresh of a pull request

**CI execution_ref:** Pull request source branch.

**can-trigger-ci:** `true` ||
|| [pull_request.review_assignment](pull-request-review-assignment.md) | PullRequestReviewAssignment event - represents changes to pull request reviewers

**CI execution_ref:** Pull request source branch.

**can-trigger-ci:** `true` ||
|| [pull_request.review_decision](pull-request-review-decision.md) | PullRequestReviewDecision event - represents a review decision on a pull request

**CI execution_ref:** Pull request source branch.

**can-trigger-ci:** `true` ||
|| [pull_request.update](pull-request-update.md) | PullRequestUpdate event - represents update of a pull request

**CI execution_ref:** Pull request source branch.

**can-trigger-ci:** `true` ||
|| [pull_request_comment.create](pull-request-comment-create.md) | PullRequestCommentCreate event - represents creation of a pull request comment

**CI execution_ref:** Pull request source branch.

**can-trigger-ci:** `true` ||
|| [pull_request_comment.create_bulk](pull-request-comment-create-bulk.md) | PullRequestCommentCreateBulk event - represents bulk creation of pull request comments

**CI execution_ref:** Pull request source branch.

**can-trigger-ci:** `true` ||
|| [pull_request_comment.publish](pull-request-comment-publish.md) | PullRequestCommentsPublish event - represents publishing of draft pull request comments

**CI execution_ref:** Pull request source branch.

**can-trigger-ci:** `true` ||
|| [pull_request_comment.reactions_update](pull-request-comment-reactions-update.md) | PullRequestCommentReactionsUpdate event - represents update of reactions on a pull request comment

**CI execution_ref:** Pull request source branch.

**can-trigger-ci:** `true` ||
|| [repository.create](repository-create.md) | RepositoryCreated event

**can-trigger-ci:** `false` ||
|| [repository.push](repository-push.md) | Push event - represents git push operation to a repository

**CI execution_ref:** Created or updated branch or tag. Default branch when deleted.

**can-trigger-ci:** `true` ||
|| [repository.refs_update](repository-refs-update.md) | RefsUpdate event - represents git refs update operation to a repository

**can-trigger-ci:** `false` ||
|| [run.complete](run-complete.md) | CI run completed - emitted when a CI run completes (terminal status)

**can-trigger-ci:** `false` ||
|| [webhook.ping](webhook-ping.md) | Ping event - sent when a webhook is tested

**can-trigger-ci:** `false` ||
|| [workflow.complete](workflow-complete.md) | CI workflow completed - emitted when a single CI workflow completes (terminal status)

**can-trigger-ci:** `false` ||
|#
