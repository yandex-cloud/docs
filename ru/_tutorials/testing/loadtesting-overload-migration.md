# Миграция результатов нагрузочного тестирования из OverLoad

[Yandex OverLoad](https://overload.yandex.net/) — сервис для мониторинга и анализа нагрузочного тестирования. [Результаты тестов](../../load-testing/concepts/load-test-results.md) из OverLoad можно перенести в {{ load-testing-full-name }}.

Чтобы перенести результаты нагрузочного тестирования:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Получите API-токен OverLoad](#get-overload-token).
1. [Узнайте идентификаторы тестов](#get-test-id).
1. [Перенесите результаты тестирования](#transfer-results).
1. [Проверьте результаты](#check-results).

Если результаты тестов из OverLoad вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% note info %}

Минимальная роль в каталоге, необходимая для переноса результатов нагрузочного тестирования из OverLoad, — `loadtesting.loadTester`. Подробнее см. [описание роли](../../load-testing/security/#roles-list).

{% endnote %}

### Необходимые платные ресурсы {#paid-resources}

На стадии [Preview](../../overview/concepts/launch-stages.md) использование сервиса {{ load-testing-name }} не тарифицируется.

## Получите API-токен OverLoad {#get-overload-token}

1. Аутентифицируйтесь в Yandex OverLoad:
    1. На [странице сервиса](https://overload.yandex.net/) нажмите кнопку **Sign in**.
    1. Выберите учетную запись, с которой вы зарегистрировались в OverLoad: [Яндекс ID](https://yandex.ru/support/id/) или [GitHub](https://docs.github.com/en/account-and-profile).
1. Нажмите на изображение учетной записи и выберите **My api token**. Сохраните API-токен.

## Узнайте идентификаторы тестов {#get-test-id}

1. На вкладке **Public tests** нажмите кнопку **show my tests only**.
1. Сохраните идентификаторы тестов, результаты которых вы хотите перенести в {{ load-testing-name }}.

## Перенесите результаты тестирования {#transfer-results}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.

  1. На панели слева перейдите на вкладку ![tests](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}**.
  1. Справа сверху нажмите ![options](../../_assets/options.svg) и выберите **{{ ui-key.yacloud.load-testing.label_import-tests-from-overload }}**.
  1. В открывшемся окне введите параметры импортирования:
      * **{{ ui-key.yacloud.load-testing.field_overload-token }}** — API-токен OverLoad, полученный ранее.
      * **{{ ui-key.yacloud.load-testing.field_overload-test-id }}** — идентификатор теста в OverLoad, результаты которого вы хотите перенести. Если тестов несколько, нажмите кнопку **{{ ui-key.yacloud.load-testing.button_add-overload-test-id }}** и введите следующий идентификатор. 
  1. Нажмите кнопку **{{ ui-key.yacloud.common.import }}**.

  Для переноса результатов нагрузочного тестирования потребуется некоторое время. 

{% endlist %}

## Проверьте результаты {#check-results}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.

  1. На панели слева перейдите на вкладку ![operations](../../_assets/mdb/operations.svg) **{{ ui-key.yacloud.common.operations-key-value }}**.
  1. Убедитесь, что следующие операции успешно завершены:
      * **Overload Migration**;
      * **Overload Migrate Test** по каждому переносимому тесту.
  1. На панели слева перейдите на вкладку ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}**.
  1. Проверьте, что в списке появились тесты с именем вида `[overload <идентификатор_теста>]<описание_теста>`.
  1. Выберите один из перенесенных тестов и посмотрите результаты. 

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы удалить результаты тестов, перенесенные из OverLoad:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.

  1. На панели слева перейдите на вкладку ![tests](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}**.
  1. Напротив теста, результаты которого вы хотите удалить, нажмите ![options](../../_assets/options.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление.

{% endlist %}
