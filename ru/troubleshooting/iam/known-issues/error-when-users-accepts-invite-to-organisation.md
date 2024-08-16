# Устранение ошибок при работе с приглашениями в облачную организацию


## Описание проблемы {#issue-description}

При попытке принять приглашение в облачную организацию отображается одно следующих из сообщений об ошибке:

* `No valid emails. Or all specified emails have been invited before`;
* `Invitation ‘Invitation.Id(value=*************) has 'ACCEPTED' status. But 'PENDING' status is expected`;
* `Invitation ‘Invitation.Id(value=*************)’ has been expired after YYYY-MM-DDTHH:MM:SSZ`.

## Диагностика и воспроизведение {#issue-diagnostics-and-reproduction}

* Ошибка `No valid emails. Or all specified emails have been invited before;` означает, что при отправке приглашения были неправильно указаны адреса почтовых ящиков, либо пользователи с указанными в приглашении почтовыми ящиками уже являются членами организации;

* Ошибка `Invitation ‘Invitation.Id(value=*************)' has 'ACCEPTED' status. But 'PENDING' status is expected.` означает, что приглашение уже было принято ранее. Повторные попытки принять это приглашение приводят ее возникновению;

* Ошибка `Invitation ‘Invitation.Id(value=*************)’ has been expired after YYYY-MM-DDTHH:MM:SSZ` означает, что срок действия приглашения истек в указанное в тексте ошибки время. 

## Решение {#issue-resolution}

Удалите текущее приглашение, затем создайте новое и отправьте его пользователю повторно.

Подробнее о порядке действий по удалению и созданию нового приглашения мы пишем в разделе [**Пользователи с аккаунтом на Яндексе**](../../../organization/operations/add-account.md#useraccount) в документации сервиса {{ org-full-name }}.

## Если проблема осталась {#if-issue-still-persists}

Если вышеописанные действия не помогли решить проблему, [создайте запрос в техническую поддержку]({{ link-console-support }}). При создании запроса укажите следующую информацию:

1. Описание ошибки, отображаемое после нажатия на кнопку **Сведения об ошибке** после перехода по ссылке из письма на страницу с приглашением.
1. [HAR-файл](../../../support/create-har.md) с сохраненными результатами взаимодействия браузера с серверами {{ yandex-cloud }}.
