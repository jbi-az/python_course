#!/usr/bin/python3
import sys, importlib, contextlib, inspect, io, re

if len(sys.argv) != 2:
    print(f"Usage: {sys.argv[0]} <library>")
    sys.exit()

lib = importlib.import_module(sys.argv[1])
print("List of functions in library: {sys.argv[0]}\n")
print("{0:20} ==> {1}".format("FUNCTION", "SYNOPSIS"))

members = inspect.getmembers(lib)

for i in members:
    if inspect.isfunction(i[1]) or inspect.isbuiltin(i[1]):
        capture = io.StringIO()
        with contextlib.redirect_stdout(capture):
            help(lib.__name__ + "." + i[0])
        str = capture.getvalue()
        regex = re.compile(r'\w*\s=\s(.*\(.*\))')
        mo = regex.search(str)
        print(f"{i[0]:20.20} ==> {mo.group(1)}")

print("\n")

while True:
    print("What function from the list do you like to research more? (or q to quit)")
    answer = input()
    if answer == "q":
        sys.exit()
    if answer not in [i[0] for i in members]:
        print("This function is not in the list. Try again or q to quit")
        continue
    print("\n")
    help(lib.__name__ + "." + answer)
