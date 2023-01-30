#!/bin/sh

print_help () {
  echo "Usage: `basename $0` [options]"
  echo -e "\nOptions:\n"
  echo "  -k, --api-key       Grafana api key."
  echo "  -u, --url           Grafana url."
	echo "  -d, --data-source   Grafana data source to import."
  exit 1
}

if [ $# -lt 6 ]; then
  print_help
fi

while [ $# -gt 0 ]; do
	case "$1" in
		-k|--api-key)
			grafana_api_key="$2"
			shift
		;;
		-u|--url)
			grafana_url="$2"
			shift
		;;
		-d|--data-source)
			grafana_data_source="$2"
			shift
		;;
		*)
			print_help
		;;
	esac
	shift
done

curl -ks --fail-with-body -X POST -H "Authorization: Bearer $grafana_api_key" -H "Content-Type: application/json" --data-binary @$grafana_data_source $grafana_url/api/datasources
