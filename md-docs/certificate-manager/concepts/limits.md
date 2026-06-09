# Квоты и лимиты в {{ certificate-manager-name }}

В сервисе {{ certificate-manager-name }} действуют следующие ограничения:

* [_Квоты_]({{ link-console-quotas }}) — организационные ограничения, которые можно изменить по запросу в техническую поддержку.
* _Лимиты_ — технические ограничения, обусловленные особенностями архитектуры {{ yandex-cloud }}. Изменить лимиты невозможно.

Если вам необходимо больше ресурсов, увеличьте квоты одним из способов:

* [Сформируйте запрос на увеличение]({{ link-console-quotas }}).
* Обратитесь в [техническую поддержку]({{ link-console-support }}) и расскажите, какие потребляемые квоты нужно увеличить и на сколько.

Чтобы ваш запрос был рассмотрен, у вас должна быть [роль](../../iam/roles-reference.md#quota-manager-requestoperator) `quota-manager.requestOperator` или выше (`editor` или `admin`).

Управлять квотами позволяет сервис [{{ quota-manager-name }}](../../quota-manager/quickstart.md).

#### Квоты {#certificate-manager-quotas}

#|
|| Вид ограничения | Значение ||
|| Количество сертификатов в облаке
`certificate-manager.certificates.count` | 20 ||
|| Количество доменов в облаке
`certificate-manager.domains.count` | 10 ||
|#

#### Лимиты для сертификатов от Let's Encrypt® {#certificate-manager-limits}

Вид ограничения | Значение
----- | -----
Количество доменов в одном сертификате | 100
Количество сертификатов на один домен | 50 в неделю
Количество сертификатов на один набор доменов | 5 в неделю

#### См. также {#certificate-manager-see-also}

- [Документация Let's Encrypt. Ограничения](https://letsencrypt.org/ru/docs/rate-limits/)