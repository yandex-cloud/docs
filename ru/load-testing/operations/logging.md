# Передача логов теста в {{ cloud-logging-name }}

Настройте передачу логов тестирования в сервис [{{ cloud-logging-full-name }}](../../logging/). Логи можно использовать для анализа результатов теста и выявления проблем при тестировании. 

Ресурсы, которые передаются в [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-name }}:
* `loadtesting.log.tank` — общие логи запуска [Яндекс Танка](https://yandextank.readthedocs.io/en/latest/).
* `loadtesting.log.phantom` — логи генератора нагрузки [Phantom](../concepts/load-generator.md#phantom), если он был использован в тесте.
* `loadtesting.log.pandora` — логи генератора нагрузки [Pandora](../concepts/load-generator.md#pandora), если он был использован в тесте.

Чтобы настроить передачу логов в {{ cloud-logging-name }}:
1. [Создайте лог-группу](../../logging/operations/create-group.md) в том же каталоге, в котором находится [агент тестирования](../concepts/agent.md).
1. [Назначьте роль](../../logging/operations/access-rights.md#add-access) `{{ roles-logging-writer }}` на лог-группу сервисному аккаунту, который использовался при [создании агента](create-agent.md) тестирования.
1. [Создайте новый тест](../quickstart.md#run-test), в поле **{{ ui-key.yacloud.load-testing.field_logging-group }}** укажите созданную лог-группу.

    Или перезапустите имеющийся тест:

    {% list tabs %}

    - Консоль управления

      1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
      1. На панели слева выберите ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}**.
      1. Выберите необходимый тест. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.load-testing.restart }}**.
      1. В поле **{{ ui-key.yacloud.load-testing.field_logging-group }}** выберите созданную лог-группу.
      1. В блоке **{{ ui-key.yacloud.load-testing.test-data-section }}** загрузите файл с [тестовыми данными](../concepts/payload.md).
      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**. 

    {% endlist %}

    После завершения теста агент передаст необходимые логи в указанную лог-группу. Идентификатор логов в лог-группе будет соответствовать идентификатору теста.

{% note info %}

Автоматическую передачу логов можно настроить только до начала тестирования. Логи уже проведенных тестов можно [передать в лог-группу](../../logging/operations/write-logs.md) вручную.

Логи теста хранятся на агенте тестирования в директории `/var/lib/tankapi/tests/<дата и время запуска теста>`.

{% endnote %}