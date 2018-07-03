# -*- coding: utf-8 -*-
import pytest
import os
import inspect
import sys

before = [str(m) for m in sys.modules]

# from bin.YamlReadConfig import *
from .context import bin

after = [str(m) for m in sys.modules]
print([m for m in after if not m in before])


def test_case01():
    # self.whereWeAre()
    clazz = bin.YamlReadConfig()
    assert clazz.getConfigValue('server') == 'localhost'


def test_case02():
    # self.whereWeAre()
    clazz = bin.YamlReadConfig()
    assert clazz.getConfigValue('user') == 'admin'
