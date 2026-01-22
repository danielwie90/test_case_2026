import json
from income_api_client.models import income_request

import pandas as pd


def validate_request_and_get_data_frame(request_data: bytes) -> pd.DataFrame:
    """
    Function to validate the incoming request data and return it as a dataframe.

    Parameters:
    ----------
    request_data : bytes
        The raw data from the incoming request.

    Returns:
    -------
    pd.DataFrame
        Dataframe representation of the request data.
    """
    try:
        request_json = json.loads(request_data)
        if isinstance(request_json, list):
            for item in request_json:
                income_request.IncomeRequest.from_dict(item)
        else:
            income_request.IncomeRequest.from_dict(request_json)
        return pd.DataFrame(request_json)
    except Exception as e:
        raise ValueError(f"An unexpected error occurred: {e}")


def predict_income(request_df: pd.DataFrame) -> float:
    """
    Function to predict yearly income based on monthly income.

    Parameters:
    ----------
    request_json : dict
        The json format of the request.

    Returns:
    -------
    float
        The predicted yearly income.
    """
    request_df.sort_values(by="period", inplace=True, ascending=False)
    request_df_year = request_df.head(12)
    max_age = request_df_year["age"].max()
    newest_employment_status = request_df_year.head(1)["employment_status"]
    age_factor = 1.5 if max_age < 25 else 1.0
    employment_factor = 1.5 if newest_employment_status.values[0] == "student" else 1.0

    adjustment_factor = max(age_factor, employment_factor)
    adjusted_income_month = request_df_year["income_month"] * adjustment_factor

    if request_df_year.shape[0] == 12:
        # We have a full year of data
        return adjusted_income_month.sum()

    return adjusted_income_month.mean() * 12
