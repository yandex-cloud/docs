For all errors, the response body has the same format:

```json
{
   "Code": "<error_name>",
   "message": "<error_description>"
}
```

The name of the error is taken from its code, e.g., `BadRequestException`.
