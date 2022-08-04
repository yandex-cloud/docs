# Slack

Let's say we need to send an automatic notification to the messenger each time the issue status is changed. This could be used, for example, to track whether releases are ready for testing. To do this, [create a trigger](user/trigger.md) that keeps track of issue statuses like <q>Release</q> and sends an HTTP request when the issue status changes to <q>Ready for testing</q>.

If you want to transmit {{ tracker-name }} notifications to team chats, set up an external app in Slack and create a trigger that will send messages to Slack via HTTP requests.

## Step 1. Set up Slack {#slack-setup}

1. Log in to Slack.

1. Connect {{ tracker-name }} to Slack as an external app (Slack App):

    1. Follow the link [Create your Slack app](https://api.slack.com/apps/new).

    1. Think up a name for the app, like <q>Tracker</q>.

    1. Select the workspace to connect {{ tracker-name }} to.

    1. Click **Create App**.

1. Enable **Incoming Webhooks** → **Activate Incoming Webhooks** in the settings of your new Slack App.

1. Refresh the settings page.

1. Click **Add New Webhook to Workspace**.

1. Select the channel that {{ tracker-name }} will send messages to and click **Authorize**.

1. The app settings page will then display the address that {{ tracker-name }} will use to send messages in the **Webhook URLs for Your Workspace** section. Here's what the address should look like:

    ```
    https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX
    ```

    Copy the address because you'll need it when setting up {{ tracker-name }} integration.

## Step 2. Set up {{ tracker-name }} {#tracker-setup}

1. Log in to {{ tracker-name }}. You must have administrator privileges for the queue that you'll configure the trigger for.

1. Go to the queue settings, open the **Triggers** section, and click [**Create trigger**](user/create-trigger.md).

1. Name the trigger, for example, <q>Slack notifications</q>.

1. Configure trigger conditions so that the trigger is fired when the status of a **Release** issue changes to **Ready for testing**:

    1. Choose **Conditions to be met** → **All**.

    1. Add the condition **Type** → **Field equals to** → **Release**.

    1. Add the condition **Status** → **Field value became equal to** → **Ready for testing**.

    ![](../_assets/tracker/slack-trigger-example.png)

1. Click **Add new action** and choose **HTTP request**.

1. Configure the request:
    - Method: **POST**.
    - URL: The address you received when setting up integration in Slack.
    - Authorization method: **NoAuth**.
    - Content type: **application/json**.
    - Request body:

        ```
        {
            "link_names": true,
            "text": "@tracker, time to test the issue <https://tracker.yandex.ru/not_var{{issue.key}}|not_var{{issue.key}}>: not_var{{issue.summary}}"
        }
        ```

        To add the issue field values to the request body, click **{ }** to the right of the field and choose the field name.
    - Leave the headers empty.

    ![](../_assets/tracker/slack-webhook-example.png)

1. Save your trigger.

To test the trigger in action, change the issue status from **Release** to **Ready for testing**. The trigger sends a message to the group chat with the link to the issue and the following text: <q>Time to test the issue TEST-123: Configure triggers</q>.

