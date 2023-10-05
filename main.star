def run(plan, service_a_count=1, service_b_count=1, service_c_count=1):
    service_configs = {}
    
    for i in range(service_a_count):
        config = ServiceConfig("galenmarchetti/service-a")
        service_configs["service-a-" + str(i)] = config
    for i in range(service_b_count):
        config = ServiceConfig("galenmarchetti/service-b")
        service_configs["service-b-" + str(i)] = config
    for i in range(service_c_count):
        config = ServiceConfig("galenmarchetti/service-c")
        service_configs["service-c-" + str(i)] = config
    
    plan.add_services(service_configs)