""" plain test for pytest"""

# pylint: disable W0613


def setup_module(module):
    """ TODO Missing docstring """
    print("\nIn setup_module()...")


def teardown_module(module):
    """ TODO Missing docstring """
    print("\nIn teardown_module()...")


def setup_function(function):
    """ TODO Missing docstring """
    print("\nIn setup_function()...")


def teardown_function(function):
    """ TODO Missing docstring """
    print("\nIn teardown_function()...")


def test_case01():
    """ TODO Missing docstring """
    print("\nIn test_case01()...")


def test_case02():
    """ TODO Missing docstring """
    print("\nIn test_case02()...")


class TestClass02:
    """ TODO Missing docstring """
    @classmethod
    def setup_class(cls):
        """ TODO Missing docstring """
        print("\nIn setup_class()...")

    @classmethod
    def teardown_class(cls):
        """ TODO Missing docstring """
        print("\nIn teardown_class()...")

    def setup_method(self, method):
        """ TODO Missing docstring """
        print("\nIn setup_method()...")

    def teardown_method(self, method):
        """ TODO Missing docstring """
        print("\nIn teardown_method()...")

    def test_case03(self):
        """ TODO Missing docstring """
        print("\nIn test_case03()...")

    def test_case04(self):
        """ TODO Missing docstring """
        print("\nIn test_case04()...")
