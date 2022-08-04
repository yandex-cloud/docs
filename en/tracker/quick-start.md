# Setting up {{ tracker-name }}

Set up your workspace in {{ tracker-name }} and create your first issues.

## Step 1. Create a queue {#section_ebb_qlx_vhb}

Create a queue so that your team has a shared space to manage your issues.



1. On the top panel in {{ tracker-name }}, select **Queues** → **+ Create queue**.

1. Select the queue template. To make starting out easier, we've created several queue templates for you. Templates have everything you may need to start solving all kinds of issues:

    - **Development**: For issues related to software development and testing.

    - **Working with people and documents**: For issues related to tech support, HR, and document approval.

    - **Creating products and services**: For service projects and production issues.

    If it's your first time creating a queue, we recommend picking the [Starting right now]({{ link-quick-start }}) template. This is a versatile template suitable for most issues.

1. Think up a name for your queue. Its name should reflect the kinds of issues making up the queue. Example of a good name: <q>Department of Witchcraft and Wizardry</q>. Example of a poor name: <q>Roflmao</q>.

1. Set a unique queue key, such as <q>MAGIC</q>. The key should also be clear and easy to remember, so it's easy for you to find the queue in the list when you need it. Each issue in the queue is labeled with the queue key and issue number, such as <q>MAGIC-342</q>.

1. Click **Create**.

Your queue is ready. You can access the queue page anytime from the **Queues** menu on the top panel in {{ tracker-name }}.

## Step 2. Set up your issue board {#section_uth_1mx_vhb}

Boards are an easy way to keep track of your issues from one or more queues. Issues are sorted by columns that correspond to different issue statuses. Managing issue boards in {{ tracker-name }} is similar to working with regular sticker boards: just drag your issues between columns to change their status.



Follow these steps to create a board for your new queue:

1. Select **Boards** → **Create board** on the top panel in {{ tracker-name }}.

1. Choose your board type. We recommend starting with a standard board, as it's more versatile and easy to set up.

1. You can add issues to the board manually or set it up so that issues meeting certain requirements are placed on the board automatically.

    For now, choose the manual mode, as we'll discuss the auto mode later.

1. Think up a name for your board, such as <q>Magic Board</q>.

1. Enter your queue key in the **Queue** field: <q>MAGIC</q>. This will allow you to easily create issues for the queue right on the board page.

1. Click **Create**.

The new board appears in the **Boards** menu on the top panel. Add your board to Favorites to always have it at your fingertips: just click ![](../_assets/tracker/add-to-favorites.png) to the right of the board name.

## Step 3. Create your first issues {#section_cjc_5lx_vhb}

Issues are the foundation of {{ tracker-name }}. To make your workflow more efficient, try decomposing each issue into smaller tasks with clear goals.

{{ tracker-name }} provides multiple ways to create issues. For instance, you can create a new issue right from the board in just a couple of clicks. Or you can use the full issue creation form.

{% list tabs %}

- Creating an issue on the board

    Using the board is the fastest way to do this. You only need to enter the issue name. Everything else can be set up later.



    1. Open the page of your new board.

    1. Click **Add issue** in the lower-right corner.

    1. Think up a name for your issue, such as <q>Find the answer to the ultimate question of life, the Universe, and everything</q>. It's better to keep the name concise so it's easier to find in the list.

    1. Click **Create**.

    {{ tracker-name }} creates the issue in the queue that you specified when creating your board (the <q>MAGIC</q> queue in this case). The new issue appears on the board, the queue page, and the [{{ tracker-name }} main page]({{ link-tracker }}) in your issue list.

- Creating an issue using the full form

    Use the full form to set up all the issue attributes you need right from the start.



    1. Click **Create issue** on the top panel in {{ tracker-name }}.

    1. Choose the queue to create your issue in, such as <q>MAGIC</q>.

        {% note tip %}

        If you create an issue from the queue page, the queue field will already be filled in.

        {% endnote %}

    1. Think up a name for your issue, such as <q>Find the answer to the ultimate question of life, the Universe, and everything</q>. It's better to keep the name concise so it's easier to find in the list.

    1. You can also specify some details about your issue in the Description field. For instance, you can specify what he ultimate question of life, the Universe, and everything is.

    1. Click **Select fields** and customize the list of issue fields, such as **Assignee**, **Deadline**, and **Boards**.

    1. Make yourself the issue's assignee, specify a deadline, and choose <q>Magic Board</q> as your issue board.

    1. Click **Create** at the bottom of the page.

    Your issue is ready. It appears on the board, the queue page, and the [{{ tracker-name }} main page]({{ link-tracker }}) in your issue list.

{% endlist %}

## Step 4. What to do next {#section_ptb_ly4_h3b}

Learn more about {{ tracker-name }} and its basic features.

#### For team member

{{ tracker-name }} will help team members plan their tasks, discuss them with colleagues, and record the progress of their work. If you're new to {{ tracker-name }}, start with these sections:

| Section | Description |
| ------ | -------- |
| [{#T}](about-tracker.md) | Find out what's inside {{ tracker-name }} and how it works. |
| [Change the interface language](user/personal.md#choose-language) | Choose English or Russian as your interface language. |
| [Viewing my issues](user/my-tickets.md) | View the list of issues that are linked to you. |
| [Working with issues](user/ticket-in-progress.md) | Find out how to start working on an issue, keep track of your progress and complete your issues. |
| [Viewing issues in a queue](user/queue.md) | View all the issues related to a certain topic. |
| [{#T}](user/subscribe.md) | Subscribe to important issues so that you can find them quickly and stay up to date with the latest changes. |

#### For project managers

Project managers can use {{ tracker-name }} to effectively allocate team resources, assign tasks, and track progress. If you're new to {{ tracker-name }}, start with these sections:

| Section | Description |
| ------ | -------- |
| [{#T}](manager/queue-access.md) | Set up user access to issues in your queue. |
| [{#T}](user/search-task.md) | Find out how to quickly find the issues you need. |
| [{#T}](user/dashboard.md) | Create a dashboard page with statistics on issues that are important to you. |

