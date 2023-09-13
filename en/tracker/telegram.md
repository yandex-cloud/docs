# Telegram

Suppose that you need to automatically send notifications to the messenger whenever an issue changes its status. You might need it to see when your releases are ready for testing. To do this, [create a trigger](user/trigger.md) that keeps track of issue statuses like <q>{{ ui-key.startrek.blocks-desktop_queue-new-presets.preset--task-type--release }}</q> and sends an HTTP request when the issue status changes to <q>{{ ui-key.startrek-backend.presets.developmentPreset.board.column.ready.for.test }}</q>.

The Telegram messenger uses bots to automatically send messages to group chats and individual users. If you want to transmit {{ tracker-name }} notifications to Telegram, create a Telegram bot and set up a trigger that will send messages through the bot via HTTP requests.

## Step 1. Setting up a Telegram bot {#bot-setup}

1. Create a new Telegram bot:

   1. Add the `@BotFather` bot to your contacts in Telegram and send it a message saying `/start`.

   1. Send the message `/newbot` and follow the instructions: come up with a display name for the bot (such as `My Company`) and an account name (such as `MyCompanyBot`). The account name must end with `bot`.

   In response, you'll get a message that the bot has been created successfully. The message will include the token: a secret code that you'll need to access your bot over the API. The token follows the format `1234567890:ABC123-defHIJ...`

1. Add the bot you created to the Telegram group chat you want to send {{ tracker-name }} notifications to.
   If you want to receive {{ tracker-name }} notifications privately, start a chat with the bot.

1. Find out the ID of the Telegram chat where you want to post notifications. You can view this ID by using a dedicated bot, such as `@myidbot`:
   - To find out the ID of a group chat, add the bot to this chat and send it a message saying `/getgroupid`. Please keep in mind that group chat IDs start with a minus sign `-`.
   - You can send private messages using your account ID. To do this, send the bot a private message saying `/getid`.


To learn more about setting up a Telegram bot, please visit [https://core.telegram.org/bots](https://core.telegram.org/bots).

## Step 2. Set up {{ tracker-name }} {#tracker-setup}

1. Log in to {{ tracker-name }}. You must have administrator privileges for the queue that you'll configure the trigger for.

1. Go to **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_triggers.title }}** in the queue settings and click [**{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_triggers.button-create }}**](user/create-trigger.md).

1. Name the trigger, for example, <q>Telegram notifications</q>.

1. Configure trigger conditions so that the trigger is fired when the status of a **{{ ui-key.startrek.blocks-desktop_queue-new-presets.preset--task-type--release }}** issue changes to **{{ ui-key.startrek-backend.presets.advancedDevelopment.board.column.ready.for.test }}**:

   1. Select **{{ ui-key.startrek.blocks-desktop_trigger-condition.title }}** → **{{ ui-key.startrek.blocks-desktop_trigger-condition.condition-type--and_short }}**.

   1. Add the condition: **{{ ui-key.startrek.blocks-desktop_page-admin-tab_type_fields.table-head--type }}** → **{{ ui-key.startrek-backend.messages.trigger.condition.type.fieldEquals }}** → **{{ ui-key.startrek.blocks-desktop_queue-new-presets.preset--task-type--release }}**.

   1. Add the condition: **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_triggers.content-header--status }}** → **{{ ui-key.startrek-backend.messages.trigger.condition.type.fieldBecameEqual }}** → **{{ ui-key.startrek-backend.presets.advancedDevelopment.board.column.ready.for.test }}**.

   ![](../_assets/tracker/slack-trigger-example.png)

1. Click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_trigger-editor.action_add-action }}** and select **{{ ui-key.startrek.blocks-desktop_trigger-action.title_webhook }}**.

1. Set up the request:
   - Method: **POST**.
   - Address: `https://api.telegram.org/bot<token>/sendMessage`
      Add the value of the token that you obtained when [setting up the Telegram bot](#bot-setup), into the address.
   - Authorization method: **NoAuth**.
   - Content type: **application/json**.
   - Request body:
      ```
      {
          "chat_id": "<chat ID>",
          "text": "Time to test the issue [not_var{{issue.key}}: not_var{{issue.summary}}]({{ link-tracker }}not_var{{issue.key}})"
      }
      ```
      For the `chat_id`, enter the chat ID you received when [setting up your Telegram bot](#bot-setup).
      To add the issue field values to the request body, click **{ }** to the right of the field and choose the field name.
   - Leave the headers empty.

   {% note info %}

   If you want to use other methods and parameters in your HTTP requests, please refer to the Telegram bot API guide at [https://core.telegram.org/bots/api](https://core.telegram.org/bots/api).

   {% endnote %}

   ![](../_assets/tracker/telegram-trigger-request.png)

1. Save your trigger.


To test the trigger in action, change the issue status from **{{ ui-key.startrek.blocks-desktop_queue-new-presets.preset--task-type--release }}** to **{{ ui-key.startrek-backend.presets.developmentPreset.board.column.ready.for.test }}**. The trigger will send a message to your Telegram chat saying: <q>Issue TEST-123 is ready for testing: Configure triggers ({{ link-tracker-example-1 }})</q>.

