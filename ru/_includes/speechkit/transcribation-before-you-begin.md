1. [Создайте](../../storage/operations/buckets/create.md) бакет и загрузите в него аудиофайл, который необходимо распознать.
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роли `storage.uploader` и `ai.speechkit-stt.user` на каталог, в котором вы ранее создали бакет.
1. [Получите](../../iam/operations/iam-token/create-for-sa.md) IAM-токен для созданного сервисного аккаунта.