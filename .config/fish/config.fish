if status is-interactive
    set -U fish_greeting I am not as think as you confused I am.
    starship init fish | source
end



######## Aliases ########
alias nano="nano -l"
alias dc=docker-compose
alias dio="cd ~/code/dionysos-server && code ."

######## Screenshots ########
function sc -d "Take a screenshot" -a name
    if test (count $argv) = 0
        grim -l 0 -g "$(slurp)" - | swappy -f -
    else
        grim -l 0 -g "$(slurp)" - | swappy -f - -o - | pngquant - > $name.png
    end
end

######## Config Management ########
# From https://github.com/vazanoir/config
function config
    git --git-dir=$HOME/.cfg/ --work-tree=$HOME $argv
end

function save_config
    config add -u && \
    config commit -m "Update $(date +"%Y-%m-%d %H:%M") $(uname -s)/$(uname -m)" && \
    config push
end

function load_config
    config fetch --all
    config reset --hard origin/main
end
