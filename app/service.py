# An extremely basic 'service' built using Python and Streamlit
import streamlit as st
import json

CONFIG_PATH = "service-config.json"

st.write("Hello, I'm an extremely basic service.")

with open(CONFIG_PATH) as config_fp:
    config_file = json.load(config_fp)

st.write("My configuration file is: " + str(config_file))