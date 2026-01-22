import flask
from model_bp import income_prediction


def create_app():
    app = flask.Flask("income-api")
    with app.app_context():
        app.register_blueprint(income_prediction)
        return app
