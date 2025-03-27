---
title: Tracker integration step
description: This article describes the fields for the Tracker integration step.
---

# Tracker

Accessing the {{ tracker-full-name }} API. The `getIssue`, `createIssue`, `updateIissue`, `listIssues`, `linkIssues`, `updateIssueStatus`, `createComment`, `updateComment`, and `listComments` fields are mutually exclusive.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`endpoint` | `string` | No | `api.tracker.yandex.net` | Yes | Host for calling the {{ tracker-full-name }} API.
`oauthToken` | `string` | Yes | No | Yes | [OAuth token](../../../../../iam/concepts/authorization/oauth-token.md) to be used for authorization when accessing the {{ tracker-short-name }} API.
`organization` | [Organization](#tracker-organization) | Yes | No | No | Organization ID.
`getIssue` | [TrackerGetIssue](#trackergetissue) | No | No | No | Description of the action to get an issue.
`createIssue` | [TrackerCreateIssue](#trackercreateissue) | No | No | No | Description of the action to create an issue.
`updateIissue` | [TrackerUpdateIssue](#trackerupdateissue) | No | No | No | Description of the action to update an issue.
`listIssues` | [TrackerListIssues](#trackerlistissues) | No | No | No | Description of the action to search for an issue.
`linkIssues` | [TrackerLinkIssues](#trackerlinkissues) | No | No | No | Description of the action to add a link between issues.
`updateIssueStatus` | [TrackerUpdateIssueStatus](#trackerupdateissuestatus) | No | No | No | Description of the action to update an issue status.
`createComment` | [TrackerCreateComment](#trackercreatecomment) | No | No | No | Description of the action to create a comment.
`updateComment` | [TrackerUpdateComment](#trackerupdatecomment) | No | No | No | Description of the action to update a comment.
`listComments` | [TrackerListComments](#trackerlistcomments) | No | No | No | Description of the action to display comments on an issue.

## Organization {#tracker-organization}

The `yandexOrganizationId` and `cloudOrganizationId` fields are mutually exclusive.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`yandexOrganizationId` | `string` | No | No | Yes | Organization ID in {{ ya-360 }}.
`cloudOrganizationId` | `string` | No | No | Yes | [Organization](../../../../../organization/quickstart.md) ID in {{ org-full-name }}.

## TrackerGetIssue {#trackergetissue}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`key` | `string` | Yes | No | Yes | Issue key.

## TrackerCreateIssue {#trackercreateissue}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`queue` | `string` | Yes | No | Yes | Queue to create the issue in.
`title` | `string` | Yes | No | Yes | Issue title.
`parent` | `string` | No | No | Yes | Parent issue key.
`description` | `string` | No | No | Yes | Issue description.
`sprints` | `string` | No | No | Yes | One of more sprints. You can specify the value as a string or JSON array.
`type` | `string` | No | No | Yes | Issue type.
`priority` | `string` | No | No | Yes | Issue priority.
`followers` | `string` | No | No | Yes | One or more followers. You can specify the value as a string or JSON array.
`assignee` | `string` | No | No | Yes | Issue assignee.
`author` | `string` | No | No | Yes | Issue reporter.
`additionalProperties` | `map[string]string` | No | No | Yes | Additional issue fields.

## TrackerUpdateIssue {#trackerupdateissue}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`key` | `string` | Yes | No | Yes | Issue key.
`title` | `string` | No | No | Yes | Issue title.
`parent` | `string` | No | No | Yes | Parent issue key.
`description` | `string` | No | No | Yes | Issue description.
`sprints` | [TrackerUpdateIssue.Action](#trackerupdateissue-action) | No | No | Yes | Linked sprints.
`type` | `string` | No | No | Yes | Issue type.
`priority` | `string` | No | No | Yes | Issue priority.
`followers` | [TrackerUpdateIssue.Action](#trackerupdateissue-action) | No | No | Yes | Followers in the issue.
`additionalProperties` | [TrackerUpdateIssue.AdditionalProperties](#trackerupdateissue-additionalproperties) | No | No | Yes | Additional issue fields.

## TrackerUpdateIssue.Action {#trackerupdateissue-action}

The `setValue`, `addValuesList`, `removeValuesList`, and `replaceValuesMap` fields are mutually exclusive.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`setValue` | `string` | No | No | Yes | Replaces the issue field value. You can specify the value as a string or JSON array.
`addValuesList` | `string` | No | No | Yes | Adds one or more values to the issue field. You can specify the value as a string or JSON array.
`removeValuesList` | `string` | No | No | Yes | Deletes one or more values from the issue field. You can specify the value as a string or JSON array.
`replaceValuesMap` | [InterpolatableMap](#tracker-interpolatablemap) | No | No | No | Describes a list of field values to be replaced and their new values.

## TrackerUpdateIssue.AdditionalProperties {#trackerupdateissue-additionalproperties}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`pairs` | `map[string]` [TrackerUpdateIssue.Action](#trackerupdateissue-action) | No | No | Yes | Dictionary of pairs: the name of the additional field and the action to perform on it.

## InterpolatableMap {#tracker-interpolatablemap}

The `json` and `plainValue` fields are mutually exclusive.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`json` | `string` | No | No | Yes | Dictionary containing a JSON array of pairs: current and new values of fields.
`plainValue` | [MapValue](#tracker-mapvalue) | No | No | No | Dictionary containing an array of pairs: current and new values of fields as [MapValue](#tracker-mapvalue) objects.

## MapValue {#tracker-mapvalue}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`pairs` | `map[string]string` | Yes | No | Yes | Dictionary containing an array of pairs: current and new values of fields.

## TrackerListIssues {#trackerlistissues}

The `queue`, `keys`, `filter`, and `query` fields are mutually exclusive.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`pageSize` | `string` | No | No | Yes | Maximum number of issues to be included in a response.
`pageNumber` | `string` | No | No | Yes | Page number in the issue list output.
`queue` | `string` | No | No | Yes | Queue to find issues in.
`keys` | `string` | No | No | Yes | Issue keys that need to be found. You can specify the value as a string or JSON array.
`filter` | [TrackerLinkIssues.SearchOptionsFilter](#trackerlistissues-searchoptionsfilter) | No | No | Yes | Issue search filter by field values.
`query` | `string` | No | No | Yes | Filter in the request language.

## TrackerLinkIssues.SearchOptionsFilter {#trackerlistissues-searchoptionsfilter}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`issueProperties` | `map[string]string` | Yes | No | Yes | Fields to search by and the required values.
`order` | `string` | No | No | Yes | The direction and field for sorting issues.

## TrackerLinkIssues {#trackerlinkissues}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`key` | `string` | Yes | No | Yes | Issue key.
`linkKey` | `string` | Yes | No | Yes | Key of the issue you need to link to the issue specified in the `key` field.
`relationship` | `string` | Yes | No | Yes | Type of links between issues.

## TrackerUpdateIssueStatus {#trackerupdateissuestatus}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`key` | `string` | Yes | No | Yes | Key of the issue whose status you need to change.
`transition` | `string` | Yes | No | Yes | Transition ID.
`additionalProperties` | [MapValue](#tracker-mapvalue) | No | No | Yes | Additional fields required for a transition.

## TrackerCreateComment {#trackercreatecomment}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`key` | `string` | Yes | No | Yes | Key of the issue to add a comment to.
`text` | `string` | Yes | No | Yes | Text of the comment.
`mentions` | `string` | No | No | Yes | Mentions by users. You can specify the value as a string or JSON array.

## TrackerUpdateComment {#trackerupdatecomment}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`id` | `string` | Yes | No | Yes | ID of the comment being updated.
`issueKey` | `string` | Yes | No | Yes | Key of the issue the comment relates to.
`text` | `string` | Yes | No | Yes | New comment text.

## TrackerListComments {#trackerlistcomments}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`key` | `string` | Yes | No | Yes | Issue key.
`lastCommentId` | `string` | No | No | Yes | Comment's `id` parameter value after which the requested page will begin.
`pageSize` | `string` | No | No | Yes | Maximum number of comments per response.