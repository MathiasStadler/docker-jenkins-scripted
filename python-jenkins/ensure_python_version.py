"""TODO Missing docstring"""
# from here
# https://stackoverflow.com/questions/3760098/checking-version-of-python-interpreter-upon-execution-of-script-with-invalid-syn

import sys
if sys.version_info < (3, 4):
    raise SystemExit('Sorry, this code need Python 3.4 or higher')
