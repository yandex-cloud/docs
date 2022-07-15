---
title: Authentication in Yandex SpeechKit API
description: "To perform operations via the Yandex SpeechKit API, you need to authenticate from your service, federated or Yandex account. Specify the received IAM token when accessing Yandex Cloud resources via the API in the format — Authorization: Bearer <IAM-TOKEN>"
---

{% include [authentication-ml-services](../../_includes/authentication-ml-services.md) %}

If you are using API v3, also pass `x-folder-id` with the [folder ID](../../resource-manager/operations/folder/get-id.md) in the header of each request.

```
Authorization: Bearer <IAM token>
x-folder-id <folder ID>
```

#### See also {#see-also}

* [What roles are required for performing operations](../security/index.md)