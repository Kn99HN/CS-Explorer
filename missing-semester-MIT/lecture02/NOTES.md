# Shell Tools and Scripting

Most shells have their own scripting language with variables, control flow and its own syntax.

scripting language is optimized for performing shell-related tasks.

## Bash Scripting

`foo=bar`: assigning variables in bash.
=> There must be NO SPACE as it is interpreted as calling the `foo` programs with arguments `=` and `bar`.

`$foo`: accessing variable value

#### Example
```
foo=bar
echo "$foo"
# print bar
echo '$foo'
# print $foo
```
Both can be defined as string but `'` does not substitute variable values where as `"` will.

Bash also supports control flow as other programming language.

#### Example
```
mcd () {
    mkdir -p "$1"
    cd "$1"
}
```
The function creates a directory and `cd`s into the newly created directory.

`$1` refers to the first argument of the script/function. It is a special character in scripting.

### Special Character List
- `$0`: Name of the script.
- `$1`-`$9`: Arguments to the script. `$1` is the first argument and so on.
- `$@`: All the arguments.
- `$#`: Number of arguments.
- `$?`: Return code of the previous command
- `$$`: Process identification number (PID) for the current script.
- `!!`: Entire last command, including arguments. A common pattern is to execute a command only for it to fail due to missing permissions; you can quickly re-execute the command with sudo by doing `sudo !!`
- `$_`: Last argument from the last command. If you are in an interactive shell.

`0` output means everything went OK, anything different from 0 means an error occured.

- `||` is or and `&&` is and, both are short-circuting operators.
- Command can be separated in the same line using `;`

### Command Substitution
Whenever we have `$(CMD)`, it will execute `CMD`, get the ouput of the command and substitute it in place.

#### Example
`for file in $(ls)`, the shell will call `ls` and then iterate over those values. 

A lesser known similar feature is process substitution, `<(CMD)`. This will execute `CMD` and place the output in a temp file and substitute the `<()` with the file's name.

```
#!/bin/bash

echo "Starting program at $(date)" # Date will be substituted

echo "Running program $0 with $# arguments with pid $$"

for file in $@; do
    grep foobar $file > /dev/null 2> /dev/null
    # When pattern is not found, grep has exit status 1
    # We redirect STDOUT and STDERR to a null register since we do not care about them
    if [[ $? -ne 0 ]]; then
        echo "File $file does not have any foobar, adding one"
        echo "# foobar" >> "$file"
    fi
done
```

We tested whether `$?` was not equal to 0. Bash implements many comparisons of this sort.

Use double brackets `[[]]` in favor of `[]` when performing comparisons. 

### Shell globbing
- Wildcards. This is used to perform of matching.

For instance, given files `foo`, `foo1`, `foo2`, `foo10`, and `bar`, the command `rm foo?` will remove `foo1` and `foo2` whereas `rm foo*` will delete all but `bar`.

- Curly braces `{}`. This is used when we want to expand common substring in series of command. 

#### Example
```
convert image.{png,jpg}
# Will expand to
convert image.png image.jpg

mv *{.py,.sh} folder
# Will move all *.py and *.sh files

touch {foo,bar}/{a...h}
# Creating files foo/a, foo/b,...foo/h, bar/a, bar/b,...bar/h
```

## Shell functions and scripts differences
- Functions have to be in the same language as the shell, while scripts can be written in any language. By including a shebang (`#!/usr/local...`), we can change the way the script is interpreted.
- Functions are loaded once when the definition is read. Scripts are loaded everytime they are executed. 
- Functions are executed in the current shell environment whereas scripts execute in their own process. Functions can modify environment variables,e.g, change your current directory. Scripts cannot. Scripts will be passed by value environment variables that have been exported using `export`.

## Shell Tools

- [TLDR pages](https://tldr.sh/) is good for complemenary solution focusing on command examples.

### Finding files
`find` is a great shell tool to recursively search for files matching some criteria.

#### Example
```
find . -name src -type d
# Find all directories named src

find . -path '**/test/**/*.py' -type f
# Find all python files that have a folder named test in their path

find . -mtime -1
# Find all files modified in the last day
```

Additionally, `find` can execute some of the monotonous tasks for us.

```
# Delete all files with .tmp extension
find . -name '*.tmp' -exec rm {} \;

# Find all PNG files and convert them to JPG
find . -name '*.png' -exec convert {} {.}.jpg \;
```

Find is good but performance might take a hit. If we care about time tradeoff, we can use `locate` which uses a database that is updated using `updatedb` daily via `cron`.

## Finding code
How about finding file by its content. 

#### Example
`grep -C 5` will print 5 lines before and after the match.

Use `-R` if we want to recursively go into directories and look for files for matching string.

grep can be improved with `ripgrep`, which gives us more effecient feature. 

```
# Find all python files where I used the requests library
rg -t py 'import requests'

# Find all files (including hidden files) without shebang line
rg -u --files-wihtout-match "^#!"

# Find all matches of foo and print the following 5 lines
rf foo -A 5

# print statistics of matches (# of matched lines and files)
rg --stats PATTERN
```

## Finding shell commands 
`history` command allow us to access shell history programmatically. 


`history | grep find` will print commands that contain "find" in history.


## Exercises

1. `ls -a -l -u`
list files in order of most recent time with flag `-l`. `-a` indicate we want to show all files including hidden files. `-u` displaying file's size in the form of readble size.



