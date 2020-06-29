#!/usr/bin/env python

# Run browsers tests with a local Firefox

import unittest

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions
from selenium.common.exceptions import WebDriverException
from browser_tests import BrowserTests

class test_local_browser(BrowserTests, unittest.TestCase):
     @classmethod
     def setUpClass(cls):
         super(test_local_browser, cls).setUpClass()
         if not cls.GENERATING_MODE:
             cls.browser = webdriver.Firefox()
             cls.browser.set_window_size(810, 1210)
             #cls.browser.maximize_window() # (does not seem to maximize to size of the frame buffer)
             size = cls.browser.get_window_size()
             print(" browser size  width: ", size['width'])
             print(" browser size height: ", size['height'])
             assert ((size['width'] >= cls.BROWSER_WIDTH) and (size['height'] >= cls.BROWSER_HEIGHT)), 'Screen is not large enough'
             cls.browser.set_window_size(cls.BROWSER_WIDTH, cls.BROWSER_HEIGHT)
 
     @classmethod
     def tearDownClass(cls):
         if not cls.GENERATING_MODE:
             cls.browser.quit()
         super(test_local_browser, cls).tearDownClass()
 
     def generate_image(self, html_file, png_file, page_must_load=True):
         try:
             self.browser.get('file://' + html_file)
             WebDriverWait(self.browser, 5) \
             .until(expected_conditions.presence_of_element_located((By.ID, 'page-container')))
         except WebDriverException as e:
             if page_must_load:
                 raise e
         finally:
             self.browser.save_screenshot(png_file)

if __name__ == '__main__':
     # turn warnings OFF to prevent 'ResourceWarning: unclosed <socket.socket'
     # see: https://stackoverflow.com/a/21500796
     #
     unittest.main()
