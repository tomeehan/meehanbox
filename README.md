# README

Dropbox clone built with Rails 5, Bootstrap 4 (Alpha) and Amazon S3. 

Users can create folders and upload files.

In production: [meehanbox.herokuapp.com/](http://meehanbox.herokuapp.com/)

![](http://tom-meehan.com/wp-content/uploads/2017/02/MeehanBoxScreen.jpg)


## TODO 

- [ ] Rename folders
- [ ] Upload PDF's, MS Office, iWork, Adobe CC filetypes.
- [ ] Shared folders

MeehanBox is using: 

- Rails 5
- Ruby 2.3
- Bootstrap 4 (Alpha)
- PostgreSQL 
- Amazon S3

To get up and running: 

1. `cd storage`
2. `rails db:create`
3. `rails db:migrate`
4. Set your Amazon S3 environment variables. 
	- `S3_BUCKET_NAME`
	- `AWS_ACCESS_KEY_ID`
	- `AWS_SECRET_ACCESS_KEY`
	- `AWS_REGION`
5. `rails server`




