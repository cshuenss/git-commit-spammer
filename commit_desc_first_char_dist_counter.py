import sys
import subprocess
import os

argc = len(sys.argv)

if (argc == 1):
    print("arg0: path to repo\n"\
    "(opt) arg1: date since\n"\
    "(opt) arg2: date to")
    exit(1)

os.chdir(sys.argv[1])

call = ["git", "log", "--oneline", "--no-decorate"]
if (argc >= 3):
    call = call + ["--since", sys.argv[2]]
    if (argc >= 4):
        call = call + ["--until", sys.argv[3]]

result = subprocess.run(call, capture_output = True, text = True)

if (result.returncode != 0):
    print(result.stderr)
    exit(result.returncode)

commits = result.stdout.split("\n")

uppercase = 0
lowercase = 0
number = 0
symbol = 0
empty = 0

for commit in commits:
    if (len(commit) == 0):
        continue
    try:
        first_word = commit.split(" ")[1]
        if (first_word[0].isalpha()):
            if (first_word[0].isupper()):
                uppercase += 1
            else:
                lowercase += 1
        elif (first_word[0].isalnum()):
            number += 1
        else:
            symbol += 1
    except IndexError:
        empty += 1

print(f"uppercase: {uppercase}\n"\
      f"lowercase: {lowercase}\n"\
      f"number: {number}\n"\
      f"symbol: {symbol}\n"\
      f"empty: {empty}")