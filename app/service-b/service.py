# An extremely basic 'service' built using Python and Streamlit
import streamlit as st
import json
import sys

st.set_page_config(layout="wide")

args = sys.argv
if len(args) == 2:
    party_mode = args[1]
    if (party_mode == "true"):
        party_mode = True
    elif (party_mode == "false"):
        party_mode = False
    else:
        st.error("Arg must be either 'true' or 'false', or empty.")
else:
    party_mode = False

if party_mode:
    st.title(":partying_face: SERVICE B IS PARTYING! :tada:")
    st.header(":confetti_ball: I'm partying because a command line argument told me to. :confetti_ball:")

CONFIG_PATH = "config/service-config.json"

st.markdown("**Hello, I'm Service B! I depend on every instance of Service A.**")

with open(CONFIG_PATH) as config_fp:
    config_file = json.load(config_fp)

st.write("**Here's my configuration file:**")
st.json(config_file)