---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Troubleshooting

{% include [ask-for-support](../../_includes/ai-common/ask-for-support.md) %}

To help the technical support team resolve your issue, use the following headers when sending HTTP requests:

* {% include [x-client-request-id](../../_includes/ai-common/x-client-request-id.md) %}

* `x-data-logging-enabled` is a flag that allows data passed by the user in the request to be saved.

    By default, we do not save any audio or text that you send. If you pass the `true` value in this header, your data is saved. This data, along with the request ID, will help the technical support team solve your problem.

## Examples {#examples}

For example, you can use these headers to let us know afterwards that your audio was poorly detected and help us refine our speech recognition model.

An example of headings used in [cURL](https://curl.haxx.se):

```bash
$ curl -X POST \
    -H "x-client-request-id: fa18fa9b-176d-4ae0-92b8-bd7897f7c00c" \
    -H "x-data-logging-enabled: true" \
    -H "authorization: Bearer ${IAM_TOKEN}" \
    --data-binary "@speech.ogg" \
    "https://stt.api.cloud.yandex.net/speech/v1/stt:recognize?folderId=${FOLDER_ID}"
```

