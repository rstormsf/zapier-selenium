# zapier-selenium
Break 15 min wait in Zapier.

#Install
on Mac OSX:
`brew install selenium-server-standalone`

run

`selenium-server -p 4444` - leave it open in the terminal

open another terminal window:
```
git clone git@github.com:rstormsf/zapier-selenium.git
cd zapier-selenium
bundle install
email=YOUREMAIL password=YOURPASSWORD ruby index.rb
```
After that you no longer need to provide your email and password since I save cookies and load it each time

Put your selenium-server and ruby script run in Cron tab each minute and you are good to go!

Tested in Firefox 35.0.1
