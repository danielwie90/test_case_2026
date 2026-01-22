import json
from flask import Blueprint, request, Response
import helper_functions as hf

income_prediction = Blueprint("income_prediction", __name__)


@income_prediction.route("/income", methods=["POST"])
def run_income_prediction():
    """Endpoint to estimate the income based on database data. The request must be on the following format to pass:
    [{
        "customer_id": <string with length 11>,
        "period": <string n the format YYYYMM>,
        "income_month": <float>,
        "age": <int>,
        "employment_status": <string>,
    }, ...]
    """

    request_df = hf.validate_request_and_get_data_frame(request_data=request.data)

    predicted_yearly_income = hf.predict_income(request_df=request_df)
    return Response(
        json.dumps({"predicted_yearly_income": predicted_yearly_income}),
        status=200,
    )
