# Url UDF

## Normalize {#normalize}

**Список функций**

* ```Url::Normalize(String) -> String?```


Нормализует URL следующим образом: приводит hostname в нижний регистр, выкидывает фрагмент и т.п.
Результат нормализации зависит только от самого URL. В процессе нормализации **НЕ** выполняются операции, зависящие от внешних данных: приведение по дублям, зеркалам и т.п.

Возвращаемое значение:

* нормализованный URL;
* `NULL`, если переданный строковый аргумент не удалось распарсить как URL.

**Примеры**

```sql
SELECT Url::Normalize("hTTp://wWw.yAnDeX.RU/"); -- "http://www.yandex.ru/"
SELECT Url::Normalize("http://ya.ru#foo");      -- "http://ya.ru/"
```

## NormalizeWithDefaultHttpScheme {#normalizewithdefaulthttpscheme}

* ```Url::NormalizeWithDefaultHttpScheme(String?) -> String?```

Выполняет нормализацию с помощью метода ```NUrlNorm::NormalizeUrl```. В отличие от `Url::Normalize`, подставляет схему ```http://``` в случае, если схемы нет.

Возвращаемое значение:

* нормализованный URL;
* исходный URL, если нормализация не удалась.

**Примеры**

```sql
SELECT Url::NormalizeWithDefaultHttpScheme("wWw.yAnDeX.RU");    -- "http://www.yandex.ru/"
SELECT Url::NormalizeWithDefaultHttpScheme("http://ya.ru#foo"); -- "http://ya.ru/"
```

## Encode / Decode {#encode}

**Список функций**

* ```Url::Encode(String?) -> String?```
* ```Url::Decode(String?) -> String?```

Кодируют UTF-8 строку в urlencoded формат (`Url::Encode`) и обратно (`Url::Decode`).

**Примеры**

```sql
SELECT Url::Decode("http://ya.ru/%D1%81%D1%82%D1%80%D0%B0%D0%BD%D0%B8%D1%86%D0%B0"); -- "http://ya.ru/страница"
SELECT Url::Encode("http://ya.ru/страница");                                         -- "http://ya.ru/%D1%81%D1%82%D1%80%D0%B0%D0%BD%D0%B8%D1%86%D0%B0"
```

## Parse {#parse}

**Список функций**

* ```Url::Parse(Parse{Flags:AutoMap}) -> Struct<Frag: String?,Host: String?,ParseError: String?,Pass: String?,Path: String?,Port: String?,Query: String?,Scheme: String?,User: String?>```

**Примеры**

```sql
SELECT Url::Parse("https://wiki.yandex-team.ru/yql/udf/list/.edit?section=24&goanchor=h-24#foo");
/*
(
  "Frag": "foo",
  "Host": "wiki.yandex-team.ru",
  "ParseError": null,
  "Pass": null,
  "Path": "/yql/udf/list/.edit",
  "Port": null,
  "Query": "section=24&goanchor=h-24",
  "Scheme": "https",
  "User": null
)
*/
```

## Get... {#get}

Получение компонента URL.

**Список функций**

* ```Url::GetScheme(String{Flags:AutoMap}) -> String```
* ```Url::GetHost(String?) -> String?```
* ```Url::GetHostPort(String?) -> String?```
* ```Url::GetSchemeHost(String?) -> String?```
* ```Url::GetSchemeHostPort(String?) -> String?```
* ```Url::GetPort(String?) -> String?```
* ```Url::GetPath(String?) -> String?```
* ```Url::GetCGIParam(String?, String) -> String?```

   Второй параметр — имя нужного CGI параметра.
* ```Url::GetDomain(String?, Uint8) -> String?```

   Второй параметр — необходимый уровень домена.
* ```Url::GetTLD(String{Flags:AutoMap}) -> String```
* ```Url::IsKnownTLD(String{Flags:AutoMap}) -> Bool```

   Зарегистрирован на http://www.iana.org/.
* ```Url::IsWellKnownTLD(String{Flags:AutoMap}) -> Bool```

   Находится в небольшом whitelist из com, net, org, ru и пр.
* ```Url::GetDomainLevel(String{Flags:AutoMap}) -> Uint64```

   Возвращает домен второго уровня в большинстве случаев и домен третьего уровня для хостеймов вида: ***.XXX.YY, где XXX — одно из com, net, org, co, gov, edu; этот список можно переопределить через опциональный второй аргумент.
* ```Url::GetSignificantDomain(String{Flags:AutoMap}, [List<String>?]) -> String```

   Возвращает домен, которым с наибольшей вероятностью владеет отдельный человек или организация; в отличие от Url::GetSignificantDomain работает по специальному whitelist, и помимо доменов из серии ***.co.uk возвращает домен третьего уровня для, например, бесплатных хостингов и блогов, скажем something.livejournal.com.
* ```Url::GetOwner(String{Flags:AutoMap}) -> String```

**Примеры**

```sql
SELECT Url::GetScheme("https://ya.ru");           -- "https://"
SELECT Url::GetDomain("http://www.yandex.ru", 2); -- "yandex.ru"
```

## Cut... {#cut}

**Список функций**

* ```Url::CutScheme(String?) -> String?```

    Возвращает переданный URL уже без схемы (http://, https:// и т.п.).
* ```Url::CutWWW(String?) -> String?```

   Возвращает переданный домен без префикса "www.", если он имелся.
* ```Url::CutWWW2(String?) -> String?```

   Возвращает переданный домен без префикса "www.", "www2.", "wwww777." и тому подобных, если он имелся.
* ```Url::CutQueryStringA­ndFragment(String{Flags:AutoMap}) -> String```

   Возращает копию переданного URL с удаленными всеми CGI параметрами и фрагментами ("?foo=bar" и/или "#baz").

**Примеры**

```sql
SELECT Url::CutScheme("http://www.yandex.ru"); -- "www.yandex.ru"
SELECT Url::CutWWW("www.yandex.ru");           -- "yandex.ru"
```

#### ...Punycode... {#punycode}

**Список функций**

* ```Url::HostNameToPunycode(String{Flag:AutoMap}) -> String?```
* ```Url::ForceHostNameToPunycode(String{Flag:AutoMap}) -> String```
* ```Url::PunycodeToHostName(String{Flag:AutoMap}) -> String?```
* ```Url::ForcePunycodeToHostName(String{Flag:AutoMap}) -> String```
* ```Url::CanBePunycodeHostName(String{Flag:AutoMap}) -> Bool```

