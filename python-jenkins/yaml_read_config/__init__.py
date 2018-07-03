""" init LOGGER for the module """
# from here
# http://docs.python-guide.org/en/latest/writing/logging/
# OLD import logging
# OLD logging.getLogger(__name__).addHandler(logging.NullHandler())

import os
import sys

import logging
from logging.config import fileConfig

#from yaml_read_config import YamlReadConfig
