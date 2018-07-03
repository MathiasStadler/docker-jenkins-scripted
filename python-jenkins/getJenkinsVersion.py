import os
import sys
import ensurePythonVersion
from customLog import log
import jenkins

# load custom module
sys.path.insert(0, os.path.abspath(
    os.path.join(os.path.dirname(__file__), './YAMLReadConfig')))
from YAMLReadConfig.bin.YamlReadConfig import YamlReadConfig


# read deafult
config = YamlReadConfig('remote')

name = config.getConfigValue('name')
serverName = config.getConfigValue('server')
port = config.getConfigValue('port')
protocol = config.getConfigValue('protocol')
user = config.getConfigValue('user')
password = config.getConfigValue('password')
timeout = config.getConfigValue('timeout')

# log default
log.info("name => {} ".format(name))
log.info("serverName => {} ".format(serverName))
log.info("port => {}".format(port))
log.info("protocol => {}".format(protocol))
log.info("user => {}".format(user))
log.info("password => {}".format(len(password) * 'X'))
log.info("timeout for connect the server => {}".format(timeout))

# create jenkins server url
jenkinsURL = "{}://{}:{}".format(protocol, serverName, port)

# log
log.info("Jenkins URL server => {}".format(jenkinsURL))

# try to connect
try:
    log.info("Try to connect to server")
    server = jenkins.Jenkins(jenkinsURL,
                             username=user, password=password, timeout=timeout)
except TimeoutError as err:
    log.error({"message": err.message})
except EnvironmentError as err:
    # handle other errors
    log.error({"message": err.message})
finally:
    config = None


user = server.get_whoami()
version = server.get_version()

info = server.get_info()

print(type(info))

for key, value in info.items():
    # print (key, value)
    print(key)

job = info['jobs']

print("info => {}".format(info))

print("jobs => {} ".format(job))

print('Hello %s from Jenkins %s' % (user['fullName'], version))
