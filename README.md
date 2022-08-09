# iPerf3

A tiny iPerf3 Docker image

## Examples

Run without arguments to start the server

        docker run -p 5201:5201 erlend/iperf3 

Connect a client to the server

        docker run erlend/iperf3 -c SERVER_HOSTNAME

See the full list of arguments in the [iPerf3 documentation](https://iperf.fr/iperf-doc.php#3doc)
