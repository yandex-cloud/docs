В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}** укажите:

* **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cutoff }}**. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда.
* **{{ ui-key.yacloud.serverless-functions.triggers.form.field_size }}**. Допустимые значения от 1 до 1000, значение по умолчанию — 1.

Триггер группирует события не дольше указанного времени ожидания и отправляет их в приемник. Число событий при этом не превышает указанный размер группы.
