Пример генерирует подписанный URL для скачивания объекта `object-for-share` из бакета `bucket-with-objects`. URL действителен в течение 100 секунд.

В примере используются библиотеки [@aws-sdk/client-s3](https://www.npmjs.com/package/@aws-sdk/client-s3) и [@aws-sdk/s3-request-presigner](https://www.npmjs.com/package/@aws-sdk/s3-request-presigner).

```js
import { S3Client, GetObjectCommand } from "@aws-sdk/client-s3";
import { getSignedUrl } from "@aws-sdk/s3-request-presigner";

const S3_ENDPOINT = "https://{{ s3-storage-host }}";

const ACCESS_KEY_ID = "JK38EXAMP********";
const SECRET_ACCESS_KEY = "ExamP1eSecReTKeykdo********";

const s3Client = new S3Client({
  region: "{{ region-id }}",
  endpoint: S3_ENDPOINT,
  credentials: {
     accessKeyId: ACCESS_KEY_ID,
     secretAccessKey: SECRET_ACCESS_KEY,
  },
});

const command = new GetObjectCommand({
  Bucket: "bucket-with-objects",
  Key: "object-for-share",
});
const objectPresignedUrl = await getSignedUrl(s3Client, command, {
  expiresIn: 100,
});

console.log(objectPresignedUrl);
```