{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится поток данных.
  1. В списке сервисов выберите **{{ yds-full-name }}**.
  1. Нажмите на имя потока данных.
  1. Скопируйте:
     * Имя потока, например `aws_stream`.
     * Эндпоинт потока, например `https://yds.serverless.yandexcloud.net//ru-central1/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv`.
  1. Из скопированных значений сформируйте идентификатор и эндпоинт потока для протокола AWS Kinesis Data Streams:
     * Идентификатор потока — `/ru-central1/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/aws_stream`.
     * Эндпоинт — `https://yds.serverless.yandexcloud.net`.

{% endlist %}