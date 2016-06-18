## Git workflow:

### update your local repo
git checkout master
git pull origin master

### make changes
git checkout -b 'feature'
​*make changes*​
add
commit

### re-update local repo
git checkout master
git pull origin master

### push your changes
git checkout 'feature'
git rebase master
git push origin 'feature'
**make a pull request**
