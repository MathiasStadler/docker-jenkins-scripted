""" Read YAML config and provide them """
import sys
import os
import logging
import yaml


# found the root path of module
CURRENT_MODULE = sys.modules[__name__]
MODULE_DIRECTORY = CURRENT_MODULE.__file__
MODULE_ROOT_PATH = os.path.dirname(
    os.path.abspath(MODULE_DIRECTORY))+os.sep

print("MODULE_ROOT_PATH => " + MODULE_ROOT_PATH)

# _LOGGING_CONFIG_FILE = MODULE_ROOT_PATH + '/config/logging_config.ini'

# LOGGER.fileConfig(_LOGGING_CONFIG_FILE, disable_existing_loggers=False)
LOGGER = logging.getLogger()
LOGGER.setLevel(logging.DEBUG)
LOGGER.debug('Logging start')

LOGGER.debug("version of yaml => %s ", yaml.__version__)


class YamlReadConfig:
    """read YAML config """
    CURRENT_MODULE = sys.modules[__name__]
    MODULE_DIRECTORY = CURRENT_MODULE.__file__
    MODULE_ROOT_PATH = os.path.dirname(
        os.path.abspath(MODULE_DIRECTORY))+os.sep

    _DEFAULT_CONFIG = 'default'
    _DEFAULT_CONFIG_FILE = MODULE_ROOT_PATH + '/config/localhost_config.yml'

    def __init__(self, config=None, config_file=None):

        if config is None:
            self._config = self._DEFAULT_CONFIG
        else:
            self._config = config
        LOGGER.info("config => %s", self._config)

        if config_file is None:
            self._config_file = self._DEFAULT_CONFIG_FILE
        else:
            self._config_file = config_file
        LOGGER.info(" config File => %s", self._config_file)

    @property
    def config_file(self):
        """ get name of config_file"""
        return self._config_file

    @config_file.setter
    def config_file(self, config_file):
        """ set name of config_file"""
        self._config_file = config_file
        LOGGER.info("Setting config file of => %s ", self._config_file)

    @property
    def config(self):
        """ get config """
        return self._config_file

    @config.setter
    def config_setter(self, config):
        """set config """
        self._config = config
        print("Setting config of => %s " % self._config_file)

    def get_config_value(self, kez):
        """ return value of kez back """
        # Attention the config file is the package
        file = open(self._config_file)
        # pylint: disable=no-member
        try:
            doc = yaml.load(file)
        except yaml.YAMLError as exc:
            if exc.problem_mark is not None:
                mark = exc.problem_mark
                print("Error position: (%s:%s)" %
                      (mark.line+1, mark.column+1))
            else:
                LOGGER.error("Something went wrong while parsing yaml file")

        file.close()
        # return_kez = doc[self.default_config][kez]
        try:
            return_kez = doc[self._config][kez]
            return return_kez
        except KeyError:
            logging.error("Kez %s not available", format(kez))
            return None


# x = YamlReadConfig()

# server = x.getConfigValue('server')

# print (server)
