# Подключение голосового агента к телефонии Asterisk

Голосовой агент {{ ai-studio-name }} умеет разговаривать с абонентом по телефону. Из этой инструкции вы узнаете, как подключить агента к собственной телефонии.

Абонент звонит на внутренний номер, попадает на агента и говорит с ним голосом. Агент отвечает голосом и опирается на промпт и поисковый индекс, которые вы задали при его создании.

Инструкция подойдет, если вы решаете одну из задач:

* автоматизировать первую линию поддержки;
* принимать типовые обращения без оператора;
* отвечать на вопросы по внутренней базе знаний.

{% note info %}

Инструкция описывает связку **FreePBX 16** и **Asterisk 16**. Настройку номера вы выполняете в интерфейсе FreePBX, а медиаканал создаете средствами Asterisk. На других версиях и на Asterisk без FreePBX шаги будут отличаться.

{% endnote %}

## Как устроено решение {#how-it-works}

Realtime API работает по протоколу WebSocket и принимает аудио в формате PCM. Asterisk передает звук по протоколу RTP. Напрямую эти протоколы не совместимы. Поэтому между ними нужен посредник — программный мост.

Мост решает три задачи:

* принимает звук абонента из Asterisk;
* передает звук в Realtime API и получает ответ агента;
* возвращает ответ агента обратно в разговор.

Звонок проходит по такому маршруту:

1. Абонент набирает внутренний номер.
2. Диалплан передает вызов в приложение ARI.
3. Мост создает медиаканал External Media и получает звук абонента.
4. Мост отправляет звук в Realtime API.
5. Мост получает ответ агента и возвращает его в разговор.

Мост работает на том же сервере, что и Asterisk. Звук между Asterisk и мостом идет через локальный интерфейс `127.0.0.1`. Наружу мост открывает только исходящее соединение с {{ ai-studio-name }}.

{% note info %}

Механизм AudioSocket подключить проще, но он доступен только с Asterisk 18. В Asterisk 16 используйте механизм ARI External Media. Он доступен с версии 16.6.

{% endnote %}

## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру {{ yandex-cloud }}:

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) в вашем каталоге.
2. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роль `ai.models.user`.
3. [Создайте API-ключ](../../iam/operations/authentication/manage-api-keys.md) с областью действия `yc.ai.foundationModels.execute`.
4. [Создайте голосового агента](../operations/agents/create-voice-agent.md) и сохраните его идентификатор.

Подготовьте сервер телефонии:

* FreePBX 16 и Asterisk версии 16.6 или выше.
* Доступ по SSH с правами суперпользователя.
* Свободный внутренний номер для агента. Далее в инструкции — номер `4502`.
* Городской номер и входящий транк, если вы принимаете звонки извне.

Проверьте версию Asterisk:

```bash
asterisk -V
```

Узнайте кодек, в котором работают ваши телефоны. Выполните команду во время звонка:

```bash
asterisk -rx "core show channel <идентификатор_канала>" | grep -i format
```

Инструкция описывает кодек G.711 μ-law (`ulaw`). Для кодека G.711 A-law замените в коде моста функции `ulaw2lin` и `lin2ulaw` на `alaw2lin` и `lin2alaw`.

## Настройте ARI в Asterisk {#configure-ari}

Интерфейс ARI работает поверх HTTP-сервера Asterisk. Сначала включите сервер, затем создайте пользователя.

1. Проверьте состояние HTTP-сервера:

    ```bash
    asterisk -rx "http show status"
    ```

    Сервер должен слушать адрес `127.0.0.1:8088`.

1. Если сервер выключен, добавьте в файл `/etc/asterisk/http_custom.conf` строки:

    ```ini
    [general]
    enabled=yes
    bindaddr=127.0.0.1
    bindport=8088
    ```

1. Создайте пользователя ARI в файле `/etc/asterisk/ari_additional_custom.conf`:

    ```ini
    [yabridge]
    type = user
    read_only = no
    password = <пароль>
    ```

1. Перезагрузите модуль ARI:

    ```bash
    asterisk -rx "module reload res_ari.so"
    ```

1. Убедитесь, что пользователь появился в списке:

    ```bash
    asterisk -rx "ari show users"
    ```

## Настройте диалплан {#configure-dialplan}

Диалплан передает вызов в приложение ARI. Имя приложения — `voice-bot`.

1. Добавьте контекст в файл `/etc/asterisk/extensions_custom.conf`:

    ```ini
    [yandex-agent]
    exten => s,1,NoOp(Voice agent)
     same => n,Stasis(voice-bot)
     same => n,Hangup()
    ```

1. Примените конфигурацию:

    ```bash
    fwconsole reload
    ```

## Сделайте агента внутренним номером {#create-extension}

Агент должен стать полноценным внутренним номером. Тогда абонент дозвонится до него двумя способами:

* наберет номер агента с внутреннего телефона;
* наберет номер агента как добавочный после звонка на городской номер.

Далее в инструкции номер агента — `4502`.

{% note warning %}

Не используйте для этого раздел **Misc Applications**. Сервисные коды из него не набираются в голосовом меню. Абонент с городского номера не сможет до них дозвониться.

{% endnote %}

### Создайте назначение {#custom-destination}

Назначение связывает интерфейс FreePBX с контекстом диалплана.

1. Перейдите в раздел **Admin** → **Custom Destinations** и нажмите **Add**.
1. В поле **Target** укажите `yandex-agent,s,1`.
1. В поле **Description** укажите `Voice agent`.
1. В поле **Return** выберите **No**.
1. Нажмите **Submit**, затем **Apply Config**.

### Создайте номер агента {#custom-extension}

Обычный SIP-номер здесь не подходит: к агенту не подключается телефон. Создайте пользовательский номер (Custom Extension). Он не требует регистрации устройства и сразу передает вызов в диалплан.

1. Перейдите в раздел **Applications** → **Extensions**.
1. Нажмите **Add Extension** → **Add New Custom Extension**.
1. В поле **User Extension** укажите номер `4502`.
1. В поле **Display Name** укажите `Voice agent`.
1. Откройте вкладку **Advanced**.
1. В поле **dial** укажите:

    ```text
    Local/s@yandex-agent
    ```

1. Нажмите **Submit**, затем **Apply Config**.

Проверьте, что номер попал в диалплан:

```bash
asterisk -rx "dialplan show 4502@from-internal"
```

Теперь наберите `4502` с любого внутреннего телефона. Вызов дойдет до агента.

## Настройте звонок с городского номера {#inbound-route}

Абонент звонит на городской номер, попадает в голосовое меню и набирает добавочный `4502`.

### Разрешите набор добавочного в голосовом меню {#ivr-direct-dial}

1. Перейдите в раздел **Applications** → **IVR**.
1. Откройте нужное голосовое меню или создайте новое.
1. В поле **Direct Dial** выберите **Extensions**.
1. Нажмите **Submit**, затем **Apply Config**.

Параметр **Direct Dial** разрешает абоненту набирать внутренние номера прямо в меню. Номер `4502` — обычный внутренний номер, поэтому меню его примет.

### Направьте городской номер в голосовое меню {#configure-inbound}

1. Перейдите в раздел **Connectivity** → **Inbound Routes**.
1. Откройте маршрут для вашего городского номера или создайте новый.
1. В поле **DID Number** укажите городской номер, например `88001234567`.
1. В поле **Set Destination** выберите **IVR** и нужное голосовое меню.
1. Нажмите **Submit**, затем **Apply Config**.

Чтобы соединять абонента с агентом сразу, без меню, укажите в поле **Set Destination** значение **Custom Destinations** → **Voice agent**.

### Проверьте маршрут {#check-route}

1. Позвоните на городской номер с мобильного телефона.
1. Дождитесь приветствия голосового меню.
1. Наберите `4502`.
1. Произнесите фразу и дождитесь ответа агента.

{% note info %}

Кодек входящего транка определяет формат медиаканала. Инструкция описывает кодек G.711 μ-law (`ulaw`). Проверьте кодеки транка в разделе **Connectivity** → **Trunks** на вкладке **Advanced**.

{% endnote %}

## Установите Python {#install-python}

Мосту нужен Python версии 3.8 или выше. Не заменяйте системный Python: на нем работает FreePBX.

1. Проверьте версию Python:

    ```bash
    python3 --version
    ```

1. Установите модуль для виртуальных окружений:

    * Debian или Ubuntu:

        ```bash
        apt-get update && apt-get install -y python3-venv
        ```

    * RHEL, CentOS или Rocky Linux:

        ```bash
        yum install -y python3-venv
        ```

1. Если версия Python ниже 3.8, установите новую версию отдельно:

    ```bash
    apt-get install -y build-essential zlib1g-dev libffi-dev libssl-dev wget
    cd /usr/src
    wget https://www.python.org/ftp/python/3.11.9/Python-3.11.9.tgz
    tar xzf Python-3.11.9.tgz && cd Python-3.11.9
    ./configure --prefix=/opt/python311
    make -j"$(nproc)" && make altinstall
    ```

    Команда `make altinstall` не затрагивает системный Python. Далее используйте интерпретатор `/opt/python311/bin/python3.11`.

## Установите мост {#install-bridge}

Мост работает как служба systemd от отдельного пользователя. Суперпользователь нужен только для установки.

1. Создайте пользователя службы:

    ```bash
    useradd --system --no-create-home --shell /usr/sbin/nologin yabridge
    ```

1. Создайте каталог и виртуальное окружение Python:

    ```bash
    mkdir -p /opt/yabridge
    python3 -m venv /opt/yabridge/venv
    /opt/yabridge/venv/bin/pip install aiohttp
    ```

    Если вы установили Python отдельно, создайте окружение его интерпретатором:

    ```bash
    /opt/python311/bin/python3.11 -m venv /opt/yabridge/venv
    ```

1. Сохраните [код моста](#bridge-code) в файл `/opt/yabridge/bridge.py`.

1. Создайте файл `/opt/yabridge/env` с параметрами подключения:

    ```bash
    ARI_USER=yabridge
    ARI_PASS=<пароль_пользователя_ARI>
    ARI_APP=voice-bot
    YC_FOLDER_ID=<идентификатор_каталога>
    YC_API_KEY=<API-ключ>
    YC_PROMPT_ID=<идентификатор_агента>
    ```

1. Ограничьте доступ к файлу с ключом:

    ```bash
    chmod 600 /opt/yabridge/env
    chown -R yabridge:yabridge /opt/yabridge
    ```

1. Создайте файл службы `/etc/systemd/system/yabridge.service`:

    ```ini
    [Unit]
    Description=Voice agent bridge
    After=network-online.target

    [Service]
    User=yabridge
    EnvironmentFile=/opt/yabridge/env
    ExecStart=/opt/yabridge/venv/bin/python /opt/yabridge/bridge.py
    Restart=always
    RestartSec=2

    [Install]
    WantedBy=multi-user.target
    ```

1. Запустите службу:

    ```bash
    systemctl daemon-reload
    systemctl enable --now yabridge
    ```

1. Убедитесь, что мост подключился к ARI:

    ```bash
    journalctl -u yabridge -n 20
    ```

    В журнале появится строка `ARI events connected, app=voice-bot`.

{% note warning %}

Приложение ARI регистрируется в Asterisk только на время работы моста. Если служба остановлена, вызов завершится с ошибкой `Stasis app 'voice-bot' not registered`.

{% endnote %}

## Код моста {#bridge-code}

Мост преобразует звук в обоих направлениях:

* от Asterisk — из `ulaw` 8 кГц в PCM 16 кГц;
* к Asterisk — из PCM 16 кГц в `ulaw` 8 кГц.

Частота 16 кГц повышает качество распознавания. Кодек `ulaw` совпадает с кодеком телефона, поэтому Asterisk передает звук абоненту без потерь.

Мост отправляет ответный поток на порт из переменной `UNICASTRTP_LOCAL_PORT`. Asterisk принимает RTP только на этом порту.

```python
import asyncio
import audioop
import base64
import json
import logging
import os
import random
import socket
import struct

import aiohttp

ARI_BASE = os.environ.get("ARI_BASE", "http://127.0.0.1:8088/ari")
ARI_APP = os.environ.get("ARI_APP", "voice-bot")
ARI_USER = os.environ["ARI_USER"]
ARI_PASS = os.environ["ARI_PASS"]

YC_FOLDER_ID = os.environ["YC_FOLDER_ID"]
YC_API_KEY = os.environ["YC_API_KEY"]
YC_PROMPT_ID = os.environ["YC_PROMPT_ID"]
YC_MODEL = os.environ.get("YC_MODEL", "speech-realtime-260528/latest")
PROMPT_VARIABLES = {}

WSS_URL = (
    "wss://ai.api.cloud.yandex.net/v1/realtime"
    f"?model=gpt://{YC_FOLDER_ID}/{YC_MODEL}"
)
YC_HEADERS = {"Authorization": f"Api-Key {YC_API_KEY}"}

YC_RATE = 16000
AST_RATE = 8000
FRAME_MS = 20
SAMPLES = AST_RATE * FRAME_MS // 1000
RTP_HDR = 12

logging.basicConfig(level=logging.INFO)
log = logging.getLogger("bridge")


class RtpSender:
    def __init__(self, pt):
        self.pt = pt & 0x7F
        self.seq = random.randint(0, 0xFFFF)
        self.ts = random.randint(0, 0xFFFFFFFF)
        self.ssrc = random.randint(0, 0xFFFFFFFF)
        self.first = True

    def packet(self, payload):
        b1 = self.pt | (0x80 if self.first else 0x00)
        self.first = False
        hdr = struct.pack("!BBHII", 0x80, b1, self.seq & 0xFFFF,
                          self.ts & 0xFFFFFFFF, self.ssrc)
        self.seq = (self.seq + 1) & 0xFFFF
        self.ts = (self.ts + SAMPLES) & 0xFFFFFFFF
        return hdr + payload


class RtpProtocol(asyncio.DatagramProtocol):
    def __init__(self):
        self.queue = asyncio.Queue()
        self.transport = None

    def connection_made(self, transport):
        self.transport = transport

    def datagram_received(self, data, addr):
        self.queue.put_nowait(data)


class Call:
    def __init__(self, ari, caller_id):
        self.ari = ari
        self.caller_id = caller_id
        self.em_id = f"em-{caller_id}"
        self.bridge_id = None
        self.proto = None
        self.transport = None
        self.dest = None
        self.ws = None
        self.outbuf = bytearray()
        self.epoch = 0
        self.cur = None
        self.sender = None
        self.audio_pt = None
        self.up = None
        self.down = None
        self.tasks = []

    async def start(self):
        loop = asyncio.get_running_loop()
        await self.ari.rest("POST", f"/channels/{self.caller_id}/answer")

        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        sock.bind(("127.0.0.1", 0))
        port = sock.getsockname()[1]
        self.transport, self.proto = await loop.create_datagram_endpoint(
            RtpProtocol, sock=sock)

        bridge = await self.ari.rest("POST", "/bridges", type="mixing")
        self.bridge_id = bridge["id"]
        await self.ari.rest("POST", f"/bridges/{self.bridge_id}/addChannel",
                            channel=self.caller_id)

        await self.ari.rest(
            "POST", "/channels/externalMedia",
            app=ARI_APP, channelId=self.em_id,
            external_host=f"127.0.0.1:{port}",
            format="ulaw", transport="udp",
            encapsulation="rtp", connection_type="client", direction="both")

        addr = await self.ari.rest("GET", f"/channels/{self.em_id}/variable",
                                   variable="UNICASTRTP_LOCAL_ADDRESS")
        rtp_port = await self.ari.rest("GET", f"/channels/{self.em_id}/variable",
                                       variable="UNICASTRTP_LOCAL_PORT")
        self.dest = (addr["value"], int(rtp_port["value"]))

        self.ws = await self.ari.http.ws_connect(
            WSS_URL, headers=YC_HEADERS, heartbeat=20.0)
        await self.ws.send_json({
            "type": "session.update",
            "session": {
                "prompt": {"id": YC_PROMPT_ID, "variables": PROMPT_VARIABLES},
                "audio": {
                    "input": {"format": {"type": "audio/pcm", "rate": YC_RATE}},
                    "output": {"format": {"type": "audio/pcm", "rate": YC_RATE}},
                },
            },
        })

        self.tasks = [
            asyncio.create_task(self.to_yandex()),
            asyncio.create_task(self.from_yandex()),
            asyncio.create_task(self.to_asterisk()),
        ]
        log.info("call %s started", self.caller_id)

    async def attach(self):
        await self.ari.rest("POST", f"/bridges/{self.bridge_id}/addChannel",
                            channel=self.em_id)

    async def to_yandex(self):
        try:
            while True:
                data = await self.proto.queue.get()
                if len(data) < RTP_HDR:
                    continue
                pt = data[1] & 0x7F
                if self.audio_pt is None:
                    self.audio_pt = pt
                    self.sender = RtpSender(pt)
                if pt != self.audio_pt:
                    continue
                pcm8 = audioop.ulaw2lin(data[RTP_HDR:], 2)
                pcm16, self.up = audioop.ratecv(
                    pcm8, 2, 1, AST_RATE, YC_RATE, self.up)
                await self.ws.send_json({
                    "type": "input_audio_buffer.append",
                    "audio": base64.b64encode(pcm16).decode(),
                })
        except (asyncio.CancelledError, aiohttp.ClientError):
            pass

    async def from_yandex(self):
        try:
            async for msg in self.ws:
                if msg.type != aiohttp.WSMsgType.TEXT:
                    continue
                event = json.loads(msg.data)
                etype = event.get("type")
                if etype == "input_audio_buffer.speech_started":
                    self.epoch += 1
                    self.cur = None
                    self.outbuf.clear()
                elif etype == "response.created":
                    self.cur = self.epoch
                elif etype == "response.output_audio.delta":
                    if self.cur == self.epoch:
                        pcm16 = base64.b64decode(event["delta"])
                        pcm8, self.down = audioop.ratecv(
                            pcm16, 2, 1, YC_RATE, AST_RATE, self.down)
                        self.outbuf.extend(audioop.lin2ulaw(pcm8, 2))
                elif etype == "conversation.item.input_audio_transcription.completed":
                    log.info("user: %s", event.get("transcript", ""))
                elif etype == "error":
                    log.error("error: %s", event)
        except (asyncio.CancelledError, aiohttp.ClientError):
            pass

    async def to_asterisk(self):
        loop = asyncio.get_running_loop()
        silence = b"\xff" * SAMPLES
        next_t = loop.time()
        try:
            while True:
                if self.dest and self.sender:
                    if len(self.outbuf) >= SAMPLES:
                        frame = bytes(self.outbuf[:SAMPLES])
                        del self.outbuf[:SAMPLES]
                    else:
                        frame = silence
                    self.transport.sendto(self.sender.packet(frame), self.dest)
                next_t += FRAME_MS / 1000
                await asyncio.sleep(max(0, next_t - loop.time()))
        except asyncio.CancelledError:
            pass

    async def close(self):
        for task in self.tasks:
            task.cancel()
        if self.ws and not self.ws.closed:
            await self.ws.close()
        if self.transport:
            self.transport.close()
        await self.ari.rest("DELETE", f"/channels/{self.em_id}")
        if self.bridge_id:
            await self.ari.rest("DELETE", f"/bridges/{self.bridge_id}")


class Ari:
    def __init__(self, http):
        self.http = http
        self.auth = aiohttp.BasicAuth(ARI_USER, ARI_PASS)
        self.calls = {}
        self.media = {}

    async def rest(self, method, path, **params):
        url = f"{ARI_BASE}{path}"
        async with self.http.request(
                method, url, params=params, auth=self.auth) as resp:
            if resp.status >= 400:
                log.error("ARI %s %s: %s", method, path, resp.status)
                return None
            if resp.content_type == "application/json":
                return await resp.json()
            return await resp.text()

    async def run(self):
        url = (ARI_BASE.replace("http", "ws", 1)
               + f"/events?app={ARI_APP}&subscribeAll=true"
               + f"&api_key={ARI_USER}:{ARI_PASS}")
        async with self.http.ws_connect(url, heartbeat=30.0) as ws:
            log.info("ARI events connected, app=%s", ARI_APP)
            async for msg in ws:
                if msg.type == aiohttp.WSMsgType.TEXT:
                    await self.on_event(json.loads(msg.data))

    async def on_event(self, event):
        etype = event.get("type")
        if etype == "StasisStart":
            cid = event["channel"]["id"]
            if cid in self.media:
                await self.media[cid].attach()
                return
            call = Call(self, cid)
            self.calls[cid] = call
            self.media[call.em_id] = call
            await call.start()
        elif etype in ("StasisEnd", "ChannelDestroyed"):
            cid = event.get("channel", {}).get("id")
            call = self.calls.pop(cid, None)
            if call:
                self.media.pop(call.em_id, None)
                await call.close()


async def main():
    async with aiohttp.ClientSession() as http:
        ari = Ari(http)
        while True:
            try:
                await ari.run()
            except Exception as err:
                log.warning("reconnect: %s", err)
            await asyncio.sleep(3)


asyncio.run(main())
```

{% note tip %}

Если ваш агент использует переменные промпта, задайте их в словаре `PROMPT_VARIABLES`. Иначе Realtime API вернет ошибку `Value for the variable ... is not provided`.

{% endnote %}

## Проверьте работу агента {#test}

1. Откройте журнал моста:

    ```bash
    journalctl -u yabridge -f
    ```

1. Позвоните на номер `4502` с внутреннего телефона.
1. Произнесите фразу и дождитесь ответа агента.

Затем проверьте звонок извне:

1. Позвоните на городской номер.
1. Наберите добавочный `4502` в голосовом меню.
1. Произнесите фразу и дождитесь ответа агента.

В журнале появятся строки:

```text
call 1783415957.1449 started
user: привет
```

Строка `user:` содержит расшифровку вашей реплики. Ответ агента вы услышите в трубке.

## Возможные проблемы {#troubleshooting}

### Вызов сбрасывается сразу {#call-drops}

В журнале Asterisk появляется ошибка `Stasis app 'voice-bot' not registered`.

Мост не подключен к ARI. Проверьте состояние службы и список приложений:

```bash
systemctl status yabridge
asterisk -rx "ari show apps"
```

### Агент не слышит абонента {#no-recognition}

В журнале моста нет строк `user:`.

Проверьте кодек медиаканала во время звонка:

```bash
asterisk -rx "core show channels concise" | grep UnicastRTP
```

Скопируйте идентификатор канала и выполните:

```bash
asterisk -rx "core show channel <идентификатор_канала>" | grep -i format
```

Если Asterisk согласовал кодек `alaw`, замените в коде моста функции преобразования.

### Абонент не слышит агента {#no-audio}

В журнале моста есть строки `user:`, но в трубке тишина.

Мост отправляет звук не на тот порт. Убедитесь, что мост читает переменную `UNICASTRTP_LOCAL_PORT`. Asterisk принимает RTP только на этом порту.

### Realtime API возвращает ошибку о переменной {#prompt-variable}

Агент использует шаблон промпта с переменными. Задайте значения в словаре `PROMPT_VARIABLES`.

## Сервисные команды {#service-commands}

Команды помогут обслуживать решение и находить причину сбоя.

### Управление службой моста {#service-bridge}

| Команда | Назначение |
| --- | --- |
| `systemctl status yabridge` | Проверить состояние службы. |
| `systemctl restart yabridge` | Перезапустить мост после изменения кода или настроек. |
| `systemctl stop yabridge` | Остановить мост. Звонки на номер перестанут доходить до агента. |
| `systemctl enable yabridge` | Включить автозапуск моста при загрузке сервера. |
| `systemctl daemon-reload` | Перечитать файл службы после его правки. |

### Журналы {#service-logs}

| Команда | Назначение |
| --- | --- |
| `journalctl -u yabridge -f` | Смотреть журнал моста в реальном времени. |
| `journalctl -u yabridge -n 50` | Показать последние 50 строк журнала. |
| `journalctl -u yabridge --since today` | Показать журнал за сегодня. |
| `asterisk -rvvvv` | Открыть консоль Asterisk с подробной трассировкой вызовов. |

### Состояние ARI и вызовов {#service-ari}

| Команда | Назначение |
| --- | --- |
| `asterisk -rx "ari show apps"` | Проверить, что приложение `voice-bot` зарегистрировано. |
| `asterisk -rx "ari show users"` | Показать пользователей ARI. |
| `asterisk -rx "http show status"` | Проверить HTTP-сервер Asterisk на порту 8088. |
| `asterisk -rx "core show channels"` | Показать активные каналы, включая `UnicastRTP`. |
| `asterisk -rx "bridge show all"` | Показать бриджи и число каналов в них. |

### Диагностика звука {#service-audio}

| Команда | Назначение |
| --- | --- |
| `asterisk -rx "core show channel <идентификатор_канала>"` | Показать кодек канала и переменную `UNICASTRTP_LOCAL_PORT`. |
| `asterisk -rx "rtp set debug on 127.0.0.1"` | Включить отладку RTP только для медиаканала моста. |
| `asterisk -rx "rtp set debug off"` | Выключить отладку RTP. |
| `tcpdump -ni lo udp port <порт>` | Проверить, идут ли RTP-пакеты между Asterisk и мостом. |

{% note warning %}

Отладку RTP выключайте сразу после проверки. На загруженной АТС она сильно увеличивает объем журнала.

{% endnote %}

### Применение настроек Asterisk {#service-config}

| Команда | Назначение |
| --- | --- |
| `fwconsole reload` | Применить изменения диалплана и настроек FreePBX. |
| `asterisk -rx "module reload res_ari.so"` | Перечитать настройки ARI после правки файла пользователей. |
| `asterisk -rx "dialplan show yandex-agent"` | Проверить, что контекст загружен. |