1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
1. Hа панели слева выберите ![image](../../_assets/console-icons/layout-cells.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_schema-registry }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.schema-registry.label_create-namespace-action }}**.
1. В поле **{{ ui-key.yacloud.common.name }}** задайте уникальное имя пространства имен.
1. (Опционально) Добавьте описание пространства имен.
1. В блоке **Параметры совместимости**:
    1. Задайте **Уровень проверки совместимости**
        * `BACKWARD`: (значение по умолчанию) потребители, использующие новую схему, могут читать данные, написанные производителями с использованием последней зарегистрированной схемы;
        * `BACKWARD_TRANSITIVE`: потребители, использующие новую схему, могут читать данные, записанные производителями с использованием всех ранее зарегистрированных схем;
        * `FORWARD`: потребители, использующие последнюю зарегистрированную схему, могут читать данные, написанные производителями, использующими новую схему;
        * `FORWARD_TRANSITIVE`: потребители, использующие все ранее зарегистрированные схемы, могут читать данные, написанные производителями с использованием новой схемы;
        * `FULL`: новая схема совместима вперед и назад с последней зарегистрированной схемой;
        * `FULL_TRANSITIVE`: новая схема совместима вперед и назад со всеми ранее зарегистрированными схемами;
        * `NONE`: проверки совместимости схемы отключены.
          Подробнее о типах совместимости схем см. в [документации Confluent](https://docs.confluent.io/platform/current/schema-registry/fundamentals/schema-evolution.html#compatibility-types).
    1. Выберите [политику проверки совместимости](../../metadata-hub/concepts/compatibility-check-policy.md) для JSON-схем:
        * `optional-friendly` — основывается на [решении](#optional-parameters-compatibility-solution) с использованием разных контентных моделей для производителя и потребителя. Поддерживает добавление и удаление опциональных параметров с сохранением полной транзитивной совместимости.
        * `Confluent` — основывается на стандартах [Confluent Schema Registry](https://docs.confluent.io/platform/current/schema-registry/fundamentals/schema-evolution.html#compatibility-types) и не обеспечивает полную совместимость при добавлении и удалении опциональных параметров.
    1. Выберите политику проверки совместимости для Protobuf-схем:
        * Confluent — основывается на стандартах [Confluent Schema Registry](https://docs.confluent.io/platform/current/schema-registry/fundamentals/schema-evolution.html#compatibility-types).
        * buf — основывается на стандартах [Buf](https://buf-build-git-psachs-docs-and-search-bufbuild.vercel.app/docs/build/usage/).
1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
