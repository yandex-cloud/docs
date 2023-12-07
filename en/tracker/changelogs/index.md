# {{ tracker-full-name }} revision history for October 2023

* [Updates](#top-news)
* [Fixes and improvements](#fixes)

## Updates {#top-news}

### Adding portfolios and projects on a Gantt chart for a portfolio {#portfolio-gantt-add}

You can create new and nest existing portfolios or projects in a [Gantt chart for a portfolio](../gantt/portfolio.md).

To do this, click ![](../../_assets/tracker/svg/add-task.svg) **Add** below the list of nested portfolios and projects.

### Automatic calculation of time spent on an issue {#calculate-time}

[Advanced time tracking](../user/time-spent.md#extended-spent-time) mode now allows you to automatically calculate the time spent on an issue. The time calculation covers the span from when the issue was assigned until it was closed, the employee's schedule considered.

To learn how to activate auto time calculation and how it works, see [{#T}](../manager/queue-spent-time.md).

### Viewing a workflow on the issue page {#see-workflow}

{{ tracker-name }} users can now view a queue's [workflow](../manager/workflow.md) in issues. If authorized to [view queue issues](../manager/queue-access.md#acces-types), the user will now see a set of statuses inside an issue. The user will also be able to view transitions, but only those they have access to within the workflow configuration.

To view the workflow on the issue page, click ![](../../_assets/tracker/svg/arrow.svg) → **View workflow** in the right-hand panel in the **Status** field.

### List of statuses in the workflow editor {#list-workflow}

The workflow editor now has a panel where you can search by workflow status and transition. Click the panel to view a list of all the workflow statuses. Each status will show a list of transitions configured for it with prompts on the settings available for each one (e.g., automation, transition screens).

![](../../_assets/tracker/workflow-editor-list-of-statuses.png =300x)

Hovering over a status selects in the diagram all the transitions from the status, as well as the initial and final statuses for a given transition. You can also swap statuses and transitions in the list by dragging them. Hovering over an element makes an icon appear to the right of it. Click and hold the icon and drag the selected element.

## Fixes and improvements {#fixes}

### New interface with {{ tracker-name }} settings {#new-admin-settings}

The [**Issue statuses**]({{ link-tracker-statuses }}), [**Issue types**]({{ link-admin-types }}), and [**Resolutions**]({{ link-admin-resolutions }}) pages are now available in the new interface. Use these pages to perform a search, create new entities, and view the list of existing ones.

### Viewing {{ tracker-name }} settings {#see-admin-settings}

Organization users who are not administrators can now follow direct links to view {{ tracker-name }} settings:

* Issue statuses: [{{ link-tracker-statuses }}]({{ link-tracker-statuses }})
* Issue types: [{{ link-admin-types }}]({{ link-admin-types }})
* Resolutions: [{{ link-admin-resolutions }}]({{ link-admin-resolutions }})




### Notifications about changes to portfolios and projects {#projects-notifications}

{{ tracker-name }} now notifies users about portfolio and project updates. Users with the following roles will be notified:
* Author
* Owner
* Customer
* Participant
* Follower


### Creating and editing versions {#queue-versions}

The new interface allows you to create and edit [queue versions](../manager/versions.md).

### Fixed the error of updating issue status with local fields {#boards-fix}

Fixed the error that prevented dragging an issue to a different column on the [issue board](../manager/agile-new.md) for an [issue status](../manager/workflow-status-edit.md) update, if it was required to fill a [local field](../local-fields.md) on the transition screen.

### Fixed the error with setting up conditions for transition between local fields {#workflow-fix}

Fixed the error that prevented specifying [local fields](../local-fields.md) in transition conditions in the [workflow](../manager/workflow.md) editor.

### Fixed emoji display {#emoji-fix}

Fixed the issue that caused emojis to be replaced with their text names.

### Fixed the home page link {#logo-link-fix}

Fixed the error that opened a wrong page when clicking the {{ tracker-name }} logo (not the one specified in the settings).