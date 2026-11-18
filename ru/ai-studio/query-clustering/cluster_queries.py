#!/usr/bin/env python3
"""Группировка поисковых фраз по пересечению выдачи Search API. Python 3.9+."""

import argparse
import base64
import csv
import hashlib
import json
import os
from pathlib import Path
import sys
import time
import urllib.error
import urllib.request
from urllib.parse import urlsplit, urlunsplit
import xml.etree.ElementTree as ET


HOST = "https://searchapi.api.cloud.yandex.net"


def save_json(path, value):
    """Заменяем файл только после успешной записи временного файла."""
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_suffix(path.suffix + ".tmp")
    temporary.write_text(json.dumps(value, ensure_ascii=False, indent=2), encoding="utf-8")
    temporary.replace(path)


def normalize_url(url):
    """Убираем фрагмент; регистр пути и параметры запроса сохраняем."""
    parts = urlsplit(url.strip())
    if parts.scheme.lower() not in ("http", "https") or not parts.hostname:
        raise ValueError("В выдаче получен некорректный URL")
    return urlunsplit((parts.scheme.lower(), parts.netloc.lower(),
                       parts.path or "/", parts.query, ""))


def parse_serp(answer):
    """Проверяем Base64, структуру XML и ошибку внутри успешного HTTP-ответа."""
    root = ET.fromstring(base64.b64decode(answer["rawData"], validate=True))
    response = root.find("response") if root.tag == "yandexsearch" else None
    if response is None:
        raise ValueError("Неожиданная структура XML поискового ответа")
    error = response.find("error")
    if error is not None:
        # Код 15: по запросу ничего не найдено. Остальные ошибки не маскируем.
        if error.get("code") == "15":
            return []
        raise RuntimeError("Ошибка XML Search API: " + str(error.get("code")))
    grouping = response.find("results/grouping")
    if grouping is None:
        raise ValueError("В ответе нет результатов и нет явной ошибки")
    urls = [normalize_url(node.text or "") for node in grouping.findall("group/doc/url")]
    return list(dict.fromkeys(urls))[:10]


def parse_wordstat(answer):
    if not isinstance(answer.get("results"), list):
        raise ValueError("В ответе Wordstat отсутствует список results")
    result = {}
    for row in answer["results"]:
        phrase = row["phrase"].strip()
        count = int(row["count"])
        if not phrase or count < 0:
            raise ValueError("Некорректная фраза или частота Wordstat")
        result[phrase] = max(result.get(phrase, 0), count)
    return result


class Client:
    def __init__(self, key, folder, cache_dir, cache_hours=24, attempts=4,
                 retry_pause=60, request_pause=1.1):
        self.key = key
        self.folder = folder
        self.cache_dir = Path(cache_dir)
        self.cache_hours = cache_hours
        self.attempts = attempts
        self.retry_pause = retry_pause
        self.request_pause = request_pause
        self.last_request = 0.0
        self.http_attempts = 0
        self.cache_hits = 0

    def post(self, path, body, validate):
        body = dict(body, folderId=self.folder)
        identity = json.dumps([HOST, path, body], sort_keys=True, ensure_ascii=False)
        cache = self.cache_dir / (hashlib.sha256(identity.encode()).hexdigest() + ".json")
        if cache.exists() and time.time() - cache.stat().st_mtime < self.cache_hours * 3600:
            answer = json.loads(cache.read_text(encoding="utf-8"))
            validate(answer)
            self.cache_hits += 1
            return answer
        request = urllib.request.Request(
            HOST + path, data=json.dumps(body).encode("utf-8"),
            headers={"Authorization": "Api-Key " + self.key,
                     "Content-Type": "application/json"}, method="POST")
        for attempt in range(self.attempts):
            time.sleep(max(0, self.request_pause - (time.monotonic() - self.last_request)))
            self.last_request = time.monotonic()
            self.http_attempts += 1
            try:
                with urllib.request.urlopen(request, timeout=60) as response:
                    answer = json.load(response)
            except urllib.error.HTTPError as error:
                if error.code != 429 or attempt + 1 == self.attempts:
                    raise
                delay = self.retry_pause * (2 ** attempt)
                retry_after = error.headers.get("Retry-After", "")
                if retry_after.isdigit():
                    delay = max(delay, int(retry_after))
                print(f"HTTP 429: повтор через {delay} с", file=sys.stderr)
                time.sleep(delay)
                continue
            validate(answer)
            save_json(cache, answer)
            return answer
        raise RuntimeError("Не удалось получить ответ Search API")

    def expand(self, seed, number, region):
        answer = self.post("/v2/wordstat/topRequests", {
            "phrase": seed, "numPhrases": str(number),
            "regions": [region], "devices": ["DEVICE_ALL"]}, parse_wordstat)
        return parse_wordstat(answer)

    def top10(self, phrase, region):
        answer = self.post("/v2/web/search", {
            "query": {"searchType": "SEARCH_TYPE_RU", "queryText": phrase,
                      "page": "0", "fixTypoMode": "FIX_TYPO_MODE_OFF"},
            "groupSpec": {"groupMode": "GROUP_MODE_FLAT",
                          "groupsOnPage": "10", "docsInGroup": "1"},
            "region": region, "responseFormat": "FORMAT_XML"}, parse_serp)
        return parse_serp(answer)


def clusters(serp, frequencies, threshold=3):
    """Каждую фразу сравниваем с главной фразой, без склейки цепочкой."""
    groups = []
    for phrase in sorted(serp, key=lambda p: (-frequencies[p], p)):
        urls = set(serp[phrase])
        if not urls:
            continue
        for group in groups:
            if len(urls & set(serp[group["head"]])) >= threshold:
                group["phrases"].append(phrase)
                break
        else:
            groups.append({"head": phrase, "head_count": frequencies[phrase],
                           "phrases": [phrase]})
    return groups


def read_csv(path):
    frequencies = {}
    with Path(path).open(encoding="utf-8-sig", newline="") as stream:
        for row in csv.DictReader(stream):
            phrase = row["phrase"].strip()
            count = int(row["count"])
            if not phrase or count < 0:
                raise ValueError("CSV: фраза пустая или частота отрицательная")
            frequencies[phrase] = max(frequencies.get(phrase, 0), count)
    if not frequencies:
        raise ValueError("CSV не содержит фраз")
    return frequencies


def positive_int(value):
    number = int(value)
    if number < 1:
        raise argparse.ArgumentTypeError("Нужно положительное целое число")
    return number


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    source = parser.add_mutually_exclusive_group(required=True)
    source.add_argument("--seed", help="Исходная фраза для Wordstat")
    source.add_argument("--input", type=Path, help="CSV со столбцами phrase,count")
    parser.add_argument("--num-phrases", type=positive_int, default=50)
    parser.add_argument("--max-queries", type=positive_int, default=5)
    parser.add_argument("--region", default="225")
    parser.add_argument("--threshold", type=positive_int, default=3)
    parser.add_argument("--config-dir", type=Path, default=Path.home() / ".config/search-api")
    parser.add_argument("--cache-dir", type=Path, default=Path("cache"))
    parser.add_argument("--output", type=Path, default=Path("clusters.json"))
    parser.add_argument("--run", action="store_true", help="Разрешить запросы к API")
    args = parser.parse_args(argv)
    if args.num_phrases > 2000 or args.threshold > 10:
        parser.error("num-phrases не больше 2000, threshold не больше 10")
    frequencies = read_csv(args.input) if args.input else {}
    limit = min(args.max_queries, len(frequencies) if args.input else args.num_phrases)
    wordstat_requests = 0 if args.input else 1
    print(f"Без кэша и повторов: Wordstat — {wordstat_requests}, веб-поиск — не более {limit}.")
    if not args.run:
        print("Запросы не отправлены. Для запуска добавьте --run.")
        return 0
    if args.output.exists():
        parser.error("Файл результата уже существует: выберите другое имя --output")
    key = (args.config_dir / "api_key").read_text(encoding="utf-8").strip()
    folder = (args.config_dir / "folder_id").read_text(encoding="utf-8").strip()
    if not key or not folder:
        raise ValueError("Пустой API-ключ или идентификатор каталога")
    client = Client(key, folder, args.cache_dir)
    if args.seed:
        print("Внимание: проверьте ограничение актуальности Wordstat в документации.")
        frequencies = client.expand(args.seed, args.num_phrases, args.region)
    frequencies = dict(sorted(frequencies.items(), key=lambda item: (-item[1], item[0]))[:limit])
    serp = {phrase: client.top10(phrase, args.region) for phrase in frequencies}
    result = {"region": args.region, "threshold": args.threshold,
              "frequencies": frequencies, "serp": serp,
              "clusters": clusters(serp, frequencies, args.threshold),
              "without_results": [phrase for phrase, urls in serp.items() if not urls],
              "http_attempts": client.http_attempts, "cache_hits": client.cache_hits}
    save_json(args.output, result)
    print(f"Фраз: {len(serp)}, кластеров: {len(result['clusters'])}, "
          f"без результатов: {len(result['without_results'])}.")
    print(f"HTTP-попыток: {client.http_attempts}, ответов из кэша: {client.cache_hits}.")
    print(f"Результат: {args.output}")
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except (OSError, ValueError, KeyError, RuntimeError, ET.ParseError) as error:
        # Тело ответа и объект запроса не печатаем: в них могут быть служебные данные.
        print(f"Ошибка: {error}", file=sys.stderr)
        sys.exit(1)
