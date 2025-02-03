function ql --description "Run MacOS quicklook"
    qlmanage -p $argv > /dev/null 2>&1
end
