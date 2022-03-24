Чтобы указать на все возможные поддомены любых уровней, вместо первого уровня доменного имени используйте звездочку `*`. В этом случае значение нужно обернуть в кавычки.

> Например, значение `"*.yandexcloud.example"` соответствует доменным именам `foo.yandexcloud.example`, `foo-bar.yandexcloud.example`, `foo.bar.yandexcloud.example`, `foo.bar.baz.yandexcloud.example` и т. п. (но не `yandexcloud.example`).

Заменить звездочкой только часть первого уровня доменного имени, например `*foo.yandexcloud.example`, нельзя.