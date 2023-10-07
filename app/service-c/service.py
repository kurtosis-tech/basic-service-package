# An extremely basic 'service' built using Python and Streamlit
import streamlit as st
import json
import os

if "PARTY_MODE" in os.environ:
    party_mode = os.environ["PARTY_MODE"]
    if (party_mode == "true"):
        party_mode = True
    elif (party_mode == "false"):
        party_mode = False
    else:
        st.error("PARTY_MODE environment variable must be either 'true' or 'false', or empty.")
else:
    party_mode = False

st.set_page_config(layout="wide")

CONFIG_PATH = "config/service-config.json"

if party_mode:
    st.title(":partying_face: SERVICE C IS PARTYING! :tada:")
    st.header(":confetti_ball: I'm partying because an environment variable told me to. :confetti_ball:")

st.markdown("**Hello, I'm Service C! I depend on every instance of Service A and Service B.**")

with open(CONFIG_PATH) as config_fp:
    config_file = json.load(config_fp)

st.write("**Here's my configuration file:**")
st.json(config_file)