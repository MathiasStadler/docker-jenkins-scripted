""" TODO Missing docstring """
import getopt
import sys

VERSION = '1.0'
VERBOSE = False
CONFIG = 'default.out'

# print('ARGV      :', sys.argv[1:])

try:
    # pylint: disable=C0330
    OPTIONS, REMAINDER = getopt.gnu_getopt(
        sys.argv[1:],
        'c:v',
        ['CONFIG=',
         'VERBOSE',
         'VERSION=',
         ]
    )
except getopt.GetoptError as err:
    print('ERROR:', err)
    sys.exit(1)

print('OPTIONS   :', OPTIONS)

for opt, arg in OPTIONS:
    if opt in ('-c', '--config'):
        config_filename = arg
    elif opt in ('-v', '--verbose'):
        VERBOSE = True
    elif opt == '--config':
        CONFIG = arg

print('VERSION   :', VERSION)
print('VERBOSE   :', VERBOSE)
print('CONFIG    :', config_filename)
print('REMAINING :', REMAINDER)
