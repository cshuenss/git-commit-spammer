from datetime import datetime
import subprocess

try:
    x = int(input("Number of files\n> "))
except ValueError:
    print("Number of files must be a natural number")
    exit(1)

timestamp = datetime.strftime(datetime.now(), "%d%m%y-%H%M%S%f")
for i in range(0,x):
    filename = f"./file-{timestamp}-{str(i+1)}"
    f = open(filename, "w")
    f.close()

subprocess.call(["git","add","./."])
subprocess.call(["git","commit","-a","-m",f"add {str(x)} files"])
