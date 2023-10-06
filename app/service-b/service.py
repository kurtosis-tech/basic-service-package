# An extremely basic 'service' built using Python and Streamlit
import streamlit as st
import json

CONFIG_PATH = "config/service-config.json"

st.markdown("**Hello, I'm Service B! I depend on every instance of Service A.**")

with open(CONFIG_PATH) as config_fp:
    config_file = json.load(config_fp)

st.write("**Here's my configuration file:**")
st.json(config_file)