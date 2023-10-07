# An extremely basic 'service' built using Python and Streamlit
import streamlit as st
import json

st.set_page_config(layout="wide")

CONFIG_PATH = "config/service-config.json"

with open(CONFIG_PATH) as config_fp:
    config_file = json.load(config_fp)

if config_file['party_mode']:
    st.title(":partying_face: SERVICE A IS PARTYING! :tada:")
    st.header(":confetti_ball: I'm partying because my configuration file told me to. :confetti_ball:")

st.markdown("**Hello, I'm Service A! I don't depend on anyone.**")

st.write("**Here's my configuration file:**")
st.json(config_file)