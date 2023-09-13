# Setting up {{ tracker-name }}

Set up your workspace in {{ tracker-name }} and create your first issues.

## Step 1. Create a queue {#create-queue}

Create a queue for your team: this is a shared space where all your issues are brought together.


1. In the left-hand panel, select ![](../_assets/tracker/svg/queues.svg) **{{ ui-key.startrek.blocks-desktop_b-head.queues }}** → **{{ ui-key.startrek.blocks-desktop_b-head.new-queue }}**.

1. Select queue template To make it easier for you to get started, we prepared some queue templates for you. The templates include everything you might ever need to work with a variety of issues:

   - **{{ ui-key.startrek.blocks-desktop_queue-new-presets.category--development }}**: For issues related to software development and testing.

   - **{{ ui-key.startrek.blocks-desktop_queue-new-presets.category--support }}**: For issues related to tech support, HR, and document approval.

   - **{{ ui-key.startrek.blocks-desktop_queue-new-presets.category--business }}**: For service projects and production issues.

   If it's your first time creating a queue, we recommend picking the [Start now]({{ link-quick-start }}) template. This is a universal template that suits most issues.

1. Think up a name for your queue. The name should make it clear which issues belong to this queue. Here is an example of a good name: <q>Department of magic and wizardry</q>; bad name: <q>Abracadabra</q>.

1. Set a unique queue key, such as <q>MAGIC</q>. The key should also be clear and easy to remember, so it's easy for you to find the queue in the list when you need it. Each issue in the queue is labeled with the queue key and issue number, such as <q>MAGIC-342</q>.

1. Click **{{ ui-key.startrek.blocks-desktop_queue-new-presets.create }}**.

The queue is ready to go. You can access the queue page anytime from the **{{ ui-key.startrek.blocks-desktop_b-head.queues }}** menu in the {{ tracker-name }} top panel.

## Step 2. Set up your issue board {#set-board}

A board is a visual method to track the status of issues belonging to the same or different queues. Issues on the board are distributed across columns that correspond to different statuses. Managing issue boards in {{ tracker-name }} is similar to working with regular sticker boards: just drag your issues between columns to change their status.


To create a board for the issues in your new queue:

1. In the left-hand panel, click ![](../_assets/tracker/svg/boards.svg) **{{ ui-key.startrek.ui_components_NavigationBar.boards }}** → **{{ ui-key.startrek.ui_components_NavigationBar_BoardsPanel.create-button }}**.

1. Choose your board type. We recommend starting with a simple board: this is the most universal board that is easiest to configure.

1. You can add issues to the board manually or set up the board so that the issues that meet certain criteria are added to it automatically.

   Select the manual mode: we'll discuss the automatic mode a bit later.

1. Think up a name for your board, such as <q>Magic Board</q>.

1. In the **{{ ui-key.startrek.ui_components_IssueListsPanel.queue }}** field, enter your queue key: <q>MAGIC</q>. This way, you can quickly create issues in this queue directly from the board page.

1. Click **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardCreateModal.submit-btn }}**.

The new board will appear in the ![](../_assets/tracker/svg/boards.svg) **{{ ui-key.startrek.ui_components_NavigationBar.boards }}** menu in the left-hand panel.

## Step 3. Create your first issues {#create-tasks}

Issues are the foundation of {{ tracker-name }}. To make your work more efficient, try to break it down into individual issues with clear execution criteria.

{{ tracker-name }} provides multiple ways to create issues. For instance, you can create a new issue right from the board in just a couple of clicks. Or you can use the full issue creation form.

### Creating an issue on a board {#tasks-board}

The fastest way to create an issue is to do it from the board. You only need to enter the issue name. Everything else can be set up later.


1. Open the page of your new board.

1. In the leftmost column, click ![](../_assets/tracker/svg/add-task.svg) and select **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardEmptyScreen.empty-screen--new-issue }}**.

1. Think up a name for your issue, such as <q>Find the answer to the ultimate question of life, the Universe, and everything</q>. It's better to keep the name concise so it's easier to find in the list.

1. Press **Enter**.

{{ tracker-name }} creates the issue in the queue that you specified when creating your board (the <q>MAGIC</q> queue in this case). The new issue appears on the board, the queue page, and the [{{ tracker-name }} home page]({{ link-tracker }}) in your issue list.

### Creating an issue using the full form {#tasks-form}

Use the full form to set up all the issue attributes you need right from the start.


1. Click ![](../_assets/tracker/svg/icon-add.svg) **{{ ui-key.startrek.blocks-desktop_b-head.new_issue }}** in the left panel.

1. In the upper-left corner of the page, choose the queue to create your issue in, such as <q>MAGIC</q>.

   {% note tip %}

   If you create an issue from a queue page, the queue field is pre-populated.

   {% endnote %}

1. Select a form to create an issue from. **{{ ui-key.startrek.ui_components_PageCreateIssue.empty-template }}** is selected by default.

1. Think up a name for your issue, such as <q>Find the answer to the ultimate question of life, the Universe, and everything</q>. It's better to keep the name concise so it's easier to find in the list.

1. To give more detail about the issue, use the issue description. For example, you may give your perspective on the ultimate question of life, the universe, and everything.

1. In the right-hand panel, set up a list of the issue fields you need, e.g., **{{ ui-key.startrek-backend.fields.issue.type-key-value }}**, **{{ ui-key.startrek-backend.fields.issue.assignee-key-value }}**, and **{{ ui-key.startrek-backend.fields.issue.dueDate-key-value }}**.

1. Make yourself the issue's assignee, specify a deadline, and choose <q>Magic Board</q> as your issue board.

1. Click **{{ ui-key.startrek-backend.types.types.trigger.action.create.issue }}**.

The new issue is ready-to-go. The new issue appears on the board, the queue page, and the [{{ tracker-name }} home page]({{ link-tracker }}) in your issue list.

## Step 4. What's next {#whats-next}

Learn more about {{ tracker-name }} and its basic features.

### For team member

{{ tracker-name }} will help team members plan their tasks, discuss them with colleagues, and record the progress of their work. If you're new to {{ tracker-name }}, start with these sections:

| Section | Description |
------ | --------
| [{#T}](about-tracker.md) | Find out what's inside {{ tracker-name }} and how it works. |
| [Change the interface language](user/personal.md#choose-language) | Choose English or Russian as your interface language. |
| [Viewing my issues](user/my-tickets.md) | View a list of your related issues. |
| [Working with issues](user/ticket-in-progress.md) | Learn how to accept an issue, report on its progress, and close the issue. |
| [Viewing issues in a queue](user/queue.md) | View all the issues related to a certain topic. |
| [{#T}](user/subscribe.md) | Subscribe to your key issues to access them quickly and stay abreast of their latest changes. |

### Supervisor

Project managers can use {{ tracker-name }} to effectively allocate team resources, assign tasks, and track progress. If you're new to {{ tracker-name }}, start with these sections:

| Section | Description |
------ | --------
| [{#T}](manager/queue-access.md) | Set up user access to issues in your queue. |
| [{#T}](user/search-task.md) | Learn how to quickly find relevant issues. |
| [{#T}](user/dashboard.md) | Create a dashboard, that is, the page that includes statistics on your key issues. |

