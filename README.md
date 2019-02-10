explainshell-cli
================

A script to fetch data from [explainshell.com](https://explainshell.com/), considering it as a quick & dirty CLI version of explainshell.

## Dependency

- Python3
- [HTML-XML-utils](https://www.w3.org/Tools/HTML-XML-utils/README)

## How to use

```
Usage:
  ./explainshell.sh '<command>'
```

Please don't forget to use **single quotes** to quote command text:

```
./explainshell.sh 'tar xzvf archive.tar.gz'
```

In case, there are **single quotes** in command text, use **double quotes** to quote command text and use **backslash** to escape single quotes:

```
./explainshell.sh "cut -d \' \' -f 1 /var/log/apache2/access_logs | uniq -c | sort -n"
```
