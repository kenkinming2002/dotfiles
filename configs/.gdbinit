python

import os
import sys

home_dir    = os.environ['HOME']
modules_dir = os.path.join(home_dir,'.config/gdb/')
sys.path.insert(0, modules_dir)
print(modules_dir)

from printers import register_eigen_printers

register_eigen_printers(None)

