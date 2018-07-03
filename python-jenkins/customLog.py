import sys
import logging

# logging

# create log with application name
log = logging.getLogger(__name__)
log.setLevel(logging.DEBUG)
# create file handler which logs even debug messages
fh = logging.FileHandler(__name__ + '.log')
fh.setLevel(logging.DEBUG)
# create console handler with a higher log level
ch = logging.StreamHandler(sys.stdout)
# ch.setLevel(logging.DEBUG)
ch.setLevel(logging.NOTSET)
# create formatter and add it to the handlers
# formatter = logging.Formatter(
#    '%(asctime)s - %(name)s - %(levelname)s-8s - %(message)s')
formatter = logging.Formatter(
    '%(asctime)s - %(levelname)-8s - %(name)s - \t %(message)s')
fh.setFormatter(formatter)
ch.setFormatter(formatter)
# add the handlers to the log
log.addHandler(fh)
log.addHandler(ch)

# log.log(0, "No set Log start")
log.debug("Debug Log Start ")
log.info("Info Log start")
log.warn("Warn Log start")
log.error("Error Loh start")
log.critical("Critical Log start")
