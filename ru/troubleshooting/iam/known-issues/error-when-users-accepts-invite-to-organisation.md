# Устранение ошибок при работе с приглашениями в облачную организацию

## Описание проблемы {#issue-descriprtion}
При попытке принять приглашение в облачную организацию отображается одно следующих из сообщений об ошибке:
- `No valid emails. Or all specified emails have been invited before`;
- `Invitation ‘Invitation.Id(value=xxxxxxxxxxxxx) has 'ACCEPTED' status. But 'PENDING' status is expected`;
- `Invitation ‘Invitation.Id(value=xxxxxxxxxxxxx)’ has been expired after YYYY-MM-DDTHH:MM:SSZ`.

## Диагностика и воспроизведение {#diagnosis-and-reproduction}
* Ошибка `No valid emails. Or all specified emails have been invited before;` означает, что при отправке приглашения были неправильно указаны адреса почтовых ящиков, либо пользователи с указанными в приглашении почтовыми ящиками уже являются членами организации;

* Ошибка `Invitation ‘Invitation.Id(value=xxxxxxxxxxxxx)' has 'ACCEPTED' status. But 'PENDING' status is expected.` означает, что приглашение уже было принято ранее. Повторные попытки принять это приглашение приводят к данной ошибке;

* Ошибка `Invitation ‘Invitation.Id(value=xxxxxxxxxxxxx)’ has been expired after YYYY-MM-DDTHH:MM:SSZ` означает, что срок действия приглашения истек в указанное в тексте ошибки время. 

## Решение {#issue-resolution}
Попробуйте удалить текущее приглашение, затем создать новое и отправить его пользователю повторно.
Подробнее о порядке действий по удалению и созданию нового приглашения мы пишем в разделе [«Пригласить пользователя Яндекса»](../../../organization/operations/add-account.md#add-or-invite-user-account) в документации сервиса Yandex Cloud Organization.

## Если проблема осталась {#if-issue-still-persists}
Если вышеописанные действия не помогли решить проблему, [создайте запрос в техническую поддержку](https://console.cloud.yandex.ru/support?section=contact).
В запросе укажите следующую информацию:
1. Описание ошибки, отображаемое после нажатия на кнопку «Сведения об ошибке» после перехода по ссылке из письма на страницу с приглашением;
2. [HAR-файл](../../../support/create-har.md) с сохраненными результатами взаимодействия браузера с серверами Yandex Cloud.
