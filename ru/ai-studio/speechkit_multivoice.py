#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Public SpeechKit v1 tutorial example. No secrets in source or outputs."""
from __future__ import annotations

import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import tempfile
import time
import urllib.error
import urllib.parse
import urllib.request
import wave

API = "https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize"
AUDIO_RATE = 48000
MAX_CHARS = 180  # Example conservative request size; verify billing block rules.


def split_for_tts(text: str, max_chars: int = MAX_CHARS) -> list[str]:
    """Split on sentence/word boundaries without dropping punctuation."""
    text = re.sub(r"\s+", " ", text).strip()
    if not text:
        return []
    sentences = re.split(r"(?<=[.!?…])\s+", text)
    result: list[str] = []
    for sentence in sentences:
        if len(sentence) <= max_chars:
            result.append(sentence)
            continue
        buf = ""
        for token in sentence.split(" "):
            if len(token) > max_chars:
                raise ValueError("A word exceeds the configured chunk limit")
            candidate = (buf + " " + token).strip()
            if len(candidate) > max_chars and buf:
                result.append(buf)
                buf = token
            else:
                buf = candidate
        if buf:
            result.append(buf)
    assert all(0 < len(s) <= max_chars for s in result)
    assert re.sub(r"\s+", " ", " ".join(result)).strip() == text
    return result


def cache_name(text: str, voice: str) -> str:
    # An immutable request signature; use distinct cache for every API setting.
    spec = {"api": "speechkit-v1", "voice": voice, "lang": "ru-RU",
            "format": "mp3", "speed": "1.0", "emotion": "neutral", "text": text}
    raw = json.dumps(spec, ensure_ascii=False, sort_keys=True).encode("utf-8")
    return hashlib.sha256(raw).hexdigest() + ".mp3"


def synthesize(text: str, voice: str, key: str) -> bytes:
    body = urllib.parse.urlencode({
        "text": text, "lang": "ru-RU", "voice": voice,
        "format": "mp3", "speed": "1.0", "emotion": "neutral",
    }).encode("utf-8")
    request = urllib.request.Request(
        API, data=body, method="POST",
        headers={"Authorization": "Api-Key " + key,
                 "Content-Type": "application/x-www-form-urlencoded"},
    )
    # No automatic retries after timeouts: a retry may incur duplicate billing.
    try:
        with urllib.request.urlopen(request, timeout=90) as response:
            data = response.read()
            if response.status != 200 or not data:
                raise RuntimeError("SpeechKit returned no MP3 data")
            if data[:3] != b"ID3" and not (
                len(data) > 1 and data[0] == 0xFF and (data[1] & 0xE0) == 0xE0
            ):
                raise RuntimeError("SpeechKit response is not an MP3 frame")
            return data
    except urllib.error.HTTPError as exc:
        # Do not log request headers, credentials, or remote response bodies.
        raise RuntimeError("SpeechKit HTTP error: " + str(exc.code)) from None


def require_ffmpeg() -> str:
    ffmpeg = shutil.which("ffmpeg")
    if not ffmpeg:
        raise RuntimeError("Install FFmpeg and make the ffmpeg command available")
    return ffmpeg


def render(data: dict, directory: Path, dry_run: bool) -> dict:
    if not isinstance(data.get("segments"), list) or not data["segments"]:
        raise ValueError("Expected non-empty segments list")
    parts: list[dict] = []
    for index, segment in enumerate(data["segments"]):
        speaker = segment["speaker"]
        voice = segment["voice"]
        if not isinstance(speaker, str) or not speaker.strip():
            raise ValueError("Missing speaker")
        if not isinstance(voice, str) or not re.fullmatch(r"[a-z0-9_]+", voice):
            raise ValueError("Unsupported voice identifier")
        pause = float(segment.get("pause_after", 0))
        if not 0 <= pause <= 8:
            raise ValueError("pause_after must be from 0 to 8 seconds")
        chunks = split_for_tts(segment["text"])
        if not chunks:
            raise ValueError("An empty dialogue segment is not allowed")
        for chunk in chunks:
            parts.append({"index": index, "speaker": speaker, "voice": voice,
                          "text": chunk, "pause_after": 0.0,
                          "cache_file": cache_name(chunk, voice)})
        if parts:
            parts[-1]["pause_after"] = pause
    if not parts:
        raise ValueError("Nothing to synthesize")
    summary = {"api": "speechkit-v1", "chunks": len(parts),
               "characters": sum(len(x["text"]) for x in parts),
               "voices": sorted(set(x["voice"] for x in parts))}
    if dry_run:
        return {"status": "DRY_RUN_NO_API_CALLS", **summary}

    key = os.environ.get("YANDEX_API_KEY", "")
    if not key:
        raise RuntimeError("Set YANDEX_API_KEY in the process environment; never commit it")
    ffmpeg = require_ffmpeg()
    directory.mkdir(parents=True, exist_ok=True)
    cache = directory / ".cache"
    cache.mkdir(exist_ok=True)
    new = 0
    for part in parts:
        target = cache / part["cache_file"]
        if target.exists() and target.stat().st_size > 0:
            continue
        audio = synthesize(part["text"], part["voice"], key)
        # Atomic commit: a failed response does not poison the cache.
        with tempfile.NamedTemporaryFile(dir=cache, suffix=".tmp", delete=False) as temp:
            temp.write(audio)
            temp_path = Path(temp.name)
        os.replace(temp_path, target)
        new += 1

    output = directory / "multivoice.mp3"
    with tempfile.TemporaryDirectory(dir=directory, prefix="mix_") as td:
        tempdir = Path(td)
        master = tempdir / "master.wav"
        with wave.open(str(master), "wb") as target:
            target.setnchannels(1)
            target.setsampwidth(2)
            target.setframerate(AUDIO_RATE)
            for n, part in enumerate(parts):
                normalized = tempdir / ("part_" + str(n) + ".wav")
                subprocess.run(
                    [ffmpeg, "-nostdin", "-v", "error", "-y",
                     "-i", str(cache / part["cache_file"]), "-ac", "1",
                     "-ar", str(AUDIO_RATE), "-c:a", "pcm_s16le", str(normalized)],
                    check=True, timeout=90)
                with wave.open(str(normalized), "rb") as source:
                    if source.getnchannels() != 1 or source.getframerate() != AUDIO_RATE:
                        raise RuntimeError("Unexpected decoded audio format")
                    while True:
                        frames = source.readframes(8192)
                        if not frames:
                            break
                        target.writeframesraw(frames)
                silence = int(part["pause_after"] * AUDIO_RATE)
                if silence:
                    target.writeframesraw(b"\x00\x00" * silence)
        subprocess.run(
            [ffmpeg, "-nostdin", "-v", "error", "-y", "-i", str(master),
             "-c:a", "libmp3lame", "-b:a", "128k", str(output)],
            check=True, timeout=180)
    return {"status": "MP3_WRITTEN", "file": str(output),
            "new_api_requests": new, "cache_hits": len(parts) - new, **summary}


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--input", required=True, type=Path)
    parser.add_argument("--output", default=Path("speech-output"), type=Path)
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()
    data = json.loads(args.input.read_text(encoding="utf-8"))
    result = render(data, args.output, args.dry_run)
    print(json.dumps(result, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
