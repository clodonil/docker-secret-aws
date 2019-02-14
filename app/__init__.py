from flask import Flask, render_template
app = Flask(__name__)
app.config.from_object('config')


@app.route('/')
def message():
    # alert-primary
    # alert-danger
    # alert-success 
    alert = { 
                'development': 'alert-primary', 
                'homolog'    : 'alert-danger', 
                'production' : 'alert-success' 
              } 

    message = "{0}".format(app.config['MESSAGE'])

    return render_template('page.html',message=message, env=alert[app.config['ENV']],db_url=app.config['DB_URL'], db_user=app.config['DB_USER'],db_passwd=app.config['DB_PASSWD'])
    
    