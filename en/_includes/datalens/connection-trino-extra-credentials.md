**Additional credentials**: This settings allows providing random name-value pairs to {{ TR }} in the `X-Trino-Extra-Credential` HTTP request header. For example, you can use it to access an external source on behalf of a specific user without creating a separate connection.

The supported names are defined in the configuration by the {{ TR }} cluster administrator. If the connector on the {{ TR }} side is not configured to accept them, the values will be ignored.

The naming requirements are as follows:

* Non-empty string.
* ASCII characters.
* No spaces and no `=`.

Values are stored encrypted and not displayed after saving. When you reopen the form, the value field will show a `Secret value` placeholder.

* To change the value, enter a new one.
* To keep the previous value, do not change the field.
* To delete the name-value pair, delete the entire string.
