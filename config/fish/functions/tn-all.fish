function tn-all -a filter
  for f in */
    switch $f
      case '*'
        echo Starting session $f
        # cd $f
        # tn -d
        # cd ..
    end
  end
end
