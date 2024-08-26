# PHANTOM

Тип тестовых данных для генератора нагрузки Phantom. Позволяет передавать HTTP-запросы с любыми методами и в любых сочетаниях, они отсылаются на сервер «как есть». Такой формат позволяет делать сложные комбинации запросов и хорошо подходит для генерации запросов из логов сервиса, но не предназначен для ручного конфигурирования.

Тип тестовых данных указывается при [создании теста](../../operations/create-test-bucket.md#create-test).

Формат данных:

```text
<byte_length_1> <tag_1>\r\n
<request_headers_1>\r\n
<request_body_1>\r\n
<byte_length_2> <tag_2>\r\n
<request_headers_2>\r\n
<request_body_2>\r\n
...
<byte_length_N> <tag_N>\r\n
<request_headers_N>\r\n
<request_body_N>\r\n

```

Где:

- `byte_length` — длина тела запроса в байтах (не в символах);
- `request_headers` — заголовки запроса;
- `request_body` — тело запроса;
- `\r\n` — символы перевода строк, обязательные после тела запроса.

Примеры тестовых данных:

- GET запросы:

	```http
	73 good
	GET / HTTP/1.0
	Host: xxx.tanks.example.com
	User-Agent: xxx (shell 1)

	77 bad
	GET /abra HTTP/1.0
	Host: xxx.tanks.example.com
	User-Agent: xxx (shell 1)

	78 unknown
	GET /ab ra HTTP/1.0
	Host: xxx.tanks.example.com
	User-Agent: xxx (shell 1)
	```

- POST запросы (бинарные данные):

	```http
	904
	POST /upload/2 HTTP/1.0
	Content-Length: 801
	Host: xxxxxxxxx.dev.example.com
	User-Agent: xxx (shell 1)

	^.^........W.j^1^.^.^.²..^^.i.^B.P..-!(.l/Y..V^.      ...L?...S'NR.^^vm...3Gg@s...d'.\^.5N.$NF^,.Z^.aTE^.
	._.[..k#L^ƨ`\RE.J.<.!,.q5.F^՚iΔĬq..^6..P..тH.`..i2
	.".uuzs^^F2...Rh.&.U.^^..J.P@.A......x..lǝy^?.u.p{4..g...m.,..R^.^.^......].^^.^J...p.ifTF0<.s.9V.o5<..%!6ļS.ƐǢ..㱋....C^&.....^.^y...v]^YT.1.#K.ibc...^.26...   ..7.
	b.$...j6.٨f...W.R7.^1.3....K`%.&^..d..{{      l0..^\..^X.g.^.r.(!.^^...4.1.$\ .%.8$(.n&..^^q.,.Q..^.D^.].^.R9.kE.^.$^.I..<..B^..^.h^^C.^E.|....3o^.@..Z.^.s.$[v.

	527
	POST /upload/3 HTTP/1.0
	Content-Length: 424
	Host: xxxxxxxxx.dev.example.com
	User-Agent: xxx (shell 1)

	^.^........QMO.0^.++^zJw.ر^$^.^Ѣ.^V.J....vM.8r&.T+...{@pk%~C.G../z顲^.7....l...-.^W"cR..... .&^?u.U^^.^.....{^.^..8.^.^.I.EĂ.p...'^.3.Tq..@R8....RAiBU..1.Bd*".7+.
	.Ol.j=^.3..n....wp..,Wg.y^.T..~^..
	```

- POST запросы (multipart):

	```http
	533
	POST /updateShopStatus? HTTP/1.0
	User-Agent: xxx/1.2.3
	Host: xxxxxxxxx.dev.example.com
	Keep-Alive: 300
	Content-Type: multipart/form-data; boundary=AGHTUNG
	Content-Length:334
	Connection: Close

	--AGHTUNG
	Content-Disposition: form-data; name="host"

	load-test-shop-updatestatus.ru
	--AGHTUNG
	Content-Disposition: form-data; name="user_id"

	1
	--AGHTUNG
	Content-Disposition: form-data; name="wsw-fields"

	<wsw-fields><wsw-field name="moderate-code"><wsw-value>disable</wsw-value></wsw-field></wsw-fields>
	--AGHTUNG--
	```

{% note info %}

В одном файле можно комбинировать запросы любых перечисленных выше типов.
Между запросами в файле допустимо любое число пустых строк до тех пор, пока не встретится заголовок с размером.

{% endnote %}

Примеры генераторов тестовых данных в этом формате см. в [документации](https://yandextank.readthedocs.io/en/latest/ammo_generators.html) инструмента для нагрузочного тестирования.