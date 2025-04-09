Optionally, click ![plus](../../_assets/console-icons/plus.svg) **Message retry settings** and specify the following:

* **Number of retries**: Number of message retries before {{ er-name }} moves the messages to the dead-letter queue (DLQ). Valid values range from 0 to 1,000. The default value is 3.
* **Interval**: Time, in hours, before a retry attempt to send the messages if the current attempt fails. Valid values range from 0 to 60 hours. The default value is 10.