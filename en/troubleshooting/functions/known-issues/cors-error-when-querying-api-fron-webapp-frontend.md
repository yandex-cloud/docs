# You see a CORS error when accessing the SpeechKit, Vision, or Translate API from your web application frontend

## Issue description {#issue-description}

When you try to access the SpeechKit, Vision, or Translate API, the service returns a CORS error.

E.g.:

```
Access to XMLHttpRequest at '<https://vision.api.cloud.yandex.net/vision/v1/batchAnalyze>' from origin '...' has been blocked by CORS policy: Response to preflight request doesn't pass access control check: No 'Access-Control-Allow-Origin'
```

## Solution {#issue-resolution}

You cannot enable direct interaction between an application running in a frontend environment, and the API. Our AI services (Vision, SpeechKit, or Translate) can't handle cross-domain requests because the APIs of these services have not implemented a response to the OPTIONS request.

You can use Cloud Functions for this. In the service, you'll need to [create a cloud function](../../../functions/operations/function/function-create.md) and implement in it an API that will deliver requests to SpeechKit, Vision, or Translate.