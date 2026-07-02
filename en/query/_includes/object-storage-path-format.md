| Path format | Description | Example |
|----|----|---|
| Path ends with `/` | Points to a folder | Path `/a` addresses everything inside a folder:<br>`/a/b/c/d/1.txt`<br>`/a/b/2.csv` |
| Path contains a `*` wildcard | Points to any file in any subfolder matching the pattern | Path `/a/*.csv` addresses all files in the following subfolders:<br>`/a/b/c/1.csv`<br>`/a/2.csv`<br>`/a/b/c/d/e/f/g/2.csv` |
| Path does not end with `/` and contains no wildcards | Points to an individual file | Path `/a/b.csv` refers to the specific file `/a/b.csv` |
