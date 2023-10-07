# An extremely basic 'service' built using Python and Streamlit
import streamlit as st
import json
import os

PARTY_MODE = os.environ["PARTY_MODE"]

st.set_page_config(layout="wide")

CONFIG_PATH = "config/service-config.json"

if PARTY_MODE:
    st.title(":partying_face: SERVICE C IS PARTYING! :tada:")
    st.header(":confetti_ball: I'm partying because an environment variable told me to. :confetti_ball:")

st.markdown("**Hello, I'm Service C! I depend on every instance of Service A and Service B.**")

with open(CONFIG_PATH) as config_fp:
    config_file = json.load(config_fp)

st.write("**Here's my configuration file:**")
st.json(config_file)