1. Сохраните скрипт в файл `s3_test_script.sh`.

    {% cut "Код скрипта" %}

    ```bash
    #!/usr/bin/env bash
    set -u

    if [[ $# -lt 1 || $# -gt 2 || ! -f $1 || ! -r $1 ]]; then
      printf 'Usage: %s /path/to/wal-g-config [storage/directory]\n' "$0" >&2
      exit 2
    fi

    config=$1
    directory=${2:-}
    directory=${directory#/}
    directory=${directory%/}
    wal_g=${WAL_G_BIN:-wal-g}
    listing=$(mktemp) || exit 2
    trap 'rm -f "$listing"' EXIT

    if ! "$wal_g" --config "$config" st ls -r >"$listing"; then
      printf 'ERROR: wal-g st ls -r failed\n' >&2 
      exit 2
    fi

    help=$({ "$wal_g" --config "$config" st cat --help || :; } 2>&1)
    if [[ $help == *--decode* ]]; then
      decode_flag=--decode
    elif [[ $help == *--decrypt* ]]; then
      decode_flag=--decrypt
    else
      printf 'ERROR: st cat supports neither --decode nor --decrypt\n' >&2
      exit 2
    fi
    if [[ $help != *--decompress* ]]; then
      printf 'ERROR: st cat does not support --decompress\n' >&2
      exit 2
    fi

    red='' reset=''
    if [[ -t 2 ]]; then red=$'\033[31m'; reset=$'\033[0m'; fi
    checked=0 decoded=0 raw=0 unknown=0 failed=0

    while IFS= read -r line; do
      path=''
      case $line in
        obj\ *) read -r _ _ _ _ _ _ path <<<"$line" ;;
        [0-9]*) read -r _ _ _ _ _ path <<<"$line" ;;
        dir\ *|type\ *|size\ *|'') continue ;;
        *) printf 'UNPARSED listing line: %s\n' "$line" >&2; ((unknown += 1)); continue ;;
      esac

      if [[ -z $path ]]; then
        printf 'UNPARSED listing line: %s\n' "$line" >&2
        ((unknown += 1))
        continue
      fi
      if [[ -n $directory && $path != "$directory/"* ]]; then
        continue
      fi

      ((checked += 1))
      case $path in
        *.br|*.lz4|*.lzma|*.zst|*.zstd|*.lzo)
          ((decoded += 1))
          "$wal_g" --config "$config" st cat "$path" "$decode_flag" --decompress >/dev/null ;;
        *.json)
          ((raw += 1))
          "$wal_g" --config "$config" st cat "$path" >/dev/null ;;
        *)
          ((raw += 1, unknown += 1))
          printf 'RAW ONLY (unknown format): %s\n' "$path" >&2
          "$wal_g" --config "$config" st cat "$path" >/dev/null ;;
      esac

      if [[ $? -ne 0 ]]; then
        printf '%sFAIL%s %s\n' "$red" "$reset" "$path" >&2
        ((failed += 1))
      fi
    done <"$listing"

    printf 'Checked: %d; decoded: %d; raw: %d; failed: %d; unknown: %d\n' \
      "$checked" "$decoded" "$raw" "$failed" "$unknown"

    if ((failed > 0)); then exit 1; fi
    if ((checked == 0 || unknown > 0)); then exit 2; fi
    ```
   
    {% endcut %}
