# dwhs theme; built from mh as starting point

# features:
# path is autoshortened to ~30 characters
# displays git status (if applicable in current folder)
# turns username green if superuser, otherwise it is white

# TODO: 
# * get the tabs/windows set correctly

autoload -U add-zsh-hook
autoload -U vcs_info
autoload -U colors && colors

# git theming
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '%f%F{red}'
zstyle ':vcs_info:*' stagedstr '%f%F{yellow}'
# if we're in a merge, we want this to be magenta
zstyle ':vcs_info:*' actionformats '%F{magenta}(%b)%f'
zstyle ':vcs_info:*' formats '%F{green}%u(%b)%f'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git svn
# TODO: test whether there are untracked files, not general dirtiness
ZSH_THEME_GIT_PROMPT_DIRTY="✱" 

set_tab_title () {
    tab_title="$UNISONLOCALHOSTNAME: `pwd`"
    if [ -n "$_TRACK_LABEL" ] ; then
        TRACK_LABEL_STR=" ${_TRACK_LABEL}"
    else
        TRACK_LABEL_STR=""
    fi
    echo -ne "\e]1;${tab_title}\a"
    echo -ne "\e]2;${USER}@${UNISONLOCALHOSTNAME}$TRACK_LABEL_STR\a"
}


theme_precmd () { 
    vcs_info 
    set_tab_title
}
add-zsh-hook precmd theme_precmd

# if superuser make the username green
if [ $UID -eq 0 ]; then NCOLOR="green"; else NCOLOR="white"; fi

# prompt
PROMPT='%{$fg[$NCOLOR]%}${PIXI_PROMPT}${UNISONLOCALHOSTNAME}:%{$fg[white]%}%30<...<%~%<<%{$reset_color%} %n%(!.#.$) '
#RPROMPT='$(git_prompt_info)'
RPROMPT='${vcs_info_msg_0_}$(parse_git_dirty)'


# LS colors, made with http://geoff.greer.fm/lscolors/
#export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LSCOLORS="ExexdxhxCxegedBxbxeAeA"
#export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;32:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:'
