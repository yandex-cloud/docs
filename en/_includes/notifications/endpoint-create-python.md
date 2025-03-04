```python
response = client.create_platform_endpoint(
    PlatformApplicationArn="<notification_channel_ARN>",
    Token="<push_token>",
)
print ("Endpoint ARN:", response["EndpointArn"])
```

Where:

* `PlatformApplicationArn`: Notification channel ID (ARN).
* `Token`: Unique push token for the app on the user’s device.

As a result, you will get a mobile endpoint ID (ARN).