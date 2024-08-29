#### Quotas {#vision-quotas}

| Type of limit | Value |
----- | -----
| Number of requests per second, [synchronous mode](../vision/ocr/api-ref/TextRecognition/index.md) | 1 |
| Number of requests per second, [asynchronous mode](../vision/ocr/api-ref/TextRecognitionAsync/index.md) | 10 |
| Number of requests per second, asynchronous mode (getting an operation status) | 50 |
| Number of requests per second, asynchronous mode (getting a response) | 50 |

#### Limits {#vision-limits}

| Type of limit | Value |
----- | -----
| Period for storing recognition results on the server | 3 days |
| Maximum file size for the [OCR API](../vision/ocr/api-ref/index.md) | {{ ocr-max-filesize }} |
| Maximum image size | 20 MP (length × width) |
| Maximum number of pages in a PDF file when using the [OCR API in asynchronous mode](../vision/ocr/api-ref/TextRecognitionAsync/index.md) | 200 |