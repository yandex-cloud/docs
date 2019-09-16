Explanations:

* `yc iam create-token`: get an IAM token.
* `-d @<(cat  EOF ... EOF)`: create a request body.
* `yc config get folder-id`: get the ID of the default folder selected in the CLI.
* `base64 -i $1`: Base64 encoding of the image passed in the function arguments.

