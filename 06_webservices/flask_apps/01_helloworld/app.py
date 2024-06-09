# This a REST API (web service) built using Flask
# This webservice is not connected to any outside web serve- it uses inbuilt memory for demonstration purposes
# We call this web service because , we have another http file through which we communicate to this API 
# We send our details through http file and this restapi webservice is extracting info from the inbuilt memory (usually web server) and  then respond to the http request again
# Webservice can have a front end(like web application) as well
# Here we simply use the root route to display html outputs to show the web application over this web service
# The flutter app (like eg1.dart) uses the http file /request to inteeract with this restapi (webservice) and ger the data from the web server(in built memory)





# A simple web app that says hello in different languages, and
# allows you to add greetings in new languages.

from flask import Flask, request
from flask_cors import CORS 
# using CORS to allow this API to use Other sources like android emulators also to access this server
import random

app = Flask(__name__)
CORS(app)

hellos = {
    'cn': '你好，世界！',
    'en': 'Hello, World!',
    'es': '¡Hola Mundo!',
    'th': 'สวัสดีชาวโลก!',
}

# the annotation below says the method following it (index) is used to address the route (/), we use simply, (/), because everything is under the same root
@app.route('/')
def index():
    return random.choice(list(hellos.values()))
# This function(handler) just return the list of values, it is taken and packaged by "app" to return as http response




@app.route('/<lang>', methods=['GET', 'PUT'])
def other_hellos(lang):
    if request.method == 'GET':
        return hellos.get(lang, 'Hello, World!')
    else:
        hellos[lang] = request.get_data().decode('utf-8')
        return 'Success', 200



HOSTNAME='0.0.0.0'
# allows this app to be accessible locally as well as on other apps on the computer
PORT=5001
# Port is the address given to identify each application

if __name__ == '__main__':
    app.run(host=HOSTNAME, port=PORT, debug=True)

# debug = True says whenver i amke some changes in this file, rerun the app
