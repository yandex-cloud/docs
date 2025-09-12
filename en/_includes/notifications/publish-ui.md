1. Select the topic.
1. Click **{{ ui-key.yacloud.cns.action_send-message }}**.
1. Select a notification type: 
     
    * **Same**: To send the same notification to all channel types.
    * **Different**: To enter different texts for different channel types.

1. Enter the same text for all channels, or different texts for different channel types, in JSON format. If a channel is not specified, the notification will contain the `default` message text.
   
    Notification format in JSON:
    
    {% include [topic-message-json](topic-message-json.md) %}

1. Click **{{ ui-key.yacloud.cns.action_send-msg }}**.