| Path format | Description | Example |
|----|----|---|
| Path that ends with `/` | Folder path | Path `/a` locates the entire contents of a folder:<br>`/a/b/c/d/1.txt`<br>`/a/b/2.csv` |
| Path that contains the `*` macro substitution character | Any files nested in the path | Path `/a/*.csv` locates files in folders:<br>`/a/b/c/1.csv`<br>`/a/2.csv`<br>`/a/b/c/d/e/f/g/2.csv` |
| Path that neither ends with `/` nor contains macro substitution characters | Path to an individual file | Path `/a/b.csv` locates a specific file: `/a/b.csv` |
