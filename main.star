config_template_b = read_file("./service-b-config.json.tmpl")
config_template_c = read_file("./service-c-config.json.tmpl")


def make_config_list(services_dict):
    service_config_list = "["
    count = 0
    for service_name in services_dict:
        service = services_dict[service_name]
        service_locator = (
            service.ip_address + ":" + str(service.ports["frontend"].number)
        )
        service_config_string = (
            '{"name": "' + service_name + '", "uri": "' + service_locator + '"}'
        )
        service_config_list += service_config_string
        if count < len(services_dict.keys()) - 1:
            service_config_list += ","
        count += 1
    service_config_list += "]"
    return service_config_list


def run(plan, service_a_count=1, service_b_count=1, service_c_count=1):
    """
    Runs some very basic services, for demo purposes.

    Args:
        service_a_count (int): [OPTIONAL] [int] number of instances of Service A to run
        service_b_count (int): [OPTIONAL] [int] number of instances of Service B to run
        service_c_count (int): [OPTIONAL] [int] number of instances of Service C to run
    """
    service_a_configs = {}
    service_b_configs = {}
    service_c_configs = {}
    frontend_port = PortSpec(8501, application_protocol="http")

    for i in range(service_a_count):
        config = ServiceConfig(
            "galenmarchetti/service-a", ports={"frontend": frontend_port}
        )
        service_a_configs["service-a-" + str(i + 1)] = config
    service_a_dict = plan.add_services(service_a_configs)

    service_a_config_list = make_config_list(service_a_dict)
    template_data_config_b = {
        "service_a_config_array": service_a_config_list,
    }
    config_artifact_b = plan.render_templates(
        config={
            "service-config.json": struct(
                template=config_template_b, data=template_data_config_b
            )
        }
    )

    for i in range(service_b_count):
        config = ServiceConfig(
            "galenmarchetti/service-b",
            ports={"frontend": frontend_port},
            files={"/app/config": config_artifact_b},
        )
        service_b_configs["service-b-" + str(i + 1)] = config
    service_b_dict = plan.add_services(service_b_configs)
    service_b_config_list = make_config_list(service_b_dict)

    template_data_config_c = {
        "service_a_config_array": service_a_config_list,
        "service_b_config_array": service_b_config_list,
    }
    config_artifact_c = plan.render_templates(
        config={
            "service-config.json": struct(
                template=config_template_c, data=template_data_config_c
            )
        }
    )

    for i in range(service_c_count):
        config = ServiceConfig(
            "galenmarchetti/service-c",
            ports={"frontend": frontend_port},
            files={"/app/config": config_artifact_c},
        )
        service_c_configs["service-c-" + str(i + 1)] = config

    services_c = plan.add_services(service_c_configs)
