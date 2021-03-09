from gensim.summarization import keywords
from flask import Flask, jsonify, request
import json

#text1 = "Hello, people from the future! Welcome to Normalized Nerd! I love to create educational videos on Machine Learning and Creative Coding. Machine learning and Data Science have changed our world dramatically and will continue to do so. But how they exactly work?...Find out with me. If you like my videos please subscribe to my channel."

response = ''
app = Flask(__name__)
@app.route('/', methods = ['GET','POST'])

def nameRoute():
    print('hello world')
    return jsonify({'hello': 'hello'})
    # global response
    # if(request.method == 'POST'):
    #     request_data = request.data
    #     request_data = json.loads(request_data.decode('utf-8'))
    #     complaint = request_data['complaint']
    #     print(complaint)
    #     response = 'yo'
    #     #response = keywords(complaint)
    #     return " "
    

if __name__ == "__main__":
    app.run(debug= True)

