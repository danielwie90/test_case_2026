#!/bin/bash

py -3.10 -m venv .venv
source .venv/scripts/activate
cd income_prediction/ || exit
pip install -r requirements.txt
cd .. || exit