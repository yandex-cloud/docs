# Bash function error handling

The Bash script’s standard error output stream, `stderr`, is sent to the [centralized logging system](logging.md).

If the script terminates with a code other than 0, this indicates an execution error. In this case, the content of the standard output stream is redirected to the log and the function returns this error:

```json
{
    "errorType": "BashScriptExecutionError"
}
```

If the function response exceeds 1 MB, the function returns the following error:

```json
{
    "errorType": "BashScriptReadOutputError"
}
```
