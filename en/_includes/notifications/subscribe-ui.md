1. Select a topic.
1. Select **{{ ui-key.yacloud.cns.shared.CnsTopicLayout.subscriptions_cp53u }}** on the left.
1. Click **Create subscription**.
1. Select a notification channel type: 
     
   * **Mobile push notifications**.
   
       Enter the endpoint ARN in `arn:aws:sns::<cloud_id>:endpoint/<platform>/<channel_name>/<endpoint_unique_id>` format. You can copy the ARN on the endpoint’s settings page.

   * **In-browser push notifications**.

       Enter the endpoint ARN in `arn:aws:sns::<cloud_id>:endpoint/<platform>/<channel_name>/<endpoint_unique_id>` format.
   
   * **SMS**.
      
       Enter your phone number in [E.164](https://en.wikipedia.org/wiki/E.164) format, e.g., `+79991112233`. You do not need to pre-add the phone number to the SMS notification channel, but you need to create the channel itself.

1. Click **Create subscription**.

   Subscribe other endpoints to the topic in the same way.