"""TODO Missing docstring"""
import sys
import logging

# logging

# create LOGGER with application name
LOGGER = logging.getLogger(__name__)
LOGGER.setLevel(logging.DEBUG)
# create file handler which logs even debug messages
FILE_HANDLER = logging.FileHandler(__name__ + '.log')
FILE_HANDLER.setLevel(logging.DEBUG)
# create console handler with a higher log level
CONSOLE_HANDLER = logging.StreamHandler(sys.stdout)
# ch.setLevel(logging.DEBUG)
CONSOLE_HANDLER.setLevel(logging.NOTSET)
# create formatter and add it to the handlers
# formatter = logging.Formatter(
#    '%(asctime)s - %(name)s - %(levelname)s-8s - %(message)s')
FORMATTER = logging.Formatter(
    '%(asctime)s - %(levelname)-8s - %(name)s - \t %(message)s')
FILE_HANDLER.setFormatter(FORMATTER)
CONSOLE_HANDLER.setFormatter(FORMATTER)
# add the handlers to the log
LOGGER.addHandler(FILE_HANDLER)
LOGGER.addHandler(CONSOLE_HANDLER)

# LOGGER.log(0, "No set Log start")
LOGGER.debug("Debug Log Start ")
LOGGER.info("Info Log start")
LOGGER.error("Error Loh start")
LOGGER.critical("Critical Log start")
