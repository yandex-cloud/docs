# Как начать работать с {{ vision-short-name }}

Этот раздел описывает, как распознать текст на изображении или в файле с помощью {{ vision-short-name }} [API](../vision/ocr/api-ref/index.md).

## Перед началом работы {#before-you-begin}

{% include [curl](../_includes/curl.md) %}


{% list tabs group=authentication %}

- Аккаунт на Яндексе {#yandex-account}

  1. На странице [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) убедитесь, что [платежный аккаунт](../billing/concepts/billing-account.md) находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
  1. [Получите IAM-токен](../iam/operations/iam-token/create.md), необходимый для аутентификации.
  1. [Получите идентификатор любого каталога](../resource-manager/operations/folder/get-id.md), на который у вашего аккаунта есть роль `{{ roles-vision-user }}` или выше.
  1. Полученный идентификатор передавайте в заголовке `x-folder-id`.

{% endlist %}

## Распознайте текст {#analyze-image}

Вы можете использовать любую модель для распознавания из [списка](concepts/ocr/index.md#models). Для примера воспользуемся моделью `page`, которая позволяет распознавать любое количество текста на изображении:

1. Подготовьте файл изображения, соответствующий требованиям:

    {% include [file-restrictions](../_includes/vision/ocr-file-restrictions.md) %}

    {% include [file-restrictions](../_includes/vision/example-image.md) %}

1. Кодируйте файл с изображением в формат Base64:

    {% include [base64-encode-command](../_includes/vision/base64-encode-command.md) %}

1. Создайте файл с телом запроса, например `body.json`.

    **body.json:**
    ```json
    {
      "mimeType": "JPEG",
      "languageCodes": ["*"],
      "model": "page",
      "content": "<изображение_в_кодировке_base64>"
    }
    ```

    В свойстве `content` укажите содержимое файла, полученное при [переводе](./operations/base64-encode.md) изображения в формат Base64.
    
    Чтобы сервис автоматически определил язык текста, укажите в конфигурации свойство `"languageCodes": ["*"]`.


1. {% include [send-request](../_includes/vision/send-request_ocr.md) %}

    Результат будет состоять из распознанных блоков текста, строк и слов с указанием их местоположения на изображении:

    {% include [text-detection-penguins](../_includes/vision/text-detection-example.md) %}

1. Чтобы получить все распознанные на изображении слова, найдите все значения со свойством `text`.

{% include [coordinate-definition-issue-note](../_includes/vision/coordinate-definition-issue-note.md) %}
