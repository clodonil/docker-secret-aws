from flask import Flask, render_template
app = Flask(__name__)
app.config.from_object('config')


@app.route('/')
def message():
    # alert-primary
    # alert-danger
    # alert-success 
    alert = { 
                'Development': 'alert-primary', 
                'Homolog'    : 'alert-danger', 
                'Production' : 'alert-success' 
              } 

    message = "{0}  [ environment: {1} ]".format(app.config['MESSAGE'],app.config['ENV'])

    return render_template('page.html',message=message, env=alert[app.config['ENV']])