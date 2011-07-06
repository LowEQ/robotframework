import time
import random
import string
import unittest

from robot.result.parsingcontext import TextCache, Location
from robot.result import jsparser
from robot.utils.asserts import assert_equals, assert_true



class _ContextTesting(unittest.TestCase):

    def setUp(self):
        self._context = jsparser.Context()

    def _verify_ids(self, values, ids):
        results = []
        for value in values:
            results.append(self._context.get_id(value))
        assert_equals(ids, results)


class TestTextContext(_ContextTesting):

    def _verify_text(self, values, ids, dump):
        self._verify_ids(values, ids)
        assert_equals(self._context.dump_texts(), dump)

    def test_add_empty_string(self):
        self._verify_text([''], [0] , ['*'])

    def test_add_text(self):
        self._verify_text(['Hello!'], [1] , ['*', '*Hello!'])

    def test_add_several_texts(self):
        self._verify_text(['Hello!', '', 'Foo'], [1, 0, 2] , ['*', '*Hello!', '*Foo'])


class TestTextCache(unittest.TestCase):

    def setUp(self):
        # To make test reproducable log the random seed if test fails
        self._seed = long(time.time() * 256)
        random.seed(self._seed)
        self._text_cache = TextCache()

    def _verify_text(self, string, expected):
        self._text_cache.add(string)
        assert_equals(['*', expected], self._text_cache.dump())

    def _compress(self, text):
        return self._text_cache._compress(text)

    def test_short_test_is_not_compressed(self):
        self._verify_text('short', '*short')

    def test_long_test_is_compressed(self):
        long_string = 'long'*1000
        self._verify_text(long_string, self._compress(long_string))

    def test_coded_string_is_at_most_1_characters_longer_than_raw(self):
        for i in range(300):
            id = self._text_cache.add(self._generate_random_string(i))
            assert_true(i+1 >= len(self._text_cache.dump()[id]),
                        msg='len(self._text_cache.dump()[id]) (%s) > i+1 (%s) [test seed = %s]'  % \
                            (len(self._text_cache.dump()[id]), i+1, self._seed))

    def test_long_random_strings_are_compressed(self):
        for i in range(30):
            value = self._generate_random_string(300)
            id = self._text_cache.add(value)
            assert_equals(self._compress(value), self._text_cache.dump()[id],\
                          msg='Did not compress [test seed = %s]' % self._seed)

    def _generate_random_string(self, length):
        return ''.join(random.choice(string.digits) for _ in range(length))


class TestSplittingContext(unittest.TestCase):

    def setUp(self):
        self._context = jsparser.Context(split_tests=True)
        self._context.start_suite('suite')

    def test_getting_split_results(self):
        assert_equals(self._context.split_results, [])

    def test_keyword_data_for_single_test(self):
        self._context.start_test('my test')
        self._context.start_keyword()
        self._context.end_keyword()
        test_index = self._context.end_test(['my kw data'])
        assert_equals(self._context.split_results, [(['my kw data'], ['*'])])
        assert_equals(test_index, 1)

    def test_adding_strings_for_single_keyword(self):
        self._context.start_test('t')
        self._context.start_keyword()
        self._context.get_id('log message')
        self._context.end_keyword()
        self._context.end_test(['data'])
        assert_equals(self._context.split_results, [(['data'], ['*', '*log message'])])

    def test_adding_strings_before_keyword(self):
        self._context.start_test('t')
        self._context.get_id('log message')
        self._context.start_keyword()
        self._context.end_keyword()
        self._context.end_test(['data'])
        assert_equals(self._context.split_results, [(['data'], ['*'])])

    def test_recursive_keywords(self):
        self._context.start_test('my test')
        self._context.start_keyword()
        self._context.start_keyword()
        self._context.end_keyword()
        self._context.end_keyword()
        self._context.end_test(['my kw data'])
        assert_equals(self._context.split_results, [(['my kw data'], ['*'])])

    def test_several_keywords(self):
        self._context.start_test('my test')
        self._context.start_keyword()
        self._context.end_keyword()
        self._context.start_keyword()
        self._context.end_keyword()
        self._context.end_test(['kw data 1', 'kw data 2'])
        assert_equals(self._context.split_results, [(['kw data 1', 'kw data 2'], ['*'])])

    def test_several_tests(self):
        self._context.start_test('my test')
        self._context.start_keyword()
        self._context.end_keyword()
        test_index1 = self._context.end_test(['kw data 1'])
        self._context.start_test('my test 2')
        self._context.start_keyword()
        self._context.end_keyword()
        test_index2 = self._context.end_test(['kw data 2'])
        assert_equals(self._context.split_results, [(['kw data 1'], ['*']),
                                                    (['kw data 2'], ['*'])])
        assert_equals(test_index1, 1)
        assert_equals(test_index2, 2)

    def test_several_tests_texts(self):
        self._context.start_test('my test')
        self._context.start_keyword()
        self._context.get_id('log message in test 1')
        self._context.end_keyword()
        self._context.end_test(['kw data 1'])
        self._context.start_test('my test 2')
        self._context.start_keyword()
        self._context.get_id('log message in test 2')
        self._context.end_keyword()
        self._context.end_test(['kw data 2'])
        assert_equals(self._context.split_results, [(['kw data 1'], ['*', '*log message in test 1']),
                                                    (['kw data 2'], ['*', '*log message in test 2'])])


class TestLocation(unittest.TestCase):

    def setUp(self):
        self._loc = Location()
        self._loc.start_suite()

    def _verify_id(self, id):
        assert_equals(self._loc.current_id, id)

    def test_start_one_suite(self):
        self._verify_id('s0')

    def test_start_multiple_suites(self):
        self._loc.start_suite()
        self._loc.start_suite()
        self._verify_id('s0_s0_s0')

    def test_start_and_end_suites(self):
        self._loc.start_suite()
        self._loc.end_suite()
        self._verify_id('s0')
        self._loc.start_suite()
        self._verify_id('s0_s1')
        self._loc.end_suite()
        self._verify_id('s0')

    def test_start_test(self):
        self._loc.start_test()
        self._verify_id('s0_t0')

    def test_start_and_end_tests(self):
        self._loc.start_test()
        self._loc.end_test()
        self._loc.start_test()
        self._verify_id('s0_t1')
        self._loc.end_test()
        self._loc.start_suite()
        self._loc.start_test()
        self._verify_id('s0_s0_t0')
        self._loc.end_test()
        self._loc.end_suite()
        self._verify_id('s0')

    def test_keywords_in_test(self):
        self._loc.start_test()
        self._loc.start_keyword()
        self._loc.start_keyword()
        self._verify_id('s0_t0_k0_k0')
        self._loc.end_keyword()
        self._verify_id('s0_t0_k0')
        self._loc.start_keyword()
        self._verify_id('s0_t0_k0_k1')
        self._loc.end_keyword()
        self._verify_id('s0_t0_k0')
        self._loc.end_keyword()
        self._verify_id('s0_t0')
        self._loc.end_test()
        self._verify_id('s0')

    def test_suite_setup_and_teardown(self):
        self._loc.start_keyword()
        self._verify_id('s0_k0')
        self._loc.end_keyword()
        self._loc.start_test()
        self._loc.start_keyword()
        self._verify_id('s0_t0_k0')
        self._loc.end_keyword()
        self._loc.end_test()
        self._loc.start_keyword()
        self._verify_id('s0_k1')
        self._loc.end_keyword()
        self._loc.start_suite()
        self._loc.start_keyword()
        self._verify_id('s0_s0_k0')
        self._loc.end_keyword()
        self._verify_id('s0_s0')


if __name__ == '__main__':
    unittest.main()
