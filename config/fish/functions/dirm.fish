function dirm -a prefix
  docker rmi (docker images --format="{{.Repository}}" | grep $prefix)
end
