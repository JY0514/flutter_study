from flask import Flask, request

app = Flask(__name__)


# http://192.168.0.79:5000/post
@app.route('/post', methods=['POST'])
def http_post_test():
    animal = request.form.get('animal')
    human = request.form.get('human')
    print(animal)
    print(human)

    return {
        "success": 'post TEST!! ' + animal + ", " + human,
    }


# http:/192.168.0.79:5000/get?animal=tester
@app.route('/get', methods=['GET'])
def get_test():
    animal = request.args.get('animal')
    human = request.args.get('human')
    return 'GET TEST!! Welcome ' + animal + "," + human
    # return {"answer": 'GET TEST!! Welcome ' + animal + "," + human}


# @app.route('/put', methods=['PUT'])
# def put_test():
#     put_d = request.args.put('put_d')
#     return 'PUT TEST' + put_d

# @app.route('/delete', methods=['DELETE'])
# def delete_test():
#     put_d = request.args.put('put_d')
#     return 'delete TEST' + put_d


if __name__ == '__main__':
    app.run(debug=True,
            host="192.168.0.79",
            port=5000,
            )
