config_template = read_file("./service-config.json.tmpl")

def run(plan, service_a_count=1, service_b_count=1, service_c_count=1):
    service_configs = {}
    frontend_port = PortSpec(8501, application_protocol="http")
    
    template_data = [
        {
            "service_a_config_array": [1,2,3],
        },
        {
            "service_b_config_array": [1,2,3,4],
        },
        {
            "service_c_config_array": [1,2,3],
        },
    ]

    config_artifact = plan.render_templates(
        config={
            "service-config.json": struct(
                template=config_template,
                data=template_data
            )
        }
    )

    for i in range(service_a_count):
        config = ServiceConfig(
            "galenmarchetti/service-a",
            ports={"frontend": frontend_port},
            files={
                "/app/": config_artifact
            }
        )
        service_configs["service-a-" + str(i+1)] = config
    for i in range(service_b_count):
        config = ServiceConfig(
            "galenmarchetti/service-b",
            ports={"frontend": frontend_port},
        )
        service_configs["service-b-" + str(i+1)] = config
    for i in range(service_c_count):
        config = ServiceConfig(
            "galenmarchetti/service-c",
            ports={"frontend": frontend_port},
        )
        service_configs["service-c-" + str(i+1)] = config
    
    plan.add_services(service_configs)