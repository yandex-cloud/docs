
# API для получения PDF

#### Метод `GET /api/v1/pdf/<ID шаблона>.pdf` {#get-template}

Получить сгенерированный PDF файл по шаблону, идентификатор которого передается.

#### Метод `POST /api/v1/pdf` {#post-pdf}

Получить сгенерированный PDF файл по шаблону, конфигурация которого прокидывается в теле запроса.

Пример:
```
curl -X "POST" "https://pdf.charts.yandex-team.ru/api/v1/pdf" \
	-H "Authorization: OAuth <TOKEN>" \
	-H "Content-Type: application/json; charset=utf-8" \
	-d "{\
	\"text\": {\
	  \"slides\": [\
	    {\
	      \"type\": \"Title\",\
	      \"props\": {\
	        \"title\": \"Пример с POST ручкой\"\
	      }\
	    },\
	    {\
	      \"type\": \"Comment\",\
	      \"props\": {\
	        \"title\": \"Ключевые моменты\",\
	        \"comments\": [\
	          \"2018-03-27:\",\
	          \"− Начали делать этот сервис\",\
	          \"2018-04-02:\",\
	          \"− Сделали редактор\",\
	          \"2018-05-08:\",\
	          \"− Эта ручка начала работать\"\
	        ]\
	      }\
	    },\
	    {\
	      \"type\": \"OneChart\",\
	      \"props\": {\
	        \"title\": \"Один график\",\
	        \"source\": \"/preview/editor/Examples/test\"\
	      }\
	    }\
	  ]\
	}\
}" > file.pdf
```

### Работа с шаблонами {#template-work}

#### Метод `POST /api/v1/templates/create` {#post-create}

Создать шаблон.

В теле запроса указывается:
```
{
  "text": <Код шаблона (String)>,
  "name": <Имя шаблона (String)>,
  "is_private": <Видимость (Boolean)>
}
```

#### Метод `POST /api/v1/templates/readList` {#post-readList}

Получить список шаблонов.

Этот запрос посылается с пустым телом.

#### Метод `POST /api/v1/templates/read` {#post-read}

Получить шаблон.

В теле запроса указывается:
```
{
  "id": <Идентификатор шаблона (Number)>
}
```

#### Метод `POST /api/v1/templates/removeById` {#post-removeById}

Удалить шаблон по идентификатору.

В теле запроса указывается:
```
{
  "id": <Идентификатор шаблона (Number)>
}
```

#### Метод `POST /api/v1/templates/editText` {#post-editText}

Отредактировать код шаблона.

В теле запроса указывается:
```
{
  "id": <Идентификатор шаблона (Number)>,
  "text": <Код шаблона (String)>
}
```

#### Метод `POST /api/v1/templates/editInfo` {#post-editInfo}

Отредактировать информацию шаблона.

В теле запроса указывается:
```
{
  "id": <Идентификатор шаблона (Number)>,
  "name": <Имя шаблона (String)>,
  "is_private": <Видимость (Boolean)>
}
```
