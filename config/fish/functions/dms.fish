function dms -a machine
  if test -n "$machine"
    eval (docker-machine env $machine)
  else
    eval (docker-machine env default)
  end
end
