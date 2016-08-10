#!/bin/bash
_grafana_tag=$1
_release_build=false

if [ -z "${_grafana_version}" ]; then
	_grafana_tag=$_grafana_tag
	_release_build=true
fi

echo "DOCKER TAG: ${_grafana_tag}"
echo "RELEASE BUILD: ${_release_build}"

docker build --tag "grafana/grafana:${_grafana_tag}"  --no-cache=true .

if [ $_release_build == true ]; then
	docker build --tag "grafana/grafana:latest"  --no-cache=true .
fi
