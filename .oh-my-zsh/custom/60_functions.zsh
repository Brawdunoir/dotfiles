# Get the SHA digest of a Docker image by name and tag
function get_docker_image_sha() {
  local image=$1
  local manifest=$(docker manifest inspect "${image}")
  local v1=$(echo $manifest | jq -r '.config.digest')
  local v2=$(echo $manifest | jq -r '.manifests[0].digest')
  if [[ "$v1" != 'null' ]]; then
    echo "$v1"
  elif [[ "$v2" != 'null' ]]; then
    echo "$v2"
  else
    echo "Error: Failed to retrieve SHA digest for $image" >&2
    return 1
  fi
}

base() {
    echo -n $1 | base64
}

based() {
    echo -n $1 | base64 -d
}
