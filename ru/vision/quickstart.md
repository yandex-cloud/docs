# Как начать работать c [!KEYREF vision-short-name]

Этот раздел описывает, как начать использовать [!KEYREF vision-short-name] API для анализа изображений. Сейчас сервис предоставляет возможности для распознавания текста на изображении.

## Перед началом

1. Убедитесь, что у вас установлена утилита [cURL](https://curl.haxx.se), используемая в примерах.
1. [Получите идентификатор каталога](../resource-manager/operations/folder/get-id.md), на который у вас есть роль `editor` или выше. Подробнее о необходимых ролях в разделе [Управление доступом](security/index.md).

    Если каталога еще нет, создайте его:

    [!INCLUDE [create-folder](../_includes/create-folder.md)]
1. Получите IAM-токен, необходимый для аутентификации (чтобы получить IAM-токен для сервисного аккаунта, воспользуйтесь другой [инструкцией](../iam/operations/iam-token/create-for-sa.md)):

    ---

    **[!TAB CLI]**

    ```
    $ yc iam create-token
    ```

    **[!TAB API]**

    [!INCLUDE [create-iam-token-api-steps](../_includes/iam/create-iam-token-api-steps.md)]

    ---


## Распознайте текст на изображении

[!INCLUDE [text-detection-steps](../_includes/vision/text-detection-steps.md)]