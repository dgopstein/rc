# Copy all git RC files from version control to ~/.xxxx files
RC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

dot_files=`ls $RC_DIR/_*`

for dot_file in $dot_files; do
    base=`basename $dot_file`
    target="${base/_/.}"
    echo ln -s "$dot_file" "$HOME/$target"
done

# Configure gnome settings
# use `dconf watch /` to observe changes on the fly

echo dconf write /org/gnome/settings-daemon/peripherals/mouse/left-handed true # make mouse left-handed
