(Optional) Click ![plus](../../_assets/console-icons/plus.svg) **Message grouping settings** and specify the following:

* **Number of messages per group**: Maximum number of messages {{ er-name }} will group before sending them to the target. The number of messages per group cannot exceed the specified value. Valid values ​​range from 0 to 1,000. The default value is 1.
* **Number of bytes per group**: Maximum total amount of data in the messages. If the data comes in a single message, this limit may be exceeded. Valid values ​​range from 0 to 262,144 bytes. The default value is 10,000 bytes.
* **Timeout**: Maximum time during which {{ er-name }} is grouping messages before sending them to the target. Valid values ​​range from 0 to 60 seconds. The default value is 60 seconds.