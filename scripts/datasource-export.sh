#!/bin/sh

print_help () {
  echo "Usage: `basename $0` [options]"
  echo -e "\nOptions:\n"
  echo "  -k, --api-key    Grafana api key."
  echo "  -u, --url        Grafana url."
	echo "  -od, --out-dir   Data sources output dir."
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
		-od|--out-dir)
			out_dir="$2"
			shift
		;;
		*)
			print_help
		;;
	esac
	shift
done

data_sources=$(curl -ks -H "Authorization: Bearer $grafana_api_key" $grafana_url/api/datasources)
counter=$(echo $data_sources | jq -j 'length')

if [ $counter -gt 0 ]; then
	i=0
	while [ $i -lt $counter ]; do
		id=$(echo $data_sources | jq -j --arg i "$i" '.[$i | tonumber].id')
		config=$(curl -ks -H "Authorization: Bearer $grafana_api_key" $grafana_url/api/datasources/$id)
		name=$(echo $config | jq -j '.name | gsub("\\(|\\)|\\[|\\]";"") | gsub("_|-";" ") | gsub("\\s{2,}";" ") | gsub("\\s";"-") | ascii_downcase')
		echo $config > "$out_dir$([ ${out_dir#${out_dir%?}} != '/' ] && printf '/')$name.json"
		echo "Saved data source with id=$id to file $name.json"
		let "i+=1"
	done
else
  echo "Sorry, no data sources to export this time..."
fi
