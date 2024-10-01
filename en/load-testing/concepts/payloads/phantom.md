# PHANTOM

Type of test data for the Phantom load generator. It allows sending any combinations of HTTP requests based on any methods to the server as is. With this format, you can make complex combinations of requests. It is well suited for generating requests from service logs, but not for manual configuration.

The test data type is specified when [creating a test](../../operations/create-test-bucket.md#create-test).

Data format:

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

Where:

- `byte_length`: Request body length in bytes (not in characters).
- `request_headers`: Request headers.
- `request_body`: Request body.
- `\r\n`: Newline characters required after the request body.

Examples of test data:

- GET requests:

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

- POST requests (binary data):

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

- POST requests (multipart):

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

You can combine any of the above request types in a single file.
There can be any number of empty lines between requests in a file, as long as there is no header specifying the size.

{% endnote %}

For sample generators of test data in this format, see the load testing tool [documentation](https://yandextank.readthedocs.io/en/latest/ammo_generators.html).