sed -i '/limit maxproc/d' ~/.cshrc.mine
echo "module load ruby" >> ~/.cshrc.mine
echo "module load ocaml" >> ~/.cshrc.mine
echo "module load rust" >> ~/.cshrc.mine
echo "tap -q java" >> ~/.cshrc.mine
source ~/.cshrc.mine
timeout 60 gem install --user-install sqlite3 sinatra
echo 'eval `opam config env`' >> ~/.cshrc.mine
opam init
