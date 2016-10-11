#!/bin/bash
VERSION="v0.0.1 (10.11 | El Capitan)"

# Clean machine setup
# Many ideas from http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac
# https://gist.github.com/saetia/1623487

echo "Clean Install OSX"
echo "(version $VERSION)"

# ==================================================
# Step 1: Get user input
# ==================================================

echo "You can buy anything you need at Matt\'s General store"
echo "We're going to get your machine set up super quick, so you can start having fun as soon as possible. We will need a little information first. Make sure you are able to provide your..."
echo "- Full name"
echo "- Email address"

echo "If you are going to be developing software for Jive we can help set up your environment. We will install Maven, Tomcat, and PostgresSQL bianaries, and give you the applications Eclipse for JAVA and PGAdmin3 to help you out."
echo "Do you want to configure this machine to develop for Jive? (Y/N)"
read JIVESETUP

# Get name
echo "What is your full name?"
read NAME

# Get email
echo "Enter your email address?"
read EMAIL


# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update
brew doctor

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash
brew install bash

# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew install homebrew/dupes/grep

# Modify $PATH
$PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH

echo "Installing binaries..."
#NODE!!!
brew cleanup

brew install node
sudo brew postinstall node

# Define brew packages here
binaries=(
  curl
  tree
  ssh-copy-id
  wget
  python
  git
  mysql
  ansible
)

for i in "${bianaries[@]}"
do

  if test ! $(which brew); then
    brew install i
  fi

done


# Set MySQL to launch at startup.
ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist



echo "Installing Brew Caskroom for app goodness"
brew install caskroom/cask/brew-cask
brew tap caskroom/versions

brew cask install java
brew cask install java7

# Define Apps here
# List available at https://github.com/caskroom/homebrew-cask/tree/master/Casks
apps=(
  google-chrome
  firefox
  vagrant
  flash
  iterm2
  sublime-text3
  virtualbox
  joinme
  genymotion
  spectacle
  diffmerge
  xtrafinder
  sequel-pro
  sourcetree
  cyberduck
)


echo "Installing apps..."

# Install apps one at a time instead of passing them to `brew cask install` all
# at once. This way, if an app can’t be downloaded/installed it won’t interrupt
# the rest in the list.
for app in “${apps[@]}”
do
  # Install apps to /Applications
  # Default is: /Users/$user/Applications
  # Later we set /Applications as the default.
  brew cask install --appdir="/Applications" $app
done


# TODO: Pull down scotchbox LAMP box, and a good MEAN box
# TODO: New bianaries, htop, testem, gitflow
# TODO: Write out sublime preferences... or clone them... better idea


echo "Updating OSX Preferences..."
echo "This will optimize OSX for power users. Hang on to your hat!"


# Let's optimize OSX for power users

#Show hidden files
defaults write com.apple.finder AppleShowAllFiles TRUE
#Disable window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
#Enable repeat on keydown
defaults write -g ApplePressAndHoldEnabled -bool false
# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
#Disable ext change warning
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
#Disable webkit homepage
defaults write org.webkit.nightly.WebKit StartPageDisabled -bool true
# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
#Use current directory as default search scope in Finder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
#Show Path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true
#Disable sound effect when changing volume
defaults write -g com.apple.sound.beep.feedback -integer 0
#Show Status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true
#Enable AirDrop over Ethernet and on unsupported Macs
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true
#Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0
# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true && \
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true && \
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true && \
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
#Set a shorter Delay until key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 12
#Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true && \
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true && \
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true
#Disable Safari’s thumbnail cache for History and Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2
#Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
# Disable smart quotes as it’s annoying for messages that contain code
defaults write com.apple.messageshelper.MessageController \
SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false
# Trackpad: map bottom right corner to right-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2 && \
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true && \
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1 && \
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true && \
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true && \
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true && \
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
# Enable tap to click
defaults -currentHost write -globalDomain com.apple.mouse.tapBehavior -int 1
#Show the ~/Library folder
chflags nohidden ~/Library
#Show absolute path in finder's title bar.
defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES
#Enable 3-finger drag
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerSwipeGesture -int 1
# Custom login message
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "Hello world\!"
#Restart Finder to apply settings
killall Finder

echo "Installing Z-SHELL..."
# Install z-shell
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh


echo 'Creating your local development structure'
# From Tim Mila with love!!!
mkdir ~/Development
mkdir ~/Development/projects
mkdir ~/Development/jive
mkdir ~/Development/jive/sources


# ==================================================
# Jive Stuff?
# ==================================================

# If we are setting up for Jive we need to add some Maven memory option stuff...
if [ "$JIVESETUP" = "Y" ] || [ "$JIVESETUP" = "y" ] || [ "$JIVESETUP" = "yes" ] || [ "$JIVESETUP" = "Yes" ]; then

  echo "It is now JIVE SETUP TIME!!!!"

  # Settings XML Variables

  # Get Bitbucket username
  echo "Enter your Bitbucket Username. This is needed to set up your machine to utilize the PEAK FRAMEWORK"
  read BITBUCKETUSERNAME

  # Get Bitbucket password
  echo "Enter your Bitbucket password"
  read BITBUCKETPASSWORD

  # MVN Username
  echo "Enter your Maven username. This is needed for your machine to pull Jive dependencies."
  read MAVENUSERNAME

  # MVN Password
  echo "Enter your Maven password"
  read MAVENPASSWORD

  MACHINEUSER="$(echo $USER | tr -d '\n')"
  BASE64BITBUCKET="$(echo -ne $BITBUCKETUSERNAME:$BITBUCKETPASSWORD | openssl base64)"

  # Jive related bianaries
  jivebinaries=(
    homebrew/versions/tomcat7
    maven
    postgresql
  )

  echo "installing JIVE binaries..."
  brew install ${jivebinaries[@]}

  # Jive related apps
  jiveapps=(
    eclipse-java
    pgadmin3
  )

  echo "installing JIVE apps..."
  brew cask install --appdir="/Applications" ${jiveapps[@]}

  echo "Undoing homebrew's default postgresql setup"
  rm -rf /usr/local/var/postgres

  echo "Creating a postgres user UN:postgres / PW:postgres"
  initdb -D /usr/local/var/postgres -U postgres

  echo "Setting postgres to start when your computer starts"

  mkdir -p ~/Library/LaunchAgents
  cp /usr/local/Cellar/postgresql/9.4.4/homebrew.mxcl.postgresql.plist ~/Library/LaunchAgents/
  launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
  pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start


  # Adding some important lines to your .zsh file

  #blank line
  echo ' ' >> ~/.zshrc

  #comment heading
  echo '## JIVE ##' >> ~/.zshrc

  echo 'export MAVEN_OPTS="-Xmx1024m -Xms256m"' >> ~/.zshrc
  echo 'export JAVA7_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_76.jdk/Contents/Home' >> ~/.zshrc
  echo 'export JAVA8_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_40.jdk/Contents/Home' >> ~/.zshrc
  echo 'export JAVA_HOME=$JAVA8_HOME' >> ~/.zshrc

  echo 'export PLUGINDIR_7S=/Users/$USER/Development/projects/7s_plugins' >> ~/.zshrc
  echo 'export PATH=~/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/git/bin:$PATH' >> ~/.zshrc
  echo 'export HOMEBREW_CASK_OPTS="--appdir=/Applications"' >> ~/.zshrc

  echo 'alias java7="export JAVA_HOME=$JAVA7_HOME;echo Now using Java 7. Run `echo $JAVA_HOME` in terminal to confirm java version"' >> ~/.zshrc
  echo 'alias java8="export JAVA_HOME=$JAVA8_HOME;echo Now using Java 8. Run `echo $JAVA_HOME` in terminal to confirm java version"' >> ~/.zshrc

  # settings.xml file
  # Do we have the template settings.xml file here?
  if [ -f settings.xml ]; then

    # Does the .m2 directory exist?
    if [ ! -d ~/.m2 ]; then
      echo 'Creating your ~/.m2 directory'
      mkdir ~/.m2
    fi

    # create settings.xml with corect data
    echo 'Generating a Peak Enabled Maven settings.xml file for you!'
    cat settings.xml | sed -e "s/\${bitbucketusername}/$BITBUCKETUSERNAME/" -e "s/\${bitbucketpassword}/$BITBUCKETPASSWORD/" -e "s/\${machineusername}/$MACHINEUSER/" -e "s/\${mavenusername}/$MAVENUSERNAME/" -e "s/\${mavenpassword}/$MAVENPASSWORD/" -e "s/\${bitbucketbase64}/$BASE64BITBUCKET/" > ~/.m2/settings.xml

  fi

  sudo cp local_policy.jar /Library/Java/JavaVirtualMachines/jdk1.8.0_40.jdk/Contents/Home/jre/lib/security
  sudo cp US_export_policy.jar /System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home/jre/lib/security

fi

#blank line
echo ' ' >> ~/.zshrc

echo '## PATH TO YOUR DEV FOLDER ##' >> ~/.zshrc
echo 'export DEVPATH="/Users/$USER/Development"' >> ~/.zshrc
echo 'alias climb="mountainclimber"' >> ~/.zshrc

#blank line
echo ' ' >> ~/.zshrc

echo '## Create alias to make installing peak tools MUCH easier ##' >> ~/.zshrc
echo 'alias installpeaktools="brew tap telemachus/anytap && brew install brew-any-tap && brew any-tap 7Summits seven-summits-tap git@bitbucket.org:7Summits/homebrew-7s-tap.git && brew install seven-summits-tools"' >> ~/.zshrc


#install gulp, grunt, bower, and composer
sudo npm install gulp -g
sudo npm install --save-dev gulp-install
sudo chown -R $USER ~/.npm
sudo npm install -g grunt-cli
npm install --global yarnpkg

npm install -g bower

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer


# Enable SUBL in the terminal
sudo ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/bin/subl


# ==================================================
# Generate a local SSH Key
# ==================================================


if [ ! -d ~/.ssh ]; then
  # SETUP SSH
  echo "Setting up SSH..."

  ssh-keygen -t rsa -C "$EMAIL"
fi

#set git config values
echo "Setting GIT config values..."

echo "Setting global user name to $NAME"
git config --global user.name "$NAME" &&

echo "Setting global email to $EMAIL"
git config --global user.email "$EMAIL" &&

echo "Setting global editor to Sublime Text"
git config --global core.editor "subl -w" &&

git config --global color.ui true &&
git config --global push.default simple


# ==================================================
# Trumpet Sweet Sweet Victory
# ==================================================


echo "YOU MADE IT!!! Restart your computer and you'll be good to go. ::AIR GUITAR SOLO::"
