# -*- coding: utf-8 -*-
""" TODO Missing docstring """
import sys

MODULE_BEFORE_LOAD_CUSTOM = [str(m) for m in sys.modules]

# from bin.YamlReadConfig import *
from .context import bin

MODULE_AFTER_LOAD_CUSTOM = [str(m) for m in sys.modules]
print([m for m in MODULE_AFTER_LOAD_CUSTOM if not m in MODULE_BEFORE_LOAD_CUSTOM])


def test_case01():
    """ TODO Missing docstring """
    # self.whereWeAre()
    clazz = bin.YamlReadConfig()
    assert clazz.get_config_value('server') == 'localhost'


def test_case02():
    """ TODO Missing docstring """
    # self.whereWeAre()
    clazz = bin.YamlReadConfig()
    assert clazz.get_config_value('user') == 'admin'
