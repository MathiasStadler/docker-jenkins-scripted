from .context import bin


class Test_YamlReadConfig:

    testClazz = None

    def test_case01(self):
        yamlReadConfig = bin.YamlReadConfig()
        assert yamlReadConfig.getConfigValue('server') == 'localhost'

    def test_case_set_custom_config(self):
        '''set custom config file'''
        yamlReadConfig = bin.YamlReadConfig()
        assert yamlReadConfig is not None

        configFilePath = yamlReadConfig.configFile
        defaultConfigFilePath = 'localhost'

        # assert configFilePath == defaultConfigFilePath
        # yamlReadConfig.configFile("./custom_jenkins.yml")
