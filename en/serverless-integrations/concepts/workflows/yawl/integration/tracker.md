---
title: Tracker integration step
description: This article describes the fields for the Tracker integration step.
---

# Tracker

{% include [workflows-ai-studio-note](../../../../../_includes/serverless-integrations/workflows-ai-studio-note.md) %}

Accessing the {{ tracker-full-name }} API. The `getIssue`, `createIssue`, `updateIissue`, `listIssues`, `linkIssues`, `updateIssueStatus`, `createComment`, `updateComment`, and `listComments` fields are mutually exclusive.

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`endpoint` | `string` | None | `api.tracker.yandex.net` | Yes | Host for calling the {{ tracker-full-name }} API.
`oauthToken` | `string` | Yes | None | Yes | [OAuth token]({{ link-tracker-cloudless }}api-ref/access#about_OAuth) for authentication when accessing the {{ tracker-short-name }} API.
`organization` | [Organization](#tracker-organization) | Yes | None | None | Organization ID
`getIssue` | [TrackerGetIssue](#trackergetissue) | None | None | None | Description of the action to get an issue.
`createIssue` | [TrackerCreateIssue](#trackercreateissue) | None | None | None | Description of the action to create an issue.
`updateIissue` | [TrackerUpdateIssue](#trackerupdateissue) | None | None | None | Description of the action to update an issue.
`listIssues` | [TrackerListIssues](#trackerlistissues) | None | None | None | Description of the action to search for an issue.
`linkIssues` | [TrackerLinkIssues](#trackerlinkissues) | None | None | None | Description of the action to add a link between issues.
`updateIssueStatus` | [TrackerUpdateIssueStatus](#trackerupdateissuestatus) | None | None | None | Description of the action to update an issue status.
`createComment` | [TrackerCreateComment](#trackercreatecomment) | None | None | None | Description of the action to create a comment.
`updateComment` | [TrackerUpdateComment](#trackerupdatecomment) | None | None | None | Description of the action to update a comment.
`listComments` | [TrackerListComments](#trackerlistcomments) | None | None | None | Description of the action to display comments on an issue.

## Organization {#tracker-organization}

The `yandexOrganizationId` and `cloudOrganizationId` fields are mutually exclusive.

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`yandexOrganizationId` | `string` | None | None | Yes | Organization ID in {{ ya-360 }}.
`cloudOrganizationId` | `string` | None | None | Yes | [Organization](../../../../../organization/quickstart.md) ID in {{ org-full-name }}.

## TrackerGetIssue {#trackergetissue}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`key` | `string` | Yes | None | Yes | Issue key.

## TrackerCreateIssue {#trackercreateissue}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`queue` | `string` | Yes | None | Yes | Queue to create the issue in.
`title` | `string` | Yes | None | Yes | Issue title.
`parent` | `string` | None | None | Yes | Parent issue key.
`description` | `string` | None | None | Yes | Issue description.
`sprints` | `string` | None | None | Yes | One of more sprints. You can specify the value as a string or JSON array.
`type` | `string` | None | None | Yes | Issue type.
`priority` | `string` | None | None | Yes | Issue priority.
`followers` | `string` | None | None | Yes | One or more followers. You can specify the value as a string or JSON array.
`assignee` | `string` | None | None | Yes | Issue assignee.
`author` | `string` | None | None | Yes | Issue reporter.
`additionalProperties` | `map[string]string` | None | None | Yes | Additional issue fields.

## TrackerUpdateIssue {#trackerupdateissue}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`key` | `string` | Yes | None | Yes | Issue key.
`title` | `string` | None | None | Yes | Issue title.
`parent` | `string` | None | None | Yes | Parent issue key.
`description` | `string` | None | None | Yes | Issue description.
`sprints` | [TrackerUpdateIssue.Action](#trackerupdateissue-action) | None | None | Yes | Linked sprints.
`type` | `string` | None | None | Yes | Issue type.
`priority` | `string` | None | None | Yes | Issue priority.
`followers` | [TrackerUpdateIssue.Action](#trackerupdateissue-action) | None | None | Yes | Followers in the issue.
`additionalProperties` | [TrackerUpdateIssue.AdditionalProperties](#trackerupdateissue-additionalproperties) | None | None | Yes | Additional issue fields.

## TrackerUpdateIssue.Action {#trackerupdateissue-action}

The `setValue`, `addValuesList`, `removeValuesList`, and `replaceValuesMap` fields are mutually exclusive.

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`setValue` | `string` | None | None | Yes | Replaces the issue field value. You can specify the value as a string or JSON array.
`addValuesList` | `string` | None | None | Yes | Adds one or more values to the issue field. You can specify the value as a string or JSON array.
`removeValuesList` | `string` | None | None | Yes | Deletes one or more values from the issue field. You can specify the value as a string or JSON array.
`replaceValuesMap` | [InterpolatableMap](#tracker-interpolatablemap) | None | None | None | Describes a list of field values to be replaced and their new values.

## TrackerUpdateIssue.AdditionalProperties {#trackerupdateissue-additionalproperties}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`pairs` | `map[string]` [TrackerUpdateIssue.Action](#trackerupdateissue-action) | None | None | Yes | Dictionary of pairs: the name of the additional field and the action to perform on it.

## InterpolatableMap {#tracker-interpolatablemap}

The `json` and `plainValue` fields are mutually exclusive.

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`json` | `string` | None | None | Yes | Dictionary containing a JSON array of pairs: current and new values of fields.
`plainValue` | [MapValue](#tracker-mapvalue) | None | None | None | Dictionary containing an array of pairs: current and new values of fields as [MapValue](#tracker-mapvalue) objects.

## MapValue {#tracker-mapvalue}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`pairs` | `map[string]string` | Yes | None | Yes | Dictionary containing an array of pairs: current and new values of fields.

## TrackerListIssues {#trackerlistissues}

The `queue`, `keys`, `filter`, and `query` fields are mutually exclusive.

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`pageSize` | `string` | None | None | Yes | Maximum number of issues to be included in a response.
`pageNumber` | `string` | None | None | Yes | Page number in the issue list output.
`queue` | `string` | None | None | Yes | Queue to find issues in.
`keys` | `string` | None | None | Yes | Issue keys that need to be found. You can specify the value as a string or JSON array.
`filter` | [TrackerLinkIssues.SearchOptionsFilter](#trackerlistissues-searchoptionsfilter) | None | None | Yes | Issue search filter by field values.
`query` | `string` | None | None | Yes | Filter in the request language.

## TrackerLinkIssues.SearchOptionsFilter {#trackerlistissues-searchoptionsfilter}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`issueProperties` | `map[string]string` | Yes | None | Yes | Fields to search by and the required values.
`order` | `string` | None | None | Yes | The direction and field for sorting issues.

## TrackerLinkIssues {#trackerlinkissues}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`key` | `string` | Yes | None | Yes | Issue key.
`linkKey` | `string` | Yes | None | Yes | Key of the issue you need to link to the issue specified in the `key` field.
`relationship` | `string` | Yes | None | Yes | Type of links between issues.

## TrackerUpdateIssueStatus {#trackerupdateissuestatus}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`key` | `string` | Yes | None | Yes | Key of the issue whose status you need to change.
`transition` | `string` | Yes | None | Yes | Transition ID.
`additionalProperties` | [MapValue](#tracker-mapvalue) | None | None | Yes | Additional fields required for a transition.

## TrackerCreateComment {#trackercreatecomment}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`key` | `string` | Yes | None | Yes | Key of the issue to add a comment to.
`text` | `string` | Yes | None | Yes | Text of the comment.
`mentions` | `string` | None | None | Yes | Mentions by users. You can specify the value as a string or JSON array.

## TrackerUpdateComment {#trackerupdatecomment}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`id` | `string` | Yes | None | Yes | ID of the comment being updated.
`issueKey` | `string` | Yes | None | Yes | Key of the issue the comment relates to.
`text` | `string` | Yes | None | Yes | New comment text.

## TrackerListComments {#trackerlistcomments}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`key` | `string` | Yes | None | Yes | Issue key.
`lastCommentId` | `string` | None | None | Yes | Comment's `id` parameter value after which the requested page will begin.
`pageSize` | `string` | None | None | Yes | Maximum number of comments per response.