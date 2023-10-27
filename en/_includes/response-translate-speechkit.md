# Response format

The response may contain:
- Result of request execution if successful.
- Error code and description if the request failed:

  ```json
  {
    "error_code": "{string}",
    "error_message": "{string}"
  }
  ```

## Response codes {#response-codes}

| Code | Reason | Description |
| ----- | ----- | ----- |
| 200 | OK | Successful execution of the request. |
| 400 | BAD_REQUEST | Syntax error in the request. |
| 401 | UNAUTHORIZED | Authorization error. |
| 429 | TOO_MANY_REQUESTS | Request limit exceeded. |
| 500 | INTERNAL_SERVER_ERROR | Server-side error. |

