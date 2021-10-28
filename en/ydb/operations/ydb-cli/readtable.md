# Streaming table reads

The `readtable` command is used to read entire table snapshots. By streaming data you can read a table of any size.

```bash
{{ ydb-cli }} -e <endpoint> -d <database> table readtable episodes --ordered --limit 5 --columns series_id,season_id,episode_id,title
```

Command parameters:

- `--limit`: Limit the number of entries to read.
- `--ordered`: Order read entries by key.
- `--columns`: Columns whose values should be read (all by default) in CSV format.

Command results:

```bash
┌───────────┬───────────┬────────────┬─────────────────────────────────┐
| series_id | season_id | episode_id | title                           |
├───────────┼───────────┼────────────┼─────────────────────────────────┤
| [1u]      | [1u]      | [1u]       | ["Yesterday's Jam"]             |
├───────────┼───────────┼────────────┼─────────────────────────────────┤
| [1u]      | [1u]      | [2u]       | ["Calamity Jen"]                |
├───────────┼───────────┼────────────┼─────────────────────────────────┤
| [1u]      | [1u]      | [3u]       | ["Fifty-Fifty"]                 |
├───────────┼───────────┼────────────┼─────────────────────────────────┤
| [1u]      | [1u]      | [4u]       | ["The Red Door"]                |
├───────────┼───────────┼────────────┼─────────────────────────────────┤
| [1u]      | [1u]      | [5u]       | ["The Haunting of Bill Crouse"] |
└───────────┴───────────┴────────────┴─────────────────────────────────┘
```

To only get the number of read entries, use the `--count-only` parameter:

```bash
{{ ydb-cli }} -e <endpoint> -d <database> table readtable episodes --columns series_id --count-only
```

Command results:

```bash
70
```

