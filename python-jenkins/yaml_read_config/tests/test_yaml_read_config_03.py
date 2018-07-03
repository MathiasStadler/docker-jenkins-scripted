""" TODO Missing docstring """
from .context import YamlReadConfig


class TestYamlReadConfig:
    """ TEST Yaml Read Config"""
    testClazz = None

    def test_case01(self):
        # pylint: disable=W0612,W0613,R0201
        """ TODO Missing docstring """
        yaml_read_config = YamlReadConfig.YamlReadConfig()
        assert yaml_read_config.get_config_value('server') == 'localhost'

    def test_case_set_custom_config(self):
        # pylint: disable=W0612,W0613,R0201
        '''set custom config file'''
        yaml_read_config = YamlReadConfig.YamlReadConfig()
        assert yaml_read_config is not None

        # config_file_path = yaml_read_config.config_file
        # default_config_file_path = 'localhost'

        # assert configFilePath == defaultConfigFilePath
        # yamlReadConfig.configFile("./custom_jenkins.yml")
