# Синтез речи (TTS)

#### Как озвучивать длинные тексты? {#long-texts}

Чтобы озвучить большой текст, разбейте его на части любым удобным для вас способом.
[Лимит](../../{{ speechkit-slug }}/concepts/limits.md#speechkit-limits) на размер запроса синтеза речи составляет 5000 символов.

#### Как настроить ударения и произношение? {#tts-stress-pronunciation}

Чтобы скорректировать произношение отдельных слов и текста в целом, воспользуйтесь разметкой [SSML](../../{{ speechkit-slug }}/tts/markup/ssml.md) или [TTS](../../{{ speechkit-slug }}/tts/markup/tts-markup.md).

#### Ошибка unsupported content-type: application/json {#content-type}

Ошибка `unsupported content-type: application/json` возникает, если вы устанавливаете неподдерживаемый тип передаваемого текста `application/json` в стандартном заголовке `content-type`.

Чтобы выполнить синтез речи, используйте один из поддерживаемых типов:
* `application/x-www-form-urlencoded` 
* `multipart/form-data`

Описание метода API см. в [документации](../../{{ speechkit-slug }}/tts/request.md). 

#### В озвученном тексте меняются голоса {#voices-change}

Если в озвученном тексте меняются голоса, проверьте, какой голос указан в запросе. Каждому голосу соответствует свой основной язык. Чтобы указать голос, который подходит для вашего текста, воспользуйтесь [списком доступных голосов](../../{{ speechkit-slug }}/tts/voices.md).

#### Ошибка SSML: Error during parsing XML {#ssml-err}

Убедитесь, что вы не используете SSML в параметре `text`. Если вы задаете текст в формате SSML, используйте для этого [соответствующий параметр](../../{{ speechkit-slug }}/tts/request.md#body_params).

#### Как добавить паузу в тексте? {#add-pause}

Чтобы поставить паузу в тексте, добавьте sil-тег. В скобках укажите длительность паузы в миллисекундах. Пауза появится в тех местах, где вы поставите тег. Например: `Начало sil<[3000]> продолжение через 3 секунды`.

#### Запрос curl не работает в Windows PowerShell {#curl-powershell}

В Windows PowerShell `curl` по умолчанию является псевдонимом системного вызова [Invoke-WebRequest](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest). Чтобы повторить [пример из документации](../../{{ speechkit-slug }}/tts/request.md#ssml), воспользуйтесь кодом:

`Invoke-WebRequest -Method 'Post' -H @{'Authorization' = 'Bearer ваш_токен'} -Body "lang=ru-RU&folderId= ваш_id_каталога&ssml=$([System.Net.WebUtility]::UrlEncode($(Get-Content -Path C:\curl\new.xml)))" -OutFile C:\curl\output.ogg "https://tts.{{ api-host }}/speech/v1/tts:synthesize"`

Больше советов для пользователей MS Windows см. в разделе [{#T}](../../overview/concepts/console-syntax-guide.md).

#### Из чего складывается стоимость использования? {#tts-cost}

Примеры расчета стоимости использования, правила тарификации и актуальные цены смотрите в [документации](../../{{ speechkit-slug }}/pricing.md).
