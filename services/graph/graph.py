from flask import Flask, render_template
import docker

app = Flask(__name__)
client = docker.from_env()

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/network_data')
def network_data():
    # Get list of containers
    containers = client.containers.list()

    # Create a directed graph in DOT language notation
    dot = "digraph {\n"
    dot += "    rankdir=TB;\n"  # Set direction to top-to-bottom
    for container in containers:
        dot += f'    "{container.id}" [label="{container.name}"];\n'
        networks = container.attrs['NetworkSettings']['Networks']
        for network_name, network_info in networks.items():
            if 'IPAddress' in network_info:
                ip_address = network_info['IPAddress']
                dot += f'    "{container.id}" -> "{network_name}" [label="{ip_address}"];\n'
    dot += "}"

    return dot, 200, {'Content-Type': 'text/plain; charset=utf-8'}

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5001, debug=True)
