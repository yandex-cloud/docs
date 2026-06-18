#### Why does an API request return the `Illegal duration format` error? {#illegal-duration}

If your API request body contains parameters in `type.googleapis.com/google.protobuf.Duration` format, you may get the following error:

```text
Illegal duration format; duration must end with 's' for type type.googleapis.com/google.protobuf.Duration
```

When using this format, make sure to append `s` to duration values.

For example:

```json
{
  "timeout": "120s"
}
```