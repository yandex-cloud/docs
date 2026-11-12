"""Проверки без сетевых запросов: python -m unittest -v test_cluster_queries.py."""

import base64
from io import BytesIO
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch
from urllib.error import HTTPError

import cluster_queries as app


def xml_answer(xml):
    return {"rawData": base64.b64encode(xml.encode()).decode()}


class ClusteringTests(unittest.TestCase):
    def test_chain_does_not_join_unrelated_queries(self):
        serp = {"A": ["a", "b", "c", "d"],
                "B": ["a", "b", "c", "x", "y"],
                "C": ["c", "x", "y"]}
        groups = app.clusters(serp, {"A": 30, "B": 20, "C": 10})
        self.assertEqual([g["phrases"] for g in groups], [["A", "B"], ["C"]])

    def test_empty_results_are_excluded(self):
        self.assertEqual(app.clusters({"A": [], "B": ["a"]}, {"A": 20, "B": 10}),
                         [{"head": "B", "head_count": 10, "phrases": ["B"]}])

    def test_duplicate_urls_do_not_inflate_intersection(self):
        groups = app.clusters({"A": ["a", "a", "a"], "B": ["a", "a", "a"]},
                              {"A": 20, "B": 10})
        self.assertEqual(len(groups), 2)

    def test_equal_frequencies_have_stable_order(self):
        serp = {"B": ["a", "b", "c"], "A": ["a", "b", "c"]}
        self.assertEqual(app.clusters(serp, {"A": 10, "B": 10})[0]["head"], "A")

    def test_url_preserves_case_and_query(self):
        self.assertEqual(app.normalize_url("https://EXAMPLE.org/Path?q=One#section"),
                         "https://example.org/Path?q=One")
        self.assertNotEqual(app.normalize_url("https://site.ru/A"),
                            app.normalize_url("https://site.ru/a"))

    def test_xml_entities_and_only_document_urls(self):
        answer = xml_answer('<yandexsearch><request><url>https://wrong.ru/</url></request>'
                            '<response><results><grouping><group><doc>'
                            '<url>https://example.org/A?a=1&amp;b=2</url>'
                            '</doc></group></grouping></results></response></yandexsearch>')
        self.assertEqual(app.parse_serp(answer), ["https://example.org/A?a=1&b=2"])

    def test_xml_errors_are_not_empty_results(self):
        with self.assertRaises(RuntimeError):
            app.parse_serp(xml_answer('<yandexsearch><response><error code="55">'
                                     'Ошибка</error></response></yandexsearch>'))
        self.assertEqual(app.parse_serp(xml_answer('<yandexsearch><response>'
                         '<error code="15">Нет результатов</error></response></yandexsearch>')), [])

    def test_missing_or_corrupt_payload_is_rejected(self):
        for answer in ({}, {"rawData": "!"}, xml_answer("<unexpected/>")):
            with self.subTest(answer=answer), self.assertRaises((KeyError, ValueError)):
                app.parse_serp(answer)

    def test_wordstat_converts_counts_and_checks_schema(self):
        self.assertEqual(app.parse_wordstat({"results": [{"phrase": "тема", "count": "12"}]}),
                         {"тема": 12})
        self.assertEqual(app.parse_wordstat({"results": []}), {})
        with self.assertRaises(ValueError):
            app.parse_wordstat({"error": "failure"})

    def test_cache_reuses_success_and_separates_request_parameters(self):
        with tempfile.TemporaryDirectory() as directory:
            client = app.Client("test-key", "test-folder", directory, request_pause=0)
            payload = b'{"results": []}'
            with patch.object(app.urllib.request, "urlopen", side_effect=lambda *a, **k: BytesIO(payload)) as send:
                client.expand("тема", 5, "225")
                client.expand("тема", 5, "225")
                client.expand("тема", 5, "213")
                self.assertEqual(send.call_count, 2)
                self.assertEqual(client.cache_hits, 1)
            cached = "".join(p.read_text() for p in Path(directory).glob("*.json"))
            self.assertNotIn("test-key", cached)

    def test_failed_response_is_not_cached(self):
        with tempfile.TemporaryDirectory() as directory:
            client = app.Client("test", "folder", directory, request_pause=0)
            with patch.object(app.urllib.request, "urlopen", return_value=BytesIO(b'{}')):
                with self.assertRaises(ValueError):
                    client.expand("тема", 5, "225")
            self.assertEqual(list(Path(directory).glob("*.json")), [])

    def test_429_retry_after_and_final_failure(self):
        with tempfile.TemporaryDirectory() as directory:
            client = app.Client("test", "folder", directory, attempts=2,
                                retry_pause=1, request_pause=0)
            error = HTTPError("https://test", 429, "quota", {"Retry-After": "7"}, None)
            with patch.object(app.time, "sleep") as sleep, patch.object(
                    app.urllib.request, "urlopen", side_effect=[error, BytesIO(b'{"results": []}')]):
                self.assertEqual(client.expand("тема", 5, "225"), {})
                self.assertTrue(any(call.args == (7,) for call in sleep.call_args_list))
            with patch.object(app.time, "sleep"), patch.object(
                    app.urllib.request, "urlopen", side_effect=error) as send:
                with self.assertRaises(HTTPError):
                    client.expand("другая тема", 5, "225")
                self.assertEqual(send.call_count, 2)

    def test_other_http_errors_are_not_retried(self):
        with tempfile.TemporaryDirectory() as directory:
            client = app.Client("test", "folder", directory, request_pause=0)
            with patch.object(app.urllib.request, "urlopen", side_effect=HTTPError(
                    "https://test", 403, "forbidden", {}, None)) as send:
                with self.assertRaises(HTTPError):
                    client.expand("тема", 5, "225")
                self.assertEqual(send.call_count, 1)

    def test_dry_run_never_reads_credentials_or_calls_network(self):
        with patch.object(app.urllib.request, "urlopen") as send:
            self.assertEqual(app.main(["--seed", "тема"]), 0)
            send.assert_not_called()

    def test_csv_bom_and_duplicate_phrases(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "phrases.csv"
            path.write_text('phrase,count\n"тема, с запятой",12\n"тема, с запятой",7\n',
                            encoding="utf-8-sig")
            self.assertEqual(app.read_csv(path), {"тема, с запятой": 12})


if __name__ == "__main__":
    unittest.main()
