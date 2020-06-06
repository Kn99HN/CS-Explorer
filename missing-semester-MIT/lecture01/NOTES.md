# Course overview + the shell

MacOS will use bash (born again shell), where you can interact using text. We are usually shown with a command prompt.

```
date  // displaying the current date.
echo // print out the value as text.
>    // reading input stream into an output stream
>>   // appending to a file
cat  // concatenate to a file and print
|    // pipe operator
```

## How does the shell know
The machine have built-in program.
Shell is similar to an programming variable. It is inteprested when we run the shell script.

When we run the `echo` command, the shell sees that it should execute the program `echo`, and search through the `$PATH` for a file by that name. When it finds it, it will run the command.

### Navigating in the shell
`/` is the root of the file system, where all the files and directories are stored.

A path that starts with `/` is called an `absolute path`.

Any other path is a `relative path`.


`root` user is one that has all access to everything in the system, including create, read, update and delet. You will not be logged in as root as it can be dangerous.

Instead, you will need to use `sudo`, indicating you want to do something as super user.


## Environment Variable
The path directory, which the shell will try to find the appropriate commands from these directories.

$PATH is a way to name the location of a file in the computer.

## Example
```
echo "Hello world"
echo Hello\ World
```


```
drwxr-xr-x  3 khanhnguyen  staff  96 Jun  6 14:40 lecture01
```

The `d` tell us that lecture01 is a directory. `rwx`, indicating permission for the owner (read, write, and delete).

```
echo hello > hello.txt

If we want to append to a file, we do:
echo hello >> hello.txt
```

This will print hello to a file. More formally, we are taking an input stream, which is `hello` and outputting it as a stream to `hello.txt` file

```
ls -l / | tail -n1

rwxr-xr-x 1 root  root  4096 Jun 20  2019 var
```

`|` operator, which is called pipe, lets you "chain" programs such that the output of one is the input of another

# Exercises

- When running a file as script, we might not have full access to it to we have to use sh.
- `#!/bin/sh` is a comment, the program when see this, knows that it should run `/bin/sh`, passing the scripts as the first argument.