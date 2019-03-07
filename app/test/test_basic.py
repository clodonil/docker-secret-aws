import os
import unittest
 

 
class BasicTests(unittest.TestCase):


    
    # executed prior to each test
    def setUp(self):
        app.config['ENVIRONMENT'] = 'development'
        app.config['MSG'] = 'Test Unit'
        app.config['db_user'] = 'root'
        app.config['db_passwd'] = 'xxxx'
        app.config['db_url'] ='10.0.0.1'
        self.app = app.test_client()
        
        self.assertEqual(app.debug, False)
 
    # executed after each test
    def tearDown(self):
        pass
 
 
###############
#### tests ####
###############
 
    def test_main_page(self):
        response = self.app.get('/', follow_redirects=True)
        self.assertEqual(response.status_code, 200)
 
 
