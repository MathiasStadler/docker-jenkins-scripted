"""TODO Missing docstring"""
# -*- coding: utf-8 -*-

import os
import inspect
# from .context import bin
from .. import yaml_read_config

MATH_OBJ = 0


def set_up_module():
    """called once, before anything else in this module"""
    print("In set_up_module()...")
    # pylint: disable=W0603
    global MATH_OBJ
    MATH_OBJ = yaml_read_config.YamlReadConfig()


def tear_down_module():
    # pylint: disable=W0612,W0613,R0201
    """called once, after everything else in this module"""
    print("In tearDownModule()...")
    # pylint: disable=W0603
    global MATH_OBJ
    del MATH_OBJ


class TestClass01:
    """TODO Missing docstring"""

    @classmethod
    def set_up_class(cls):
        """called once, before any test in the class"""
        print("In setUpClass()...")

    def set_up(self):
         # pylint: disable=W0612,W0613,R0201
        """called before every test method"""
        print("\nIn setUp() method...")

    def where_we_are(self):
        """TODO Missing docstring"""
        print("File => %s" % os.path.basename(__file__))
        print("CLass => %s" % self.__class__.__name__)
        print("def => %s" % inspect.stack()[1][3])

    def tear_down(self):
        # pylint: disable=W0612,W0613,R0201
        """called after every test method"""
        print("In tearDown() method...")

    @classmethod
    def tear_down_class(cls):
        # pylint: disable=W0612,W0613,R0201
        """called once, after all tests, if setUpClass() successful"""
        print("\nIn tearDownClass()...")

    def setup_function(self):
        # pylint: disable=W0612,W0613,R0201
        """setup_function(): use it with @with_setup() decorator"""
        print("\nsetup_function()...")

    def teardown_function(self):
        # pylint: disable=W0612,W0613,R0201
        """teardown_function(): use it with @with_setup() decorator"""
        print("\nteardown_function()...")

    # Test Cases
    def _test_case01(self):
        self.where_we_are()
        assert MATH_OBJ.get_config_value('server') == 'localhost'

    def _test_case02(self):
        self.where_we_are()
        assert MATH_OBJ.get_config_value('user') == 'admin'
