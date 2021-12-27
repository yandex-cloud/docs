# Приложение на PHP

На этой странице подробно разбирается код тестового приложения, доступного в составе PHP SDK {{ ydb-short-name }}.

{% include [addition.md](example/addition.md) %}

{% include [intro.md](example/step-init-intro.md) %}

Фрагмент кода приложения для инициализации драйвера:

```php
<?php

use YandexCloud\Ydb\Ydb;

$config = [
    // ...
];

$ydb = new Ydb($config);

```

Фрагмент кода приложения для создания сессии:

```php
// obtaining the Table service
$table = $ydb->table();

// obtaining a session
$session = $table->session();
```

{% include [step-error-handling.md](example/step-error-handling.md) %}
