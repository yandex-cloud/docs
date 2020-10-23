# Url UDF

## Normalize {#normalize}

**List of functions**

* ```Url::Normalize(String) -> String?```

Normalizes the URL as follows: converts the hostname into lowercase, strips out certain fragments, and so on.
The normalization result only depends on the URL itself. The normalization **DOES NOT** include operations depending on the external data: transformation based on duplicates, mirrors, etc.

Returned value:

* Normalized URL.
* `NULL`, if the passed string argument can't be parsed as a URL.

**Examples**

```sql
SELECT Url::Normalize("hTTp://wWw.yAnDeX.RU/"); -- "http://www.yandex.ru/"
SELECT Url::Normalize("http://ya.ru#foo");      -- "http://ya.ru/"
```

## NormalizeWithDefaultHttpScheme {#normalizewithdefaulthttpscheme}

* ```Url::NormalizeWithDefaultHttpScheme(String?) -> String?```

Performs normalization using the ```NUrlNorm::NormalizeUrl``` method. Unlike `Url::Normalize`, inserts the ```http://``` schema in case there is no schema.

Returned value:

* Normalized URL.
* Source URL, if the normalization has failed.

**Examples**

```sql
SELECT Url::NormalizeWithDefaultHttpScheme("wWw.yAnDeX.RU");    -- "http://www.yandex.ru/"
SELECT Url::NormalizeWithDefaultHttpScheme("http://ya.ru#foo"); -- "http://ya.ru/"
```

## Encode / Decode {#encode}

**List of functions**

* ```Url::Encode(String?) -> String?```
* ```Url::Decode(String?) -> String?```

Encode a UTF-8 string to the urlencoded format (`Url::Encode`) and back (`Url::Decode`).

**Examples**

```sql
SELECT Url::Decode("http://ya.ru/%D1%81%D1%82%D1%80%D0%B0%D0%BD%D0%B8%D1%86%D0%B0"); -- "http://ya.ru/страница"
SELECT Url::Encode("http://ya.ru/страница");                                         -- "http://ya.ru/%D1%81%D1%82%D1%80%D0%B0%D0%BD%D0%B8%D1%86%D0%B0"
```

## Parse {#parse}

**List of functions**

* ```Url::Parse(Parse{Flags:AutoMap}) -> Struct<Frag: String?,Host: String?,ParseError: String?,Pass: String?,Path: String?,Port: String?,Query: String?,Scheme: String?,User: String?>```

**Examples**

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

Get a component of the URL.

**List of functions**

* ```Url::GetScheme(String{Flags:AutoMap}) -> String```

* ```Url::GetHost(String?) -> String?```

* ```Url::GetHostPort(String?) -> String?```

* ```Url::GetSchemeHost(String?) -> String?```

* ```Url::GetSchemeHostPort(String?) -> String?```

* ```Url::GetPort(String?) -> String?```

* ```Url::GetPath(String?) -> String?```

* ```Url::GetCGIParam(String?, String) -> String?```

   The second parameter is the name of the intended CGI parameter.

* ```Url::GetDomain(String?, Uint8) -> String?```

   The second parameter is the required domain level.

* ```Url::GetTLD(String{Flags:AutoMap}) -> String```

* ```Url::IsKnownTLD(String{Flags:AutoMap}) -> Bool```

   Registered on http://www.iana.org/.

* ```Url::IsWellKnownTLD(String{Flags:AutoMap}) -> Bool```

   Belongs to a small whitelist of com, net, org, ru, and others.

* ```Url::GetDomainLevel(String{Flags:AutoMap}) -> Uint64```

   Returns a second-level domain in most cases and a third-level domain for the hostnames like: ***.XXX.YY, where XXX is com, net, org, co, gov, or edu; you can redefine this list using an optional second argument.

* ```Url::GetSignificantDomain(String{Flags:AutoMap}, [List<String>?]) -> String```

   Returns the domain that's most likely owned by an individual or organization; unlike Url::GetSignificantDomain, it uses a special whitelist. Besides the ***.co.uk domains, it can return a third-level domain used by free hosting sites and blogs (e.g., something.livejournal.com).

* ```Url::GetOwner(String{Flags:AutoMap}) -> String```

**Examples**

```sql
SELECT Url::GetScheme("https://ya.ru");           -- "https://"
SELECT Url::GetDomain("http://www.yandex.ru", 2); -- "yandex.ru"
```

## Cut... {#cut}

**List of functions**

* ```Url::CutScheme(String?) -> String?```

    Returns the passed URL without the schema (http://, https://, etc.).

* ```Url::CutWWW(String?) -> String?```

   Returns the passed domain without the "www." prefix (if any).

* ```Url::CutWWW2(String?) -> String?```

   Returns the passed domain without the prefixes like " www.", " www2.", " wwww777." (if any).

* ```Url::CutQueryStringA­ndFragment(String{Flags:AutoMap}) -> String```

   Returns a copy of the passed URL, stripping out all the CGI parameters and fragments ("?foo=bar" and/or "#baz").

**Examples**

```sql
SELECT Url::CutScheme("http://www.yandex.ru"); -- "www.yandex.ru"
SELECT Url::CutWWW("www.yandex.ru");           -- "yandex.ru"
```

#### ...Punycode... {#punycode}

**List of functions**

* ```Url::HostNameToPunycode(String{Flag:AutoMap}) -> String?```
* ```Url::ForceHostNameToPunycode(String{Flag:AutoMap}) -> String```
* ```Url::PunycodeToHostName(String{Flag:AutoMap}) -> String?```
* ```Url::ForcePunycodeToHostName(String{Flag:AutoMap}) -> String```
* ```Url::CanBePunycodeHostName(String{Flag:AutoMap}) -> Bool```

