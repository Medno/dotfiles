echo "Type in your first and last name (no accent or special characters - e.g. 'ç'): "
read full_name

echo "Type in your email address (the one used for your GitHub account): "
read email

git config --file ./secret/gitconfig user.email $email
git config --file ./secret/gitconfig user.name $full_name

echo "👌 Awesome, all set."
