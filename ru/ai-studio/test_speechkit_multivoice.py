# -*- coding: utf-8 -*-
"""Offline tests: all audio is generated locally; no calls to Yandex Cloud."""
from pathlib import Path
from unittest import mock
import json
import os
import shutil
import subprocess
import tempfile
import unittest

import speechkit_multivoice as subject


class PublicExampleTests(unittest.TestCase):
    def test_split_keeps_punctuation_and_words(self):
        text = "Первое предложение. Второе предложение! А теперь вопрос?"
        chunks = subject.split_for_tts(text, 24)
        self.assertEqual(" ".join(chunks), text)
        self.assertTrue(all(len(x) <= 24 for x in chunks))

    def test_empty_dialogue_rejected(self):
        with self.assertRaisesRegex(ValueError, "empty"):
            subject.render({"segments": [{"speaker": "X", "voice": "alena",
                                           "text": "   "}]}, Path("."), True)

    def test_dry_run_is_offline(self):
        sample = Path(__file__).with_name("sample_dialogue.json")
        data = json.loads(sample.read_text(encoding="utf-8"))
        with mock.patch.object(subject, "synthesize", side_effect=RuntimeError("API MUST NOT RUN")):
            result = subject.render(data, Path("does-not-exist"), True)
        self.assertEqual(result["status"], "DRY_RUN_NO_API_CALLS")
        self.assertGreaterEqual(result["chunks"], len(data["segments"]))

    @unittest.skipUnless(shutil.which("ffmpeg"), "FFmpeg not installed")
    def test_full_montage_cache_reuse_with_synthetic_audio(self):
        with tempfile.TemporaryDirectory() as td:
            temp = Path(td)
            wave_mp3 = temp / "synthetic.mp3"
            subprocess.run([
                "ffmpeg", "-nostdin", "-v", "error", "-y", "-f", "lavfi",
                "-i", "sine=frequency=330:duration=0.18", "-c:a", "libmp3lame",
                "-b:a", "64k", str(wave_mp3)
            ], check=True, timeout=25)
            synthetic = wave_mp3.read_bytes()
            sample = Path(__file__).with_name("sample_dialogue.json")
            data = json.loads(sample.read_text(encoding="utf-8"))
            with mock.patch.dict(os.environ, {"YANDEX_API_KEY": "SYNTHETIC_TEST_ONLY"}):
                with mock.patch.object(subject, "synthesize", return_value=synthetic) as api:
                    first = subject.render(data, temp / "result", False)
                    self.assertEqual(first["status"], "MP3_WRITTEN")
                    self.assertEqual(first["new_api_requests"], first["chunks"])
                    self.assertEqual(api.call_count, first["chunks"])
                    self.assertTrue(Path(first["file"]).stat().st_size > 200)
                with mock.patch.object(subject, "synthesize",
                                       side_effect=RuntimeError("CACHE MISSED")):
                    second = subject.render(data, temp / "result", False)
                    self.assertEqual(second["new_api_requests"], 0)
                    self.assertEqual(second["cache_hits"], second["chunks"])
                    self.assertTrue(Path(second["file"]).is_file())


if __name__ == "__main__":
    unittest.main()
