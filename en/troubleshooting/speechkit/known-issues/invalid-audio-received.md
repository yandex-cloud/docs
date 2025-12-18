# Resolving the `Invalid audio received` error



## Issue description {#issue-description}

When you make a request to recognize a file, you see this error in the service response:
```
{
"code": 3,
"message": "Invalid audio received"
}
```

## Solution {#issue-resolution}

This error means that the audio file data has been encoded by an unsupported codec. For more information on the supported audio formats and codecs, see [this article](../../../speechkit/formats.md).