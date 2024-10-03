---
title: Handling errors in {{ vision-short-name }}
description: '{{ vision-short-name }} returns request errors, file processing errors, and analysis errors for specific type of analysis.'
---

# Handling errors in {{ vision-short-name }}

{{ vision-short-name }} returns errors for these three levels:

* [Request errors](#request-error).
* [File processing errors](#file-error).
* [Errors performing a specific type of analysis](#feature-error).

This section lists possible errors and provides descriptions for each of these levels.

## Request errors {#request-error}

A standard error returned by {{ yandex-cloud }} if an operation fails. For a list of error codes and descriptions, see the [API concepts](../../api-design-guide/concepts/errors.md).

## File processing errors {#file-error}

An error that occurs if the service failed to process some of the files received. For example, if it failed to decode an image:

```json
{
 "results": [
  {
   "error": {
    "code": 3,
    "message": "Can't decode Image"
   }
  },
  {
    "results": [{ ... }] // Results of analyzing another file.
  }
 ]
}
```

If a file processing error occurs, the gRPC error code is always `3`, and the error cause is specified in the `message`. Here are some examples:

* Image cannot be decoded.
* Image too big.
* Image resolution too high.
* Error converting to JPEG.

## Analysis errors {#feature-error}

An error that occurs if the service failed to analyze one of the requested `features` for the file. For example, it failed to recognize text due to an incorrect configuration:

```json
{
 "results": [
  {
   "results": [
    {
     "error": {
      "code": 3,
      "message": "Incorrect feature configuration: Incorrect number of language codes: 0"
     }
    }
   ]
  },
  {
    "results": [{ ... }] // Results of analyzing another file.
  }
 ]
}
```

Possible errors:

| Error code | Error description |
---- | ----
| 3 | Invalid request parameters. For example, the configuration specifies an incorrect number of languages. |
| 8 | The [limit](../concepts/limits.md) for the given feature has been exceeded. |
| 13 | Internal server error. This error means that the operation cannot be performed due to a server-side technical problem, e.g., due to insufficient computing resources. |
