import re
import json
from typing import Union

import pandas as pd


def validate_request_and_get_json_format(request_data: bytes) -> dict:
    """
    Function to validate the incoming request data and return it as a json.

    Parameters:
    ----------
    request_data : bytes
        The raw data from the incoming request.

    Returns:
    -------
    dict
        The json format of the request.
    """
    try:
        request_json = json.loads(request_data)
        if not {
            "customer_id",
            "period",
            "income_month",
            "age",
            "employment_status",
        }.issubset(request_json.keys()):
            raise ValueError("Missing required keys in the request data.")
        for key, value in request_json.items():
            _validate_key_in_dictionary(key=key, value=value)
    except Exception as e:
        raise ValueError(f"An unexpected error occurred: {e}")
    return request_json


def _validate_key_in_dictionary(
    key: str,
    value: Union[str, float, int],
) -> None:
    """
    Function to validate if a key is present in a dictionary.

    Parameters:
    ----------
    key : str
        The key to look for.
    value : Union[str, float, int]
        The value associated with the key.

    Raises:
    ------
    ValueError
        If the key is not present in the dictionary.
    """
    if key == "customer_id":
        if not isinstance(value, str) or len(value) != 11:
            raise ValueError(f"Invalid length for '{key}'. Expected length 11.")
    if key == "period":
        if not isinstance(value, str) or not re.match(r"\d{6}", value):
            raise ValueError(f"Invalid format for '{key}'. Expected format 6 digits.")
    if key == "employment_status":
        if value not in ["employed", "unemployed", "student"]:
            raise ValueError(
                f"Invalid value for '{key}'. Expected one of ['employed', 'unemployed', 'self-employed', 'student']."
            )
    if key == "income_month":
        if not isinstance(value, float) or value < 0:
            raise ValueError(f"Invalid value for '{key}'. Must be non-negative.")


def predict_income(request_json: dict) -> float:
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
    if isinstance(request_json, dict):
        request_json = [request_json]
    request_df = pd.DataFrame(request_json)
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
