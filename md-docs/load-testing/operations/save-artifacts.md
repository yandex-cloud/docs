# Сохранение артефактов теста в {{ objstorage-name }}

{% note warning %}

С 1 июля 2026 года сервис {{ load-testing-name }} прекращает работу. Подробнее на странице [Закрытие сервиса Yandex Load Testing](../sunset.md).

{% endnote %}


Настройте сохранение артефактов тестирования в сервис {{ objstorage-full-name }}. Артефакты можно использовать для анализа результатов теста и выявления проблем при тестировании.

{% note info %}

Сохранение артефактов можно настроить только до начала тестирования.

{% endnote %}

## Подготовка инфраструктуры {#infrastructure-prepare}

1. Создайте [бакет](../../storage/concepts/bucket.md) в том же каталоге, в котором находится [агент тестирования](../concepts/agent.md).
1. [Назначьте роль](../../iam/operations/sa/assign-role-for-sa.md) `storage.uploader` сервисному аккаунту, который использовался при [создании агента](create-agent.md) тестирования.

## Запуск теста {#run-test}

Вы можете создать новый тест:

{% list tabs %}

- Консоль управления

  1. [Создайте новый тест](../quickstart.md#run-test), в блоке **{{ ui-key.yacloud.load-testing.section_export }}** включите опцию **{{ ui-key.yacloud.load-testing.field_export-enable }}**.
  1. В поле **{{ ui-key.yacloud.load-testing.field_export-bucket }}** выберите бакет, в который будут сохраняться артефакты теста. 
  1. В поле **{{ ui-key.yacloud.load-testing.field_export-filter-include }}** укажите, какие файлы необходимо сохранять, с помощью маски в формате [glob-выражения](https://ru.wikipedia.org/wiki/Шаблон_поиска).
  1. (Опционально) В поле **{{ ui-key.yacloud.load-testing.field_export-filter-exclude }}** укажите, какие файлы необходимо исключить, с помощью маски в формате glob-выражения.
  1. (Опционально) Включите опцию **{{ ui-key.yacloud.load-testing.field_export-is-archive }}**, чтобы сохранить все файлы в один архив. 

{% endlist %}

Или перезапустить имеющийся тест:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором вы хотите перезапустить тест.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
  1. На панели слева выберите ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}**.
  1. Выберите необходимый тест. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.load-testing.restart }}**.
  1. В блоке **{{ ui-key.yacloud.load-testing.section_export }}** включите опцию **{{ ui-key.yacloud.load-testing.field_export-enable }}**.
  1. В поле **{{ ui-key.yacloud.load-testing.field_export-bucket }}** выберите бакет, в который будут сохраняться артефакты теста. 
  1. В поле **{{ ui-key.yacloud.load-testing.field_export-filter-include }}** укажите, какие файлы необходимо сохранять, с помощью маски в формате [glob-выражения](https://ru.wikipedia.org/wiki/Шаблон_поиска).
  1. (Опционально) В поле **{{ ui-key.yacloud.load-testing.field_export-filter-exclude }}** укажите, какие файлы необходимо исключить, с помощью маски в формате glob-выражения.
  1. (Опционально) Включите опцию **{{ ui-key.yacloud.load-testing.field_export-is-archive }}**, чтобы сохранить все файлы в один архив. 
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.  

{% endlist %}

Артефакты теста хранятся на агенте тестирования в директории `/var/lib/ulta/tests`.