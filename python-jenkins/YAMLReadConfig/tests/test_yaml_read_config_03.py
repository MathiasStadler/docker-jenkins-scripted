""" TODO Missing docstring """
from .context import bin


class TestYamlReadConfig:
    """ TEST Yaml Read Config"""
    testClazz = None

    def test_case01(self):
        """ TODO Missing docstring """
        yaml_read_config = bin.YamlReadConfig()
        assert yaml_read_config.get_config_value('server') == 'localhost'

    def test_case_set_custom_config(self):
        '''set custom config file'''
        yaml_read_config = bin.YamlReadConfig()
        assert yaml_read_config is not None

        # config_file_path = yaml_read_config.config_file
        # default_config_file_path = 'localhost'

        # assert configFilePath == defaultConfigFilePath
        # yamlReadConfig.configFile("./custom_jenkins.yml")
