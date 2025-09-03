---
title: Как экспортировать отчёт с результатами тестирования в {{ objstorage-full-name }}
description: Следуя данной инструкции, вы сможете выполнить экспорт отчётов в статичные форматы.
---

# Экспорт отчётов с результатами тестирования

В {{ load-testing-name }} результаты тестирования можно экспортировать в виде файлов статичных форматов (HTML, PDF и CSV) в бакет [{{ objstorage-full-name }}](../../storage/). Сформированный отчёт из бакета доступен по ссылке, а также может быть скачан напрямую. 

## Экспорт отчёта в {{ objstorage-full-name }} {#export-report}

1. В [консоли управления]({{ link-console-main }}) выберите каталог.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
1. На вкладке ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}** выберите необходимый тест.
1. На странице теста в правом верхнем углу нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.load-testing.button_export-report }}**.
1. В диалоге **{{ ui-key.yacloud.load-testing.label_report-export-title }}**:
	- В секции **{{ ui-key.yacloud.load-testing.field_report-export-bucket }}** выберите нужный бакет или создайте новый.
	- В поле **{{ ui-key.yacloud.load-testing.field_report-export-folder }}** введите имя папки, в которую будет сохранен отчёт. Если папки в бакете нет, она будет создана.
	- В секции **{{ ui-key.yacloud.load-testing.field_report-export-format }}** выберите нужный формат.
	- В поле **{{ ui-key.yacloud.load-testing.field_report-export-time-interval }}** при необходимости переключите формат интервала времени (весь или текущий). Текущий интервал доступен только после изменения границ интервала на шкале времени на вкладке **{{ ui-key.yacloud.load-testing.label_test-report }}**.  
1. Нажмите кнопку **{{ ui-key.yacloud.load-testing.button_export-report }}**.

## Выгрузка отчёта из {{ objstorage-full-name }} {#download-report}

1. В [консоли управления]({{ link-console-main }}) выберите каталог.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
1. На вкладке ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}** выберите необходимый тест.
1. На вкладке **{{ ui-key.yacloud.load-testing.label_report-exports-history-title }}** убедитесь, что статус нужной операции экспорта обозначен как **{{ ui-key.yacloud.common.operations.column_value_done }}**.
1. Перейдите на страницу нужной операции экспорта по ссылке в колонке **Путь к файлу**.
1. Чтобы получить ссылку на отчёт, в правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.storage.file.button_generate }}**.
1. Чтобы скачать отчёт, нажмите **{{ ui-key.yacloud.storage.bucket.button_download }}**.
1. При необходимости вы можете настроить доступ к отчётам. Для этого нажмите ![image](../../_assets/console-icons/ellipsis.svg) в правом верхнем углу, выберите группу пользователей и уровень доступа.
