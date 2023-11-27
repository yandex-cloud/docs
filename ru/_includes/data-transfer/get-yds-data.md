Проверьте, что в поток данных {{ yds-name }} перенеслись данные из источника:

  {% list tabs %}

  * Консоль управления

      1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}**.
      1. Выберите поток-приемник из списка и перейдите в раздел ![image](../../_assets/console-icons/bars.svg) **{{ ui-key.yacloud.data-streams.label_data-introspection }}**.
      1. Убедитесь, что в сегменте `shard-000000` появились сообщения, содержащие строки таблицы из источника. Чтобы рассмотреть сообщения подробнее, нажмите на значок ![image](../../_assets/console-icons/eye.svg).

  * AWS

      1. [Установите AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
      1. [Настройте окружение](../../data-streams/quickstart/index.md) для {{ yds-name }}.
      1. Прочитайте данные из потока с помощью:

          * [AWS CLI](../../data-streams/operations/aws-cli/get-records.md).
          * [AWS SDK](../../data-streams/operations/aws-sdk/get-records.md).

  {% endlist %}
