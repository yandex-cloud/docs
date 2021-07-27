---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Handling errors

The script standard error output stream, `stderr`, is sent to the [centralized logging system](logging.md).

If the script is terminated with a code other than 0, it means that it failed. In this case, the content of the standard output stream is redirected to a log file and the function invocation results in the following error:

```json
{
    "errorType": "BashScriptExecutionError"
}
```

If the function response exceeds 1 MB, the following error is returned:

```json
{
    "errorType": "BashScriptReadOutputError"
}
```

