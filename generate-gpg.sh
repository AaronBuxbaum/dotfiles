# Generating a GPG
brew install gpg2
gpg --full-generate-key # select RSA type with length 4096
gpg --list-secret-keys --keyid-format=long # copy the 16-digit ID; make sure it is the "sec" item
gpg --armor --export long_id_here
# add the GPG key to GitHub
gpg --list-secret-keys --keyid-format=short # copy the 8-digit ID
git config --global user.signingKey short_id_here
