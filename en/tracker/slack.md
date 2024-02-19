# Slack

Let's assume that you need to automatically send notifications to the messenger whenever an issue changes its status. You may need it to see when your releases are ready for testing. To do this, [create a trigger](user/trigger.md) that will keep track of issue statuses such as **Release** and send an HTTP request when the issue status changes to **{{ ui-key.startrek-backend.presets.developmentPreset.board.column.ready.for.test }}**.

If you want to send {{ tracker-name }} notifications to team chats, set up an external app in Slack and create a trigger that will send messages to Slack via HTTP requests.

## Step 1. Set up Slack {#slack-setup}

1. Log in to Slack.

1. Connect {{ tracker-name }} to Slack as an external app (Slack App):

   1. Follow the [Create your Slack app](https://api.slack.com/apps/new) link.

   1. Name your app, e.g., _Tracker_.

   1. Select the workspace to connect {{ tracker-name }} to.

   1. Click **Create App**.

1. Enable **Incoming Webhooks** → **Activate Incoming Webhooks** in the settings of your new Slack App.

1. Update the page with the application settings.

1. Click **Add New Webhook to Workspace**.

1. Select the channel that {{ tracker-name }} will send messages to and click **Authorize**.

1. The app settings page will then display the address that {{ tracker-name }} will use to send messages in the **Webhook URLs for Your Workspace** section. The URL has the following format:
   ```
   https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX
   ```
   Copy the address as you will need it when setting up {{ tracker-name }} integration.

## Step 2. Set up {{ tracker-name }} {#tracker-setup}

1. Log in to {{ tracker-name }}. You must have administrator privileges for the queue for which you want to configure the trigger.

1. Go to the queue settings, open the **Triggers** section, and click [**Create trigger**](user/create-trigger.md).

1. Name the trigger, e.g., _Slack notifications_.

1. Configure trigger conditions so that the trigger is fired when the status of a **Release** issue changes to **{{ ui-key.startrek-backend.presets.advancedDevelopment.board.column.ready.for.test }}**:

   1. Select **Conditions to be met** → **All**.

   1. Add the condition: **Type** → **{{ ui-key.startrek-backend.messages.trigger.condition.type.fieldEquals }}** → **Release**.

   1. Add the condition: **Status** → **{{ ui-key.startrek-backend.messages.trigger.condition.type.fieldBecameEqual }}** → **{{ ui-key.startrek-backend.presets.advancedDevelopment.board.column.ready.for.test }}**.

   ![](../_assets/tracker/slack-trigger-example.png)

1. Click **Add new action** and choose **HTTP request**.

1. Set up the request:
   - Method: **POST**.
   - Address: URL that you received when you set up the integration on the Slack side.
   - Authorization method: **NoAuth**.
   - Content type: **application/json**.
   - Request body:
      ```
      {
          "link_names": true,
          "text": "@tracker, time to test the issue <{{ link-tracker }}not_var{{issue.key}}|not_var{{issue.key}}>: not_var{{issue.summary}}"
      }
      ```
      To add the issue field values to the request body, click **{ }** to the right of the field and choose the field name.
   - Leave the headers empty.

   ![](../_assets/tracker/slack-webhook-example.png)

1. Save your trigger.

To test the trigger in action, change the issue status from **Release** to **{{ ui-key.startrek-backend.presets.developmentPreset.board.column.ready.for.test }}**. The trigger will send a message to the team chat with the link to the issue and the following text: _Time to test the TEST-123 issue: Configure triggers_.


