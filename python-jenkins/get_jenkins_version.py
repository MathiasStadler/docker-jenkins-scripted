"""TODO Missing docstring"""


import getopt
import os
import sys
import jenkins

# import ensure_python_version
from custom_log import LOGGER


# load custom module
# pylint: disable=C0413
sys.path.insert(0, os.path.abspath(
    os.path.join(os.path.dirname(__file__), './yaml_read_config')))

print("sys.path => {}".format(sys.path))

import yaml_read_config


# getopt

# default values
VERSION = '1.0'
VERBOSE = False
CONFIG = 'default.out'

# print('ARGV      :', sys.argv[1:])

try:
    # pylint: disable=C0330
    OPTIONS, REMAINDER = getopt.gnu_getopt(
        sys.argv[1:],
        'c:v',
        ['config=',
         'verbose',
         'version=',
         ])
except getopt.GetoptError as err:
    LOGGER.error('ERROR: %s', err)
    sys.exit(1)

print('OPTIONS   :', OPTIONS)

for opt, arg in OPTIONS:
    if opt in ('-c', '--config'):
        config_filename = arg
    elif opt in ('-v', '--verbose'):
        verbose = True
    elif opt == '--version':
        version = arg

LOGGER.debug("VERSION   : %s", VERSION)
LOGGER.debug("VERBOSE   :%s", VERBOSE)
LOGGER.debug("CONFIG    : %s", config_filename)
LOGGER.debug("REMAINING :%s", REMAINDER)


# read deafult
CONFIG = yaml_read_config.YamlReadConfig('remote', config_filename)

NAME = CONFIG.get_config_value('name')
SERVER_NAME = CONFIG.get_config_value('server')
PORT = CONFIG.get_config_value('port')
PROTOCOL = CONFIG.get_config_value('protocol')
USER = CONFIG.get_config_value('user')
PASSWORD = CONFIG.get_config_value('password')
TIMEOUT = CONFIG.get_config_value('timeout')

# LOGGER default
LOGGER.info("name => %s", NAME)
LOGGER.info("serverName => %s", SERVER_NAME)
LOGGER.info("port => %i", PORT)
LOGGER.info("protocol => %s", PROTOCOL)
LOGGER.info("user => %s", USER)
LOGGER.info("password => %s", len(PASSWORD) * 'X')
LOGGER.info("timeout for connect the server => %i", TIMEOUT)

# create jenkins server url
JENKINS_URL = "{}://{}:{}".format(PROTOCOL, SERVER_NAME, PORT)

# LOGGER
LOGGER.info("Jenkins URL server => %s", JENKINS_URL)

# try to connect
try:
    LOGGER.info("Try to connect to server")
    SERVER = jenkins.Jenkins(JENKINS_URL,
                             username=USER, password=PASSWORD, timeout=TIMEOUT)

except TimeoutError as err:
    # pylint: disable=no-member
    LOGGER.error({"message": err.message})
except EnvironmentError as err:
    # handle other errors
    # pylint: disable=no-member
    LOGGER.error({"message": err.message})
finally:
    CONFIG = None

# get remote user
REMOTE_USER = SERVER.get_whoami()
# get Jenkins version
VERSION = SERVER.get_version()

# get complete server info
SERVER_INFO = SERVER.get_info()

# old print(type(SERVER_INFO))

for key, value in SERVER_INFO.items():
    # print (key, value)
    print(key)

SERVER_JOBS = SERVER_INFO['jobs']

LOGGER.info("info => %s", SERVER_INFO)

LOGGER.info("jobs => %s ", SERVER_JOBS)

LOGGER.info('Hello %s from Jenkins %s', REMOTE_USER['fullName'], VERSION)
