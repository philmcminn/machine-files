# Replicating Brew Setup

1. Create a "Brewfile":

`brew bundle dump --describe`

**(Note that there is a command to do this: `bu`)**

This contains formulae, casks (including fonts), taps, and Mac App Store apps (if you using mas).

Before you run this command you need to delete any existing Brewfile in the current directory.

2. On the new machine, use:

`brew bundle`


## Notes on using `mas`

`mas` is a way to manage apps installed via the Mac App Store.

I didn't have a lot of success with getting it to work.

You can list the apps installed with 

`mas list`

You have to be logged into the App Store on your Mac. 
