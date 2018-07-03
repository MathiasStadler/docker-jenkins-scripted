""" plain test for pytest"""

# pylint: disable W0613


def setup_module(module):
    # pylint: disable=W0612,W0613
    """ TODO Missing docstring """
    print("\nIn setup_module()...")


def teardown_module(module):
    # pylint: disable=W0612,W0613
    """ TODO Missing docstring """
    print("\nIn teardown_module()...")


def setup_function(function):
    # pylint: disable=W0612,W0613
    """ TODO Missing docstring """
    print("\nIn setup_function()...")


def teardown_function(function):
    # pylint: disable=W0612,W0613
    """ TODO Missing docstring """
    print("\nIn teardown_function()...")


def test_case01():
    # pylint: disable=W0612,W0613
    """ TODO Missing docstring """
    print("\nIn test_case01()...")


def test_case02():
    # pylint: disable=W0612,W0613
    """ TODO Missing docstring """
    print("\nIn test_case02()...")


class TestClass02:
    # pylint: disable=W0612,W0613
    """ TODO Missing docstring """
    @classmethod
    def setup_class(cls):
        # pylint: disable=W0612,W0613
        """ TODO Missing docstring """
        print("\nIn setup_class()...")

    @classmethod
    def teardown_class(cls):
        # pylint: disable=W0612,W0613
        """ TODO Missing docstring """
        print("\nIn teardown_class()...")

    def setup_method(self, method):
        # pylint: disable=W0612,W0613,R0201
        """ TODO Missing docstring """
        print("\nIn setup_method()...")

    def teardown_method(self, method):
        # pylint: disable=W0612,W0613,R0201
        """ TODO Missing docstring """
        print("\nIn teardown_method()...")

    def test_case03(self):
        # pylint: disable=W0612,W0613,R0201
        """ TODO Missing docstring """
        print("\nIn test_case03()...")

    def test_case04(self):
        # pylint: disable=W0612,W0613,R0201
        """ TODO Missing docstring """
        print("\nIn test_case04()...")
