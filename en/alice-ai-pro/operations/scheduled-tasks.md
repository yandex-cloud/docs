---
title: Scheduled tasks
description: Create scheduled tasks in {{ alice-ai-pro-name.p }} and manage their execution.
---

# Scheduled tasks

Scheduled tasks allow you to assign recurring tasks to {{ alice-ai-pro-name.d }}, e.g., preparing a digest or regular report. {{ alice-ai-pro-name.i }} executes the task at the specified time and saves the result in the chat.

You do not have to keep the browser tab open for the task to be executed. {{ alice-ai-pro-name.i }} will run the task in the background, and you can view the result in the chat after the execution.

You can create a task in the chat or set it up manually.

## Creating a task in the chat {#create-in-chat}

1. Open **Scheduled tasks**.
1. Click **Create in chat**.
1. Describe what you want to automate and how often the task should be run.
1. Answer any follow-up questions from {{ alice-ai-pro-name.r }}.
1. Check the task you created and update its settings as needed.

This method will work if you are unsure about what schedule or other settings to choose.

## Creating a task manually {#create-manually}

1. Open **Scheduled tasks**.
1. Click **Create manually**.
1. Enter a name for the task.
1. In the **Instructions** field, [describe the expected result](formulate-task.md). Here is an example: `Prepare a brief overview of the week’s top news and highlight the five main events`.
1. Choose where {{ alice-ai-pro-name.i }} should perform the task:

   - **New chat**: Select a project or create chats without a project.
   - **Existing chat**: Select the chat to run the task in.

1. Select a [model and reasoning mode](../concepts/models.md).
1. Configure the schedule:

   - Interval in minutes
   - Hourly
   - Daily
   - Weekly on selected days
   - Monthly on selected date

1. Specify the end date if needed. Without it, the task will continue until you stop or delete it.
1. Choose which executions to be notified about: all or only executions that end with an error.
1. Click **Create**.

When you create a task, your browser may ask you for a permission to show notifications.

Task execution time is saved together with the time zone set when creating the task. You can view the time zone in the task details.

## Viewing task execution results {#view-results}

Open the task to see the next execution time, end date, time zone, and execution history. You can see the status of each execution:

- **Queued**: Execution is waiting to be started.
- **Running**: {{ alice-ai-pro-name.i }} is executing the task.
- **Completed**: Task is completed.
- **Error**: Task failed.
- **Action required**: User action is required to continue.
- **Interrupted**: Task was stopped.

To view the result, navigate to the chat from the task. The chat with the result will become available after the first execution.

## Managing a task {#manage-task}

Open the task actions and select the command you need:

- **Edit**: Change the instructions, chat, model, schedule, or notifications.
- **Go to chat**: Open the chat with the results.
- **Pause**: Pause upcoming executions.
- **Resume**: Resume a paused scheduled task.
- **Run now**: Run the task without waiting for the next scheduled execution.
- **Delete**: Stop all future executions and delete the task from the list.

After you delete a task, you can still access the chats with its execution results.

#### Useful links {#see-also}

- [{#T}](chats.md)
- [{#T}](formulate-task.md)
- [{#T}](../concepts/models.md)
- [{#T}](../concepts/plugins.md)
- [{#T}](../qa/troubleshooting.md)
