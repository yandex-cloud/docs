# Example: setting up {{ tracker-name }} for a development team

{{ tracker-name }}  is a collaboration tool that makes it easier to manage the development of apps and programs. {{ tracker-name }} features a variety of tools for developers:

- Flexible issue management: customizable issue types, statuses, and parameters, templates, and [issue decomposing and structuring via links](#manage_tickets).

- Tools for [managing Agile workflows](#agile).

- [Recurring action automation](#automation) to save developers' time.


- [Ability to connect source code repositories](#repo) and [integration with other environments](#api).

Let's look at how to set up a {{ tracker-name }} workflow for a development team.

## Create a queue for the development team {#create}

Each team has their own established way of planning their workload, solving issues, and releasing products. If you want to set up a familiar workflow for the team in {{ tracker-name }}, use an [issue queue](queue-intro.md). A queue is an area shared by related issues being worked on under a single product or pipeline.

We recommend setting up a standalone queue for each team. You can also create several queues if you want to split the workflow into multiple pipelines. For instance, this can be useful if your development team has multiple assigned sub-teams, each performing their own tasks independently.

To create a queue for the development team, do the following:


1. If your organization doesn't have **{{ tracker-name }}** yet, [activate the service](enable-tracker.md).

1. Make sure all the support staff is added to your organization and [grant them full access to {{ tracker-name }}](enable-tracker.md#subscriptions).

1. [Create an issue queue.](manager/create-queue.md) Select a [queue template](manager/workflows.md) with statuses and issue types that are best suited to your workflow:

    - <q>Basic development</q>: This template contains issue types and statuses that are most commonly used when developing programs and apps. A [simple issue board](#board_types) is created when you select this template.

    - <q>Software development as a service</q>: This template provides an issue type called <q>Project</q> and a status that lets you coordinate approval of your performance with the customer.

    - <q>Scrum</q>: This template is suitable for teams that work with [Scrum]({{ link-wiki-scrum }}). A [<q>Scrum</q> issue board]( #board_types) is created when you select this template.

    - <q>Kanban</q>: This template is suitable for teams that work with [Kanban]({{ link-wiki-kanban }}). A [simple <q>Kanban</q> issue board](#board_types) is created when you select this template.

    {% note info %}

    If you selected a queue template without an associated issue board, you can [create one later](manager/create-agile-board.md).

    {% endnote %}

1. If you want to change the list of issue statuses available to your queue, go to queue settings and simply copy the [basic workflow](manager/add-workflow.md) and [edit it](manager/workflow-status-edit.md).

1. Add the employees who will be working on your product to your [queue team](manager/queue-team.md).

1. You can also configure [access rights to issues within the queue](manager/queue-access.md) if needed. For example, you can allow certain user groups to create or view issues in the queue or prevent them from doing so.

## Structure issues {#manage_tickets}

There are several ways to structure issues in {{ tracker-name }}. You can apply them individually or use several at the same time.

#### Issue types

Your queue may include multiple [issue types](manager/add-ticket-type.md) with different pipelines. For instance, the <q>Basic development</q> queue template includes the following issue types by default: <q>Task</q>, <q>Improvement</q>, <q>Bug</q>, and <q>Release</q>.

You can also add new issue types and [set up a dedicated workflow for them](manager/add-workflow.md) if needed, such as setting up their possible statuses and status transition rules.

#### Links

{{ tracker-name }} lets you [link issue types to each other](user/ticket-links.md). A list of clickable issue links is displayed on the issue pages. Here is what issue links let you do:

- Decompose your issues. Break larger project chunks into standalone issues and sub-issues.

    Let's say you need to implement a new feature in your product, which implies resolving multiple smaller issues. For such cases, you can create a <q>New feature</q> type parent issue and link your sub-issues to it.

- Display issue hierarchy. Useful if the issue can only be solved after first dealing with the blocker issue.

- Add links to issues sharing a common theme.

#### Components

[Components](manager/components.md) help you group issues in a queue that are related to the same subject. When managing issues with components, you can set up a default assignee and [access rights](manager/queue-access.md#section_tbh_cs5_qbb).

#### Versions

[Versions](manager/versions.md) help you group issues in the same queue based on the product version they belong to.

#### Projects

Use [projects](manager/projects.md) to group issues with the same deadline and responsible employee. Projects can include issues from different queues.

## Use Agile methodologies {#agile}

If your team's work is organized using [Agile software development](https://en.wikipedia.org/wiki/Agile_software_development), try using issue boards in {{ tracker-name }}. Boards help you keep track of tasks laid out for the team (such as during daily meetups). Issues are displayed on the board as cards sorted into columns based on their status.


 ![](../_assets/tracker/agile-board-c.png)

If you [chose to create a queue](#create) using the <q>Basic development</q>, <q>Scrum</q>, or <q>Kanban</q> templates, an issue board sharing the queue's name will also be created automatically. The board will display all issues contained in your queue.

You can also [create multiple issue boards](manager/create-agile-board.md). This can be useful if you have multiple work groups or issue types:

1. On the top panel in {{ tracker-name }}, choose **Boards** → **Create board**.

1. Select the [board type](#board_types).

1. Enable the **Add issues automatically** option and set the filters so that only issues with the needed parameters are displayed.

    For example, you can set up filters in such a way so that all issues from your queue are displayed on the board, or only issues with certain [components](manager/components.md) or assignees are displayed, and so on.

     ![](../_assets/tracker/dev-process-board-filter.png)

#### Board types in {{ tracker-name }} {#board_types}

{{ tracker-name }} has multiple board types:

- <q>Basic</q>. This board has the least features, displays the team's issues and issue statuses.

- <q>Kanban</q>. This board is similar to the basic board, but all issues with the **Open** status are automatically moved to the [**Backlog**](manager/agile.md#dlen_backlog) column.

- <q>Scrum</q>. In addition to displaying issue statuses, this board lets you manage [sprints](manager/agile.md#dlen_sprint), [rate issues](manager/planning-poker.md), and view [burn down charts](manager/agile.md#dlen_burndown).

#### Scrum board tools

The <q>Scrum</q> board offers tools to help organize your workflow according to the [Scrum]({{ link-wiki-scrum }}) methodology:

- **Sprints**

    Scrum implies that your workflow is broken down into smaller cycles called sprints. A sprint usually lasts one or two weeks. Please try planning your sprints in a way that lets your team solve all scheduled issues in the allotted time. You should also gauge your issues with [planning poker](#poker) to visualize your workload more clearly beforehand.

    To [schedule a sprint in {{ tracker-name }}](manager/create-agile-sprint.md):

    - Click **Sprints** in the upper-right corner of the issue board.

    - [Create a sprint](manager/create-agile-sprint.md#create_sprint) and set its start and end dates.

    - Add issues to your sprint: drag them from the **Backlog** column to the sprint issue list. Alternatively, you can specify a sprint in the **Agile** → **Sprint** field on the issue page.

    If you want the board to only display issues related to a specific sprint, select that sprint at the top of the page. To track the issue completion speed for issues in a sprint, use a [burn down chart](#burndown).

- **Planning poker** {#poker}

    To accurately gauge the workload for the upcoming sprint, you need to be able to evaluate its issue complexity. To do this, Scrum uses [poker planning](https://en.wikipedia.org/wiki/Planning_poker). This method lets each member of your team score issues on their complexity independently, discuss the results, and finally pin down the total score. This scoring method usually involves relative issue complexity grades called [Story Points](manager/agile.md#dlen_sp).

    You can [use planning poker in {{ tracker-name }}](manager/planning-poker.md):

    - To [assess your issues](manager/planning-poker.md#section_estimate), ask your team members to go to the poker page. To do this, click **Poker** in the upper-right corner of the issue board.

    - You can also [set the issue rating scale](manager/planning-poker.md#section_estimate) and [specify rules for calculating the final score](manager/planning-poker.md#section_calc) in the board settings.

- **Burn down chart** {#burndown}

    The burn down chart shows the issue completion speed and remaining workload in a single [sprint](manager/agile.md#dlen_sprint). Burn down charts are useful for evaluating whether the team will be able to solve the planned issues in time.

    The chart's vertical axis shows the total workload left in [Story Points](manager/agile.md#dlen_sp), while the horizontal axis shows time. The ideal burndown chart should be as close as possible to a straight line that starts at the point with the most amount of work during the first day (total workload volume within a sprint) and ends at the zero point during the last day of the sprint.

    To [view the burn down chart in {{ tracker-name }}](manager/burndown.md), click **Burn down chart** in the upper-right corner of the issue board.

#### Issue decomposition

Agile development strategies decompose issues as follows:

- Larger tasks that cannot be completed within a single sprint are called Epics.

- Epics are then broken down into <q>User Stories</q>, which are finalized product features that can be implemented in a single sprint

- User Stories are then broken down into standalone issues, such as designing the interface, or backend and frontend development.

To accommodate a system like that, the [<q>Scrum</q> queue template](manager/workflows.md#sec_scrum) provides Epic and Story issue types. If you [chose to create a queue](#create) using a template that does not have the Epic and Story issue types, you can [add them in the queue settings](manager/add-ticket-type.md).

## Configure issue templates {#templates}

You can use [templates](user/ticket-template.md) to make it easier to create common issue types, such as bug fixing or testing-related issues. You can use templates to set predetermined issue parameters and add tips that remind users to specify the necessary information and help describe the issue in more detail.

To create an issue template for your queue and grant access rights to it for your team members, do the following:

1. On the top panel in {{ tracker-name }}, click  ![](../_assets/tracker/tracker-settings.png) → **Manage templates**.

    On the {{ tracker-name }} top panel, click on your profile picture and select **Personal settings**. Then click **Manage templates**.

1. Choose **Issues** and click **Create template**.

1. Set the name and description for the template.

1. If you want the template to only be used in your own queue, enter the queue key or name in the **Queue binding** field. In this case, the team members within the queue will automatically gain read-only access to the template.

1. Fill in the template fields and save the template. The specified field values will be automatically filled in for the issues created using this template.

1. To configure template access, click **Access control** next to the template and add the desired groups or users.

1. To let the members of your team use your template:

    - Make sure the employees have read-only access to the template.

    - They must then enable that template. To do this, go to the template management page and enable the desired template.

If you need an issue template available to all users by default, [set up an issue creation form](manager/forms-integration.md) via Yandex.Forms. 


## Connecting repositories {#repo}

If you're using cloud-based services such as GitHub, GitLab, or Bitbucket, you can connect your repositories to {{ tracker-name }} and then link commits to issues. This will help you track any code changes related to a particular issue.

{% note warning %}

Git repositories hosted on your own private server can't be linked to {{ tracker-name }}.

{% endnote %}

To connect a repository, do the following:

1. Make sure that you are logged in as the organization administrator.

1. In the {{ tracker-name }} settings, go to the [Repositories]({{ link-repositories }}) tab and click **Connect repository**.

1. Select the service where the repository is hosted and specify the following information:

    - Link to the repository.

    - Specify the token for private GitHub and GitLab repositories. For public repositories, you do not need to specify a token.

    - For Bitbucket repositories, you need to specify your Bitbucket login and a special password generated for {{ tracker-name }}.

    For more information about repository connection parameters, see [{#T}](manager/add-repository.md).

1. To display related commits on the issue page, go to your [queue settings](manager/edit-queue-general.md#integration) and enable the option **Show "Commits" tab**.

To link a commit to an issue in {{ tracker-name }}, specify your [issue key](user/create-ticket.md#key) in a comment on the commit.

## Automate recurring actions {#automation}

You can automate common actions related to {{ tracker-name }} issues using [triggers, auto actions, and macros](automation.md). This lets you change issue parameters in response to certain events (whether by sending a command or setting up a recurring trigger) as well as create scheduled issues.

Let's look at some examples of how you can automate certain actions in {{ tracker-name }}:

#### Pick assignees automatically {#auto-assign-executor}

If a certain issue falls under the responsibility of a specific employee, you can automatically make them an assignee for that issue using [triggers](user/trigger.md). A trigger is activated once specified conditions are fulfilled and automatically changes issue parameters in response.

For example, the tester should start testing a new product feature once the developer changes the issue status to<q>Ready for testing</q>. If you want to automatically assign that tester as the issue's assignee, configure the trigger as follows:

- Trigger conditions: The issue status has changed to <q>Ready for testing</q>.

- Trigger action: Specify the tester in the <q>Assignee</q> field.

![](../_assets/tracker/trigger-example-status.png)

Now let's consider a situation where one developer is responsible for the server side of a product while another developer handles the client side. When creating new bug-related issues pertaining to the server or client side of a product, you can automatically assign the corresponding developer to handle the job using components and triggers:

1. [Configure the components](manager/components.md) of your queue corresponding to each side of product development like their <q>Server</q> side and <q>Client</q> side. Add the relevant component when creating a new bug-related issue.

1. Configure the server side bug trigger:

    - Trigger conditions: The value in the <q>Components</q> field changed to <q>Server</q>.

    - Trigger action: Specify the server side developer in the <q>Assignee</q> field.

     ![](../_assets/tracker/dev-process-trigger-component.png)

1. Configure the client side bug trigger in a similar manner:

    - Trigger conditions: The value in the <q>Components</q> field changed to <q>Client</q>.

    - Trigger action: Specify the client side developer in the <q>Assignee</q> field.

For a detailed example of setting up triggers, see [{#T}](manager/trigger-examples.md#assign_ticket).

#### Remind the assignee about the deadline{#auto-remind-deadline}

If you want to make sure assignees finish their issues on time, you can use auto actions to send them reminders. Auto actions are triggered recurringly and update issue parameters that fit specified criteria.

Let's say you need to check all issues in your queue once a day. If the issue is not solved and the date specified in the <q>Deadline</q> field is less than 3 days away, the issue must be updated with a comment and the assignee must be invited. To do this, configure your auto action as follows:

- Auto action type: **Update issues**.

- Frequency: Once per day.

- Filter parameters: A query written using the [query language](user/query-filter.md):

    ```
    Resolution: empty() AND Deadline: <= today() + 3d
    ```

     ![](../_assets/tracker/autoaction-example-condition.png)

- Issue action: Send a comment and invite the user specified in the <q>Assignee</q> field.

For a detailed example of setting up auto actions, see [{#T}](user/create-autoaction.md#autoaction_example).

#### Create recurring issues{#auto-create-task}

You can use auto actions if you need to have recurring issues created based on a specified template. For example, this lets you automatically create a data backup issue every week.

To do this, configure your auto action as follows:

- Auto action type: **Create issues**.

- Frequency: Once a week on Fridays.

    You can set the start and end of the time frame during which issues are created automatically. If the time frame is not specified, recurring issue creation will go on indefinitely.

     ![](../_assets/tracker/dev-process-autoaction-schedule.png)

- Queue action: Create an issue. Fill in the fields for the automatic issue creation template.

For a detailed example of setting up auto actions, see [{#T}](user/create-autoaction.md#autoaction_example).

## Integrate {{ tracker-name }} with other platforms {#api}

Developers have to use various different platforms to build, test, and deploy their apps, among other things. You can use {{ tracker-name }} to find links to related resources or to issues hosted on other platforms, making cross-platform development more convenient. To send information from other platforms to {{ tracker-name }}, use the {{ tracker-name }} API. To learn more about the {{ tracker-name }} API capabilities, read the [Yandex.Tracker API reference](about.md).

To transmit data from {{ tracker-name }} to another platform, try sending HTTP requests via [triggers](user/trigger.md).

Let's look at some examples of how you can link {{ tracker-name }} to other platforms.

#### Track review code status

Let's say our development team uses Bitbucket as their repository. Once a developer sends a pool request to the repository, their colleagues review the code and either accept or reject the initial pool request. If the request pool is accepted, the developer changes the issue status to <q>Ready for testing</q>. If it was rejected, the status is changed to <q>Needs improvement</q> instead.

You can use the {{ tracker-name }} API to update issue statuses automatically based on the review results. However, this requires creating an intermediate service that would receive event information from Bitbucket, process it, and send requests to the {{ tracker-name }} API. Sample algorithm:

1. The developer makes a pool request and specifies the [issue key](user/create-ticket.md#key) in the comments. This will help us determine which issue needs a status update.

1. Bitbucket must have a web hook set up so that it sends an HTTP request to the intermediate service once the reviewer accepts or rejects a pool request.

1. The intermediate service receives the HTTP request, determines the event type (pool requested accepted or rejected), and retrieves the issue key from the comment left for the pool request.

1. The intermediate service then sends a request to the {{ tracker-name }} API, telling it to update the issue status. The request URL must contain the issue key and the status key. You can find the status key in the {{ tracker-name }} settings on the [**Issue statuses**]({{ link-tracker-statuses }}) tab.

    See the request format in [Tracker API reference](about.md).

#### Link a test bench to an issue

Test benches are usually used to test new product features. If several product features are being developed concurrently, having a dedicated test bench for each issue makes things more streamlined. Make sure your issues include links to test benches to make finding them easier. This can be done automatically using the {{ tracker-name }} API.

Let's say the team automated test bench generation using a script: the script loads the app code from a separate issue branch, converts it into a Docker image, unpacks the container from that image on a server, and finally launches it.

The same script can be used to add a link to the unpacked bench to the issue. To do this:


1. In {{ tracker-name }}, [create a new issue field called](user/create-param.md#section_pxn_fp4_xgb) <q>Bench link</q>.

1. When developing a new product feature, create a separate branch in the repository that must have the [issue key](user/create-ticket.md#key) specified in its name. This issue key is needed to send a request to the {{ tracker-name }} API.

1. Once the script has deployed the test bench, it sends a request to the {{ tracker-name }} API, adding the bench address to the <q>Bench link</q> issue field. The request URL must contain the issue key, and the request body must contain the key and the new field value. You can find the field key in the {{ tracker-name }} settings on the [**Fields**]({{ link-admin-fields }}) tab.

    See the request format in [Tracker API documentation](about.md).

#### Send notifications to a messenger

Messengers are a great way to quickly notify employees about important events. If a messenger has an API, you can use {{ tracker-name }} to set up a trigger that sends HTTP requests to the messenger's API when certain events occur. For instance, a request can be triggered once an error with the critical priority status is added to the queue.

To view examples for setting up triggers that send notifications to Slack and Telegram, see [{#T}](messenger.md).


[Contact support](troubleshooting.md)

