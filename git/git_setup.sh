echo "Type in your first and last name (no accent or special characters - e.g. 'ç'): "
read full_name

echo "Type in your email address (the one used for your GitHub account): "
read email

secret_path=./secret
secret_file=$secret_path/gitconfig
if ! [ -e "$secret_file" ] ; then
  mkdir $secret_path
  touch "$secret_file"
fi

git config --file $secret_file user.email "$email"
git config --file $secret_file user.name "$full_name"

echo "👌 Awesome, all set."
