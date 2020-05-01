import atexit
import os
import readline
import xdg.BaseDirectory

histfile = os.path.join(xdg.BaseDirectory.xdg_cache_home, "python/history")

try:
    readline.read_history_file(histfile)
    readline.set_history_length(1000)
except FileNotFoundError:
    pass

atexit.register(readline.write_history_file, histfile)
