{% include [support-headers](../../_includes/ai-common/support-headers.md) %}

## Examples {#examples}

Example of adding a header using [cURL](https://curl.haxx.se):

```bash
curl -X POST \
    -H "X-Client-Request-ID: fa18fa9b-176d-4ae0-92b8-bd7897f7c00c" \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    -d '@body.json' \
    https://vision.api.cloud.yandex.net/vision/v1/batchAnalyze
```

